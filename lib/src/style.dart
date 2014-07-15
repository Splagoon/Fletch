part of fletch;

class _StyleCollection {
    Fletch _parent;

    /**
     * Gets the *computed* CSS value for the given property of the first
     * selected element.
     *
     * If the property does not exist or has no value, an empty string is
     * returned.
     */
    String operator[](String property) => _parent.length > 0 ? _parent.first.getComputedStyle().getPropertyValue(property) : "";

    /**
     * Sets the value for a CSS property on all selected elements.
     */
    void operator[]=(String property, String value) {
        for (var element in _parent)
            element.style.setProperty(property, value);
    }

    /**
     * Sets multiple CSS properties on the selected elements.
     * For example:
     *
     *     $("div").style({
     *         "font-family": "sans-serif",
     *         "font-weight": "bold",
     *         "text-shadow": "1px 1px 0 black"
     *     });
     *
     */
    void call(Map<String, String> properties) {
        for (var element in _parent)
            properties.forEach((property, value) => element.style.setProperty(property, value));
    }
}

