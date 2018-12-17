local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local StarterGui = require(TS.getModule("rbx-services", script.Parent).out).StarterGui;
local EngageRemoteObject = TS.import(script.Parent.Parent, "manager-remote", "manager-remote").EngageRemoteObject;
local screenGui = Instance.new("ScreenGui", StarterGui);
screenGui.ResetOnSpawn = false;
local UserInterfaceRemotes = {
	ChangeValue = function(player, value, newVariable)
		value.Value = newVariable;
	end;
};
EngageRemoteObject(UserInterfaceRemotes);
_exports.UserInterfaceRemotes = UserInterfaceRemotes;
return _exports;
