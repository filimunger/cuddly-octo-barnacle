local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local _0 = TS.import(script.Parent.Parent, "classes", "classes-enemy");
local Classes_Enemy, T_EnemyCharacter, T_EnemyName = _0.Classes_Enemy, _0.T_EnemyCharacter, _0.T_EnemyName;
local _1 = TS.import(script.Parent.Parent, "classes", "classes-friendly");
local T_FriendlyName, Classes_Friendly, T_FriendlyCharacter = _1.T_FriendlyName, _1.Classes_Friendly, _1.T_FriendlyCharacter;
local enemies = {};
local CreateEnemy = function(name)
	local cls = Classes_Enemy[name].new(name);
	TS.array_push(enemies, cls);
	cls:Play();
end;
local GetEnemyFromPart = function(part)
	local parent = part.Parent;
	for _, character in pairs(enemies) do
		if character.Model == parent then
			return character;
		end;
	end;
end;
local friendlies = {};
local CreateFriendly = function(name, player)
	local friendlyCharacter = Classes_Friendly[name].new(name, player);
	TS.array_push(friendlies, friendlyCharacter);
end;
local GetFriendlyFromPart = function(part)
	local parent = part.Parent;
	for _, character in pairs(friendlies) do
		if character.Model == parent then
			return character;
		end;
	end;
end;
local GetFriendlyCharacter = function(player)
	for _, character in pairs(friendlies) do
		if character.Player == player then
			return character;
		end;
	end;
	warn('Failed to get client character');
	return (nil);
end;
_exports.CreateEnemy = CreateEnemy;
_exports.GetEnemyFromPart = GetEnemyFromPart;
_exports.CreateFriendly = CreateFriendly;
_exports.GetFriendlyFromPart = GetFriendlyFromPart;
_exports.GetFriendlyCharacter = GetFriendlyCharacter;
return _exports;
