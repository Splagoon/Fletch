part of fletch;

class _StyleCollection {
    Fletch _parent;

    String operator[](String property) => _parent.first.getComputedStyle().getPropertyValue(property);

    void operator[]=(String property, String value) {
        for (var element in _parent)
            element.style.setProperty(property, value);
    }

    void call(Map<String, String> properties) {
        for (var element in _parent)
            properties.forEach((property, value) => element.style.setProperty(property, value));
    }
}

