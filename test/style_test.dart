import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";

void styleTest() {
    group("Fletch styles", () {
        test("should get computed property value on first element", () {
            expect($("p").style["text-align"], equals("center"));
        });

        test("should set single property value on all elements", () {
            $("p").style["color"] = "red";
            expect($("p[data-purpose='summary']").style["color"], equals("rgb(255, 0, 0)"));
            expect($("p[data-purpose='testing']").style["color"], equals("rgb(255, 0, 0)"));
        });

        test("should set multiple property values on all elements", () {
            $("p").style({
                "line-height": "25px",
                "font-family": "serif",
                "background-color": "yellow"
            });

            expect($("p[data-purpose='summary']").style["line-height"], equals("25px"));
            expect($("p[data-purpose='summary']").style["font-family"], equals("serif"));
            expect($("p[data-purpose='summary']").style["background-color"], equals("rgb(255, 255, 0)"));
            expect($("p[data-purpose='testing']").style["line-height"], equals("25px"));
            expect($("p[data-purpose='testing']").style["font-family"], equals("serif"));
            expect($("p[data-purpose='testing']").style["background-color"], equals("rgb(255, 255, 0)"));
        });

        test("should get empty value for nonexistant property", () {
            expect($("p").style["does-not-exist"], isEmpty);
        });

        test("should not fail with no elements selected", () {
            expect(() => $(null).style["color"], returnsNormally);
            expect(() => $(null).style["color"] = "red", returnsNormally);
        });
    });
}