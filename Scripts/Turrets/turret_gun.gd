extends Node2D

@export var timer: Timer 
@export var bullet: PackedScene
@export var bullet_place: Node2D
@export var bullet_speed = 100.0
@onready var bullet_holder = GlobalRefs.bullet_holder

var turret_base: Turret
var activated = false
var on_cooldown = false
var direction_input = 0

func _physics_process(delta):
	#if activated and not on_cooldown:
	if not on_cooldown:
		shoot()

func shoot():
	timer.start()
	on_cooldown = true
	var instance = bullet.instantiate()
	bullet_holder.add_child(instance)
	instance.original_turret_base = turret_base
	if bullet_place:
		instance.global_position = bullet_place.global_position
		instance.global_rotation = bullet_place.global_rotation 
		instance.global_rotation += deg_to_rad(randf_range(-10,10))
		instance.initialize_velocity(instance.global_rotation,bullet_speed)
		
	
func _on_timer_timeout():
	on_cooldown = false