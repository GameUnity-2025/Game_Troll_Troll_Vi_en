extends Node2D



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level/Lv2.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
