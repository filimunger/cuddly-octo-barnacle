local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Character;
local Workspace = require(TS.getModule("rbx-services", script.Parent).out).Workspace;
local OriginFrame = TS.import(script.Parent.Parent, "demo", "module").OriginFrame;
local _0 = TS.import(script.Parent.Parent, "msc", "helper-functions");
local AddPrimaryPart, CreateNewEffect, WeldModel = _0.AddPrimaryPart, _0.CreateNewEffect, _0.WeldModel;
do
	Character = {};
	Character.__index = {};
	Character.new = function(...)
		return Character.constructor(setmetatable({}, Character), ...);
	end;
	Character.constructor = function(self, name)
		self.Name = 'Plane';
		self.Health = 100;
		self.Name = name;
		self.Model = CreateNewEffect(self.Name);
		local primaryPart = AddPrimaryPart(self.Model);
		self.Model:SetPrimaryPartCFrame(OriginFrame);
		self.BodyGyro = Instance.new("BodyGyro", primaryPart);
		local bodyGyroForce = 5000;
		self.BodyGyro.MaxTorque = Vector3.new(bodyGyroForce, bodyGyroForce, bodyGyroForce);
		self.BodyGyro.P = bodyGyroForce;
		self.BodyGyro.CFrame = primaryPart.CFrame;
		self.BodyVelocity = Instance.new("BodyVelocity", primaryPart);
		local bodyVelocityForce = 9e9;
		self.BodyVelocity.MaxForce = Vector3.new(bodyVelocityForce, bodyVelocityForce, bodyVelocityForce);
		self.BodyVelocity.P = bodyVelocityForce;
		return self;
	end;
end;
_exports.Character = Character;
return _exports;
