using System;
using System.Collections;
using Godot;

public class Locator<T> where T : class
{
	private static T _value = null;

	public static void Register(T value)
	{
		_value = value;
	}

	public static T Get()
	{
		return _value;
	}
}
