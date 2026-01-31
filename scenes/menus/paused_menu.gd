extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_leave_game_btn_pressed() -> void:
	get_tree().quit()


func _on_back_to_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _input(event):
	if event.is_action_pressed("ui_cancel"): # "ui_cancel" est la touche Echap par défaut
		print("Détection de l'appui sur Echap")
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	print(get_tree().paused)
	$PanelPausedMenu.visible = true
