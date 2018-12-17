local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports;
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local Players, Workspace, ReplicatedFirst, ReplicatedStorage = _0.Players, _0.Workspace, _0.ReplicatedFirst, _0.ReplicatedStorage;
local EngageRemoteObject = TS.import(script.Parent.Parent, "manager-remote", "manager-remote").EngageRemoteObject;
local _1 = TS.import(script.Parent, "module");
local MapHeightRadius, MapWidthRadius = _1.MapHeightRadius, _1.MapWidthRadius;
local GetModelCFrame = TS.import(script.Parent.Parent, "msc", "helper-functions").GetModelCFrame;
local SetPartCollisionGroup = TS.import(script.Parent, "collision-groups").SetPartCollisionGroup;
local _2 = TS.import(script.Parent, "character-manager");
local CreateEnemy, CreateFriendly, GetFriendlyCharacter = _2.CreateEnemy, _2.CreateFriendly, _2.GetFriendlyCharacter;
_exports = true;
Players.CharacterAutoLoads = false;
local friendlyCharacters = Instance.new("Model", Workspace);
friendlyCharacters.Name = 'FriendlyCharacters';
local enemyCharacters = Instance.new("Model", Workspace);
enemyCharacters.Name = 'EnemyCharacters';
local friendlyData = Instance.new("Model", Workspace);
friendlyData.Name = 'FriendlyData';
for _, character in pairs(ReplicatedStorage:WaitForChild('Effects'):WaitForChild('Characters'):WaitForChild('FriendlyCharacters'):GetChildren()) do
	local modelCFrame = GetModelCFrame(character);
	for _, instance in pairs(character:GetDescendants()) do
		if instance:IsA('Attachment') then
			local part = instance.Parent;
			local mirror = (part.Parent):FindFirstChild((part.Name) .. '_Mirror');
			if mirror then
				local clone = instance:Clone();
				clone.Parent = mirror;
			end;
		end;
	end;
end;
for _, set in pairs({ { -1, 0 }, { 0, 1 }, { 0, -1 }, { 1, 0 } }) do
	local x = set[1];
	local y = set[2];
	local wall = Instance.new("Part", Workspace);
	wall.Anchored = true;
	wall.Size = Vector3.new((x == 0 and MapWidthRadius * 2 or 0), 100, (y == 0 and MapHeightRadius * 2 or 0));
	wall.CFrame = CFrame.new(Vector3.new(MapWidthRadius * x, 0, MapHeightRadius * y));
	wall.Transparency = 1;
	SetPartCollisionGroup(wall, 'EnemyBullets');
end;
Players.PlayerAdded:Connect(function(player)
	CreateFriendly('Plane', player);
end);
local ManagedRemotes = {
	CharacterSteer = function(player, x, y, steady)
		if player then
			GetFriendlyCharacter(player):Steer(x, y, steady);
		end;
	end;
	CharacterFire = function(player, bool)
		if player then
			GetFriendlyCharacter(player):Fire(bool);
		end;
	end;
};
EngageRemoteObject(ManagedRemotes);
while true do
	CreateEnemy('Noid');
	wait(3);
end;
return _exports;
