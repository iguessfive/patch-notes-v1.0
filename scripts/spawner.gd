extends PathFollow3D

@export var spawn_interval_by_round: Curve
@export var points_available_by_round: Curve
@export var time_mult_by_round: Curve
@export var current_round: int
@export var points_per_spawn: int
@export var enemy: PackedScene
var spawn_interval: float
var current_spawn_timer: float
var points_amount: float
var time_mult: float
var spawning_in_progress: bool
var num_enemies_in_round: int = 0


func _ready() -> void:
	start_round()


func _process(delta):
	if spawning_in_progress:
		progress += (delta * time_mult)
		current_spawn_timer += delta
		if current_spawn_timer >= spawn_interval:
			if points_amount - 1 >= 0:
				# spawn enemy.
				spawn_enemy()


func start_round():
	spawn_interval = spawn_interval_by_round.sample(current_round)
	points_amount = points_available_by_round.sample(current_round)
	time_mult = time_mult_by_round.sample(current_round)
	spawning_in_progress = true


func spawn_enemy():
	var node = enemy.instantiate()
	get_tree().root.add_child(node)
	node.global_position = self.global_position
	num_enemies_in_round += 1
	node.connect("died", decrement_enemy_count)
	points_amount -= 1
	current_spawn_timer = 0


func decrement_enemy_count():
	num_enemies_in_round -= 1
	if num_enemies_in_round <= 0 and spawning_in_progress == false:
		end_round()


func end_round():
	current_round += 1
	start_round()
