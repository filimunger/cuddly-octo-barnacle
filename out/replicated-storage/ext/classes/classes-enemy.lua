local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Character_Enemy;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "demo", "collision-groups").SetPartCollisionGroup;
local _0 = TS.import(script.Parent.Parent, "demo", "module");
local MapWidthRadius, MapHeightRadius = _0.MapWidthRadius, _0.MapHeightRadius;
local Character = TS.import(script.Parent, "classes").Character;
local _1 = TS.import(script.Parent, "classes-deck");
local T_Deck, T_DeckName, Classes_Deck = _1.T_Deck, _1.T_DeckName, _1.Classes_Deck;
local Workspace = require(TS.getModule("rbx-services", script.Parent).out).Workspace;
local WeldModel = TS.import(script.Parent.Parent, "msc", "helper-functions").WeldModel;
local createDeck = function(name)
	return Classes_Deck[name].new();
end;
do
	local super = Character;
	Character_Enemy = {};
	Character_Enemy.__index = setmetatable({
		TakeDamage = function(self, damage)
			local _2 = self; _2.Health = _2.Health - (damage);
			if self.Health <= 0 then
				self.Model:Destroy();
			end;
		end;
		Play = function(self)
			print('me', self);
			if self then
				self.Deck:Play();
			else
				print('lol');
			end;
		end;
	}, super);
	Character_Enemy.new = function(...)
		return Character_Enemy.constructor(setmetatable({}, Character_Enemy), ...);
	end;
	Character_Enemy.constructor = function(self, name)
		Character.constructor(self, name);
		self.Model.Parent = Workspace:WaitForChild('EnemyCharacters');
		for _, instance in pairs(self.Model:GetDescendants()) do
			if instance:IsA('BasePart') then
				SetPartCollisionGroup(instance, 'EnemyCharacters');
			end;
		end;
		WeldModel(self.Model);
		self.Model:SetPrimaryPartCFrame(CFrame.new(Vector3.new(math.random(-MapWidthRadius, MapWidthRadius), 0, -MapHeightRadius + 50)));
		return self;
	end;
end;
local Classes_Enemy = {} do
	local _2 = Classes_Enemy;
	local Noid, ProceduralBoss;
	do
		local super = Character_Enemy;
		Noid = {};
		Noid.__index = setmetatable({}, super);
		Noid.new = function(...)
			return Noid.constructor(setmetatable({}, Noid), ...);
		end;
		Noid.constructor = function(self, ...)
			super.constructor(self, ...);
			self.Deck = createDeck('Noid');
			return self;
		end;
	end;
	do
		local super = Character_Enemy;
		ProceduralBoss = {};
		ProceduralBoss.__index = setmetatable({}, super);
		ProceduralBoss.new = function(...)
			return ProceduralBoss.constructor(setmetatable({}, ProceduralBoss), ...);
		end;
		ProceduralBoss.constructor = function(self, ...)
			super.constructor(self, ...);
			self.Deck = createDeck('RandomizedBossDeck');
			return self;
		end;
	end;
	_2.Noid = Noid;
	_2.ProceduralBoss = ProceduralBoss;
end;
_exports.Classes_Enemy = Classes_Enemy;
return _exports;
