local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Character_Friendly;
local _0 = TS.import(script.Parent, "classes");
local Character, T_Character = _0.Character, _0.T_Character;
local _1 = TS.import(script.Parent, "classes-blaster");
local T_Blaster, Classes_Blaster, T_BlasterName = _1.T_Blaster, _1.Classes_Blaster, _1.T_BlasterName;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "main", "collision-groups").SetPartCollisionGroup;
local OriginFrame = TS.import(script.Parent.Parent, "main", "module").OriginFrame;
local Workspace = require(TS.getModule("rbx-services", script.Parent).out).Workspace;
local _2 = TS.import(script.Parent.Parent.Parent, "msc", "helper-functions");
local VariableValue, CreateNewEffect, WeldModel = _2.VariableValue, _2.CreateNewEffect, _2.WeldModel;
local createBlaster = function(blasterName, character)
	local cls = Classes_Blaster[blasterName].new(character);
	return cls;
end;
do
	local super = Character;
	Character_Friendly = {};
	Character_Friendly.__index = setmetatable({
		Fire = function(self, bool)
			self.ClientClicking = bool;
			if bool then
				if not self.Firing then
					self.Firing = true;
					self:UpdateInternal('Firing');
					while self.ClientClicking do
						for _, blaster in pairs(self.Blasters) do
							blaster:Fire();
						end;
						wait(self.ReloadSpeed);
					end;
					self.Firing = false;
					self:UpdateInternal('Firing');
				end;
			end;
		end;
		Bomb = function(self)
		end;
		Steer = function(self, x, y, steady)
			if steady ~= nil then
				self.Steady = steady;
				self.Model.PrimaryPart.Transparency = (self.Steady and 0 or 1);
				if self.Steady then
					self.CurrentUnitVelocity = self.SteadyUnitVelocity;
				else
					self.CurrentUnitVelocity = self.UnitVelocity;
				end;
			end;
			self.UnitX = self.UnitX + x;
			self.UnitY = self.UnitY + y;
			self.BodyGyro.CFrame = (OriginFrame * CFrame.Angles(0, 0, -math.rad(45 * self.UnitX * ((self.Steady and 0.5 or 1)))));
			self:SetVelocity(Vector3.new(self.CurrentUnitVelocity * self.UnitX, 0, self.CurrentUnitVelocity * self.UnitY * -1));
			local blazeBool = self.UnitY ~= -1;
			for _, effect in pairs(self.Effects.Blazer) do
				effect.Enabled = blazeBool;
			end;
			local cruiseBool = self.UnitY > 0;
			for _, effect in pairs(self.Effects.Cruiser) do
				effect.Enabled = cruiseBool;
			end;
		end;
		UpdateInternal = function(self, id)
			self.InternalData[id].Value = (self)[id];
		end;
		Spawn = function(self)
			self:Steer(0, 0, false);
			self.Model:SetPrimaryPartCFrame(CFrame.new(Vector3.new()));
		end;
		Die = function(self)
			local _3 = self; _3.Lives = _3.Lives - 1;
			self:UpdateInternal('Lives');
			self:Spawn();
			print('ded');
		end;
	}, super);
	Character_Friendly.new = function(...)
		return Character_Friendly.constructor(setmetatable({}, Character_Friendly), ...);
	end;
	Character_Friendly.constructor = function(self, name, player)
		Character.constructor(self, name);
		self.InternalData = {};
		self.Blasters = {};
		self.Firing = false;
		self.ClientClicking = false;
		self.ReloadSpeed = 0.1;
		self.HitboxRadius = 3.5;
		self.UnitX = 0;
		self.UnitY = 0;
		self.CurrentUnitVelocity = 0;
		self.UnitVelocity = 230;
		self.SteadyUnitVelocity = 40;
		self.Steady = false;
		self.Lives = 5;
		local folder = Instance.new("Folder", Workspace:WaitForChild('FriendlyData'));
		for _, id in pairs({ 'Lives', 'Firing' }) do
			local variable = (self)[id];
			self.InternalData[id] = VariableValue(variable, folder, id);
		end;
		self.Model.Parent = Workspace:WaitForChild('FriendlyCharacters');
		self.Player = player;
		self.Effects = {
			Blazer = {};
			Cruiser = {};
		};
		for _, instance in pairs(self.Model:GetDescendants()) do
			if instance:IsA('BasePart') then
				SetPartCollisionGroup(instance, 'FriendlyCharacters');
				instance.Anchored = false;
				instance:SetNetworkOwner(self.Player);
				if instance ~= self.Model.PrimaryPart then
					instance.CanCollide = false;
				else
					local frame = instance.CFrame;
					instance.Size = Vector3.new(self.HitboxRadius * 2, self.HitboxRadius * 2, self.HitboxRadius * 2);
					(instance).Shape = Enum.PartType.Ball;
					instance.CFrame = frame;
					instance.Material = Enum.Material.SmoothPlastic;
					instance.Color = Color3.fromRGB(255, 255, 255);
				end;
			elseif instance:IsA('Attachment') then
				if instance.Name == 'Attachment_Blazer' then
					TS.array_push(self.Effects.Blazer, CreateNewEffect('Blazer', instance));
				elseif instance.Name == 'Attachment_Cruiser' then
					TS.array_push(self.Effects.Cruiser, CreateNewEffect('Cruiser', instance));
				elseif instance.Name == 'Attachment_Turret' then
				end;
			end;
		end;
		WeldModel(self.Model);
		self:Spawn();
		return self;
	end;
end;
local Classes_Friendly = {} do
	local _3 = Classes_Friendly;
	local Plane, Bomber;
	do
		local super = Character_Friendly;
		Plane = {};
		Plane.__index = setmetatable({}, super);
		Plane.new = function(...)
			return Plane.constructor(setmetatable({}, Plane), ...);
		end;
		Plane.constructor = function(self, ...)
			super.constructor(self, ...);
			self.Name = 'Plane';
			self.Blasters = { createBlaster('SimpleBlaster', self) };
			self.HitBoxRadius = 5;
			return self;
		end;
	end;
	do
		local super = Character_Friendly;
		Bomber = {};
		Bomber.__index = setmetatable({}, super);
		Bomber.new = function(...)
			return Bomber.constructor(setmetatable({}, Bomber), ...);
		end;
		Bomber.constructor = function(self, ...)
			super.constructor(self, ...);
			self.Name = 'Bomber';
			self.HitBoxRadius = 7;
			self.UnitVelocity = 100;
			return self;
		end;
	end;
	_3.Plane = Plane;
	_3.Bomber = Bomber;
end;
_exports.Classes_Friendly = Classes_Friendly;
return _exports;
