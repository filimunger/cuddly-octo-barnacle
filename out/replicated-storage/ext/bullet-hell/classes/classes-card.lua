local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Card;
local _0 = TS.import(script.Parent.Parent.Parent, "msc", "helper-functions");
local SimpleVector, CreateNewEffect = _0.SimpleVector, _0.CreateNewEffect;
local _1 = require(TS.getModule("rbx-services", script.Parent).out);
local Workspace, TweenService = _1.Workspace, _1.TweenService;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "main", "collision-groups").SetPartCollisionGroup;
local GetFriendlyFromPart = TS.import(script.Parent.Parent, "main", "character-manager").GetFriendlyFromPart;
local bulletSave = CreateNewEffect('EnemyBullet');
local applyAngleToFrame = function(frame, angle)
	return (frame * CFrame.Angles(0, math.rad(angle), 0));
end;
do
	Card = {};
	Card.__index = {
		Fire = function(self)
			do
				local arrayIndex = 0;
				while arrayIndex < self.TotalBulletArrays do
					do
						local bulletIndex = 0;
						while bulletIndex < self.BulletsPerArray do
							print('addbullet');
							local bulletFrame = applyAngleToFrame(self.StartFrame, arrayIndex * self.IndividualArraySpread + self.DegreesPerBulletInArray);
							local myBullet = bulletSave:Clone();
							myBullet.Size = Vector3.new(self.ObjectSize, self.ObjectSize, self.ObjectSize);
							myBullet.Parent = Workspace;
							SetPartCollisionGroup(myBullet, 'EnemyBullets');
							myBullet.CFrame = bulletFrame;
							local bulletCurrentVelocity = self.BulletInitialVelocity;
							myBullet.Velocity = (myBullet.CFrame.LookVector * bulletCurrentVelocity);
							myBullet.Touched:Connect(function(part)
								local character = GetFriendlyFromPart(part);
								if character then
									character:Die();
								end;
							end);
							if self.BulletAcceleration ~= 0 then
								coroutine.wrap(function()
									while true do
										myBullet.CFrame = applyAngleToFrame(myBullet.CFrame, self.BulletCurve);
										bulletCurrentVelocity = bulletCurrentVelocity + (self.BulletAcceleration);
										TweenService:Create(myBullet, TweenInfo.new(1), {
											Velocity = (myBullet.CFrame.LookVector * bulletCurrentVelocity);
										});
										wait(1);
									end;
								end)();
							end;
							bulletIndex = bulletIndex + 1;
						end;
					end;
					arrayIndex = arrayIndex + 1;
				end;
			end;
		end;
	};
	Card.new = function(...)
		return Card.constructor(setmetatable({}, Card), ...);
	end;
	Card.constructor = function(self, ...)
		self.TotalBulletArrays = 1;
		self.IndividualArraySpread = 360;
		self.BulletsPerArray = 12;
		self.FireRate = 0.2;
		self.XOffset = 0;
		self.YOffset = 0;
		self.CurrentSpinSpeed = 15;
		self.SpinSpeedChangeAmount = 0.5;
		self.SpinSpeedChangeSpeed = 0.2;
		self.MaxSpinSpeed = 30;
		self.BulletInitialVelocity = 4;
		self.BulletAcceleration = 1;
		self.BulletCurve = 15;
		self.ObjectSize = 4;
		self.Play = function(selfFrame)
			local targetFrame = CFrame.new(selfFrame.p, SimpleVector(Vector3.new(1, 1, 1)));
			self.StartFrame = applyAngleToFrame(targetFrame, (-self.TotalBulletArrays * self.IndividualArraySpread) / 2);
			self.DegreesPerBulletInArray = self.IndividualArraySpread / self.BulletsPerArray;
			coroutine.wrap(function()
				while true do
					self:Fire();
					wait(self.FireRate);
				end;
			end)();
			if self.SpinSpeedChangeAmount ~= 0 then
				coroutine.wrap(function()
					while true do
						local _2 = self; _2.CurrentSpinSpeed = _2.CurrentSpinSpeed + (self.SpinSpeedChangeAmount);
						if math.abs(self.CurrentSpinSpeed) >= self.MaxSpinSpeed then
							local _3 = self; _3.SpinSpeedChangeAmount = _3.SpinSpeedChangeAmount * (-1);
						end;
						wait(self.SpinSpeedChangeSpeed);
					end;
				end);
			end;
			coroutine.wrap(function()
				while true do
					wait();
					self.StartFrame = applyAngleToFrame(self.StartFrame, self.CurrentSpinSpeed / 20);
				end;
			end)();
		end;
		return self;
	end;
end;
local Classes_Card = {} do
	local _2 = Classes_Card;
	local RandomizedBossCard, BaseCard, NoidCard;
	do
		local super = Card;
		RandomizedBossCard = {};
		RandomizedBossCard.__index = setmetatable({}, super);
		RandomizedBossCard.new = function(...)
			return RandomizedBossCard.constructor(setmetatable({}, RandomizedBossCard), ...);
		end;
		RandomizedBossCard.constructor = function(self)
			Card.constructor(self);
			local cardStrength = 1;
			return self;
		end;
	end;
	do
		local super = Card;
		BaseCard = {};
		BaseCard.__index = setmetatable({}, super);
		BaseCard.new = function(...)
			return BaseCard.constructor(setmetatable({}, BaseCard), ...);
		end;
		BaseCard.constructor = function(self, ...)
			super.constructor(self, ...);
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
			return self;
		end;
	end;
	_2.RandomizedBossCard = RandomizedBossCard;
	_2.BaseCard = BaseCard;
	_2.NoidCard = NoidCard;
end;
_exports.Classes_Card = Classes_Card;
return _exports;
