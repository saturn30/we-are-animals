extends Node

signal bootstrap_finished

const ROUTE_MANAGER_SCRIPT := preload("res://core/systems/RouteManager/RouteManager.gd")

var is_bootstrapped := false
var route: RouteManager

func bootstrap() -> void:
	if is_bootstrapped:
		return

	# Keep at least one frame for Loading UI visibility.
	await get_tree().process_frame

	TranslationServer.set_locale(OS.get_locale_language())

	is_bootstrapped = true
	bootstrap_finished.emit()

	if route.is_loading_scene():
		route.go.lobby()

func _ready() -> void:
	route = ROUTE_MANAGER_SCRIPT.new() as RouteManager
	route.name = "RouteManager"
	add_child(route)
	bootstrap()
