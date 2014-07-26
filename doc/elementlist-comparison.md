Feature                                                 | Fletch                            | ElementList
--------------------------------------------------------|-----------------------------------|------------------------------------------
Append other elements to these elements                 | `.append(elements)`               | _Not Supported_
Append these elements to other elements                 | `.appendTo(elements)`             | _Not Supported_
Get an attribute for the first element                  | `.attr["name"]`                   | _Not Supported_
Set an attribute on all elements                        | `.attr["name"] = "value"`         | _Not Supported_
Get the combined children of all elements               | `.children`                       | _Not Supported_
Add a class to all elements                             | `.classes.add("class")`           | `.classes.add("class")`
Remove a class from all elements                        | `.classes.remove("class")`        | `.classes.remove("class")`
Toggle a class on all elements                          | `.classes.toggle("class")`        | `.classes.toggle("class")`
Trigger a built-in event on all elements                | `.click()`                        | _Not Supported_
Add a listener to a built-in event on all elements      | `.click.listen(listener)`         | `.onClick.listen(listener)`
Remove a listener from a built-in event on all elements | _Not Supported_                   | _Not Supported_
Trigger a custom event on all elements                  | `.event["name"]()`                | _Not Supported_
Add a listener to a custom event on all elements        | `.event["name"].listen(listener)` | _Not Supported_
Remove a listener from a custom event on all elements   | _Not Supported_                   | _Not Supported_
Get the combined parents of all elements                | `.parent`                         | _Not Supported_
Get the combined text content of all elements           | `.text`                           | _Not Supported_
Set the text content of all elements                    | `.text = "value"`                 | _Not Supported_
Get the HTML content of the first element               | `.html`                           | _Not Supported_
Set the HTML content of all elements                    | `.html = "value"`                 | _Not Supported_
Get the value for a style property on the first element | `.style["property"]`              | `.style.getPropertyValue("property")`
Set the value for a style property on all elements      | `.style["property"] = "value"`    | `.style.setProperty("property", "value")`