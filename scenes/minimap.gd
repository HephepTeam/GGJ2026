extends Control


func _process(delta: float) -> void:
	$pos.position = (Globals.player.position-Vector2(398+300/2,512))/Vector2(1024,1024)*Vector2(64,64)
	$pos.position = snapped($pos.position, Vector2(64,64))
	
