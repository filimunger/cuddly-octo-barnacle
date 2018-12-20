local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Blaster;
local _0 = TS.import(script.Parent, "classes-bullet");
local T_Bullet, T_BulletName, Classes_Bullet = _0.T_Bullet, _0.T_BulletName, _0.Classes_Bullet;
local T_Character = TS.import(script.Parent, "classes").T_Character;
local RandomIndexFromDictionary = TS.import(script.Parent.Parent.Parent, "msc", "helper-functions").RandomIndexFromDictionary;
local createBullet = function(bulletName, blaster)
	local cls = Classes_Bullet[bulletName].new();
	TS.array_push(blaster.Bullets, cls);
	return cls;
end;
do
	Blaster = {};
	Blaster.__index = {
		Fire = function(self)
			for _, attachment in pairs(self.Attachments) do
				for _, bullet in pairs(self.Bullets) do
					bullet:Fire(attachment.WorldCFrame);
				end;
			end;
		end;
	};
	Blaster.new = function(...)
		return Blaster.constructor(setmetatable({}, Blaster), ...);
	end;
	Blaster.constructor = function(self, character)
		self.AreaId = 0;
		self.Attachments = {};
		self.Bullets = {};
		for _, instance in pairs(character.Model:GetDescendants()) do
			if instance:IsA('Attachment') then
				if instance.Name == ('Attachment_Turret') .. tostring(self.AreaId) then
					TS.array_push(self.Attachments, instance);
				end;
			end;
		end;
		return self;
	end;
end;
local Classes_Blaster = {} do
	local _1 = Classes_Blaster;
	local SimpleBlaster, BombBlaster, RandomizedBlaster, SuperRandomizedBlaster;
	do
		local super = Blaster;
		SimpleBlaster = {};
		SimpleBlaster.__index = setmetatable({}, super);
		SimpleBlaster.new = function(...)
			return SimpleBlaster.constructor(setmetatable({}, SimpleBlaster), ...);
		end;
		SimpleBlaster.constructor = function(self, character)
			Blaster.constructor(self, character);
			self.AreaId = 0;
			createBullet('SimpleBullet', self);
			return self;
		end;
	end;
	do
		local super = Blaster;
		BombBlaster = {};
		BombBlaster.__index = setmetatable({}, super);
		BombBlaster.new = function(...)
			return BombBlaster.constructor(setmetatable({}, BombBlaster), ...);
		end;
		BombBlaster.constructor = function(self, ...)
			super.constructor(self, ...);
			self.AreaId = 1;
			return self;
		end;
	end;
	do
		local super = Blaster;
		RandomizedBlaster = {};
		RandomizedBlaster.__index = setmetatable({}, super);
		RandomizedBlaster.new = function(...)
			return RandomizedBlaster.constructor(setmetatable({}, RandomizedBlaster), ...);
		end;
		RandomizedBlaster.constructor = function(self, character)
			Blaster.constructor(self, character);
			self.AreaId = math.random(0, 3);
			TS.array_push(self.Bullets, Classes_Bullet[(RandomIndexFromDictionary(Classes_Bullet))].new());
			if math.random(1, 10) == 1 then
				TS.array_push(self.Bullets, Classes_Bullet[(RandomIndexFromDictionary(Classes_Bullet))].new());
			end;
			return self;
		end;
	end;
	do
		local super = Blaster;
		SuperRandomizedBlaster = {};
		SuperRandomizedBlaster.__index = setmetatable({}, super);
		SuperRandomizedBlaster.new = function(...)
			return SuperRandomizedBlaster.constructor(setmetatable({}, SuperRandomizedBlaster), ...);
		end;
		SuperRandomizedBlaster.constructor = function(self, character)
			Blaster.constructor(self, character);
			createBullet('RandomBullet', self);
			if math.random(1, 10) == 1 then
				createBullet('RandomBullet', self);
			end;
			return self;
		end;
	end;
	_1.SimpleBlaster = SimpleBlaster;
	_1.BombBlaster = BombBlaster;
	_1.RandomizedBlaster = RandomizedBlaster;
	_1.SuperRandomizedBlaster = SuperRandomizedBlaster;
end;
_exports.Classes_Blaster = Classes_Blaster;
return _exports;
