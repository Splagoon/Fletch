import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";

void coreTest() {
    group("Fletch object", () {
        test("should get text on all elements", () {
            expect($("h1").text, equals("Fletch Test"));
            expect($("#first-list li").text, equals("South North West East"));
            expect($(null).text, equals(""));
        });

        test("should set text on all elements", () {
            var list = $("#first-list li")..text = "Test";
            for (var li in list)
                expect(li.text, equals("Test"));

            expect(() => $(null).text = "Test", returnsNormally);
        });

        test("should get empty text when no elements are selected", () {
            expect($(null).text, isEmpty);
        });

        test("should get HTML on first element", () {
            expect($("div.html").html, equals("<em>Here is an emphasized element.</em>"));
        });

        test("should set HTML on all elements", () {
            $(".html").html = "<span class='html'>Test</span>";
            expect($("div.html span.html"), hasLength(2));
        });

        test("should get empty HTML when no elements are selected", () {
            expect($(null).html, isEmpty);
        });

        test("should append single element to single element", () {
            $("#container").append("<div>Append Test</div>");
            expect($("#container div").last.text, equals("Append Test"));
        });

        test("should append single element to multiple elements", () {
            $("#second-list li").append("<span>Test</span>");
            expect($("#second-list li span"), hasLength(3));
        });

        test("should append multiple elements to single element", () {
            $("body").append([new Element.br(), new Element.br()]);
            expect($("br"), hasLength(2));
        });

        test("should append multiple elements to multiple elements", () {
            $("ul").append([new Element.li(), new Element.li(), new Element.li()]);
            expect($("li"), hasLength(13));
        });

        test("should include cloned elements in selection when using appendTo", () {
            expect($("<span>")..appendTo(".content"), hasLength(9));
        });

        test("should remove elements from DOM", () {
            $(".remove.first").remove();
            expect($(".remove"), hasLength(2));

            $(".remove").remove();
            expect($(".remove"), isEmpty);
        });

        test("should get parent of elements", () {
            expect($("#first-list").parent.single.id, equals("container"));
            expect($(".content").parent, hasLength(1));
            expect($("li").parent, hasLength(2));
        });

        test("should get children of elements", () {
            expect($("#header").children, hasLength(3));
            expect($("h1").children, isEmpty);
        });
    });
}