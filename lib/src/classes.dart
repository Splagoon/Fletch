part of fletch;

class _ClassCollection {
    Fletch _parent;

    void add(String className) {
        for (var element in _parent)
            element.classes.add(className);
    }

    void remove(String className) {
        for (var element in _parent)
            element.classes.remove(className);
    }

    void toggle(String className) {
        for (var element in _parent)
            element.classes.toggle(className);
    }
}