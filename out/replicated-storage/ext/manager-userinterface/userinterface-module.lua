local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local C;
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local CollectionService, Players, TweenService = _0.CollectionService, _0.Players, _0.TweenService;
local _1 = TS.import(script.Parent.Parent, "msc", "helper-functions");
local CustomCheckTypeOf, EnumString, ObjectArrayLength = _1.CustomCheckTypeOf, _1.EnumString, _1.ObjectArrayLength;
local CallRemote = TS.import(script.Parent.Parent, "manager-remote", "manager-remote").CallRemote;
local BindInputs = TS.import(script.Parent.Parent, "manager-userinput", "userinput-module").BindInputs;
local _2 = TS.import(script.Parent, "visual-settings-module");
local PaletteInterfaceRemarks, VisualSettings = _2.PaletteInterfaceRemarks, _2.VisualSettings;
local GameVisualSettings = VisualSettings.new();
local texttipContainer;
local propertyMenuArea;
local AvailableInterfaceComponents;
local UserInterfaceTypes = {} do
	local _3 = UserInterfaceTypes;
	local Primitive, Icon, ViewportPanel, Panel, Area, TexturePanel, TextureButton, TypePanel, TypeButton, TypeBox, PropertyPanel, PropertyLabel, Container;
	do
		Primitive = {};
		Primitive.__index = {
			Destroy = function(self)
				self.MainFrame:Destroy();
			end;
		};
		Primitive.new = function(...)
			return Primitive.constructor(setmetatable({}, Primitive), ...);
		end;
		Primitive.constructor = function(self)
			self.EndInterfaceComponents = {};
			self.MainFrame = Instance.new("Frame");
			self.MainFrame.BackgroundTransparency = 1;
			self.Size = UDim2.new(1, 0, 1, 0);
			return self;
		end;
		Primitive._getters = {
			Parent = function(self)
				return self.MainFrame.Parent;
			end;
			Size = function(self)
				return self.MainFrame.Size;
			end;
			Position = function(self)
				return self.MainFrame.Position;
			end;
			Visible = function(self)
				return self.MainFrame.Visible;
			end;
			AbsoluteSize = function(self)
				return self.MainFrame.AbsoluteSize;
			end;
			AbsolutePosition = function(self)
				return self.MainFrame.AbsolutePosition;
			end;
		};
		local __index = Primitive.__index;
		Primitive.__index = function(self, index)
			local getter = Primitive._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		Primitive._setters = {
			ZIndex = function(self, prop)
				local oldZIndex = self.MainFrame.ZIndex;
				self.MainFrame.ZIndex = prop;
				local difference = self.MainFrame.ZIndex - oldZIndex;
				local recurse;
				recurse = function(object)
					for _, element in pairs(object:GetChildren()) do
						if TS.isA(element, "GuiObject") then
							element.ZIndex = element.ZIndex + difference;
						end;
						recurse(element);
					end;
				end;
				recurse(self.MainFrame);
			end;
			Parent = function(self, parent)
				self.MainFrame.Parent = parent;
				if parent then
					local newParent = (parent:IsA('GuiObject') and not parent:IsA('ScrollingFrame') and parent or (parent.Parent and parent.Parent:IsA('GuiObject') and not parent.Parent:IsA('ScrollingFrame') and parent.Parent or (parent.Parent and parent.Parent.Parent and parent.Parent.Parent:IsA('GuiObject') and not parent.Parent.Parent:IsA('ScrollingFrame') and parent.Parent.Parent or nil)));
					if newParent then
						self.ZIndex = newParent.ZIndex + 1;
					end;
				end;
			end;
			Name = function(self, prop)
				self.MainFrame.Name = prop;
			end;
			Size = function(self, prop)
				self.MainFrame.Size = prop;
			end;
			Position = function(self, prop)
				self.MainFrame.Position = prop;
			end;
			Visible = function(self, prop)
				self.MainFrame.Visible = prop;
			end;
		};
		Primitive.__newindex = function(self, index, value)
			local setter = Primitive._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Primitive;
		Icon = {};
		Icon.__index = setmetatable({}, super);
		Icon.new = function(...)
			return Icon.constructor(setmetatable({}, Icon), ...);
		end;
		Icon.constructor = function(self)
			Primitive.constructor(self);
			self.ImageLabel = Instance.new("ImageLabel", self.MainFrame);
			self.ImageLabel.ZIndex = self.MainFrame.ZIndex + 1;
			self.ImageLabel.Size = UDim2.new(1, 0, 1, 0);
			self.ImageLabel.BackgroundTransparency = 1;
			self.Image = GameVisualSettings.IconImage;
			return self;
		end;
		Icon._getters = setmetatable({
			Color = function(self)
				return self.ImageLabel.BackgroundColor3;
			end;
		}, { __index = super._getters });
		local __index = Icon.__index;
		Icon.__index = function(self, index)
			local getter = Icon._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		Icon._setters = setmetatable({
			Color = function(self, prop)
				self.ImageLabel.ImageColor3 = prop;
			end;
			Image = function(self, prop)
				self.ImageLabel.Image = prop;
			end;
			ImageTransparency = function(self, prop)
				self.ImageLabel.ImageTransparency = prop;
			end;
		}, { __index = super._setters });
		Icon.__newindex = function(self, index, value)
			local setter = Icon._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Primitive;
		ViewportPanel = {};
		ViewportPanel.__index = setmetatable({
			SetContents = function(self, contents)
				self.ViewportFrame:ClearAllChildren();
				contents.Parent = self.ViewportFrame;
			end;
		}, super);
		ViewportPanel.new = function(...)
			return ViewportPanel.constructor(setmetatable({}, ViewportPanel), ...);
		end;
		ViewportPanel.constructor = function(self)
			Primitive.constructor(self);
			self.ViewportFrame = Instance.new("ViewportFrame", self.MainFrame);
			self.ViewportFrame.ZIndex = self.MainFrame.ZIndex + 1;
			self.ViewportFrame.Size = UDim2.new(1, 0, 1, 0);
			self.ViewportFrame.BackgroundTransparency = 1;
			return self;
		end;
		ViewportPanel._getters = setmetatable({
			Camera = function(self)
				return self.ViewportFrame.CurrentCamera;
			end;
		}, { __index = super._getters });
		local __index = ViewportPanel.__index;
		ViewportPanel.__index = function(self, index)
			local getter = ViewportPanel._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		ViewportPanel._setters = setmetatable({
			Camera = function(self, prop)
				self.ViewportFrame.CurrentCamera = prop;
			end;
		}, { __index = super._setters });
		ViewportPanel.__newindex = function(self, index, value)
			local setter = ViewportPanel._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Primitive;
		Panel = {};
		Panel.__index = setmetatable({
			CheckColorAndLinkIfNecessary = function(self, prop, alt)
				if alt == nil then alt = self.Frame end;
				for _, collectionName in pairs(CollectionService:GetTags(alt)) do
					CollectionService:RemoveTag(alt, collectionName);
				end;
				for collectionName in pairs(PaletteInterfaceRemarks) do
					local visualSettingsIndex = (PaletteInterfaceRemarks)[collectionName];
					local compareColor = (GameVisualSettings)[visualSettingsIndex];
					if compareColor == prop then
						CollectionService:AddTag(alt, collectionName);
						return;
					end;
				end;
			end;
			AddInterfaceComponent = function(self, interfaceComponentIndex, id, ...)
				local args = { ... };
				local fn = (TS.typeof(interfaceComponentIndex) == 'string' and AvailableInterfaceComponents[interfaceComponentIndex] or (interfaceComponentIndex));
				local endInterfaceFunction = fn(self, unpack(args));
				if endInterfaceFunction then
					TS.array_push(self.EndInterfaceComponents, endInterfaceFunction);
				end;
			end;
			RemoveInterfaceComponents = function(self)
				for _, endInterfaceComponent in pairs(self.EndInterfaceComponents) do
					endInterfaceComponent();
				end;
				self.EndInterfaceComponents = {};
			end;
			OnRemove = function(self)
				self:RemoveInterfaceComponents();
			end;
		}, super);
		Panel.new = function(...)
			return Panel.constructor(setmetatable({}, Panel), ...);
		end;
		Panel.constructor = function(self)
			Primitive.constructor(self);
			self.Frame = Instance.new("Frame", self.MainFrame);
			self.Frame.BorderSizePixel = 0;
			self.Frame.Size = UDim2.new(1, 0, 1, 0);
			if TS.instanceof(self, Panel) then
				self.Color = GameVisualSettings.PanelColor;
			end;
			self.MainFrame.AncestryChanged:Connect(function()
				if not self.MainFrame.Parent then
					self:OnRemove();
				end;
			end);
			return self;
		end;
		Panel._getters = setmetatable({
			Color = function(self)
				return self.Frame.BackgroundColor3;
			end;
		}, { __index = super._getters });
		local __index = Panel.__index;
		Panel.__index = function(self, index)
			local getter = Panel._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		Panel._setters = setmetatable({
			TotalPadding = function(self, padding)
				self.Frame.Size = UDim2.new(1, -padding * 2, 1, -padding * 2);
				self.Frame.Position = UDim2.new(0, padding, 0, padding);
			end;
			Transparency = function(self, prop)
				self.Frame.BackgroundTransparency = prop;
			end;
			Color = function(self, prop)
				self.Frame.BackgroundColor3 = prop;
				self:CheckColorAndLinkIfNecessary(prop);
			end;
		}, { __index = super._setters });
		Panel.__newindex = function(self, index, value)
			local setter = Panel._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Panel;
		Area = {};
		Area.__index = setmetatable({}, super);
		Area.new = function(...)
			return Area.constructor(setmetatable({}, Area), ...);
		end;
		Area.constructor = function(self)
			Panel.constructor(self);
			local player = Players.LocalPlayer;
			if player then
				self.Transparency = 1;
				self.Parent = player:WaitForChild('PlayerGui'):WaitForChild('ScreenGui');
			end;
			return self;
		end;
		Area._getters = super._getters;
		local __index = Area.__index;
		Area.__index = function(self, index)
			local getter = Area._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		Area._setters = super._setters;
		Area.__newindex = function(self, index, value)
			local setter = Area._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Panel;
		TexturePanel = {};
		TexturePanel.__index = setmetatable({}, super);
		TexturePanel.new = function(...)
			return TexturePanel.constructor(setmetatable({}, TexturePanel), ...);
		end;
		TexturePanel.constructor = function(self)
			Panel.constructor(self);
			self.ImageLabel = Instance.new("ImageLabel", self.MainFrame);
			self.ImageLabel.ZIndex = self.MainFrame.ZIndex + 1;
			self.ImageLabel.Size = UDim2.new(1, 0, 1, 0);
			self.ImageLabel.BackgroundTransparency = 1;
			self.Frame.Transparency = 1;
			self.NineSlice = true;
			if TS.instanceof(self, TexturePanel) then
				self.Color = GameVisualSettings.TexturePanelColor;
				self.Image = GameVisualSettings.TexturePanelImage;
			end;
			return self;
		end;
		TexturePanel._getters = setmetatable({
			Color = function(self)
				return self.ImageLabel.BackgroundColor3;
			end;
		}, { __index = super._getters });
		local __index = TexturePanel.__index;
		TexturePanel.__index = function(self, index)
			local getter = TexturePanel._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		TexturePanel._setters = setmetatable({
			Image = function(self, prop)
				self.ImageLabel.Image = prop;
			end;
			ImageTransparency = function(self, prop)
				self.ImageLabel.ImageTransparency = prop;
			end;
			Transparency = function(self, prop)
				self.ImageLabel.ImageTransparency = prop;
			end;
			Color = function(self, prop)
				self.ImageLabel.ImageColor3 = prop;
				self:CheckColorAndLinkIfNecessary(prop, self.ImageLabel);
			end;
			NineSlice = function(self, prop)
				if prop then
					self.ImageLabel.ScaleType = Enum.ScaleType.Slice;
					self.ImageLabel.SliceCenter = Rect.new(GameVisualSettings.NineSlice, GameVisualSettings.NineSlice, GameVisualSettings.ImageSize - GameVisualSettings.NineSlice, GameVisualSettings.ImageSize - GameVisualSettings.NineSlice);
				else
					self.ImageLabel.ScaleType = Enum.ScaleType.Crop;
				end;
			end;
		}, { __index = super._setters });
		TexturePanel.__newindex = function(self, index, value)
			local setter = TexturePanel._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = TexturePanel;
		TextureButton = {};
		TextureButton.__index = setmetatable({}, super);
		TextureButton.new = function(...)
			return TextureButton.constructor(setmetatable({}, TextureButton), ...);
		end;
		TextureButton.constructor = function(self)
			TexturePanel.constructor(self);
			self.ImageButton = Instance.new("ImageButton", self.Frame);
			self.ImageButton.ZIndex = self.ImageLabel.ZIndex + 1;
			self.ImageButton.Size = UDim2.new(1, 0, 1, 0);
			self.ImageButton.BackgroundTransparency = 1;
			self.ImageButton.ImageTransparency = 1;
			if TS.instanceof(self, TextureButton) then
				self.Image = GameVisualSettings.TextureButtonImage;
				self.Color = GameVisualSettings.TextureButtonColor;
			end;
			self.Active = true;
			return self;
		end;
		TextureButton._getters = setmetatable({
			MouseClick = function(self)
				return self.ImageButton.MouseButton1Down;
			end;
		}, { __index = super._getters });
		local __index = TextureButton.__index;
		TextureButton.__index = function(self, index)
			local getter = TextureButton._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		TextureButton._setters = setmetatable({
			Active = function(self, prop)
				self.ImageButton.Active = prop;
				self.ImageButton.Selectable = prop;
				if prop then
				else
				end;
			end;
		}, { __index = super._setters });
		TextureButton.__newindex = function(self, index, value)
			local setter = TextureButton._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = TextureButton;
		TypePanel = {};
		TypePanel.__index = setmetatable({
			ConstrainSizeToTextBounds = function(self)
				self.Size = UDim2.new(0, self.TextBounds.X + 20, self.Size.Y.Scale, self.Size.Y.Offset);
			end;
			FollowConstraintSizeToTextBounds = function(self)
				self:ConstrainSizeToTextBounds();
				self.TextLabel:GetPropertyChangedSignal('TextBounds'):Connect(self.ConstrainSizeToTextBounds);
			end;
		}, super);
		TypePanel.new = function(...)
			return TypePanel.constructor(setmetatable({}, TypePanel), ...);
		end;
		TypePanel.constructor = function(self)
			TextureButton.constructor(self);
			self.TextLabel = Instance.new("TextLabel", self.Frame);
			self.TextLabel.ZIndex = self.ImageButton.ZIndex + 1;
			self.TextLabel.Size = UDim2.new(1, 0, 1, 0);
			self.TextLabel.BackgroundTransparency = 1;
			self.TextLabel.TextScaled = GameVisualSettings.LabelFontScaled;
			self.TextColor3 = GameVisualSettings.LabelTextColor;
			if TS.instanceof(self, TypePanel) then
				self.Color = GameVisualSettings.TypePanelColor;
				self.Font = GameVisualSettings.TypePanelFont;
				CollectionService:AddTag(self.TextLabel, 'TypePanelHost');
			end;
			self.Image = GameVisualSettings.TypePanelImage;
			if TS.instanceof(self, TypePanel) then
				self.ImageButton.Size = UDim2.new();
				self.Active = false;
			end;
			return self;
		end;
		TypePanel._getters = setmetatable({
			Text = function(self)
				return self.TextLabel.Text;
			end;
			TextBounds = function(self)
				return self.TextLabel.TextBounds;
			end;
		}, { __index = super._getters });
		local __index = TypePanel.__index;
		TypePanel.__index = function(self, index)
			local getter = TypePanel._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		TypePanel._setters = setmetatable({
			Text = function(self, prop)
				self.TextLabel.Text = tostring(prop);
			end;
			TextColor3 = function(self, prop)
				self.TextLabel.TextColor3 = prop;
			end;
			Font = function(self, prop)
				self.TextLabel.Font = prop;
			end;
		}, { __index = super._setters });
		TypePanel.__newindex = function(self, index, value)
			local setter = TypePanel._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = TypePanel;
		TypeButton = {};
		TypeButton.__index = setmetatable({}, super);
		TypeButton.new = function(...)
			return TypeButton.constructor(setmetatable({}, TypeButton), ...);
		end;
		TypeButton.constructor = function(self)
			TypePanel.constructor(self);
			self.Image = GameVisualSettings.TypeButtonImage;
			if TS.instanceof(self, TypeButton) then
				self.Font = GameVisualSettings.TypeButtonFont;
				CollectionService:AddTag(self.TextLabel, 'TypeButtonHost');
			end;
			self.Color = GameVisualSettings.TypeButtonColor;
			return self;
		end;
		TypeButton._getters = super._getters;
		local __index = TypeButton.__index;
		TypeButton.__index = function(self, index)
			local getter = TypeButton._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		TypeButton._setters = super._setters;
		TypeButton.__newindex = function(self, index, value)
			local setter = TypeButton._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = TexturePanel;
		TypeBox = {};
		TypeBox.__index = setmetatable({
			ConstrainSizeToTextBounds = function(self)
				self.Size = UDim2.new(0, self.TextBounds.X + 20, self.Size.Y.Scale, self.Size.Y.Offset);
			end;
			FollowConstrainSizeToTextBounds = function(self)
				self:ConstrainSizeToTextBounds();
				self.TextBox:GetPropertyChangedSignal('TextBounds'):Connect(self.ConstrainSizeToTextBounds);
			end;
		}, super);
		TypeBox.new = function(...)
			return TypeBox.constructor(setmetatable({}, TypeBox), ...);
		end;
		TypeBox.constructor = function(self)
			TexturePanel.constructor(self);
			self.TextBox = Instance.new("TextBox", self.Frame);
			self.TextBox.ZIndex = self.ImageLabel.ZIndex + 1;
			self.TextBox.Size = UDim2.new(1, 0, 1, 0);
			self.TextBox.BackgroundTransparency = 1;
			self.TextBox.TextScaled = GameVisualSettings.LabelFontScaled;
			self.TextBox.Text = '>>';
			if TS.instanceof(self, TypeBox) then
				self.Color = GameVisualSettings.TypeBoxColor;
				self.Font = GameVisualSettings.TypeBoxFont;
				CollectionService:AddTag(self.TextBox, 'TypeBoxHost');
			end;
			self.TextColor3 = GameVisualSettings.LabelTextColor;
			return self;
		end;
		TypeBox._getters = setmetatable({
			Text = function(self)
				return self.TextBox.Text;
			end;
			TextBounds = function(self)
				return self.TextBox.TextBounds;
			end;
		}, { __index = super._getters });
		local __index = TypeBox.__index;
		TypeBox.__index = function(self, index)
			local getter = TypeBox._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		TypeBox._setters = setmetatable({
			Text = function(self, prop)
				self.TextBox.Text = prop;
			end;
			TextColor3 = function(self, prop)
				self.TextBox.TextColor3 = prop;
			end;
			Font = function(self, prop)
				self.TextBox.Font = prop;
			end;
		}, { __index = super._setters });
		TypeBox.__newindex = function(self, index, value)
			local setter = TypeBox._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Primitive;
		PropertyPanel = {};
		PropertyPanel.__index = setmetatable({}, super);
		PropertyPanel.new = function(...)
			return PropertyPanel.constructor(setmetatable({}, PropertyPanel), ...);
		end;
		PropertyPanel.constructor = function(self, variable)
			Primitive.constructor(self);
			self.BindableEvent = Instance.new("BindableEvent", self.MainFrame);
			local hostValue;
			if TS.isA(variable, "Instance") then
				hostValue = variable;
				(hostValue.Changed):Connect(function()
					if hostValue then
						self.Value = hostValue.Value;
					end;
				end);
				variable = variable.Value;
			end;
			if hostValue then
				self.ValueChanged:Connect(function()
					if hostValue then
						CallRemote('ChangeValue', nil, hostValue, self.Value);
					end;
				end);
			end;
			if TS.typeof(variable) == 'string' then
				local typeBox = C('TypeBox', self);
				self.SetValueFunction = function(prop)
					typeBox.Text = prop;
				end;
				typeBox.TextBox.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						wait();
						self.Value = typeBox.Text;
					end;
				end);
				self.Value = variable;
			elseif TS.typeof(variable) == 'number' then
				local incrementWidth = 20;
				local incrementUp = C('TextureButton', self, {
					Size = UDim2.new(0, incrementWidth, 0.5, 0);
					Color = GameVisualSettings.DynamicColorPalette.Color1;
				});
				local incrementDown = C('TextureButton', self, {
					Size = UDim2.new(0, incrementWidth, 0.5, 0);
					Position = UDim2.new(0, 0, 0.5, 0);
					Color = GameVisualSettings.DynamicColorPalette.Color3;
				});
				local typeBox = C('TypeBox', self, {
					Size = UDim2.new(1, -incrementWidth, 1, 0);
					Position = UDim2.new(0, incrementWidth, 0, 0);
				});
				self.SetValueFunction = function(prop)
					typeBox.Text = prop;
				end;
				typeBox.TextBox.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						wait();
						local num = tonumber(typeBox.Text);
						if num then
							self.Value = num;
						else
							typeBox.Text = self.Value;
						end;
					end;
				end);
				self.Value = variable;
			elseif TS.typeof(variable) == 'boolean' then
				local switchPanel = C('TexturePanel', self, {
					Size = UDim2.new(1, 0, 1, 0);
					Position = UDim2.new(0, 0, 0, 0);
					Color = Color3.fromRGB(0, 0, 0);
				});
				local switchButton = C('TextureButton', switchPanel, {
					Size = UDim2.new(0, 20, 0, 20);
					Position = UDim2.new();
					Color = Color3.fromRGB(255, 255, 255);
				});
				switchButton.NineSlice = false;
				self.SetValueFunction = function(bool)
					switchButton.Position = UDim2.new((bool and 1 or 0), (bool and -20 or 0), 0, 0);
				end;
				switchButton.MouseClick:Connect(function()
					local b = self.Value;
					self.Value = not b;
				end);
				self.Value = variable;
			elseif (TS.typeof(variable) == "Color3") then
				local textureButton = C('TextureButton', self);
				local panel;
				local removePanel = function()
					if panel then
						panel:Destroy();
						panel = nil;
					end;
				end;
				self.SetValueFunction = function(prop)
					textureButton.Color = prop;
				end;
				textureButton.MouseClick:Connect(function()
					if panel and panel.Parent then
						removePanel();
					else
						local player = Players.LocalPlayer;
						propertyMenuArea.Frame.ClearAllChildren();
						local newVariable = self.Value;
						local sizeY, sizeX, posX, posY, hueWidth = 96, textureButton.AbsoluteSize.X, textureButton.AbsolutePosition.X, textureButton.AbsolutePosition.Y, 16;
						panel = C('TexturePanel', propertyMenuArea, {
							Position = UDim2.new(0, posX + sizeX + 5, 0, posY);
							Size = UDim2.new(0, sizeY + hueWidth, 0, sizeY);
						});
						lockElementToFrame(panel.MainFrame);
						local forePanel = C('Panel', panel, {
							TotalPadding = 5;
							Transparency = 1;
						});
						local colorPanel = C('Panel', forePanel, {
							Size = UDim2.new(1, -hueWidth, 1, 0);
						});
						local saturationPanel = C('TextureButton', colorPanel, {
							Image = 'rbxgameasset://saturation_value_gradient';
							Color = Color3.new(1, 1, 1);
							NineSlice = false;
						});
						local huePanel = C('TextureButton', forePanel, {
							Image = 'rbxgameasset://hue_gradient';
							Size = UDim2.new(0, hueWidth, 1, 0);
							Position = UDim2.new(1, -hueWidth, 0, 0);
							Color = Color3.new(1, 1, 1);
							NineSlice = false;
						});
						local barHue = C('Panel', huePanel, {
							Size = UDim2.new(1, 0, 0, 5);
							Color = Color3.fromRGB(0, 0, 0);
						});
						local barHighlight = C('Panel', barHue, {
							Size = UDim2.new(1, 0, 0, 3);
							Position = UDim2.new(0, 0, 0, 1);
							Color = Color3.fromRGB(255, 255, 255);
						});
						local barElse = C('Panel', saturationPanel, {
							Size = UDim2.new(0, 5, 0, 5);
							Color = Color3.fromRGB(0, 0, 0);
						});
						barHighlight = C('Panel', barElse, {
							Size = UDim2.new(0, 3, 0, 3);
							Position = UDim2.new(0, 1, 0, 1);
							Color = Color3.fromRGB(255, 255, 255);
						});
						local startHSV = { Color3.toHSV(newVariable) };
						local h, s, v = startHSV[1], startHSV[2], 1 - startHSV[3];
						local setHSV = function(nH, nS, nV)
							if nH then
								h = nH;
							end;
							if nS then
								s = nS;
							end;
							if nV then
								v = nV;
							end;
							local color = Color3.fromHSV(h, s, 1 - v);
							self.Value = color;
							barHue.Position = UDim2.new(0, 0, h, -2);
							barElse.Position = UDim2.new(s, -2, v, -2);
							colorPanel.Color = Color3.fromHSV(h, 1, 1);
						end;
						setHSV(h, s, v);
						local module = function(object, followHue)
							object.MouseClick:Connect(function()
								local player = Players.LocalPlayer;
								if player then
									local mouse = player:GetMouse();
									local update = function()
										local x, y = mouse.X, mouse.Y;
										local absolutePosition, absoluteSize = object.AbsolutePosition, object.AbsoluteSize;
										local ratioX = math.min(math.max((x - absolutePosition.X) / absoluteSize.X, 0), 1);
										local ratioY = math.min(math.max((y - absolutePosition.Y) / absoluteSize.Y, 0), 1);
										if followHue then
											setHSV(ratioY);
										else
											setHSV(nil, ratioX, ratioY);
										end;
									end;
									local moveConnection = mouse.Move:Connect(update);
									local inputConnection2;
									local _, inputConnection = BindInputs({ Enum.UserInputType.MouseButton1, nil, function()
										moveConnection:Disconnect();
										inputConnection2:Disconnect();
									end });
									if inputConnection then
										inputConnection2 = inputConnection;
									end;
									update();
								end;
							end);
						end;
						module(saturationPanel, false);
						module(huePanel, true);
					end;
				end);
				self.Value = variable;
			elseif variable then
				local tableVariable = variable;
				local typeButton = C('TypeButton', self);
				local panel;
				local removePanel = function()
					if panel then
						panel:Destroy();
						panel = nil;
					end;
				end;
				self.SetValueFunction = function(element)
					local text;
					if CustomCheckTypeOf(element, 'EnumItem') then
						text = EnumString(element);
					else
						text = element;
					end;
					typeButton.Text = text;
					removePanel();
				end;
				typeButton.MouseClick:Connect(function()
					if panel and panel.Parent then
						removePanel();
					else
						local player = Players.LocalPlayer;
						propertyMenuArea.Frame.ClearAllChildren();
						local sizeX, sizeY = typeButton.AbsoluteSize.X, 100;
						local posX, posY = typeButton.AbsolutePosition.X, typeButton.AbsolutePosition.Y;
						panel = C('TexturePanel', propertyMenuArea, {
							Position = UDim2.new(0, posX + sizeX + 5, 0, posY);
							Size = UDim2.new(0, 200, 0, sizeY);
						});
						lockElementToFrame(panel.MainFrame);
						local forePanel = C('Panel', panel, {
							TotalPadding = 5;
							Transparency = 1;
						});
						local container = C('Container', forePanel, {
							Style = 'Grid';
							CellSize = UDim2.new(1, 0, 0, 30);
						});
						for index in pairs(tableVariable) do
							local element = tableVariable[index + 1];
							local button;
							if TS.typeof(element) == 'object' then
								button = C('TextureButton', container, {});
								local myContainer = C('Container', button, {
									Style = 'Grid';
									CellSize = UDim2.new(1 / ObjectArrayLength(element), 0, 1, 0);
								});
								for index in pairs(element) do
									C('TexturePanel', myContainer, {
										Color = element[index];
									});
								end;
							else
								local text;
								if CustomCheckTypeOf(element, 'EnumItem') then
									text = EnumString(element);
								else
									text = element;
								end;
								button = C('TypeButton', container, {
									Text = text;
								});
							end;
							button.MouseClick:Connect(function()
								self.Value = element;
							end);
						end;
					end;
				end);
				self.Value = tableVariable[1];
			end;
			return self;
		end;
		PropertyPanel._getters = setmetatable({
			Value = function(self)
				return self.MyValue;
			end;
			ValueChanged = function(self)
				return self.BindableEvent.Event;
			end;
		}, { __index = super._getters });
		local __index = PropertyPanel.__index;
		PropertyPanel.__index = function(self, index)
			local getter = PropertyPanel._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		PropertyPanel._setters = setmetatable({
			Value = function(self, prop)
				self.MyValue = prop;
				if self.SetValueFunction then
					self.SetValueFunction(prop);
				end;
				self.BindableEvent:Fire();
			end;
		}, { __index = super._setters });
		PropertyPanel.__newindex = function(self, index, value)
			local setter = PropertyPanel._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		local super = Primitive;
		PropertyLabel = {};
		PropertyLabel.__index = setmetatable({}, super);
		PropertyLabel.new = function(...)
			return PropertyLabel.constructor(setmetatable({}, PropertyLabel), ...);
		end;
		PropertyLabel.constructor = function(self, variable, name)
			if name == nil then name = 'Undefined' end;
			Primitive.constructor(self);
			self.Name = name;
			local typeDistance = 0.7;
			self.TypeLabel = C('TypePanel', self, {
				Text = name;
				Size = UDim2.new(typeDistance, 0, 1, 0);
			});
			self.PropertyPanel = C('PropertyPanel', self, {}, variable);
			self.PropertyPanel.Size = UDim2.new(1 - typeDistance, 0, 1, 0);
			self.PropertyPanel.Position = UDim2.new(typeDistance, 0, 0, 0);
			return self;
		end;
		PropertyLabel._getters = super._getters;
		local __index = PropertyLabel.__index;
		PropertyLabel.__index = function(self, index)
			local getter = PropertyLabel._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		PropertyLabel._setters = super._setters;
		PropertyLabel.__newindex = function(self, index, value)
			local setter = PropertyLabel._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	do
		Container = {};
		Container.__index = {
			UpdateNewLayout = function(self)
				self.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					if self.ScrollingFrame.ScrollingDirection == Enum.ScrollingDirection.X then
						local size = self.Layout.AbsoluteContentSize.X;
						self.ScrollingFrame.CanvasSize = UDim2.new(0, size, 0, 0);
					else
						local size = self.Layout.AbsoluteContentSize.Y;
						self.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, size);
					end;
				end);
			end;
			SetGridLayout = function(self)
				self.Layout = Instance.new("UIGridLayout", self.Folder);
				self.Padding = 0;
				self.CellSize = UDim2.new(0, 50, 0, 50);
				self:UpdateNewLayout();
			end;
			SetListLayout = function(self)
				self.Layout = Instance.new("UIListLayout", self.Folder);
				self.Padding = 0;
				self:UpdateNewLayout();
			end;
		};
		Container.new = function(...)
			return Container.constructor(setmetatable({}, Container), ...);
		end;
		Container.constructor = function(self, parent)
			self.ScrollingFrame = Instance.new("ScrollingFrame", parent);
			self.ScrollingFrame.Size = UDim2.new(1, 0, 1, 0);
			self.ScrollingFrame.BackgroundTransparency = 1;
			self.ScrollingFrame.CanvasSize = UDim2.new();
			self.ScrollingFrame.ScrollBarThickness = 5;
			self.ScrollingFrame.ZIndex = 1000;
			self.ScrollingFrame.ScrollBarImageColor3 = GameVisualSettings.ScrollBarColor;
			self.ScrollingFrame.ScrollBarImageTransparency = 0;
			self.Folder = Instance.new("Folder", self.ScrollingFrame);
			self.Style = 'Grid';
			return self;
		end;
		Container._getters = {
			Parent = function(self)
				return self.ScrollingFrame.Parent;
			end;
		};
		local __index = Container.__index;
		Container.__index = function(self, index)
			local getter = Container._getters[index];
			if getter then
				return getter(self);
			else
				return __index[index];
			end;
		end;
		Container._setters = {
			Parent = function(self, parent)
				self.ScrollingFrame.Parent = parent;
			end;
			VAlignment = function(self, prop)
				self.Layout.VerticalAlignment = (prop == 'Top' and Enum.VerticalAlignment.Top or (prop == 'Center' and Enum.VerticalAlignment.Center or Enum.VerticalAlignment.Bottom));
			end;
			HAlignment = function(self, prop)
				self.Layout.HorizontalAlignment = (prop == 'Left' and Enum.HorizontalAlignment.Left or (prop == 'Center' and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Right));
			end;
			SortOrder = function(self, prop)
				self.Layout.SortOrder = prop;
			end;
			FillDirection = function(self, prop)
				self.Layout.FillDirection = prop;
				if prop == Enum.FillDirection.Horizontal then
					self.ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
				else
					self.ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
				end;
			end;
			CellSize = function(self, prop)
				if TS.isA(self.Layout, "UIGridLayout") then
					self.Layout.CellSize = prop;
				else
					warn('Tried setting cellsize of a simple layout');
				end;
			end;
			Padding = function(self, prop)
				if TS.isA(self.Layout, "UIGridLayout") then
					self.Layout.CellPadding = UDim2.new(0, prop, 0, prop);
				else
					self.Layout.Padding = UDim.new((self.Layout.FillDirection == Enum.FillDirection.Horizontal and prop or 0), (self.Layout.FillDirection == Enum.FillDirection.Vertical and prop or 0));
				end;
			end;
			Style = function(self, prop)
				if self.Layout then
					self.Layout:Destroy();
				end;
				if prop == 'Grid' then
					self:SetGridLayout();
				else
					self:SetListLayout();
				end;
				self.VAlignment = 'Center';
				self.HAlignment = 'Center';
			end;
		};
		Container.__newindex = function(self, index, value)
			local setter = Container._setters[index];
			if setter then
				setter(self, value);
			else
				rawset(self, index, value);
			end;
		end;
	end;
	_3.Primitive = Primitive;
	_3.Icon = Icon;
	_3.ViewportPanel = ViewportPanel;
	_3.Panel = Panel;
	_3.Area = Area;
	_3.TexturePanel = TexturePanel;
	_3.TextureButton = TextureButton;
	_3.TypePanel = TypePanel;
	_3.TypeButton = TypeButton;
	_3.TypeBox = TypeBox;
	_3.PropertyPanel = PropertyPanel;
	_3.PropertyLabel = PropertyLabel;
	_3.Container = Container;
