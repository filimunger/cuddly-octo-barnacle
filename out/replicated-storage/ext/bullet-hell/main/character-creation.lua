local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local _0 = TS.import(script.Parent.Parent, "classes", "classes-enemy");
local Classes_Enemy, T_EnemyCharacter, T_EnemyName = _0.Classes_Enemy, _0.T_EnemyCharacter, _0.T_EnemyName;
local _1 = TS.import(script.Parent.Parent, "classes", "classes-friendly");
local T_FriendlyName, Classes_Friendly, T_FriendlyCharacter = _1.T_FriendlyName, _1.Classes_Friendly, _1.T_FriendlyCharacter;
local _2 = TS.import(script.Parent, "class-storage");
local Friendlies, Enemies = _2.Friendlies, _2.Enemies;
local CreateEnemy = function(name)
	local cls = Classes_Enemy[name].new(name);
	TS.array_push(Enemies, cls);
	cls:Play();
end;
local CreateFriendly = function(name, player)
	local friendlyCharacter = Classes_Friendly[name].new(name, player);
	TS.array_push(Friendlies, friendlyCharacter);
end;
_exports.CreateEnemy = CreateEnemy;
_exports.CreateFriendly = CreateFriendly;
return _exports;
