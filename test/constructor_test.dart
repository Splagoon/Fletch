import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";

void constructorTest() {
    group("Fletch constructor", () {
        test("should accept CSS selector strings", () {
            expect($(".content"), hasLength(9));
        });

        test("should throw SyntaxError with invalid CSS selector strings", (){
            expect(() => $("?"), throwsA(predicate((e) => e is DomException && e.name == DomException.SYNTAX)));
        });

        test("should accept CSS selector strings with a single context", () {
            expect($("li", "#first-list"), hasLength(4));
            expect($("li", "#second-list"), hasLength(3));
        });

        test("should accept CSS selector strings with multiple contexts", () {
            expect($("li", "ul"), hasLength(7));
        });

        test("should accept HTML strings", () {
            expect($("<div>Test</div>"), hasLength(1));
            expect($("<div><div>"), hasLength(1));
            expect($("<div> >"), hasLength(1));
        });

        test("should throw ArgumentError with invalid HTML strings", () {
            expect(() => $("</div>"), throwsArgumentError);
        });

        test("should accept HTML elements", () {
            expect($(new Element.div()), hasLength(1));
        });

        test("should accept collections of HTML elements", () {
            expect($([new Element.div(), new Element.span(), new Element.div()]), hasLength(3));
        });

        test("should accept HTML documents", () {
            expect($(document), hasLength(1));
        });

        test("should accept Fletch instances and return the same instance", () {
            var fletch = $("div");
            expect($(fletch), same(fletch));
        });

        test("should accept null", () {
            expect($(null), isEmpty);
        });
    });
}