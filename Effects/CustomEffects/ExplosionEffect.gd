extends GPUParticles2D

func _on_kill_timer_timeout():
	queue_free()
