extends Control

signal maskButton_hover
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass









func _on_select_mask_button_pressed() -> void:
	$MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible = true
	if $MarginContainer/VBoxContainer/Scoring/PanelScoring.visible == true:
		$MarginContainer/VBoxContainer/Scoring/PanelScoring.visible = false;
	if $MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible == true:
		$MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible = false;
	if $MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible == true:
		$MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible = false;
	if $MarginContainer/VBoxContainer/DLC/PanelDLC.visible == true:
		$MarginContainer/VBoxContainer/DLC/PanelDLC.visible = false;

func _on_select_mask_button_mouse_entered() -> void:
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible == false : 
		if $MarginContainer/VBoxContainer/SelectMaskButton.position.x <=20.0 :
			maskButton_hover.emit()
	


func _on_return_button_pressed() -> void:
	$MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible = false


func _on_mask_2_button_mouse_entered() -> void:
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = true
		
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = true




func _on_mask_3_button_mouse_entered() -> void:
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = true
		
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = true


func _on_mask_1_button_mouse_entered() -> void:
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = true
		
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask3.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask2.visible = false
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/HBoxContainer/LabelMask1.visible = true


func _on_quit_button_pressed() -> void:
	print("JePasse")
	get_tree().quit()


func _on_select_mask_button_mouse_exited() -> void:
		if $MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible == false : 
			if $MarginContainer/VBoxContainer/SelectMaskButton.position.x >= 20.0 :
				$MarginContainer/VBoxContainer/SelectMaskButton/Panel/MarginContainer/VBoxContainer/ReturnButton/SlideL.start()


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MasterGameScene.tscn")
	


func _on_return_scoring_button_pressed() -> void:
	$MarginContainer/VBoxContainer/Scoring/PanelScoring.visible = false;


func _on_scoring_pressed() -> void:
	$MarginContainer/VBoxContainer/Scoring/PanelScoring.visible = true;
	if $MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible == true:
		$MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible = false;
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible = false;
	if $MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible == true:
		$MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible = false;
	if $MarginContainer/VBoxContainer/DLC/PanelDLC.visible == true:
		$MarginContainer/VBoxContainer/DLC/PanelDLC.visible = false;
func _on_config_button_pressed() -> void:
	$MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible = true;
	if $MarginContainer/VBoxContainer/Scoring/PanelScoring.visible == true:
		$MarginContainer/VBoxContainer/Scoring/PanelScoring.visible = false;
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible = false;
	if $MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible == true:
		$MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible = false;
	if $MarginContainer/VBoxContainer/DLC/PanelDLC.visible == true:
		$MarginContainer/VBoxContainer/DLC/PanelDLC.visible = false;


func _on_vol_princ_h_slider_value_changed(value: float) -> void:
	var db_value = linear_to_db(value)
	print(db_value)
	AudioServer.set_bus_volume_db(1, db_value)
	


func _on_return_config_button_pressed() -> void:
	$MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible = false


func _input(event):
	if event.is_action_pressed("ui_accept") and $TitleLBL.visible: # "ui_cancel" est la touche Echap par défaut
		get_tree().get_root().set_input_as_handled()
		$MarginContainer/VBoxContainer.visible = true
		$PressALBL.visible = false
		$TitleLBL.visible = false
		%StartGameButton.grab_focus()
		$Title2LBL.visible = true
			


func _on_return_btn_pressed() -> void:
	$MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible = false


func _on_credits_button_pressed() -> void:
	$MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible = true;
	if $MarginContainer/VBoxContainer/Scoring/PanelScoring.visible == true:
		$MarginContainer/VBoxContainer/Scoring/PanelScoring.visible = false;
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible = false;
	if $MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible == true:
		$MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible = false;
	if $MarginContainer/VBoxContainer/DLC/PanelDLC.visible == true:
		$MarginContainer/VBoxContainer/DLC/PanelDLC.visible = false;


func _on_dlc_pressed() -> void:
	$MarginContainer/VBoxContainer/DLC/PanelDLC.visible = true;
	if $MarginContainer/VBoxContainer/Scoring/PanelScoring.visible == true:
		$MarginContainer/VBoxContainer/Scoring/PanelScoring.visible = false;
	if $MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible == true:
		$MarginContainer/VBoxContainer/SelectMaskButton/Panel.visible = false;
	if $MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible == true:
		$MarginContainer/VBoxContainer/ConfigButton/PanelConfig.visible = false;
	if $MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible == true:
		$MarginContainer/VBoxContainer/CreditsButton/PanelCredits.visible = false;
