extends Area2D

@export var is_real: bool = false
@export var portal_scene: PackedScene
@export var target_level_path: String = "res://scenes/Level/Lv11.tscn"
@onready var marker: Marker2D = $Marker2D

# Lấy PortalManager trong scene gốc
func get_manager() -> Node:
	return get_tree().current_scene.get_node("PortalManager")

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	_consumed = false

var _consumed := false

func _on_body_entered(body: Node) -> void:
	if _consumed:
		return
	if not body.is_in_group("Player"):
		return

	var manager = get_manager()
	if manager == null:
		push_error("PortalManager không tồn tại trong scene. Hãy thêm một node tên 'PortalManager'.")
		return

	if is_real:
		# Cổng thật → mở UI Next, lưu level đích
		_consumed = true
		GameData.next_level_path = target_level_path
		get_tree().change_scene_to_file("res://scenes/Next.tscn")
		return

	# Cổng giả 2 bước
	if manager.portal1_position == Vector2.ZERO:
		# Bước 1: chạm cổng tại điểm 1 → lưu điểm 1 và spawn cổng 2 ở Marker
		manager.portal1_position = global_position
		if portal_scene:
			var new_portal := portal_scene.instantiate()
			get_tree().current_scene.add_child(new_portal)
			new_portal.global_position = marker.global_position
			# Đảm bảo lần chạm kế tiếp mở UI Next
			GameData.next_level_path = target_level_path
	else:
		# Bước 2: chạm cổng tại điểm 2 → mở UI Next và reset trạng thái
		_consumed = true
		manager.reset()
		GameData.next_level_path = target_level_path
		get_tree().change_scene_to_file("res://scenes/Next.tscn")

	queue_free()
