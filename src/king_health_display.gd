extends CanvasLayer

@onready var health_progress_bar: ProgressBar = $VBoxContainer/KingHealthHBox/ProgressBar
@onready var wave: Label = $VBoxContainer/KingHealthHBox/Wave
@onready var ability_name: Label = $VBoxContainer/AbilityHBox/Ability
@onready var ability_progress_bar: ProgressBar = $VBoxContainer/AbilityHBox/ProgressBar
		
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	health_progress_bar.value = Global.game_manager.king_health
	wave.text = "Wave: " + str(Global.game_manager.wave)
	if Global.game_manager.cur_ability in Global.game_manager.ability_name_map:
		ability_name.text = Global.game_manager.ability_name_map[Global.game_manager.cur_ability]
	else:
		ability_name.text = "Ability"
	ability_progress_bar.value = Global.game_manager.cur_ability_percent
