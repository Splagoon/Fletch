import "package:unittest/unittest.dart";
import "package:unittest/html_config.dart";
import "constructor_test.dart";
import "core_test.dart";

void main() {
    useHtmlConfiguration();

    constructorTest();
    coreTest();

    // TODO: attribute test, event test, style test
}