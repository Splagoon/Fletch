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

        test("should get empty input value when no elements are selected", () {
            expect($(null).value, isEmpty);
        });

        test("should get empty input value when no inputs are selected", () {
            expect($("div").value, isEmpty);
        });

        test("should get input value on first element", () {
            expect($("input[type='checkbox']").value, equals("tést:valué"));
        });

        test("should set input value on all elements", () {
            var hiddens = $("input[type='hidden']")..value = "this is a test";
            for (var hidden in hiddens)
                expect(hidden.value, equals("this is a test"));
        });

        test("should not fail when setting value on non-input elements", () {
            expect(() => $("div").value = "test", returnsNormally);
        });

        test("should report as unchecked when no elements are selected", () {
            expect($(null).checked, isFalse);
        });

        test("should report as unchecked when no checkable elements are selected", () {
            expect($("div").checked, isFalse);
        });

        test("should get checked state on first element", () {
            expect($("input[type='checkbox']").checked, isTrue);
        });

        test("should set checked state on all elements", () {
            var checks = $("input[name='check-input-2']")..checked = true;
            for (var check in checks)
                expect(check.checked, isTrue);
        });

        test("should uncheck previous value when checking a radio button", () {
            var radios = $("input[type='radio']");
            var first = $(radios.first);
            var second = $(radios.last);

            expect(first.checked, isTrue);
            expect(second.checked, isFalse);

            second.checked = true;

            expect(first.checked, isFalse);
            expect(second.checked, isTrue);
        });

        test("should serialize single element", () {
            expect($("input[type='text']").serialize(), equals("text-input=test+value"));
        });

        test("should serialize multiple elements", () {
            expect($("input[type='text'], textarea").serialize(),
                    equals("text-input=test+value&ta-input=The+quick%2C+brown+fox+jumps+over+the+lazy+dog."));
        });

        test("should serialize multi-value inputs multiple times", () {
            expect($("input[name='check-input']").serialize(),
                    equals("check-input=t%C3%A9st%3Avalu%C3%A9&check-input=%E3%83%86%E3%82%B9%E3%83%88"));
        });

        test("should serialize empty string when no inputs are selected", () {
            expect($("ul").serialize(), isEmpty);
        });

        test("should serialize empty string when no elements are selected", () {
            expect($(null).serialize(), isEmpty);
        });
    });
}