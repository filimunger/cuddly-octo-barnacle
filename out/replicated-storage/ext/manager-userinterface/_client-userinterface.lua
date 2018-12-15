local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports;
local _0 = TS.import(script.Parent.Parent, "msc", "helper-functions");
local BringElementToFront, ConvertObjectToArray, EnumString = _0.BringElementToFront, _0.ConvertObjectToArray, _0.EnumString;
local AddInternalMenuButton = TS.import(script.Parent, "_client-hub-menu").AddInternalMenuButton;
local _1 = TS.import(script.Parent, "userinterface-module");
local C, GameVisualSettings = _1.C, _1.GameVisualSettings;
local _2 = TS.import(script.Parent, "visual-settings-module");
local AvailablePalettes, VisualSettings = _2.AvailablePalettes, _2.VisualSettings;
_exports = true;
local menu = AddInternalMenuButton('Modify User Interface');
print('addmenu');
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
	print('addlabel');
	local propertyLabel = C('PropertyLabel', container, {}, element, index);
	propertyLabel.PropertyPanel.ValueChanged:Connect(function()
		(GameVisualSettings)[index] = propertyLabel.PropertyPanel.Value;
	end);
end;
return _exports;
