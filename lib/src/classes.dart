part of fletch;

abstract class ClassCollection {
    Fletch _parent;

    /**
     * Adds a CSS class to the selected elements.
     *
     * If the class is already present, nothing happens.
     */
    void add(String className) {
        for (var element in _parent)
            element.classes.add(className);
    }

    /**
     * Removes a CSS class from the selected elements.
     *
     * If the class is not present, nothing happens.
     */
    void remove(String className) {
        for (var element in _parent)
            element.classes.remove(className);
    }

    /**
     * Toggles a CSS class on the selected elements.
     *
     * Elements that do not have this class will have it added,
     * while elements that do have this class will have it removed.
     */
    void toggle(String className) {
        for (var element in _parent)
            element.classes.toggle(className);
    }
}

class _ClassCollection extends ClassCollection {}