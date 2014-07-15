/**
 * Convenience functions for manipulating groups of HTML elements.
 */
library fletch;

import "dart:collection";
import "dart:html";

part "src/attribute.dart";
part "src/classes.dart";
part "src/event.dart";
part "src/style.dart";

final _html_regex = new RegExp("^<.+>\$");

/**
 * A convenience wrapper around a group of [Element]s.
 *
 * A [Fletch] object wraps one or more HTML elements, adding
 * many useful convenience functions to manipulate them. All
 * features of the Fletch library are accessed through this
 * class.
 *
 * [Fletch] implements [Iterable], so its elements
 * can be accessed through normal indexing or iteration.
 */
class Fletch extends IterableBase<Element> with _EventMixin {
    final List<Element> _elements;

    /**
     * The attributes on this group of [Element]s.
     *
     * Attributes are accessed by indexing into their names.
     * For example:
     *
     *     $("img").attr["src"] = "path/to/image.png";
     *
     * When multiple elements are selected, getting an attribute's
     * value will only return the value for the first selected
     * element.
     *
     * When setting an attribute, all selected elements will be
     * affected.
     *
     * When getting the value of an attribute that does not exist
     * or does not have its value set, `null` will be returned.
     */
    final _AttributeCollection attr = new _AttributeCollection();

    /**
     * The classes on this group of [Element]s.
     *
     * The `add`, `remove`, and `toggle` functions are used to
     * manipulate classes on the selected elements. Adding
     * a class will not affect elements that already have that
     * class, and removing a class will not affect elements
     * that do not have that class. Toggling a class will add
     * it to elements that do not have it and remove it from
     * elements that do have it.
     */
    final _ClassCollection classes = new _ClassCollection();

    /**
     * The events on this group of [Element]s.
     *
     * Events are accessed by indexing into their names.
     *
     * The object returned is a functor representing the
     * requested event. Calling the functor will dispatch the
     * event.
     * For example:
     *
     *     $("button").event["click"]();
     *
     * To begin listening for an event, pass your listener to
     * the `listen` method. Listeners accept two arguments:
     * `event`, which is a reference to the [Event] being
     * triggered, and `self`, which is a reference to the
     * element triggering the event.
     * For example:
     *
     *     $("button").event["click"].listen((evt, self) => print("Clicked!"));
     *
     * You can dispatch and listen to custom events by
     * passing your custom event names into the indexer.
     */
    final _EventCollection event = new _EventCollection();

    /**
     * The CSS styles on this group of [Element]s.
     *
     * Styles are accessed by indexing into their property names.
     * For example:
     *
     *     $("div").style["font-family"] = "sans-serif";
     *
     * When multiple elements are selected, getting a style
     * property's value will only return the value for the first
     * selected element.
     *
     * When setting a style property, all selected elements will
     * be affected.
     *
     * Getting a style property's value will return its
     * _computed_ value, so inherited and calculated values are
     * included.
     *
     * To set multiple style properties at once, call [style] like
     * a function, passing in a map of property/value pairs.
     * For example:
     *
     *     $("div").style({
     *         "font-family": "sans-serif",
     *         "font-weight": "bold"
     *     });
     *
     */
    final _StyleCollection style = new _StyleCollection();

    /**
     * Constructs a [Fletch] wrapper from any valid source of
     * [Element]s.
     *
     * Valid sources are:
     * + A [String] CSS selector used to match elements
     * + A [String] of HTML to parse into an element
     * + An [Element]
     * + An [Iterable] of [Element]
     * + A [HtmlDocument]
     * + A [Fletch] (will simply return the original object)
     *
     * If a second parameter is supplied, it will be used as
     * the top-level element to run the CSS selector as. For
     * other sources, the second parameter is ignored.
     */
    factory Fletch(dynamic selection, [dynamic context]) {
        if (selection == null)
            return new Fletch._new([]);

        if (selection is String) {
            // This is HTML
            if (_html_regex.hasMatch(selection)) {
                try {
                    return new Fletch._new([new Element.html(selection)]);
                }
                on StateError {
                    throw new ArgumentError("selection does not contain an HTML element");
                }
            }

            // This is a CSS selector
            context = context == null ? [document] : new Fletch(context);
            return new Fletch._new(context.expand((element) => element.querySelectorAll(selection)).toList());
        }

        if (selection is Element)
            return new Fletch._new([selection]);

        if (selection is HtmlDocument)
            return new Fletch._new([selection.documentElement]);

        if (selection is Fletch)
            return selection;

        if (selection is Iterable<Element>)
            return new Fletch._new(selection.toList());

        // TODO: EventTarget?

        // If we've gotten this far, then the selection is invalid
        throw new ArgumentError("selection cannot be used to construct a Fletch object");
    }

