local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Bullet, BulletBonus;
local CreateNewEffect = TS.import(script.Parent.Parent, "msc", "helper-functions").CreateNewEffect;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "demo", "collision-groups").SetPartCollisionGroup;
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local Workspace, Debris = _0.Workspace, _0.Debris;
do
	Bullet = {};
	Bullet.__index = {
		Fire = function(self, frame)
			local instanceBullet = CreateNewEffect('FriendlyBullet', Workspace);
			SetPartCollisionGroup(instanceBullet, 'FriendlyBullets');
			instanceBullet.CFrame = frame;
			instanceBullet.Velocity = Vector3.new(0, 0, -100);
			instanceBullet.Touched:Connect(function(part)
			end);
			Debris:AddItem(instanceBullet, 2);
		end;
	};
	Bullet.new = function(...)
		return Bullet.constructor(setmetatable({}, Bullet), ...);
	end;
	Bullet.constructor = function(self, ...)
		self.BulletBonuses = {};
		return self;
	end;
end;
do
	BulletBonus = {};
	BulletBonus.__index = {};
	BulletBonus.new = function(...)
		return BulletBonus.constructor(setmetatable({}, BulletBonus), ...);
	end;
	BulletBonus.constructor = function(self, bullet)
		return self;
	end;
end;
local Classes_BulletBonus = {} do
	local _1 = Classes_BulletBonus;
	local Homing, Homing3;
	do
		Homing = {};
		Homing.__index = {};
		Homing.new = function(...)
			return Homing.constructor(setmetatable({}, Homing), ...);
		end;
		Homing.constructor = function(self, ...)
			return self;
		end;
	end;
	do
		Homing3 = {};
		Homing3.__index = {};
		Homing3.new = function(...)
			return Homing3.constructor(setmetatable({}, Homing3), ...);
		end;
		Homing3.constructor = function(self, ...)
			return self;
		end;
	end;
	_1.Homing = Homing;
	_1.Homing3 = Homing3;
end;
local Classes_Bullet = {} do
	local _1 = Classes_Bullet;
	local SimpleBullet;
	do
		local super = Bullet;
		SimpleBullet = {};
		SimpleBullet.__index = setmetatable({}, super);
		SimpleBullet.new = function(...)
			return SimpleBullet.constructor(setmetatable({}, SimpleBullet), ...);
		end;
		SimpleBullet.constructor = function(self)
			Bullet.constructor(self);
			self.BulletBonuses = { 'Homing' };
			return self;
		end;
	end;
	_1.SimpleBullet = SimpleBullet;
end;
_exports.Classes_Bullet = Classes_Bullet;
return _exports;
