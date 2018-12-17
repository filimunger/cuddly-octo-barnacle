local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local PhysicsService = require(TS.getModule("rbx-services", script.Parent).out).PhysicsService;
local collisionGroups = {
	FriendlyCharacters = {};
	EnemyCharacters = {};
	FriendlyBullets = {};
	EnemyBullets = {};
};
for name in pairs(collisionGroups) do
	PhysicsService:CreateCollisionGroup(name);
end;
local SetPartCollisionGroup = function(part, name)
	PhysicsService:SetPartCollisionGroup(part, name);
end;
local collisionGroupsSetCollidable = function(name0, name1, bool)
	PhysicsService:CollisionGroupSetCollidable(name0, name1, bool);
end;
collisionGroupsSetCollidable('FriendlyCharacters', 'FriendlyBullets', false);
collisionGroupsSetCollidable('EnemyCharacters', 'EnemyBullets', false);
collisionGroupsSetCollidable('FriendlyCharacters', 'FriendlyCharacters', false);
collisionGroupsSetCollidable('EnemyCharacters', 'EnemyCharacters', false);
collisionGroupsSetCollidable('EnemyCharacters', 'FriendlyCharacters', false);
collisionGroupsSetCollidable('EnemyBullets', 'FriendlyBullets', false);
collisionGroupsSetCollidable('EnemyBullets', 'EnemyBullets', false);
_exports.SetPartCollisionGroup = SetPartCollisionGroup;
return _exports;
