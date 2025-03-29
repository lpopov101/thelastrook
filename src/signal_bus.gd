class_name SignalBus
extends Node

#menu signals
signal RestartPressed
signal MainMenuPressed
signal ResumeGamePressed
signal NewGamePressed
signal ExitGamePressed

#entity signals
signal DamagedKing
signal KingHealthUpdate

#game state signals
signal WaveChanged(new_wave)
signal GameOver
