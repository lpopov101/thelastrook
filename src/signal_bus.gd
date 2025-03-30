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
signal KingPosition(position : Vector2)
signal PawnHitBound(pawn_position : Vector2)

#game state signals
signal WaveComplete
signal GameOver