end;
C = function(className, parent, properties, ...)
	local args = { ... };
	local newClass = (UserInterfaceTypes)[className].new(unpack(args));
	if parent then
		local nParent;
		if CustomCheckTypeOf(nParent, 'Userdata') then
			nParent = parent;
		else
			if (parent)['Frame'] then
				nParent = (parent)['Frame'];
			elseif (parent)['MainFrame'] then
				nParent = (parent)['MainFrame'];
			elseif (parent)['Folder'] then
				nParent = (parent)['Folder'];
			end;
		end;
		if nParent then
			newClass.Parent = nParent;
		else
			warn('No nParent');
		end;
	end;
	if properties then
		if (properties)['Style'] then
			newClass['Style'] = (properties)['Style'];
		end;
		for key in pairs(properties) do
			if key ~= 'Style' then
				newClass[key] = properties[key];
			end;
		end;
	end;
	return newClass;
end;
local lockElementToFrame = function(element)
	local parent = element.Parent;
	local parentAbsolutePosition, parentAbsoluteSize = parent.AbsolutePosition, parent.AbsoluteSize;
	local myAbsolutePosition, myAbsoluteSize = element.AbsolutePosition, element.AbsoluteSize;
	local yDifference = myAbsolutePosition.Y + myAbsoluteSize.Y - (parentAbsolutePosition.Y + parentAbsoluteSize.Y);
	if yDifference > -15 then
		local position = element.Position;
		element.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset - yDifference - 15);
	end;
