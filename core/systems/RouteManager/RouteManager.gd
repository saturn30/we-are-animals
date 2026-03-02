class_name RouteManager
extends Node

const LOADING_PATH := "res://app/screens/loading/loading.tscn"
const LOBBY_PATH := "res://app/screens/lobby/lobby.tscn"
const MAIN_PATH := "res://app/screens/main/main.tscn"
const SETTINGS_PATH := "res://app/screens/settings/settings.tscn"

class GoApi:
	extends RefCounted

	var _router

	func _init(router) -> void:
		_router = router

	func loading() -> int:
		return _router._change_scene(LOADING_PATH)

	func lobby() -> int:
		return _router._change_scene(LOBBY_PATH)

	func main() -> int:
		return _router._change_scene(MAIN_PATH)

	func settings() -> int:
		return _router._change_scene(SETTINGS_PATH)

var go: GoApi

func _init() -> void:
	go = GoApi.new(self)

func is_loading_scene() -> bool:
	var current := get_tree().current_scene
	if current == null:
		return false
	return current.scene_file_path == LOADING_PATH

func _change_scene(scene_path: String) -> int:
	var err := get_tree().change_scene_to_file(scene_path)
	if err != OK:
		push_error("Route change failed (%s): %s" % [scene_path, err])
	return err
