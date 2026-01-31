extends TileMapLayer




func _on_enter_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.room_entered.emit(self)
