extends Resource

@export var bullet_speed: float = 1000.0 # pixels per second
@export var fire_rate: float = 1.0 # bullet per second

# @export var reload_time: float
# @export var damage: float
# @export var spread: float
# @export var recoil: float
# @export var knockback: float

# ---------- Visuals & Audio ----------

# @export var shoot_sfx: AudioStream
# @export var reload_sfx: AudioStream
# @export var reload_vfx: PackedScene
# @export var shoot_vfx: PackedScene

# ---------- Components ----------
@export var bullet: PackedScene = preload("res://scenes/bullet.tscn")

# ---------- PLACEHOLDER ----------
var color: Color = random_color() 

func random_color() -> Color:
	var colors = [
		Color.RED,
		Color.GREEN,
		Color.BLUE,
		Color.YELLOW,
		Color.ORANGE,
		Color.PURPLE,
	]
	return colors.pick_random()