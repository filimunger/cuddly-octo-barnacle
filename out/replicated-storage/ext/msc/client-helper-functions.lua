local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local Workspace, Players = _0.Workspace, _0.Players;
local player = Players.LocalPlayer;
local mouse = player:GetMouse();
local defaultIgnoreList = { Workspace:WaitForChild('Characters') };
local GetCursorPosition = function(ignoreList)
	if ignoreList == nil then ignoreList = {} end;
	local ray = Workspace.CurrentCamera:ScreenPointToRay(mouse.X, mouse.Y);
	ray = Ray.new(ray.Origin, (ray.Unit.Direction * 999));
	local hit, hitPosition = Workspace:FindPartOnRayWithIgnoreList(ray, TS.array_concat(ignoreList, defaultIgnoreList), true, false);
	local cframe = CFrame.new(hitPosition, (hitPosition + ray.Unit.Direction));
	return cframe.p, hit;
end;
_exports.GetCursorPosition = GetCursorPosition;
return _exports;
