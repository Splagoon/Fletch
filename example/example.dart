import 'dart:html';
import 'package:fletch/fletch.dart';

void main() {
    $("body").style["font-family"] = "sans-serif";

    $("<h1>")..text = "Fletch Example"
             ..appendTo("body");

    var list = $("<ul>")..appendTo("body");

    for (var i = 1; i <= 10; i++) {
        $("<li>List Item $i</li>")..style["width"] = "6rem"
                                  ..appendTo(list)
                                  ..click.listen((evt, self) => $(self).classes.toggle("loud"));
    }

    $("<a>")..text = "×"
            ..attr["href"] = "#"
            ..style({
                "color": "red",
                "text-decoration": "none",
                "float": "right"
            })
            ..appendTo("li")
            ..click.listen((evt, self) => $(self).parent.remove());
}