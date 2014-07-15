part of fletch;

class _AttributeCollection {
    Fletch _parent;

    String operator[](String attribute) => _parent.first.attributes[attribute];

    void operator[]=(String attribute, String value) {
        for (var element in _parent)
            element.attributes[attribute] = value;
    }

    void call(Map<String, String> attributes) {
        for (var element in _parent)
            attributes.forEach((attribute, value) => element.attributes[attribute] = value);
    }
}