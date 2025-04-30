extends Node

@export var projectile_image = "up"
@export var stats: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#stats = {
		#"clothes": "none",
		#"hat": "none",
		#"weapon": "pistol"
	#}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_stat(modifier):
	for key in modifier:
		stats[key] = modifier[key]
