import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";

void attributeTest() {
    group("Fletch attributes", () {
        test("should get value on first element", () {
            expect($("p").attr["data-purpose"], equals("summary"));
        });

        test("should set single value on all elements", () {
            $("p").attr["data-attribute-test"] = "here is a test";
            expect($("[data-attribute-test]"), hasLength(2));
        });

        test("should set multiple values on all elements", () {
            $("p").attr({
                "data-multi-attr-test-1": "here is a test",
                "data-multi-attr-test-2": "here is another test",
                "data-multi-attr-test-3": "here is yet another test"
            });

            expect($("[data-multi-attr-test-1][data-multi-attr-test-2][data-multi-attr-test-3]"), hasLength(2));
        });

        test("should get empty value for nonexistant attribute", () {
            expect($("p").attr["data-does-not-exist"], isEmpty);
        });

        test("should not fail with no elements selected", () {
            expect(() => $(null).attr["data-does-not-exist"], returnsNormally);
            expect(() => $(null).attr["data-does-not-exist"] = "test", returnsNormally);
        });
    });
}