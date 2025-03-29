using System;
using Godot;

public partial class InputManager : Node
{
	[Export]
	private string _upAction = "up";
	[Export]
	private string _downAction = "down";
	[Export]
	private string _leftAction = "left";
	[Export]
	private string _rightAction = "right";
	public override void _Ready()
	{
		Locator<InputManager>.Register(this);
	}

	public Vector2 GetMovementInput()
	{
		var input = new Vector2(0, 0);
		if (Input.IsActionPressed(_upAction))
		{
			input.Y -= 1;
		}
		if (Input.IsActionPressed(_downAction))
		{
			input.Y += 1;
		}
		if (Input.IsActionPressed(_leftAction))
		{
			input.X -= 1;
		}
		if (Input.IsActionPressed(_rightAction))
		{
			input.X += 1;
		}
		return input;
	}

}
