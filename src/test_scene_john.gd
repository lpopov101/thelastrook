class_name JohnTest
extends Node2D

const TEST_SCENE = preload("res://scenes/test_scene_john.tscn")

static func new_scene() -> JohnTest:
	var new_s = TEST_SCENE.instantiate()
	return new_s
