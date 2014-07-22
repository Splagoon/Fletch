import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";

void classTest() {
    group("Fletch classes", () {
        test("should be able to check if any elements have a class", () {
            expect($("<div><div></div><div class='test-1'></div></div>").children.classes.contains("test-1"), isTrue);
            expect($("li").classes.contains("contains-test"), isFalse);
        });

        test("should be able to check if any elements have all of a range classes", () {
            expect($("<div><div></div><div class='test-1 test-2'></div></div>").children.classes.containsAll(["test-1", "test-2"]), isTrue);
            expect($(".content").classes.containsAll(["content", "contains-test"]), isFalse);
        });

        test("should be able to check if any elements have any of a range of classes", () {
            expect($("<div><div></div><div class='test-1'></div></div>").children.classes.containsAny(["test-1", "test-2"]), isTrue);
            expect($(".content").classes.containsAny(["contains-test-1", "contains-test-2"]), isFalse);
        });

        test("should be able to add a class", () {
            $("<div>")..classes.add("test-class")
                      ..appendTo("body");
            expect($(".test-class"), hasLength(1));
        });

        test("should be able to add multiple classes", () {
            $("<div>")..classes.addAll(["multi-class-1", "multi-class-2"])
                      ..appendTo("body");
            expect($(".multi-class-1.multi-class-2"), hasLength(1));
        });

        test("should be able to remove a class", () {
            $("<div class='test-class-1 test-class-2'>")..classes.remove("test-class-1")
                                                        ..appendTo("body");
            expect($(".test-class-2:not(.test-class-1)"), hasLength(1));
        });

        test("should be able to remove multiple classes", () {
            $("<div class='multi-class-a multi-class-b multi-class-c'>")
                    ..classes.removeAll(["multi-class-a", "multi-class-c"])
                    ..appendTo("body");
            expect($(".multi-class-b:not(.multi-class-a):not(.multi-class-c)"), hasLength(1));
        });

        test("should be able to toggle a class", () {
            $("<div><div id='test-toggle-1' class='test-toggle-class'></div><div id='test-toggle-2'></div></div>")
                    ..appendTo("body")
                    ..children.classes.toggle("test-toggle-class");
            expect($("#test-toggle-1:not(.test-toggle-class)"), hasLength(1));
            expect($("#test-toggle-2.test-toggle-class"), hasLength(1));
        });

        test("should be able to toggle multiple classes", () {
            $("<div><div id='test-toggle-1' class='multi-toggle-class-1'></div><div id='test-toggle-2' class='multi-toggle-class-2'></div></div>")
                    ..appendTo("body")
                    ..children.classes.toggleAll(["multi-toggle-class-1", "multi-toggle-class-2"]);
            expect($("#test-toggle-1.multi-toggle-class-2:not(.multi-toggle-class-1)"), hasLength(1));
            expect($("#test-toggle-2.multi-toggle-class-1:not(.multi-toggle-class-2)"), hasLength(1));
        });

        test("should not fail with no elements selected", () {
            expect(() => $(null).classes.contains("test-class"), returnsNormally);
            expect(() => $(null).classes.containsAll(["test-class-1", "test-class-2"]), returnsNormally);
            expect(() => $(null).classes.containsAny(["test-class-1", "test-class-2"]), returnsNormally);
            expect(() => $(null).classes.add("test-class"), returnsNormally);
            expect(() => $(null).classes.addAll(["test-class-1", "test-class-2"]), returnsNormally);
            expect(() => $(null).classes.remove("test-class"), returnsNormally);
            expect(() => $(null).classes.removeAll(["test-class-1", "test-class-2"]), returnsNormally);
            expect(() => $(null).classes.toggle("test-class"), returnsNormally);
            expect(() => $(null).classes.toggleAll(["test-class-1", "test-class-2"]), returnsNormally);
        });
    });
}