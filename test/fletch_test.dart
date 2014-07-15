import "package:unittest/unittest.dart";
import "package:unittest/html_config.dart";
import "constructor_test.dart";
import "core_test.dart";
import "attribute_test.dart";
import "class_test.dart";
import "event_test.dart";
import "style_test.dart";
import "class_test.dart";

void main() {
    useHtmlConfiguration();

    constructorTest();
    coreTest();
    attributeTest();
    classTest();
    eventTest();
    styleTest();
}