end;
AvailableInterfaceComponents = {
	TextCenterUnderline = function(object)
		if TS.instanceof(object, UserInterfaceTypes.TypePanel) or TS.instanceof(object, UserInterfaceTypes.TypeButton) then
			local underline = Instance.new("Frame", object.Frame);
			underline.BorderSizePixel = 0;
			underline.ZIndex = object.TextLabel.ZIndex - 1;
			underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			underline.BackgroundTransparency = 0.8;
			local updateFrame = function()
				local textBoundsX = math.min(object.Frame.AbsoluteSize.X - 10, object.TextBounds.X + 10);
				local height = object.TextBounds.Y;
				underline.Size = UDim2.new(0, textBoundsX, 0, height);
				underline.Position = UDim2.new(0.5, -textBoundsX / 2, 0.5, -height / 2);
			end;
			local connection = object.TextLabel:GetPropertyChangedSignal('TextBounds'):Connect(updateFrame);
			local connection2 = object.TextLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateFrame);
			local connection3 = object.TextLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateFrame);
			updateFrame();
			return function()
				underline:Destroy();
				connection:Disconnect();
				connection2:Disconnect();
				connection3:Disconnect();
			end;
		end;
	end;
	ButtonReaction_Default = function(object)
		if TS.instanceof(object, UserInterfaceTypes.TextureButton) then
			local remainColor;
			object.ImageButton.MouseEnter:Connect(function()
				local currentColor = object.Color;
				local factor = 0.8;
				object.Color = Color3.new(currentColor.r * factor, currentColor.g * factor, currentColor.b * factor);
				remainColor = object.Color;
			end);
			local endFunction = function()
				if remainColor and remainColor == object.Color then
					object.ImageLabel.ImageColor3 = object.Color;
				end;
				remainColor = nil;
			end;
			object.ImageButton.MouseLeave:Connect(endFunction);
			return endFunction;
		end;
	end;
	ButtonReaction_Slider = function(object)
		if TS.instanceof(object, UserInterfaceTypes.TextureButton) then
			local slider = Instance.new("Frame", object.Frame);
			slider.ZIndex = object.ImageButton.ZIndex + 1;
			slider.BorderSizePixel = 0;
			local defaultColor = Color3.fromRGB(20, 20, 20);
			local flashColor = Color3.fromRGB(255, 255, 255);
			slider.BackgroundColor3 = defaultColor;
			slider.Size = UDim2.new(0, 10, 1, 0);
			object.ImageButton.MouseEnter:Connect(function()
				TweenService:Create(slider, TweenInfo.new(0.2), {
					Size = UDim2.new(0, 50, 1, 0);
					BackgroundColor3 = flashColor;
				}):Play();
				wait(0.2);
				TweenService:Create(slider, TweenInfo.new(0.4), {
					BackgroundColor3 = defaultColor;
				}):Play();
			end);
			local endFunction = function()
				TweenService:Create(slider, TweenInfo.new(0.1), {
					Size = UDim2.new(0, 10, 1, 0);
					BackgroundColor3 = defaultColor;
				}):Play();
			end;
			object.ImageButton.MouseLeave:Connect(endFunction);
			return endFunction;
		end;
	end;
	ButtonReaction_TextTip = function(object, tip)
		if TS.instanceof(object, UserInterfaceTypes.TextureButton) then
			local leftOver;
			object.ImageButton.MouseEnter:Connect(function()
				leftOver = C('TypePanel', texttipContainer, {
					Text = tip;
					Size = UDim2.new(1, 0, 0, 20);
					Color = GameVisualSettings.TextTipBackgroundColor;
					TextColor3 = GameVisualSettings.TextTipTextColor;
				});
				leftOver:ConstrainSizeToTextBounds();
			end);
			local endFunction = function()
				if leftOver then
					leftOver:Destroy();
					leftOver = nil;
				end;
			end;
			object.ImageButton.MouseLeave:Connect(endFunction);
			return endFunction;
		end;
	end;
};
propertyMenuArea = C('Area', nil, {
	Name = 'PropertyMenuArea';
	ZIndex = 100;
});
local area = C('Area', nil, {
	Name = 'ClientUserInterface';
	ZIndex = 100;
});
local mousePrimitive = C('Primitive', area, {});
local TextTipPrimitive = C('Primitive', mousePrimitive, {
	Position = UDim2.new(0, 5, 0, 25);
});
texttipContainer = C('Container', TextTipPrimitive, {
	Style = 'List';
	VAlignment = 'Top';
	HAlignment = 'Left';
});
local player = game.Players.LocalPlayer;
local mouse = player:GetMouse();
mouse.Move:Connect(function()
	mousePrimitive.Position = UDim2.new(0, mouse.X, 0, mouse.Y);
end);
_exports.GameVisualSettings = GameVisualSettings;
_exports.UserInterfaceTypes = UserInterfaceTypes;
_exports.C = C;
return _exports;
