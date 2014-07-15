part of fletch;

typedef void _FletchEventListener(Event event, Element self);

class _EventFunctor {
    final String _event;
    final Iterable<Element> _elements;

    _EventFunctor(this._event, this._elements);

    /**
     * Dispatches the event on all selected elements.
     */
    void call() {
        for (var element in _elements)
            element.dispatchEvent(new Event(_event));
    }

    /**
     * Adds a listener for the event on all selected elements.
     *
     * For multiple listeners, call this method multiple times.
     */
    void listen(_FletchEventListener listener) {
        for (var element in _elements)
            element.on[_event].listen((evt) => listener(evt, element));
    }

    // TODO: Unsubscribe from events
}

class _EventCollection {
    Fletch _parent;

    /**
     * Gets an event by name.
     *
     * The returned object can be used to dispatch and listen for the event.
     */
    _EventFunctor operator[](String event) => new _EventFunctor(event, _parent);
}

abstract class _EventMixin {
    List<Element> _elements;

    /** Shorthand for `event["click"]` */
    _EventFunctor get click       => new _EventFunctor("click",     _elements);

    /** Shorthand for `event["resize"]` */
    _EventFunctor get resize      => new _EventFunctor("resize",    _elements);

    /** Shorthand for `event["scroll"]` */
    _EventFunctor get scroll      => new _EventFunctor("scroll",    _elements);

    /** Shorthand for `event["load"]` */
    _EventFunctor get load        => new _EventFunctor("load",      _elements);

    /** Shorthand for `event["unload"]` */
    _EventFunctor get unload      => new _EventFunctor("unload",    _elements);

    /** Shorthand for `event["blur"]` */
    _EventFunctor get blur        => new _EventFunctor("blur",      _elements);

    /** Shorthand for `event["change"]` */
    _EventFunctor get change      => new _EventFunctor("change",    _elements);

    /** Shorthand for `event["focus"]` */
    _EventFunctor get focus       => new _EventFunctor("focus",     _elements);

    /** Shorthand for `event["focusin"]` */
    _EventFunctor get focusIn     => new _EventFunctor("focusin",   _elements);

    /** Shorthand for `event["focusOut"]` */
    _EventFunctor get focusOut    => new _EventFunctor("focusout",  _elements);

    /** Shorthand for `event["select"]` */
    _EventFunctor get select      => new _EventFunctor("select",    _elements);

    /** Shorthand for `event["submit"]` */
    _EventFunctor get submit      => new _EventFunctor("submit",    _elements);

    /** Shorthand for `event["keydown"]` */
    _EventFunctor get keyDown     => new _EventFunctor("keydown",   _elements);

    /** Shorthand for `event["keypress"]` */
    _EventFunctor get keyPress    => new _EventFunctor("keypress",  _elements);

    /** Shorthand for `event["keyup"]` */
    _EventFunctor get keyUp       => new _EventFunctor("keyUp",     _elements);

    /** Shorthand for `event["dblclick"]` */
    _EventFunctor get doubleClick => new _EventFunctor("dblclick",  _elements);

    /** Shorthand for `event["hover"]` */
    _EventFunctor get hover       => new _EventFunctor("hover",     _elements);

    /** Shorthand for `event["mousedown"]` */
    _EventFunctor get mouseDown   => new _EventFunctor("mousedown", _elements);

    /** Shorthand for `event["mousemove"]` */
    _EventFunctor get mouseMove   => new _EventFunctor("mousemove", _elements);

    /** Shorthand for `event["mouseout"]` */
    _EventFunctor get mouseOut    => new _EventFunctor("mouseout",  _elements);

    /** Shorthand for `event["mouseover"]` */
    _EventFunctor get mouseOver   => new _EventFunctor("mouseover", _elements);

    /** Shorthand for `event["mouseup"]` */
    _EventFunctor get mouseUp     => new _EventFunctor("mouseup",   _elements);
}

