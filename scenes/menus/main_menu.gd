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
	if $Control/VBoxContainer/Scoring/PanelScoring.visible == true:
		$Control/VBoxContainer/Scoring/PanelScoring.visible = false;
	if $Control/VBoxContainer/ConfigButton/PanelConfig.visible == true:
		$Control/VBoxContainer/ConfigButton/PanelConfig.visible = false;


func _on_select_mask_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel.visible == false : 
		if $Control/VBoxContainer/SelectMaskButton.position.x <=20.0 :
			maskButton_hover.emit()
	


func _on_return_button_pressed() -> void:
	$Control/VBoxContainer/SelectMaskButton/Panel.visible = false


func _on_mask_2_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = true
		
	if $Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = true




func _on_mask_3_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = true
		
	if $Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = true


func _on_mask_1_button_mouse_entered() -> void:
	if $Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = true
		
	if $Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = true


func _on_quit_button_pressed() -> void:
	print("JePasse")
	get_tree().quit()


func _on_select_mask_button_mouse_exited() -> void:
		if $Control/VBoxContainer/SelectMaskButton/Panel.visible == false : 
			if $Control/VBoxContainer/SelectMaskButton.position.x >= 20.0 :
				$Control/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/ReturnButton/SlideL.start()


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_scene.tscn")



	


func _on_return_scoring_button_pressed() -> void:
	$Control/VBoxContainer/Scoring/PanelScoring.visible = false;


func _on_scoring_pressed() -> void:
	$Control/VBoxContainer/Scoring/PanelScoring.visible = true;
	if $Control/VBoxContainer/ConfigButton/PanelConfig.visible == true:
		$Control/VBoxContainer/ConfigButton/PanelConfig.visible = false;
	if $Control/VBoxContainer/SelectMaskButton/Panel.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel.visible = false;
func _on_config_button_pressed() -> void:
	$Control/VBoxContainer/ConfigButton/PanelConfig.visible = true;
	if $Control/VBoxContainer/Scoring/PanelScoring.visible == true:
		$Control/VBoxContainer/Scoring/PanelScoring.visible = false;
	if $Control/VBoxContainer/SelectMaskButton/Panel.visible == true:
		$Control/VBoxContainer/SelectMaskButton/Panel.visible = false;


func _on_vol_princ_h_slider_value_changed(value: float) -> void:
	var db_value = linear_to_db(value)
	print(db_value)
	AudioServer.set_bus_volume_db(1, db_value)
	
