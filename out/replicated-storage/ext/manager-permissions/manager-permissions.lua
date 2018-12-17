local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local GetRankId, GetPlayerRank, RankExceedsRank, PlayerExceedsRank, BindElementToRank;
local Players = require(TS.getModule("rbx-services", script.Parent).out).Players;
local RankObject = {
	Player = 0;
	Editor = 1;
	Host = 2;
};
local ManageGameRank = 'Editor';
local EditRanksRank = 'Player';
GetRankId = function(rank)
	return RankObject[rank];
end;
GetPlayerRank = function(player)
	local rankObject = player:WaitForChild('Rank');
	return rankObject.Value;
end;
RankExceedsRank = function(myRank, rank)
	return GetRankId(myRank) >= GetRankId(rank);
end;
PlayerExceedsRank = function(player, rank)
	return RankExceedsRank(GetPlayerRank(player), rank);
end;
BindElementToRank = function(element, rank, hideWhileLostRank, clickCallback, lostRankCallback, regainedRankCallback)
	if rank == nil then rank = ManageGameRank end;
	if hideWhileLostRank == nil then hideWhileLostRank = true end;
	local update;
	local player = Players.LocalPlayer;
	local rankObject = player:WaitForChild('Rank');
	local connection;
	update = function()
		if PlayerExceedsRank(player, rank) then
			if hideWhileLostRank then
				element.Visible = true;
			end;
			if regainedRankCallback then
				regainedRankCallback();
			end;
			if clickCallback and TS.isA(element, "ImageButton") then
				connection = element.MouseButton1Down:Connect(clickCallback);
			end;
		else
			if hideWhileLostRank then
				element.Visible = false;
			end;
			if connection then
				connection:Disconnect();
			end;
			if lostRankCallback then
				lostRankCallback();
			end;
		end;
	end;
	update();
	rankObject.Changed:Connect(update);
end;
_exports.RankObject = RankObject;
_exports.ManageGameRank = ManageGameRank;
_exports.EditRanksRank = EditRanksRank;
_exports.GetRankId = GetRankId;
_exports.GetPlayerRank = GetPlayerRank;
_exports.RankExceedsRank = RankExceedsRank;
_exports.PlayerExceedsRank = PlayerExceedsRank;
_exports.BindElementToRank = BindElementToRank;
return _exports;
