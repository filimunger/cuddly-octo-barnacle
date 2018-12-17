local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Deck;
local _0 = TS.import(script.Parent, "classes-card");
local T_CardName, T_Card, Classes_Card = _0.T_CardName, _0.T_Card, _0.Classes_Card;
local createCard = function(cardName, deck)
	TS.array_push(deck.Cards, Classes_Card[cardName].new());
end;
do
	Deck = {};
	Deck.__index = {
		Play = function(self)
			for _, card in pairs(self.Cards) do
				card.Play();
			end;
		end;
	};
	Deck.new = function(...)
		return Deck.constructor(setmetatable({}, Deck), ...);
	end;
	Deck.constructor = function(self, ...)
		self.Cards = {};
		return self;
	end;
end;
local Classes_Deck = {} do
	local _1 = Classes_Deck;
	local RandomizedBossDeck, Noid;
	do
		local super = Deck;
		RandomizedBossDeck = {};
		RandomizedBossDeck.__index = setmetatable({}, super);
		RandomizedBossDeck.new = function(...)
			return RandomizedBossDeck.constructor(setmetatable({}, RandomizedBossDeck), ...);
		end;
		RandomizedBossDeck.constructor = function(self, ...)
			super.constructor(self, ...);
			return self;
		end;
	end;
	do
		local super = Deck;
		Noid = {};
		Noid.__index = setmetatable({}, super);
		Noid.new = function(...)
			return Noid.constructor(setmetatable({}, Noid), ...);
		end;
		Noid.constructor = function(self)
			Deck.constructor(self);
			createCard('NoidCard', self);
			return self;
		end;
	end;
	_1.RandomizedBossDeck = RandomizedBossDeck;
	_1.Noid = Noid;
end;
_exports.Classes_Deck = Classes_Deck;
return _exports;
