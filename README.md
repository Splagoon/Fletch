# Fletch
### jQuery for Dart

Fletch is a [Dart](https://www.dartlang.org/) library aiming to provide similar
functionality to [jQuery](http://jquery.com/).  However, Fletch is _not_
designed to be API-compatible with jQuery, instead preferring to take advantage
of Dart features and design patterns.

For example, here is a snippet of jQuery:
```javascript
$("<a>").text("Dart is cool!")
        .attr("href", "https://www.dartlang.org/")
        .style("font-weight", "bold")
        .appendTo("body");
```

Here is the equivalent code in Fletch:
```dart
$("<a>")..text = "Dart is cool!"
        ..attr["href"] = "https://www.dartlang.org/"
        ..style["font-weight"] = "bold"
        ..appendTo("body");
```

Fletch is very mucha  work in progress.  So far, you can select/create
elements, get/set text, get/set styles, add/remove classes, get/set attributes,
and listen to/trigger events. Fletch should be considered **alpha quality**, as
the public-facing API may change radically between releases.

Fletch is released under the **ISC License**, which is functionally equivalent
to the BSD-2 and MIT licenses. See the `LICENSE` file for more information.