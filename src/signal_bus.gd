class_name SignalBus
extends Node

#menu signals
signal RestartPressed
signal MainMenuPressed
signal ResumeGamePressed
signal NewGamePressed
signal ExitGamePressed

#enetity signals
signal DamagedKing

#game state signals
signal WaveChanged(new_wave)
signal GameOver
