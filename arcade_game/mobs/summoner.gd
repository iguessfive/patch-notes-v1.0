extends Type.Mob

enum State {
	ORBIT,
	SUMMON,
}

@export var summon_cooldown: float = 2.0
@export var summon_mob: PackedScene

var distance_width := 600.0
var distance_height := 300.0
var speed_movement := PI/7 # radians per seconds
var orbit_angle := 0.0
var tracker := Type.SummonTracker.new()

@onready var summon_radius: float = $Sprite2D.scale.length() #PLACEHOLDER dimensions of texture
@onready var orbit_center: Vector2 = get_viewport().size * 0.5

func _ready() -> void:
	init_resource()

	# Config States
	state_machine.add_state(State.ORBIT, Callable(), _on_orbit_update, Callable(), Callable())
	state_machine.add_state(State.SUMMON, _on_summon_enter, Callable(), Callable(), Callable())

	state_machine.set_initial_state(State.SUMMON)
	hurt_box.hurt.connect(on_hurt)

func init_resource() -> void:
	resource.damage = 1
	hit_box.effect_value = resource.damage

func _on_orbit_update(delta: float) -> void:
	orbit_angle += speed_movement * delta
	var offset = Vector2((cos(fmod(orbit_angle, TAU)) * distance_width),  (sin(fmod(orbit_angle, TAU)) * distance_height))
	global_position = orbit_center + offset

func _on_summon_enter() -> void:
	summon()
	state_machine.change_state(State.ORBIT)
	get_tree().create_timer(summon_cooldown).timeout.connect(state_machine.change_state.bind(State.SUMMON))

func on_hurt(hit: HitBox2D) -> void:
	resource.health -= hit.effect_value
	print_rich("[color=cyan]Mob Health: %d[/color]" % resource.health)
	if resource.health <= 0:
		destroy()

func destroy() -> void:
	# Death VFX & SFX
	queue_free()

func summon() -> void:
	var player: Type.Player2D = get_tree().get_first_node_in_group("player_2d")
	if not player:
		return

	var mob: Type.Mob = summon_mob.instantiate()
	get_tree().current_scene.add_child.call_deferred(mob)
	tracker.count += 1
	mob.name = "Chaser%d" % tracker.count

	var direction_to_player = global_position.direction_to(player.global_position)
	var summon_angle := direction_to_player.angle()
	mob.global_position = global_position + Vector2(cos(summon_angle), sin(summon_angle)) * summon_radius
