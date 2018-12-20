local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local T_FriendlyCharacter = TS.import(script.Parent.Parent, "classes", "classes-friendly").T_FriendlyCharacter;
local T_EnemyCharacter = TS.import(script.Parent.Parent, "classes", "classes-enemy").T_EnemyCharacter;
local Friendlies = {};
local Enemies = {};
_exports.Friendlies = Friendlies;
_exports.Enemies = Enemies;
return _exports;