    /**
     * Private constructor to be used when a new [Fletch]
     * reference is required.
     */
    Fletch._new(this._elements) {
        attr._parent = classes._parent = event._parent = style._parent = this;
    }

    /**
     * The plain text content of the selected [Element]s.
     *
     * When multiple elements are selected, the value of
     * [text] will be all of the [Element]s' text values
     * joined together with spaces.
     *
     * Setting a value will set it for all selected elements.
     */
    String get text => _elements.map((e) => e.text).join(" ");

    void set text(String content) {
        for (var element in this)
            element.text = content;
    }

    List<Element> _append(Fletch selection) {
        var clones = [];
        for (var parent in this) {
            for (var child in selection) {
                if (document.contains(child)) {
                    var clone = child.clone(true);
                    clones.add(clone);
                    parent.append(clone);
                }
                else
                    parent.append(child);
            }
        }

        return clones;
    }

    /**
     * Appends one or more [Element]s as children of the
     * selected [Element]s.
     *
     * [selection] may be any selector accepted by the
     * [Fletch] constructor.
     *
     * When multiple elements are selected, the provided
     * elements will be appended to the first selected
     * element. All other selected elements will have
     * clones of the provided elements appended to them.
     * Note that event listeners on the elements are *not*
     * cloned.
     */
    void append(dynamic selection) {
        selection = new Fletch(selection);

        _append(selection);
    }

    /**
     * Appends the selected [Element]s as children to
     * one or more other [Element]s.
     *
     * [selection] may be any selector accepted by the
     * [Fletch] constructor.
     *
     * When multiple elements are provided, the selected
     * elements will be appended to the first provided
     * element. All other provided elements will have
     * clones of the selected elements appended to them.
     * Note that event listeners on the elements are *not*
     * cloned.
     *
     * For convenience, all cloned elements are added
     * to the list of currently selected [Element]s,
     * allowing them to be manipulated by the current
     * [Fletch] instance.
     */
    void appendTo(dynamic selection) {
        selection = new Fletch(selection);

        // Add all of the newly-created elements to this selection
        _elements.addAll(selection._append(this));
    }

    /**
     * Removes all selected [Element]s from the DOM.
     */
    void remove() {
        for (var element in this)
            element.remove();
    }

    /**
     * The parent(s) of the currently selected [Element]s.
     */
    Fletch get parent => new Fletch(_elements.map((element) => element.parent).where((element) => element != null).toSet());

    /**
     * The children of the currently selected [Element]s.
     */
    Fletch get children => new Fletch(_elements.expand((element) => element.children).toSet());

    // IterableBase members
    /**
     * [Iterator] for the selected [Element]s.
     */
    Iterator<Element> get iterator => _elements.iterator;

    /**
     * The number of selected [Element]s.
     */
    int get length => _elements.length;

    /**
     * Gets an [Element] from the selection at the specified index.
     */
    Element operator[](int index) => _elements[index];

    /**
     * Gets an [Element] from the selection at the specified index.
     */
    Element elementAt(int index) => _elements[index];
}

/**
 * Constructs a [Fletch] wrapper from any valid source of
 * [Element]s.
 *
 * Valid sources are:
 * + A [String] CSS selector used to match elements
 * + A [String] of HTML to parse into an element
 * + An [Element]
 * + An [Iterable] of [Element]
 * + A [HtmlDocument]
 * + A [Fletch] (will simply return the original object)
 *
 * If a second parameter is supplied, it will be used as
 * the top-level element to run the CSS selector as. For
 * other sources, the second parameter is ignored.
 *
 * This is shorthand for `new Fletch(selection, context)`
 */
Fletch $(dynamic selection, [dynamic context]) => new Fletch(selection, context);

// Here be the utility functions
_coalesce(value, defaultValue) {
    return value == null ? defaultValue : value;
}