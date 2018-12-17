local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local InputCodes = {
	Attack = { Enum.UserInputType.MouseButton1, Enum.KeyCode.Z };
	Bomb = { Enum.UserInputType.MouseButton2, Enum.KeyCode.X };
	Move_Up = { Enum.KeyCode.W, Enum.KeyCode.Up };
	Move_Left = { Enum.KeyCode.A, Enum.KeyCode.Left };
	Move_Down = { Enum.KeyCode.S, Enum.KeyCode.Down };
	Move_Right = { Enum.KeyCode.D, Enum.KeyCode.Right };
	Move_Steady = { Enum.KeyCode.LeftShift };
};
_exports.InputCodes = InputCodes;
return _exports;
