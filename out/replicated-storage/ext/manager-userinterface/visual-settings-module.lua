local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local VisualSettings;
local CollectionService = require(TS.getModule("rbx-services", script.Parent).out).CollectionService;
local AvailablePalettes = {
	SeaBottomBlue = {
		Color1 = Color3.fromRGB(225, 225, 225);
		Color2 = Color3.fromRGB(140, 146, 162);
		Color3 = Color3.fromRGB(89, 103, 132);
		Color4 = Color3.fromRGB(66, 83, 129);
		Color5 = Color3.fromRGB(47, 47, 49);
	};
	SisterSunflower = {
		Color1 = Color3.fromRGB(195, 251, 244);
		Color2 = Color3.fromRGB(251, 195, 202);
		Color3 = Color3.fromRGB(251, 244, 195);
		Color4 = Color3.fromRGB(137, 196, 250);
		Color5 = Color3.fromRGB(195, 202, 251);
	};
	DiscordColors = {
		Color1 = Color3.fromRGB(255, 255, 255);
		Color2 = Color3.fromRGB(114, 137, 218);
		Color3 = Color3.fromRGB(153, 170, 181);
		Color4 = Color3.fromRGB(44, 47, 51);
		Color5 = Color3.fromRGB(35, 39, 42);
	};
	MetroUIColors = {
		Color1 = Color3.fromRGB(209, 17, 65);
		Color2 = Color3.fromRGB(0, 177, 89);
		Color3 = Color3.fromRGB(0, 174, 219);
		Color4 = Color3.fromRGB(243, 119, 53);
		Color5 = Color3.fromRGB(255, 196, 37);
	};
	MurkWoods = {
		Color1 = Color3.fromRGB(197, 151, 157);
		Color2 = Color3.fromRGB(75, 143, 140);
		Color3 = Color3.fromRGB(72, 77, 109);
		Color4 = Color3.fromRGB(44, 54, 94);
		Color5 = Color3.fromRGB(43, 25, 61);
	};
	Poison = {
		Color1 = Color3.fromRGB(223, 243, 228);
		Color2 = Color3.fromRGB(113, 128, 185);
		Color3 = Color3.fromRGB(52, 35, 166);
		Color4 = Color3.fromRGB(46, 23, 96);
		Color5 = Color3.fromRGB(23, 23, 56);
	};
};
local PaletteInterfaceRemarks = {
	Panel = 'PanelColor';
	TexturePanel = 'TexturePanelColor';
	TextureButtonDefaultColor = 'TextureButtonColor';
	TypePanel = 'TypePanelColor';
	TypeButton = 'TypeButtonColor';
	TypeBox = 'TypeBoxColor';
};
do
	VisualSettings = {};
	VisualSettings.__index = {};
	VisualSettings.new = function(...)
		return VisualSettings.constructor(setmetatable({}, VisualSettings), ...);
	end;
	VisualSettings.constructor = function(self)
		self.LabelTextColor = Color3.fromRGB(0, 0, 0);
		self.IconImage = 'rbxgameasset://hue_gradient';
		self.TexturePanelImage = 'rbxassetid://2579500533';
		self.TextureButtonImage = 'rbxassetid://2579500533';
		self.TypePanelImage = 'rbxassetid://2579500533';
		self.TypeButtonImage = 'rbxassetid://2579500533';
		self.ImageSize = 256;
		self.NineSlice = 16;
		self.TextTipBackgroundColor = Color3.fromRGB(0, 0, 0);
		self.TextTipTextColor = Color3.fromRGB(255, 255, 255);
		self.LabelFontScaled = true;
		self.ScrollBarColor = Color3.fromRGB(255, 255, 255);
		self.ColorPalette = AvailablePalettes.MurkWoods;
		self.DynamicColorPalette = AvailablePalettes.MetroUIColors;
		self.TypePanelFont = Enum.Font.SourceSansBold;
		self.TypeButtonFont = Enum.Font.SourceSansBold;
		self.TypeBoxFont = Enum.Font.SourceSansBold;
		return self;
	end;
	VisualSettings._getters = {
		ColorPalette = function(self)
			return self.MyColorPalette;
		end;
		DynamicColorPalette = function(self)
			return self.MyDynamicColorPalette;
		end;
		TypePanelFont = function(self)
			return self.MyTypePanelFont;
		end;
		TypeButtonFont = function(self)
			return self.MyTypeButtonFont;
		end;
		TypeBoxFont = function(self)
			return self.MyTypeBoxFont;
		end;
	};
	local __index = VisualSettings.__index;
	VisualSettings.__index = function(self, index)
		local getter = VisualSettings._getters[index];
		if getter then
			return getter(self);
		else
			return __index[index];
		end;
	end;
	VisualSettings._setters = {
		ColorPalette = function(self, prop)
			self.MyColorPalette = prop;
			self.PanelColor = self.ColorPalette.Color5;
			self.TexturePanelColor = self.ColorPalette.Color4;
			self.TextureButtonColor = self.ColorPalette.Color2;
			self.TypePanelColor = self.ColorPalette.Color1;
			self.TypeButtonColor = self.ColorPalette.Color3;
			self.TypeBoxColor = self.ColorPalette.Color1;
			for index in pairs(PaletteInterfaceRemarks) do
				local myColor = (self)[(PaletteInterfaceRemarks)[index]];
				for _, element in pairs(CollectionService:GetTagged(index)) do
					if element:IsA('GuiObject') then
						if element:IsA('ImageLabel') or element:IsA('ImageButton') then
							element.ImageColor3 = myColor;
						else
							element.BackgroundColor3 = myColor;
						end;
					end;
				end;
			end;
		end;
		DynamicColorPalette = function(self, prop)
			self.MyDynamicColorPalette = prop;
		end;
		TypePanelFont = function(self, prop)
			self.MyTypePanelFont = prop;
			for _, instance in pairs(CollectionService:GetTagged('TypePanelHost')) do
				(instance).Font = prop;
			end;
		end;
		TypeButtonFont = function(self, prop)
			self.MyTypeButtonFont = prop;
			for _, instance in pairs(CollectionService:GetTagged('TypeButtonHost')) do
				(instance).Font = prop;
			end;
		end;
		TypeBoxFont = function(self, prop)
			self.MyTypeBoxFont = prop;
			for _, instance in pairs(CollectionService:GetTagged('TypeBoxHost')) do
				(instance).Font = prop;
			end;
		end;
	};
	VisualSettings.__newindex = function(self, index, value)
		local setter = VisualSettings._setters[index];
		if setter then
			setter(self, value);
		else
			rawset(self, index, value);
		end;
	end;
end;
_exports.AvailablePalettes = AvailablePalettes;
_exports.PaletteInterfaceRemarks = PaletteInterfaceRemarks;
_exports.VisualSettings = VisualSettings;
return _exports;
