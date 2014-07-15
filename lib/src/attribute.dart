part of fletch;

class _AttributeCollection {
    Fletch _parent;

    /**
     * Gets the value for an attribute on the first selected element.
     *
     * If the attribute is not set, an empty string is returned.
     */
    String operator[](String attribute) => _coalesce(_parent.length > 0 ? _parent.first.attributes[attribute] : null, "");

    /**
     * Sets the value for an attribute on all selected elements.
     *
     * Any selected elements without the attribute will have it added.
     */
    void operator[]=(String attribute, String value) {
        for (var element in _parent)
            element.attributes[attribute] = value;
    }

    /**
     * Sets multiple attributes on the selected elements.
     *
     * [attributes] is a [Map] of attribute names to their values.
     * For example:
     *
     *     $("div").attr({
     *         "data-one": "value one",
     *         "data-two": "value two",
     *         "data-etc": "and so on"
     *     });
     *
     */
    void call(Map<String, String> attributes) {
        for (var element in _parent)
            attributes.forEach((attribute, value) => element.attributes[attribute] = value);
    }
}