extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"../Rotate_Simple_Spike".rad = -0.01
		call_deferred("set_monitoring", false)
