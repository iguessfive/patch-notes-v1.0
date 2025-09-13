extends PathFollow3D

@export var time_mult: float
@export var spawn_interval_by_round: Curve
@export var points_available_by_round: Curve
@export var time_mult_by_round: Curve
@export var current_round: int
@export var points_per_spawn: int


func _process(delta):
	progress += (delta * time_mult)
