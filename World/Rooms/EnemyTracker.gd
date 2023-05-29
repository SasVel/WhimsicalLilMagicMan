extends Area2D

signal no_enemies
@onready var enemySpawnCheck = $EnemySpawnCheck

func start_tracker():
	enemySpawnCheck.start()

func _on_enemy_spawn_check_timeout():
	var enemies = self.get_overlapping_bodies()
	if enemies.size() == 0:
		emit_signal("no_enemies")
		enemySpawnCheck.stop()
