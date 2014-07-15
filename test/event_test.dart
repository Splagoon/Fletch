import "package:unittest/unittest.dart";
import "package:fletch/fletch.dart";
import "dart:html";
import "dart:async";

void eventTest() {
    group("Fletch events", () {
        test("should support single listener", () {
            var loaded = false;
            $("<img>")..load.listen((evt, self) => loaded = true)
                      ..attr["src"] = "test.jpg";

            new Timer(new Duration(seconds: 5), expectAsync(() {
                if (!loaded)
                    fail("Event listener timed out");
            }));
        });

        test("should support multiple listeners", () {
            var loaded1 = false;
            var loaded2 = false;
            $("<img>")..load.listen((evt, self) => loaded1 = true)
                      ..load.listen((evt, self) => loaded2 = true)
                      ..attr["src"] = "test.jpg";

            new Timer(new Duration(seconds: 5), expectAsync(() {
                if (!loaded1 || !loaded2)
                    fail("Event listeners timed out");
            }));
        });

        test("should support dispatching", () {
            var div = $("<div>")..text = "fail"
                                ..click.listen((evt, self) => $(self).text = "pass")
                                ..click();

            expect(div.text, equals("pass"));
        });

        test("should support custom events", () {
            var div = $("<div>")..text = "fail"
                                ..event["custom-event"].listen((evt, self) => $(self).text = "pass")
                                ..event["custom-event"]();

            expect(div.text, equals("pass"));
        });

        test("should not fail with no elements selected", () {
            expect(() => $(null).event["no-event"], returnsNormally);
            expect(() => $(null).event["no-event"].listen((evt, self) => null), returnsNormally);
        });
    });
}