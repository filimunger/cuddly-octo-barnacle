local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Bullet, BulletBonus;
local _0 = TS.import(script.Parent.Parent.Parent, "msc", "helper-functions");
local CreateNewEffect, RandomFromDictionary, RandomIndexFromDictionary = _0.CreateNewEffect, _0.RandomFromDictionary, _0.RandomIndexFromDictionary;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "main", "collision-groups").SetPartCollisionGroup;
local _1 = require(TS.getModule("rbx-services", script.Parent).out);
local Workspace, Debris = _1.Workspace, _1.Debris;
local GetEnemyFromPart = TS.import(script.Parent.Parent, "main", "character-manager").GetEnemyFromPart;
do
	Bullet = {};
	Bullet.__index = {
		Fire = function(self, frame)
			self.BulletHost = CreateNewEffect(self.BulletHostName, Workspace);
			SetPartCollisionGroup(self.BulletHost, 'FriendlyBullets');
			self.BulletHost.CFrame = frame;
			Debris:AddItem(self.BulletHost, 2);
		end;
	};
	Bullet.new = function(...)
		return Bullet.constructor(setmetatable({}, Bullet), ...);
	end;
	Bullet.constructor = function(self, ...)
		self.BulletHostName = 'BasicHost';
		self.BulletBonuses = {};
		return self;
	end;
end;
local bulletHosts = {
	BasicHost = true;
};
do
	BulletBonus = {};
	BulletBonus.__index = {
		Execute = function(self)
		end;
	};
	BulletBonus.new = function(...)
		return BulletBonus.constructor(setmetatable({}, BulletBonus), ...);
	end;
	BulletBonus.constructor = function(self, bullet)
		self.Strength = 10;
		self.Bullet = bullet;
		return self;
	end;
end;
local Classes_BulletGuidance = {} do
	local _2 = Classes_BulletGuidance;
	local Simple, Homing, Homing3;
	do
		local super = BulletBonus;
		Simple = {};
		Simple.__index = setmetatable({
			Execute = function(self)
				self.Bullet.BulletHost.Velocity = Vector3.new(0, 0, -100);
			end;
		}, super);
		Simple.new = function(...)
			return Simple.constructor(setmetatable({}, Simple), ...);
		end;
		Simple.constructor = function(self, ...)
			super.constructor(self, ...);
			return self;
		end;
	end;
	do
		local super = BulletBonus;
		Homing = {};
		Homing.__index = setmetatable({
			Execute = function(self)
			end;
		}, super);
		Homing.new = function(...)
			return Homing.constructor(setmetatable({}, Homing), ...);
		end;
		Homing.constructor = function(self, ...)
			super.constructor(self, ...);
			return self;
		end;
	end;
	do
		local super = BulletBonus;
		Homing3 = {};
		Homing3.__index = setmetatable({
			Execute = function(self)
			end;
		}, super);
		Homing3.new = function(...)
			return Homing3.constructor(setmetatable({}, Homing3), ...);
		end;
		Homing3.constructor = function(self, ...)
			super.constructor(self, ...);
			return self;
		end;
	end;
	_2.Simple = Simple;
	_2.Homing = Homing;
	_2.Homing3 = Homing3;
end;
local Classes_BulletDamage = {} do
	local _3 = Classes_BulletDamage;
	local Simple, AreaOfEffect;
	do
		local super = BulletBonus;
		Simple = {};
		Simple.__index = setmetatable({
			Execute = function(self)
				self.Bullet.BulletHost.Touched:Connect(function(part)
					local enemy = GetEnemyFromPart(part);
					if enemy then
						enemy:TakeDamage(self.Damage);
						self.Bullet.BulletHost:Destroy();
					end;
				end);
			end;
		}, super);
		Simple.new = function(...)
			return Simple.constructor(setmetatable({}, Simple), ...);
		end;
		Simple.constructor = function(self, ...)
			super.constructor(self, ...);
			self.Damage = 40;
			return self;
		end;
	end;
	do
		local super = BulletBonus;
		AreaOfEffect = {};
		AreaOfEffect.__index = setmetatable({
			Execute = function(self)
				self.Bullet.BulletHost.Touched:Connect(function(part)
					local enemy = GetEnemyFromPart(part);
					if enemy then
						enemy:TakeDamage(self.Damage);
						self.Bullet.BulletHost:Destroy();
					end;
				end);
			end;
		}, super);
		AreaOfEffect.new = function(...)
			return AreaOfEffect.constructor(setmetatable({}, AreaOfEffect), ...);
		end;
		AreaOfEffect.constructor = function(self, ...)
			super.constructor(self, ...);
			self.Damage = 40;
			return self;
		end;
	end;
	_3.Simple = Simple;
	_3.AreaOfEffect = AreaOfEffect;
end;
local Classes_BulletExtra = {} do
	local _3 = Classes_BulletExtra;
	local Something;
	do
		local super = BulletBonus;
		Something = {};
		Something.__index = setmetatable({
			Execute = function(self)
			end;
		}, super);
		Something.new = function(...)
			return Something.constructor(setmetatable({}, Something), ...);
		end;
		Something.constructor = function(self, ...)
			super.constructor(self, ...);
			return self;
		end;
	end;
	_3.Something = Something;
end;
local Classes_Bullet = {} do
	local _3 = Classes_Bullet;
	local Bomb, SimpleBullet, RandomBullet;
	do
		local super = Bullet;
		Bomb = {};
		Bomb.__index = setmetatable({}, super);
		Bomb.new = function(...)
			return Bomb.constructor(setmetatable({}, Bomb), ...);
		end;
		Bomb.constructor = function(self)
			Bullet.constructor(self);
			TS.array_push(self.BulletBonuses, Classes_BulletGuidance.Homing.new(self));
			TS.array_push(self.BulletBonuses, Classes_BulletDamage.AreaOfEffect.new(self));
			return self;
		end;
	end;
	do
		local super = Bullet;
		SimpleBullet = {};
		SimpleBullet.__index = setmetatable({}, super);
		SimpleBullet.new = function(...)
			return SimpleBullet.constructor(setmetatable({}, SimpleBullet), ...);
		end;
		SimpleBullet.constructor = function(self)
			Bullet.constructor(self);
			TS.array_push(self.BulletBonuses, Classes_BulletGuidance.Simple.new(self));
			TS.array_push(self.BulletBonuses, Classes_BulletDamage.Simple.new(self));
			return self;
		end;
	end;
	do
		local super = Bullet;
		RandomBullet = {};
		RandomBullet.__index = setmetatable({}, super);
		RandomBullet.new = function(...)
			return RandomBullet.constructor(setmetatable({}, RandomBullet), ...);
		end;
		RandomBullet.constructor = function(self)
			Bullet.constructor(self);
			self.BulletHostName = RandomIndexFromDictionary(bulletHosts);
			local c0 = RandomFromDictionary(Classes_BulletGuidance);
			TS.array_push(self.BulletBonuses, c0.new(self));
			local c1 = RandomFromDictionary(Classes_BulletDamage);
			TS.array_push(self.BulletBonuses, c1.new(self));
			local totalStrength = math.random(30, 40);
			while totalStrength > 0 do
				local randomBonus = RandomFromDictionary(Classes_BulletExtra);
				local cls = randomBonus.new(self);
				TS.array_push(self.BulletBonuses, cls);
				totalStrength = totalStrength - (cls.Strength);
			end;
			return self;
		end;
	end;
	_3.Bomb = Bomb;
	_3.SimpleBullet = SimpleBullet;
	_3.RandomBullet = RandomBullet;
end;
_exports.Classes_Bullet = Classes_Bullet;
return _exports;
