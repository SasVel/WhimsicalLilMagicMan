extends CanvasLayer

@onready var magicDimShader = $MagicDimensionShader

func _ready():
	GlobalInfo.world_state_changed.connect(world_state_changed)

func world_state_changed(val):
	if val == 0:
		magicDimShader.visible = false
	elif val == 1:
		magicDimShader.visible = true
