extends Label

@export var text_key := "ui.lobby.enter"

func _ready() -> void:
	_apply_text()

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		_apply_text()

func _apply_text() -> void:
	text = tr(text_key)
