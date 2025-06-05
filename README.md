# UnitTest for Godot

## Overview
`UnitTest` is a lightweight testing framework for Godot, designed to automate unit testing of GDScript classes. It provides structured test discovery, assertion methods, and rich text output in the Godot console.

## Installation
Simply add the `unit_test` folder to your `addons` folder (creating it in the root of your project if it does not exist).

## Features
- **Automatic Test Discovery**: Runs all methods prefixed with `test_`.
- **Rich Console Output**: Uses color formatting for better readability.
- **Editor Integration**:
  - Adds a button to the top-right toolbar in the editor for quick test execution.
  - Adds a command to the command palette (`Run Unit Tests.`) for running all tests.
- **Exclusion Support**: Allows excluding specific test classes from execution.

## Writing Tests
To create a test case, create a new GDScript file that extends `UnitTest`. Define test methods with names prefixed with `test_`, and use the provided assertion methods to validate expected behavior.

### Example
```gdscript
class_name CPUFlagTests
extends UnitTest

static func test_ccf():
    var cpu = CPU.new()

    cpu._register.C = 0
    cpu._alu.ccf()
    assert_eq(cpu._register.C, 1, "CCF failed to toggle carry flag")

    cpu._alu.ccf()
    assert_eq(cpu._register.C, 0, "CCF failed to toggle carry flag back")

static func test_scf():
    var cpu = CPU.new()

    cpu._register.C = 0
    cpu._alu.scf()
    assert_eq(cpu._register.C, 1, "SCF failed to set carry flag")
    assert_eq(cpu._register.N, 0, "SCF failed: N flag should be reset")
    assert_eq(cpu._register.H, 0, "SCF failed: H flag should be reset")
```

## Running Tests
Tests are automatically discovered and executed when running `UnitTest.run()`. It will find all classes extending `UnitTest` and execute their test methods.

### Running All Tests
```gdscript
UnitTest.run()
```

### Running Tests with Exclusions
To exclude specific test classes:
```gdscript
UnitTest.run(["CPUFlagTests"])
```

### Running Tests from the Editor
- Click the **✅ button** in the top-right toolbar.
- Use the **command palette** (`Ctrl+Shift+P` or `Cmd+Shift+P` on macOS) and search for `Run Unit Tests.`

## Assertion Methods
The following assertions are available:

- `assert_eq(a, b, msg)`: Passes if `a == b`.
- `assert_neq(a, b, msg)`: Passes if `a != b`.
- `assert_true(value, msg)`: Passes if `value` is `true`.
- `assert_false(value, msg)`: Passes if `value` is `false`.
- `assert_almost_eq(a, b, tolerance, msg)`: Passes if `a` and `b` are within `tolerance`.
- `assert_in(element, collection, msg)`: Passes if `element` is in `collection`.
- `assert_not_in(element, collection, msg)`: Passes if `element` is not in `collection`.
- `assert_is_type(type, instance, msg)`: Passes if `instance` is of `type`.

## Output Formatting
Test results are displayed in the Godot console with rich text formatting:
- **Orange**: Test execution messages
- **Green**: Passed assertions
- **Red**: Failed assertions

## Notes
- Tests run only in the editor (`Engine.is_editor_hint()` is checked).
- If no tests are found, a message is displayed.

## License
This framework is free to use and modify. Contributions are welcome!

