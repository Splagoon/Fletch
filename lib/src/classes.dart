part of fletch;

abstract class ClassCollection {
    Fletch _parent;

    /**
     * Checks if any of the selected elements has a specified CSS class.
     *
     * Note that this returns true if _at least one_ of the selected elements
     * has the specified class.
     */
    bool contains(String className) {
        return _parent.any((e) => e.classes.contains(className));
    }

    /**
     * Checks if any of the selected elements has all of the specified CSS classes.
     *
     * Note that this returns true if _at least one_ of the selected elements has
     * _all_ of the specified classes.
     *
     * If you want to check if the selection has _some_ of the specified CSS
     * classes, use [containsAny] instead.
     */
    bool containsAll(Iterable<String> classNames) {
        return _parent.any((e) => e.classes.containsAll(classNames));
    }

    /**
     * Checks if any of the selected elements has any of the specified CSS classes.
     *
     * Note that this returns true if _at least one_ of the selected elements has
     * _at least one_ of the specified classes.
     *
     * If you want to check if the selection has _all_ of the specified CSS
     * classes, use [containsAll] instead.
     */
    bool containsAny(Iterable<String> classNames) {
        return _parent.any((e) => e.classes.any(classNames.contains));
    }

    /**
     * Adds a CSS class to the selected elements.
     *
     * If the class is already present on an element, it is ignored.
     */
    void add(String className) {
        for (var element in _parent)
            element.classes.add(className);
    }

    /**
     * Adds a range of CSS classes to the selected elements.
     *
     * If any classes are already present on an element, they are ignored.
     */
    void addAll(Iterable<String> classNames) {
        for (var element in _parent)
            element.classes.addAll(classNames);
    }

    /**
     * Removes a CSS class from the selected elements.
     *
     * If the class is not present on an element, it is ignored.
     */
    void remove(String className) {
        for (var element in _parent)
            element.classes.remove(className);
    }

    /**
     * Removes a range of CSS classes from the selected elements.
     *
     * If any classes are not present on an element, they are ignored.
     */
    void removeAll(Iterable<String> classNames) {
        for (var element in _parent)
            element.classes.removeAll(classNames);
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

    /**
     * Toggles a range of CSS classes on the selected elements.
     *
     * For each class, elements that do not have the class will have it added,
     * while elements that do have the class will have it removed.
     */
    void toggleAll(Iterable<String> classNames) {
        for (var element in _parent)
            element.classes.toggleAll(classNames);
    }
}

class _ClassCollection extends ClassCollection {}