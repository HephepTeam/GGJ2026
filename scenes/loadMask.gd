extends VBoxContainer

var mymask: PackedScene = preload("res://scenes/Mask0.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.add_ui_mask.connect(addMask)


func addMask(data: MaskData):
	var mask0 = mymask.instantiate() as TextureRect
	mask0.texture = data.mask_texture
	add_child(mask0)
	
	if get_children().size()<=7:
		add_theme_constant_override("separation", -50)
	elif get_children().size()<=14:
		add_theme_constant_override("separation", -60)
	elif get_children().size()<=21:
		add_theme_constant_override("separation", -70)
	elif get_children().size()<=30:
		add_theme_constant_override("separation", -80)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if get_children().size()>0:
		#for textureRect in get_children():
			#textureRect.queue_free()
#
	#for mask in Globals.maskTab:
#
		#if Globals.maskTab.size()<=7:
			#add_theme_constant_override("separation", -50)
		#elif Globals.maskTab.size()<=14:
			#add_theme_constant_override("separation", -60)
		#elif Globals.maskTab.size()<=21:
			#add_theme_constant_override("separation", -70)
		#elif Globals.maskTab.size()<=30:
			#add_theme_constant_override("separation", -80)
		#var mask0 = mymask.instantiate() as TextureRect
		#mask0.texture = mask
		#add_child(mask0)
