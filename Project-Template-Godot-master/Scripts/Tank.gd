extends KinematicBody

var state = ""
var speed = 1
onready var Scan = $Scanner
var Bullet = preload("res://Scenes/EnemyBullet.tscn")
var health = 100


func take_damage(d):
	health -= d
	if health <= 0:
		queue_free()

func change_state(s):
	state = s
	print(state)
	var material = $sphere_tank/Sphere.mesh.surface_get_material(0)
	if state == "scanning":
		pass
	if state == "found":
		pass
	if state == "shooting":
		pass
	#$sphere_tank/Sphere.set_surface_material(0, material)
		
func _ready():
	change_state("searching")
	
func _physics_process(delta):
	if state == "searching":
		rotate(Vector3(0, 1, 0), speed*delta)
		var c = Scan.get_collider()
		if c != null and c.name == "Player":
			change_state("found")
	if state == "found":
		change_state("waiting")
		$Timer.start()
	if state == "shooting":
		var b = Bullet.instance()
		b.start($Pivot/Muzzle.global_transform)
		get_node("/root/Game/EnemyBullets").add_child(b)

func _on_Timer_timeout():
	print("timeout")
	var c = Scan.get_collider()
	if c != null and c.name == "Player":
		if state == "waiting":
			change_state("shooting")
