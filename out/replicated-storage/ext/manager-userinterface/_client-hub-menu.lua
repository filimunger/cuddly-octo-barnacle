local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local BindInputs = TS.import(script.Parent.Parent, "manager-userinput", "userinput-module").BindInputs;
local _0 = TS.import(script.Parent, "userinterface-module");
local C, T_Panel, T_TypeButton = _0.C, _0.T_Panel, _0.T_TypeButton;
local _1 = require(TS.getModule("rbx-services", script.Parent).out);
local TweenService, Workspace, Players, StarterGui = _1.TweenService, _1.Workspace, _1.Players, _1.StarterGui;
local CreateNewEffect = TS.import(script.Parent.Parent, "msc", "helper-functions").CreateNewEffect;
StarterGui:SetCore('TopbarEnabled', false);
local area = C('Area');
area.Frame.Name = 'TabMenuWorkspace';
local panel = C('Panel', area, {
	Visible = false;
	Size = UDim2.new(0.8, 0, 0.8, 0);
	Position = UDim2.new(0.1, 0, 0.1, 0);
	Transparency = 0.6;
	Color = Color3.new();
});
local scrolling = Instance.new("ScrollingFrame", panel.Frame);
scrolling.CanvasSize = UDim2.new();
scrolling.ScrollBarThickness = 0;
scrolling.BackgroundTransparency = 1;
scrolling.Size = UDim2.new(1, 0, 1, 0);
coroutine.wrap(function()
	do
		local index = 0;
		while index < 20 do
			local circle = Instance.new("ImageLabel", scrolling);
			circle.Size = UDim2.new(0, 200, 0, 200);
			circle.Image = 'rbxgameasset://clean';
			circle.BackgroundTransparency = 1;
			circle.ImageColor3 = BrickColor.random().Color;
			circle.ImageTransparency = 0.4;
			local newRandom = function()
				return UDim2.new(math.random(-10, 110) / 100, -50, math.random(-10, 110) / 100, -50);
			end;
			circle.Position = newRandom();
			coroutine.wrap(function()
				while true do
					wait(math.random(1, 10));
					local time = 20;
					TweenService:Create(circle, TweenInfo.new(time, Enum.EasingStyle.Sine), {
						Position = newRandom();
					}):Play();
					wait(time);
				end;
			end)();
			index = index + 1;
		end;
	end;
end)();
local title = C('TypePanel', panel, {
	Text = 'ewkdlmaknfalkmzxklczoiloe';
	Size = UDim2.new(0, 500, 0, 50);
});
title:ConstrainSizeToTextBounds();
title.Position = UDim2.new(0.5, -title.AbsoluteSize.X / 2, 0, -title.AbsoluteSize.Y);
local container = C('Container', panel, {
	Style = 'Grid';
	VAlignment = 'Top';
	CellSize = UDim2.new(0.4, 0, 1, 0);
});
local internalMenu = C('Panel', container, {
	Transparency = 0.5;
	TotalPadding = 15;
});
local menu = C('Panel', container, {
	Transparency = 0.9;
	TotalPadding = 10;
});
container = C('Container', menu, {
	VAlignment = 'Top';
	CellSize = UDim2.new(1, 0, 0, 30);
	Padding = 5;
});
local AddMenuButton = function(str)
	if str == nil then str = 'Undefined' end;
	local typeButton = C('TypeButton', container, {
		Text = str;
	});
	return typeButton;
end;
local AddInternalMenuButton = function(str)
	if str == nil then str = 'Undefined' end;
	local menuButton = AddMenuButton(str);
	local panel = C('Panel', internalMenu, {
		Visible = false;
	});
	local icon = C('Icon', menuButton, {
		Image = 'rbxgameasset://Images/directional-arrow';
		Name = 'InternalIcon';
		Visible = false;
		Size = UDim2.new(0, 30, 0, 30);
		Position = UDim2.new(0, 5, 0, 0);
		Color = Color3.fromRGB(0, 0, 0);
	});
	icon.ImageLabel.Rotation = 180;
	menuButton.MouseClick:Connect(function()
		for _, child in pairs(internalMenu.Frame:GetChildren()) do
			if TS.isA(child, "Frame") then
				child.Visible = false;
			end;
		end;
		for _, child in pairs(container.Folder:GetChildren()) do
			if TS.isA(child, "Frame") then
				local icon = child.Frame:FindFirstChild('InternalIcon');
				if icon then
					(icon).Visible = false;
				end;
			end;
		end;
		panel.Visible = true;
		icon.Visible = true;
	end);
	return panel;
end;
local AddVisifyingMenuButton = function(str, toAlter)
	if str == nil then str = 'Undefined' end;
	local menuButton = AddMenuButton(str);
	local panel = C('Panel', menuButton, {
		Visible = false;
		Size = UDim2.new(0, 30, 0, 30);
		Position = UDim2.new(0, 15, 0, 0);
		TotalPadding = -15;
		Transparency = 1;
	});
	local icon = C('Icon', panel, {
		Image = 'rbxgameasset://Images/eye-open';
		Color = Color3.fromRGB(0, 0, 0);
	});
	toAlter.Visible = false;
	menuButton.MouseClick:Connect(function()
		local b = toAlter.Visible;
		toAlter.Visible = not b;
		icon.Visible = toAlter.Visible;
	end);
end;
local distancePart = Instance.new("Part", Workspace);
distancePart.Anchored = true;
distancePart.CFrame = CFrame.new(Vector3.new(0, -50, 0));
distancePart.Transparency = 1;
BindInputs({ Enum.KeyCode.Y, function()
	local bool = panel.Visible;
	panel.Visible = not bool;
	if bool then
		local player = Players.LocalPlayer;
		if player.Character then
			Workspace.CurrentCamera.CameraSubject = player.Character:WaitForChild('Humanoid');
		end;
	else
		Workspace.CurrentCamera.CameraSubject = distancePart;
	end;
end });
_exports.AddMenuButton = AddMenuButton;
_exports.AddInternalMenuButton = AddInternalMenuButton;
_exports.AddVisifyingMenuButton = AddVisifyingMenuButton;
return _exports;
