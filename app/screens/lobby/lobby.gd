extends Control

@onready var title_label: Label = $CenterContainer/VBoxContainer/TitleLabel
@onready var start_button: Button = $CenterContainer/VBoxContainer/VBoxContainer/StartButton
@onready var settings_button: Button = $CenterContainer/VBoxContainer/VBoxContainer/SettingsButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	_apply_texts()

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		if not is_node_ready():
			return
		_apply_texts()

func _on_start_pressed() -> void:
	GameManager.route.go.main()

func _on_settings_pressed() -> void:
	GameManager.route.go.settings()

func _apply_texts() -> void:
	title_label.text = "WE ARE ANIMALS"
	start_button.text = tr("ui.lobby.start")
	settings_button.text = tr("ui.lobby.settings")
