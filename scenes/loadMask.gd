extends VBoxContainer

var mymask: PackedScene = preload("res://scenes/Mask0.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.add_ui_mask.connect(addMask)


func addMask(data: MaskData):
	var mask0 = mymask.instantiate() as TextureRect
	mask0.texture = data.mask_texture
	add_child(mask0)
	var count := len(Globals.masks)
	var height := 685.0
	var mask_height := 100.0
	add_theme_constant_override(
		"separation",
		clamp(height / count - mask_height, -mask_height, -50.0)
	)
