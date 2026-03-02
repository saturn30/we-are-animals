extends Control

@onready var title_label: Label = %TitleLabel
@onready var language_label: Label = %LanguageLabel
@onready var language_selector: OptionButton = %LanguageSelector
@onready var back_button: Button = %BackButton

var _selector_initialized := false

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	language_selector.item_selected.connect(_on_language_selected)
	_apply_selector_style()
	_rebuild_language_selector()
	_apply_texts()

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		if not is_node_ready():
			return
		_apply_texts()

func _on_back_pressed() -> void:
	GameManager.route.go.lobby()

func _on_language_selected(index: int) -> void:
	if not _selector_initialized:
		return

	var locale := str(language_selector.get_item_metadata(index))
	TranslationServer.set_locale(locale)

func _apply_texts() -> void:
	title_label.text = tr("ui.settings.title")
	language_label.text = tr("ui.settings.language")
	back_button.text = tr("ui.settings.back")
	_rebuild_language_selector()

func _rebuild_language_selector() -> void:
	_selector_initialized = false
	language_selector.clear()

	language_selector.add_item(tr("ui.language.english"))
	language_selector.set_item_metadata(0, "en")

	language_selector.add_item(tr("ui.language.korean"))
	language_selector.set_item_metadata(1, "ko")

	var current_locale := _normalize_locale(TranslationServer.get_locale())
	var selected := 0
	for index in range(language_selector.item_count):
		var locale := str(language_selector.get_item_metadata(index))
		if locale == current_locale:
			selected = index
			break

	language_selector.select(selected)
	_selector_initialized = true

func _normalize_locale(raw_locale: String) -> String:
	var normalized := raw_locale.to_lower().replace("_", "-")
	if normalized.begins_with("ko"):
		return "ko"
	return "en"

func _apply_selector_style() -> void:
	language_selector.add_theme_font_size_override("font_size", 30)
	var popup := language_selector.get_popup()
	popup.add_theme_font_size_override("font_size", 28)
