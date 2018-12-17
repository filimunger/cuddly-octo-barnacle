local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Card;
local _0 = TS.import(script.Parent.Parent, "msc", "helper-functions");
local SimpleVector, CreateNewEffect = _0.SimpleVector, _0.CreateNewEffect;
local Workspace = require(TS.getModule("rbx-services", script.Parent).out).Workspace;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "demo", "collision-groups").SetPartCollisionGroup;
local bulletSave = CreateNewEffect('EnemyBullet');
do
	Card = {};
	Card.__index = {};
	Card.new = function(...)
		return Card.constructor(setmetatable({}, Card), ...);
	end;
	Card.constructor = function(self, ...)
		self.BulletsPerArray = 2;
		self.IndividualArraySpread = 90;
		self.TotalBulletArrays = 1;
		self.CurrentSpinSpeed = 15;
		self.SpinSpeedChangeRate = 0;
		self.SpinReversal = 0;
		self.MaxSpinSpeed = 30;
		self.FireRate = 4;
		self.BulletSpeed = 4;
		self.BulletAcceleration = 0;
		self.BulletCurve = 0;
		self.ObjectWidth = 16;
		self.ObjectHeight = 16;
		self.XOffset = 0;
		self.YOffset = 0;
		self.Play = function()
			local targetFrame = CFrame.new(SimpleVector(Vector3.new()), SimpleVector(Vector3.new(1, 1, 1)));
			local startFrame = (targetFrame * CFrame.Angles(0, -math.rad((self.TotalBulletArrays * self.IndividualArraySpread) / 2), 0));
			local degreesPerBulletInArray = self.IndividualArraySpread / self.BulletsPerArray;
			do
				local arrayIndex = 0;
				while arrayIndex < self.TotalBulletArrays do
					do
						local bulletIndex = 0;
						while bulletIndex < self.BulletsPerArray do
							local bulletFrame = (startFrame * CFrame.Angles(0, math.rad(arrayIndex * self.IndividualArraySpread + degreesPerBulletInArray), 0));
							local myBullet = bulletSave:Clone();
							myBullet.Parent = Workspace;
							SetPartCollisionGroup(myBullet, 'EnemyBullets');
							myBullet.CFrame = bulletFrame;
							myBullet.Velocity = (myBullet.CFrame.LookVector * 50);
							myBullet.Touched:Connect(function(part)
							end);
							bulletIndex = bulletIndex + 1;
						end;
					end;
					arrayIndex = arrayIndex + 1;
				end;
			end;
		end;
		return self;
	end;
end;
local Classes_Card = {} do
	local _1 = Classes_Card;
	local RandomizedBossCard, NoidCard;
	do
		local super = Card;
		RandomizedBossCard = {};
		RandomizedBossCard.__index = setmetatable({}, super);
		RandomizedBossCard.new = function(...)
			return RandomizedBossCard.constructor(setmetatable({}, RandomizedBossCard), ...);
		end;
		RandomizedBossCard.constructor = function(self)
			Card.constructor(self);
			local cardStrength = 100;
			return self;
		end;
	end;
	do
		local super = Card;
		NoidCard = {};
		NoidCard.__index = setmetatable({}, super);
		NoidCard.new = function(...)
			return NoidCard.constructor(setmetatable({}, NoidCard), ...);
		end;
		NoidCard.constructor = function(self)
			Card.constructor(self);
			self.BulletsPerArray = 2;
			self.IndividualArraySpread = 40;
			self.TotalBulletArrays = 1;
			self.CurrentSpinSpeed = 15;
			self.SpinSpeedChangeRate = 0;
			self.SpinReversal = 0;
			self.MaxSpinSpeed = 30;
			self.FireRate = 4;
			self.BulletSpeed = 4;
			self.BulletAcceleration = 0;
			self.BulletCurve = 0;
			self.ObjectWidth = 16;
			self.ObjectHeight = 16;
			self.XOffset = 0;
			self.YOffset = 0;
			return self;
		end;
	end;
	_1.RandomizedBossCard = RandomizedBossCard;
	_1.NoidCard = NoidCard;
end;
_exports.Classes_Card = Classes_Card;
return _exports;
