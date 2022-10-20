extends Area2D

onready var state_machine = $AnimationTree.get("parameters/playback")

func _on_body_entered(_body):
	state_machine.travel("picked")
