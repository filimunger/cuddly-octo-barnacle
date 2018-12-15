local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports;
local Players = require(TS.getModule("rbx-services", script.Parent).out).Players;
local C = TS.import(script.Parent.Parent, "manager-userinterface", "userinterface-module").C;
local AddInternalMenuButton = TS.import(script.Parent.Parent, "manager-userinterface", "_client-hub-menu").AddInternalMenuButton;
local _0 = TS.import(script.Parent, "manager-permissions");
local RankObject, GetPlayerRank, PlayerExceedsRank, EditRanksRank, T_Rank = _0.RankObject, _0.GetPlayerRank, _0.PlayerExceedsRank, _0.EditRanksRank, _0.T_Rank;
local SetPlayerRank = TS.import(script.Parent, "_server-manager-permissions").SetPlayerRank;
_exports = true;
local menu = AddInternalMenuButton('Modify Permissions');
local labelHeight = 40;
local container = C('Container', menu, {
	Style = 'Grid';
	CellSize = UDim2.new(1, 0, 0, labelHeight);
});
C('TypePanel', container, {
	Text = 'Set Permissions';
});
local addPlayerToContainer = function(player)
	local panel = C('Panel', container, {});
	local nameWidth = 100;
	C('TypePanel', panel, {
		Text = player.Name;
		Size = UDim2.new(0, nameWidth, 1, 0);
	});
	local ranksPanel = C('Panel', panel, {
		Size = UDim2.new(1, -nameWidth, 1, 0);
		Position = UDim2.new(0, nameWidth, 0, 0);
	});
	local ranksContainer = C('Container', ranksPanel, {
		Style = 'Grid';
		CellSize = UDim2.new(0, labelHeight, 0, labelHeight);
		HAlignment = 'Right';
	});
	for rankName in pairs(RankObject) do
		local rankButton = C('TypeButton', ranksContainer, {
			Text = string.sub(rankName, 1, 1);
		});
		rankButton.MouseClick:Connect(function()
			local myPlayer = Players.LocalPlayer;
			if myPlayer ~= player and PlayerExceedsRank(myPlayer, EditRanksRank) and PlayerExceedsRank(myPlayer, rankName) then
				SetPlayerRank(player, rankName);
			end;
		end);
	end;
	local rankLabel = C('TypePanel', panel, {
		Position = UDim2.new(0, nameWidth, 0, 0);
		Size = UDim2.new(1, -nameWidth, 1, 0);
	});
	local update = function()
		rankLabel.Text = GetPlayerRank(player);
	end;
	local rankValue = player:WaitForChild('Rank');
	rankValue.Changed:Connect(update);
	update();
end;
local removePlayerFromContainer = function(player)
end;
TS.array_forEach(Players:GetPlayers(), addPlayerToContainer);
Players.PlayerAdded:Connect(addPlayerToContainer);
Players.PlayerRemoving:Connect(removePlayerFromContainer);
return _exports;
