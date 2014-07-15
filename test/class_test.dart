import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";

void classTest() {
    group("Fletch classes", () {
        test("should be able to add a class", () {
            $("<div>")..classes.add("test-class")
                      ..appendTo("body");
            expect($(".test-class"), hasLength(1));
        });

        test("should be able to remove a class", () {
            $("<div class='test-class-1 test-class-2'>")..classes.remove("test-class-1")
                                                        ..appendTo("body");
            expect($(".test-class-2:not(.test-class-1)"), hasLength(1));
        });

        test("should be able to toggle a class", () {
            $("<div><div id='test-toggle-1' class='test-toggle-class'></div><div id='test-toggle-2'></div></div>")
                    ..appendTo("body")
                    ..children.classes.toggle("test-toggle-class");
            expect($("#test-toggle-1:not(.test-toggle-class)"), hasLength(1));
            expect($("#test-toggle-2.test-toggle-class"), hasLength(1));
        });

        test("should not fail with no elements selected", () {
            expect(() => $(null).classes.add("test-class"), returnsNormally);
            expect(() => $(null).classes.remove("test-class"), returnsNormally);
            expect(() => $(null).classes.toggle("test-class"), returnsNormally);
        });
    });
}