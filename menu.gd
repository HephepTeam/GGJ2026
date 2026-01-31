extends Control

signal maskButton_hover
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass









func _on_select_mask_button_pressed() -> void:
	$Control/VBoxContainer/SelectMaskButton/Panel.visible = true



func _on_select_mask_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel.visible == false : 
		if $Control/VBoxContainer/SelectMaskButton.position.x !=20.0 :
			maskButton_hover.emit()
	


func _on_return_button_pressed() -> void:
	$Control/VBoxContainer/SelectMaskButton/Panel.visible = false


func _on_mask_2_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible = true
		
	if $Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible = true




func _on_mask_3_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible = true
		
	if $Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible = true


func _on_mask_1_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible = true
		
	if $Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/HBoxContainer/LabelMask1.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_select_mask_button_mouse_exited() -> void:
		if $Control/VBoxContainer/SelectMaskButton/Panel.visible == false : 
			if $Control/VBoxContainer/SelectMaskButton.position.x == 20.0 :
				$Control/VBoxContainer/SelectMaskButton/Panel/VBoxContainer/ReturnButton/SlideL.start()
