part of fletch;

/**
 * The signature for event listeners handled by Fletch.
 *
 * [event] is a reference to the fired event, and [self] is
 * a reference to the element owning the listener.
 */
typedef void FletchEventListener(Event event, Element self);

abstract class EventSubscription {
    final Iterable<StreamSubscription> _subscriptions;

    EventSubscription._new(this._subscriptions);

    void cancel() {
        for (var subscription in _subscriptions)
            subscription.cancel();
    }
}

class _EventSubscription extends EventSubscription {
    _EventSubscription(subscriptions) : super._new(subscriptions);
}

abstract class EventFunctor {
    final String _event;
    final Iterable<Element> _elements;

    EventFunctor._new(this._event, this._elements);

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
    EventSubscription listen(FletchEventListener listener) {
        var subs = [];
        for (var element in _elements)
            subs.add(element.on[_event].listen((evt) => listener(evt, element)));
        return new _EventSubscription(subs);
    }
}

class _EventFunctor extends EventFunctor {
    _EventFunctor(event, elements) : super._new(event, elements);
}

abstract class EventCollection {
    Fletch _parent;

    /**
     * Gets an event by name.
     *
     * The returned object can be used to dispatch and listen for the event.
     */
    EventFunctor operator[](String event) => new _EventFunctor(event, _parent);
}

class _EventCollection extends EventCollection {}

abstract class _EventMixin {
    List<Element> _elements;

    /** Shorthand for `event["click"]` */
    EventFunctor get click       => new _EventFunctor("click",     _elements);

    /** Shorthand for `event["resize"]` */
    EventFunctor get resize      => new _EventFunctor("resize",    _elements);

    /** Shorthand for `event["scroll"]` */
    EventFunctor get scroll      => new _EventFunctor("scroll",    _elements);

    /** Shorthand for `event["load"]` */
    EventFunctor get load        => new _EventFunctor("load",      _elements);

    /** Shorthand for `event["unload"]` */
    EventFunctor get unload      => new _EventFunctor("unload",    _elements);

    /** Shorthand for `event["blur"]` */
    EventFunctor get blur        => new _EventFunctor("blur",      _elements);

    /** Shorthand for `event["change"]` */
    EventFunctor get change      => new _EventFunctor("change",    _elements);

    /** Shorthand for `event["focus"]` */
    EventFunctor get focus       => new _EventFunctor("focus",     _elements);

    /** Shorthand for `event["focusin"]` */
    EventFunctor get focusIn     => new _EventFunctor("focusin",   _elements);

    /** Shorthand for `event["focusOut"]` */
    EventFunctor get focusOut    => new _EventFunctor("focusout",  _elements);

    /** Shorthand for `event["select"]` */
    EventFunctor get select      => new _EventFunctor("select",    _elements);

    /** Shorthand for `event["submit"]` */
    EventFunctor get submit      => new _EventFunctor("submit",    _elements);

    /** Shorthand for `event["keydown"]` */
    EventFunctor get keyDown     => new _EventFunctor("keydown",   _elements);

    /** Shorthand for `event["keypress"]` */
    EventFunctor get keyPress    => new _EventFunctor("keypress",  _elements);

    /** Shorthand for `event["keyup"]` */
    EventFunctor get keyUp       => new _EventFunctor("keyUp",     _elements);

    /** Shorthand for `event["dblclick"]` */
    EventFunctor get doubleClick => new _EventFunctor("dblclick",  _elements);

    /** Shorthand for `event["hover"]` */
    EventFunctor get hover       => new _EventFunctor("hover",     _elements);

    /** Shorthand for `event["mousedown"]` */
    EventFunctor get mouseDown   => new _EventFunctor("mousedown", _elements);

    /** Shorthand for `event["mousemove"]` */
    EventFunctor get mouseMove   => new _EventFunctor("mousemove", _elements);

    /** Shorthand for `event["mouseout"]` */
    EventFunctor get mouseOut    => new _EventFunctor("mouseout",  _elements);

    /** Shorthand for `event["mouseover"]` */
    EventFunctor get mouseOver   => new _EventFunctor("mouseover", _elements);

    /** Shorthand for `event["mouseup"]` */
    EventFunctor get mouseUp     => new _EventFunctor("mouseup",   _elements);
}

