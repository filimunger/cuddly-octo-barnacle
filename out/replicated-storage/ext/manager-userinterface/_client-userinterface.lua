local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports;
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local Players, StarterGui = _0.Players, _0.StarterGui;
if not (Players.LocalPlayer):WaitForChild('PlayerGui'):FindFirstChild('ScreenGui') then
	StarterGui.ScreenGui:Clone().Parent = (Players.LocalPlayer):WaitForChild('PlayerGui');
end;
local _1 = TS.import(script.Parent.Parent, "msc", "helper-functions");
local BringElementToFront, ConvertObjectToArray, EnumString = _1.BringElementToFront, _1.ConvertObjectToArray, _1.EnumString;
local AddInternalMenuButton = TS.import(script.Parent, "_client-hub-menu").AddInternalMenuButton;
local _2 = TS.import(script.Parent, "userinterface-module");
local C, GameVisualSettings = _2.C, _2.GameVisualSettings;
local _3 = TS.import(script.Parent, "visual-settings-module");
local AvailablePalettes, VisualSettings = _3.AvailablePalettes, _3.VisualSettings;
_exports = true;
local menu = AddInternalMenuButton('Modify User Interface');
local container = C('Container', menu, {
	Style = 'Grid';
	CellSize = UDim2.new(1, 0, 0, 40);
});
local fontFamily = { Enum.Font.Antique, Enum.Font.Arcade, Enum.Font.Arial, Enum.Font.ArialBold, Enum.Font.Bodoni, Enum.Font.Cartoon, Enum.Font.Code, Enum.Font.Fantasy, Enum.Font.Garamond, Enum.Font.Highway, Enum.Font.Legacy, Enum.Font.SciFi, Enum.Font.SourceSans, Enum.Font.SourceSansBold, Enum.Font.SourceSansItalic, Enum.Font.SourceSansLight, Enum.Font.SourceSansSemibold };
local remarks = {
	ColorPalette = BringElementToFront(ConvertObjectToArray(AvailablePalettes), GameVisualSettings.ColorPalette);
	TypePanelFont = BringElementToFront(fontFamily, EnumString(GameVisualSettings.TypePanelFont));
	TypeButtonFont = BringElementToFront(fontFamily, EnumString(GameVisualSettings.TypeButtonFont));
	TypeBoxFont = BringElementToFront(fontFamily, EnumString(GameVisualSettings.TypeBoxFont));
};
for index in pairs(remarks) do
	local element = (remarks)[index];
	local propertyLabel = C('PropertyLabel', container, {}, element, index);
	propertyLabel.PropertyPanel.ValueChanged:Connect(function()
		(GameVisualSettings)[index] = propertyLabel.PropertyPanel.Value;
	end);
end;
return _exports;
