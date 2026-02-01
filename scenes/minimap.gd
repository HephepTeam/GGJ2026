extends Control


func _process(delta: float) -> void:
	$pos.position = Globals.player.position/Vector2(1024,1024)*Vector2(32,32)
	
