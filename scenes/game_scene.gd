extends Node2D


func _ready() -> void:
	Globals.entities_container = %Entities
	Globals.points_container = %PointsContainer
	
	

func _on_player_dead() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/menus/game_over.tscn")
