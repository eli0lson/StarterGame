extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_position_and_rotation(pos: Vector2, rot):
	print(pos, rot)
	position = pos
	rotation = rot
