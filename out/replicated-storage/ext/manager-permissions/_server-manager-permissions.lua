local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local Players = require(TS.getModule("rbx-services", script.Parent).out).Players;
local T_Rank = TS.import(script.Parent, "manager-permissions").T_Rank;
local SetPlayerRank = function(player, rank) return ((function() (player:WaitForChild('Rank')).Value = rank; return (player:WaitForChild('Rank')).Value; end)()); end;
Players.PlayerAdded:Connect(function(player)
	local value = Instance.new("StringValue", player);
	value.Name = 'Rank';
	value.Value = 'Player';
end);
_exports.SetPlayerRank = SetPlayerRank;
return _exports;
