import 'dart:html';
import 'dart:math' show Random;
import 'package:fletch/fletch.dart';

var random = new Random();

void main() {
    $("button[name='random']").click.listen((evt, self) {
        evt.preventDefault();
        randomize();
    });

    $("form").submit.listen((evt, self) {
        evt.preventDefault();
        $("#output").html = $(self).serialize().replaceAllMapped(
            new RegExp("([^=]+)=([^&]+)(&?)"),
            (m) => '<div><span class="key">${m[1]}</span>=<span class="value">${m[2]}</span>${m[3]}</div>'
        );
    });
}

void randomize() {
    $("[name='name']").value = randomElement(["Catherine", "Paul", "Mary", "Anthony"]) + " " +
                               randomElement(["Piagenti", "Sinatra", "Smith", "Lewis"]);
    for (var checkbox in $("[type='checkbox']"))
        $(checkbox).checked = random.nextBool();

    $(randomElement($("[type='radio']"))).checked = true;

    $("select").value = $(randomElement($("select option"))).value;

    $("textarea").value = randomElement([
         "In ancient times, people would ",
         "My friends and I ",
         "The wild alpacas ",
         "The wizards of darkness "
    ]) + randomElement([
        "long for peace.",
        "love to go shopping.",
        "pass the time by golfing.",
        "eat, drink, and breathe video games."
    ]);
}

randomElement(array) {
    return array[random.nextInt(array.length)];
}