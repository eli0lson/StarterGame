extends Area2D

@export var id: int = 0
var modifiers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file_as_text = FileAccess.get_file_as_string("res://modifiers.txt")
	#print(file_as_text)
	var json = JSON.new()
	var parse_return = json.parse(file_as_text)
	modifiers = json.data
	
	id = randi_range(0, modifiers.size() - 1)
	$Sprite2D.texture = load(modifiers[id]["sprite_path"])
	
	var vp = get_viewport().size
	position = Vector2(randf_range(40, 1440 - 40), randf_range(40, 810 - 40))
	
	print(position, " ", vp)
	show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_area_entered(area: Area2D) -> void:
	#hide()
	#queue_free()
	#$CollisionShape2D.set_deferred("disabled", true)
	#Stats.update_stat(id)
#
#func set_sprite(path) -> void:
	#$Sprite2D.texture = load(path)


func _on_body_entered(body: Node2D) -> void:
	hide()
	queue_free()
	$CollisionShape2D.set_deferred("disabled", true)
	
	if modifiers != null && modifiers[id] != null:
		var modifier = modifiers[id]["modifier"]
		
		Stats.update_stat(modifier)
