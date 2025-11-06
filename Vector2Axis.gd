class_name Vector2Axis
extends RefCounted

var x: bool
var y: bool

func _init(_x: bool, _y: bool) -> void:
	x = _x
	y = _y

func create_null() -> Vector2Axis:
	return Vector2Axis.new(false, false)

func get_inverse() -> Vector2Axis:
	return Vector2Axis.new(!x, !y)

func is_null() -> bool:
	return !x and !y

func is_both() -> bool:
	return x and y

func to_vector2() -> Vector2:
	return Vector2(x as float, y as float)

func _mul(other: float) -> Vector2:
	return to_vector2() * other

func _rmul(other: float) -> Vector2:
	return to_vector2() * other
