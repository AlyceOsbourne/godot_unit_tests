@tool
extends EditorPlugin

var run_tests_btn: Button
var export = Export.new()

func _ready() -> void:
    run_tests_btn.pressed.connect(UnitTest.run)
    run_tests_btn.text = "✅"

func _enter_tree() -> void:
    run_tests_btn = Button.new()
    get_editor_interface().get_command_palette().add_command("Run Unit Tests.", "run_unit_tests", UnitTest.run, "Run all defined unit tests")
    add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, run_tests_btn)
    add_export_plugin(export)

func _exit_tree() -> void:
    remove_export_plugin(export)
    get_editor_interface().get_command_palette().remove_command("run_unit_tests")
    remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, run_tests_btn)
    run_tests_btn.queue_free()


class Export extends EditorExportPlugin:
    func _export_file(path: String, type: String, features: PackedStringArray) -> void:
        print("type: %s" % type)

    func _get_name() -> String:
        return "UnitTestExclude"
