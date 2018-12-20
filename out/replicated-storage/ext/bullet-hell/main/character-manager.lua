local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local _0 = TS.import(script.Parent, "class-storage");
local Friendlies, Enemies = _0.Friendlies, _0.Enemies;
local GetEnemyFromPart = function(part)
	local parent = part.Parent;
	for _, character in pairs(Enemies) do
		if character.Model == parent then
			return character;
		end;
	end;
end;
local GetFriendlyFromPart = function(part)
	local parent = part.Parent;
	for _, character in pairs(Friendlies) do
		if character.Model == parent then
			return character;
		end;
	end;
end;
local GetFriendlyForPlayer = function(player)
	for _, character in pairs(Friendlies) do
		if character.Player == player then
			return character;
		end;
	end;
	warn('Failed to get client character');
	return nil;
end;
_exports.GetEnemyFromPart = GetEnemyFromPart;
_exports.GetFriendlyFromPart = GetFriendlyFromPart;
_exports.GetFriendlyForPlayer = GetFriendlyForPlayer;
return _exports;
