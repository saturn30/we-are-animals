extends Label

@export var text_key := "ui.loading.status"
@export_range(0.05, 2.0, 0.05) var dot_interval := 0.35
@export_range(1, 5, 1) var max_dots := 3

var _base_text := ""
var _dot_count := 0
var _dots_timer: Timer

func _ready() -> void:
	_base_text = tr(text_key)
	_apply_text()
	_start_dot_timer()
	_start_pulse_animation()

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		_base_text = tr(text_key)
		_apply_text()

func _exit_tree() -> void:
	if _dots_timer != null and _dots_timer.timeout.is_connected(_on_dots_timer_timeout):
		_dots_timer.timeout.disconnect(_on_dots_timer_timeout)

func _start_dot_timer() -> void:
	_dots_timer = Timer.new()
	_dots_timer.wait_time = dot_interval
	_dots_timer.autostart = true
	_dots_timer.one_shot = false
	add_child(_dots_timer)
	_dots_timer.timeout.connect(_on_dots_timer_timeout)

func _on_dots_timer_timeout() -> void:
	_dot_count = (_dot_count + 1) % (max_dots + 1)
	_apply_text()

func _apply_text() -> void:
	text = _base_text + ".".repeat(_dot_count)

func _start_pulse_animation() -> void:
	var tween := create_tween()
	tween.set_loops()
	tween.tween_property(self, "modulate:a", 0.5, 0.55)
	tween.tween_property(self, "modulate:a", 1.0, 0.55)
