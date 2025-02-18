@tool
class_name UnitTest

func _init():
    var methods = get_method_list().filter(func(x): return (x.name as String).begins_with("test_"))
    if methods.is_empty():
        print_rich("    [b][color=orange]▶ No tests to perform[/color][/b]")

    for method in methods:
        var method_name = method.name
        print_rich("    [b][color=orange]▶ Running test method:[/color][/b] [b]%s[/b]" % method_name)
        call(method_name)
        print_rich("    [b][color=light_green]✔ Test method [b]%s[/b] succeeded[/color][/b]\n" % method_name)

static func run(exclude:Array[String] = []) -> void:
    if not Engine.is_editor_hint():
        return

    var test_classes = ProjectSettings.get_global_class_list().filter(func(x): return x.base == "UnitTest").map(func(x): return load(x.path))
    var n = test_classes.size()

    print_rich("\n[b][color=sky_blue]=========================================[/color][/b]")
    print_rich("[b][color=sky_blue]UNIT TESTS STARTING (%s TOTAL)[/color][/b]" % n)
    print_rich("[b][color=sky_blue]=========================================[/color][/b]\n")

    for i in n:
        var cls = test_classes[i]
        if cls == null:
            continue
        if cls.get_global_name() in exclude:
            continue

        print_rich("[b][color=yellow]Running test %s of %s:[/color][/b] [b]%s[/b]\n" % [i + 1, n, (cls as GDScript).get_global_name()])
        print_rich("[b][color=sky_blue]=========================================[/color][/b]")

        cls.new()

        print_rich("[b][color=light_green]✔ Finished testing [b]%s[/b][/color][/b]\n" % cls.get_global_name())
        print_rich("[b][color=sky_blue]=========================================[/color][/b]\n")

    print_rich("[b][color=white]ALL TESTS COMPLETED SUCCESSFULLY[/color][/b]\n")
    print_rich("[b][color=sky_blue]=========================================[/color][/b]\n")

static func assert_eq(a: Variant, b: Variant, msg := "") -> void:
    if a != b:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] %s != %s %s" % [a, b, msg])
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] %s == %s" % [a, b])

static func assert_neq(a: Variant, b: Variant, msg := "") -> void:
    if a == b:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] %s == %s %s" % [a, b, msg])
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] %s != %s" % [a, b])

static func assert_true(value: Variant, msg := "") -> void:
    if not value:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] Expected true but got false %s" % msg)
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] Value is true")

static func assert_false(value: Variant, msg := "") -> void:
    if value:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] Expected false but got true %s" % msg)
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] Value is false")

static func assert_almost_eq(a: Variant, b: Variant, tolerance: float = 0.000001, msg := "") -> void:
    if abs(a - b) > tolerance:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] %s ≉ %s within %s %s" % [a, b, tolerance, msg])
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] %s ≈ %s within %s" % [a, b, tolerance])

static func assert_in(element: Variant, collection, msg := "") -> void:
    if element not in collection:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] %s not found in collection %s %s" % [element, collection, msg])
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] %s is in collection" % element)

static func assert_not_in(element: Variant, collection, msg := "") -> void:
    if element in collection:
        print_rich("    [b][color=red]✖ Assertion Failed:[/color][/b] %s found in collection %s %s" % [element, collection, msg])
    else:
        print_rich("    [b][color=light_green]✔ Assertion Passed:[/color][/b] %s is not in collection" % element)
