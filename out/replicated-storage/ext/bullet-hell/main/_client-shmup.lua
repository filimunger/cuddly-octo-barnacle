local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports;
local Workspace = require(TS.getModule("rbx-services", script.Parent).out).Workspace;
local CallRemote = TS.import(script.Parent.Parent.Parent, "manager-remote", "manager-remote").CallRemote;
local BindInputs = TS.import(script.Parent.Parent.Parent, "manager-userinput", "userinput-module").BindInputs;
local C = TS.import(script.Parent.Parent.Parent, "manager-userinterface", "userinterface-module").C;
local camera = Workspace.CurrentCamera;
camera.CameraType = Enum.CameraType.Scriptable;
camera.FieldOfView = 20;
camera.CFrame = (CFrame.new(Vector3.new(0, 600, 0), Vector3.new()) * CFrame.Angles(0, 0, math.pi / 2));
local sidePanelWidth = 0.23;
local area = C('Area');
local panels = {};
for _, multiplier in pairs({ 0, 1 }) do
	local panel = C('Panel', area, {
		Color = Color3.fromRGB(0, 0, 0);
		Position = UDim2.new(multiplier + ((multiplier == 1 and -sidePanelWidth or 0)), 0, 0, -36);
		Size = UDim2.new(sidePanelWidth, 0, 1, 36);
	});
	TS.array_push(panels, panel);
end;
local peoplePanel = C('Panel', panels[2], {
	Transparency = 1;
	TotalPadding = 15;
});
local peopleContainer = C('Container', peoplePanel, {
	CellSize = UDim2.new(1, 0, 0, 250);
	Padding = 20;
});
local addPerson = function(dataFolder)
	local personPanel = C('TexturePanel', peopleContainer, {});
	local livesHeight = 60;
	local livesPanel = C('Panel', personPanel, {
		Size = UDim2.new(1, 0, 0, livesHeight);
		Transparency = 1;
	});
	local livesContainer = C('Container', livesPanel, {
		CellSize = UDim2.new(0, livesHeight * 1.1, 0, livesHeight);
		HAlignment = 'Left';
	});
	local livesValue = dataFolder:WaitForChild('Lives');
	do
		local index = 0;
		while index < livesValue.Value do
			local singleLifePanel = C('Panel', livesContainer, {
				Transparency = 1;
				TotalPadding = 2;
			});
			print('singlelife');
			local singleLife = C('Icon', singleLifePanel, {
				Image = 'rbxassetid://2656578736';
				Color = Color3.fromRGB(255, 255, 255);
			});
			local singleLifeForegroundPanel = C('Panel', singleLife, {
				Transparency = 1;
				TotalPadding = 5;
			});
			local singleLifeForeground = C('Icon', singleLifeForegroundPanel, {
				Image = 'rbxassetid://2656578736';
				Color = Color3.fromRGB(255, 100, 100);
			});
			index = index + 1;
		end;
	end;
end;
local friendlyData = Workspace:WaitForChild('FriendlyData');
TS.array_forEach(friendlyData:GetChildren(), addPerson);
friendlyData.ChildAdded:Connect(addPerson);
_exports = true;
local callSteer = function(x, y, steady)
	CallRemote('CharacterSteer', x, y, steady);
end;
local callFire = function(bool)
	CallRemote('CharacterFire', bool);
end;
BindInputs({ 'Attack', function()
	callFire(true);
end, function()
	callFire(false);
end }, { 'Bomb', function()
end }, { 'Move_Steady', function()
	callSteer(0, 0, true);
end, function()
	callSteer(0, 0, false);
end }, { 'Move_Up', function()
	callSteer(0, 1);
end, function()
	callSteer(0, -1);
end }, { 'Move_Left', function()
	callSteer(-1, 0);
end, function()
	callSteer(1, 0);
end }, { 'Move_Down', function()
	callSteer(0, -1);
end, function()
	callSteer(0, 1);
end }, { 'Move_Right', function()
	callSteer(1, 0);
end, function()
	callSteer(-1, 0);
end });
return _exports;
