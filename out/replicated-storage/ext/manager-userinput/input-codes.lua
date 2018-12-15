local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local InputCodes = {
	MouseClick = Enum.UserInputType.MouseButton1;
	Ability1 = Enum.KeyCode.R;
	Ability2 = Enum.KeyCode.F;
	Ability3 = Enum.KeyCode.V;
	TogglePlacementMenu = Enum.KeyCode.Q;
	ClosePlacementMenu = Enum.KeyCode.E;
};
_exports.InputCodes = InputCodes;
return _exports;
