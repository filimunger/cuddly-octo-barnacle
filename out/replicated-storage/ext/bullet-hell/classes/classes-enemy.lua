local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Character_Enemy;
local SetPartCollisionGroup = TS.import(script.Parent.Parent, "main", "collision-groups").SetPartCollisionGroup;
local _0 = TS.import(script.Parent.Parent, "main", "module");
local MapWidthRadius, MapHeightRadius = _0.MapWidthRadius, _0.MapHeightRadius;
local _1 = TS.import(script.Parent, "classes");
local Character, T_Character = _1.Character, _1.T_Character;
local _2 = TS.import(script.Parent, "classes-deck");
local T_Deck, T_DeckName, Classes_Deck = _2.T_Deck, _2.T_DeckName, _2.Classes_Deck;
local Workspace = require(TS.getModule("rbx-services", script.Parent).out).Workspace;
local WeldModel = TS.import(script.Parent.Parent.Parent, "msc", "helper-functions").WeldModel;
local createDeck = function(name, character)
	return Classes_Deck[name].new(character);
end;
do
	local super = Character;
	Character_Enemy = {};
	Character_Enemy.__index = setmetatable({
		TakeDamage = function(self, damage)
			local _3 = self; _3.Health = _3.Health - (damage);
			if self.Health <= 0 then
				self.Model:Destroy();
			end;
		end;
		Play = function(self)
			self.Deck:Play();
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
		self.Model:SetPrimaryPartCFrame(CFrame.new(Vector3.new(math.random(-MapWidthRadius, MapWidthRadius), 0, -MapHeightRadius - 10)));
		self:SetVelocity(Vector3.new(0, 0, 10));
		return self;
	end;
end;
local Classes_Enemy = {} do
	local _3 = Classes_Enemy;
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
			self.Deck = createDeck('Noid', self);
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
			self.Deck = createDeck('RandomizedBossDeck', self);
			return self;
		end;
	end;
	_3.Noid = Noid;
	_3.ProceduralBoss = ProceduralBoss;
end;
_exports.Classes_Enemy = Classes_Enemy;
return _exports;
