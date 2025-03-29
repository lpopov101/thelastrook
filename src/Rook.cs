using Godot;
using System;

public partial class Rook : CharacterBody2D
{
    [Export]
    private float _speed = 10000f;
    private Vector2 _curMovementDirection = Vector2.Zero;

    public override void _PhysicsProcess(double delta)
    {
        var inputManager = Locator<InputManager>.Get();
        if (inputManager == null)
        {
            return;
        }
        updateMovementDirection(inputManager.GetMovementInput());
        Velocity = (float)delta * _speed * _curMovementDirection;
        MoveAndSlide();
    }

    private void updateMovementDirection(Vector2 movementInput)
    {
        if (!Mathf.IsZeroApprox(movementInput.Y))
        {
            _curMovementDirection = new Vector2(0, movementInput.Y);
        }
        else if (!Mathf.IsZeroApprox(movementInput.X))
        {
            _curMovementDirection = new Vector2(movementInput.X, 0);
        }
    }



}
