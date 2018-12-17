local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local ReplicatedStorage = require(TS.getModule("rbx-services", script.Parent).out).ReplicatedStorage;
local ConvertVariable;
ConvertVariable = function(variable, parent)
	local t = TS.typeof(variable);
	local v;
	if t == 'string' then
		v = Instance.new("StringValue", parent);
	elseif t == 'boolean' then
		v = Instance.new("BoolValue", parent);
	elseif t == 'number' then
		v = Instance.new("NumberValue", parent);
	elseif TS.isA(variable, "Instance") then
		v = Instance.new("ObjectValue", parent);
	elseif (TS.typeof(variable) == "Color3") then
		v = Instance.new("Color3Value", parent);
	elseif (TS.typeof(variable) == "Vector3") then
		v = Instance.new("Vector3Value", parent);
	else
		if TS.typeof(variable) == 'object' then
			return ConvertVariable(variable[1], parent);
		else
			warn('Couldnt assign variable value |', variable);
			return Instance.new("BoolValue");
		end;
	end;
	v.Value = variable;
	return v;
end;
local VariableValue = function(variable, parent, name)
	local v = ConvertVariable(variable, parent);
	v.Name = (name and name or 'VariableValue');
	return v;
end;
local CreateCompoundedValue = function(variable, parent, name)
	local baseValue = VariableValue(variable, parent, name);
	local reAssign = function()
		local factor;
		if TS.typeof(variable) == 'number' then
			factor = variable;
			for _, child in pairs(baseValue:GetChildren()) do
				if child.Name == 'Multiply' then
					factor = factor * (child).Value;
				end;
			end;
			for _, child in pairs(baseValue:GetChildren()) do
				if child.Name == 'Add' then
					factor = factor + (child).Value;
				end;
			end;
		else
			factor = variable;
			for _, child in pairs(baseValue:GetChildren()) do
				if child.Name == 'Set' then
					factor = (child).Value;
				end;
			end;
		end;
		baseValue.Value = factor;
	end;
	baseValue.ChildAdded.Connect(reAssign);
	return baseValue;
end;
local ModifyCompoundedValue = function(value, modifyString)
	local firstCharacter = string.sub(modifyString, 1, 1);
	local factor = tonumber(string.gsub(modifyString, firstCharacter, ''));
	local myValue = Instance.new("NumberValue", value);
	myValue.Value = (factor and factor or 1);
	myValue.Name = (firstCharacter == '+' and 'Add' or (firstCharacter == '*' and 'Multiply' or 'Set'));
	return myValue;
end;
local CustomCheckTypeOf = function(element, string)
	return TS.typeof(element) == (string);
end;
local ScaleModel = function(model, scaling)
	local scaleCFrame = function(frame)
		local a, b, c, c0, c1, c2, c3, c4, c5, c6, c7, c8 = frame:components();
		return (CFrame.new((frame.p * scaling)) * CFrame.new(0, 0, 0, c0, c1, c2, c3, c4, c5, c6, c7, c8));
	end;
	for _, instance in pairs(model:GetDescendants()) do
		if instance:IsA('BasePart') then
			local frame = instance.CFrame;
			instance.Size = (instance.Size * scaling);
			instance.CFrame = scaleCFrame(frame);
		elseif instance:IsA('Attachment') then
			instance.Position = (instance.Position * scaling);
		elseif instance:IsA('Motor6D') then
			instance.Transform = scaleCFrame(instance.Transform);
		elseif instance:IsA('ParticleEmitter') then
			local nKeyPoints = instance.Size.Keypoints;
			local keyPoints = {};
			do
				local index = 0;
				while index < #nKeyPoints do
					local element = nKeyPoints[index + 1];
					keyPoints[index + 1] = NumberSequenceKeypoint.new(element.Time, element.Value * scaling, element.Envelope * scaling);
					index = index + 1;
				end;
			end;
			instance.Size = NumberSequence.new(keyPoints);
			instance.Speed = NumberRange.new(instance.Speed.Min * scaling, instance.Speed.Max * scaling);
		end;
	end;
end;
local DeepCopy = function(object)
	local clone = {};
	local search;
	search = function(directory, pair)
		for index in pairs(directory) do
			local element = directory[index];
			if TS.typeof(element) == 'object' then
				if not pair[index] then
					pair[index] = {};
				end;
				search(element, pair[index]);
			else
				pair[index] = element;
			end;
		end;
	end;
	search(object, clone);
	return clone;
end;
local ObjectArrayLength = function(object)
	local count = 0;
	for index in pairs(object) do
		count = count + 1;
	end;
	return count;
end;
local PackData = function(data)
	local search;
	search = function(directory)
		for index in pairs(directory) do
			local element = directory[index];
			if (TS.typeof(element) == "Color3") then
				directory[index] = { '%Color', element.r, element.g, element.b };
			elseif (TS.typeof(element) == "Vector3") then
				directory[index] = { '%Vector', element.X, element.Y, element.Z };
			elseif TS.typeof(element) == 'object' then
				search(element);
			end;
		end;
	end;
	search(data);
	return data;
end;
local UnpackData = function(data)
	local search;
	search = function(directory)
		for index in pairs(directory) do
			local element = directory[index];
			if TS.typeof(element) == 'object' then
				local newElement = element;
				if newElement[1] == '%Color' then
					directory[index] = Color3.new(newElement[2], newElement[3], newElement[4]);
				elseif newElement[1] == '%Vector' then
					directory[index] = Vector3.new(newElement[2], newElement[3], newElement[4]);
				else
					search(newElement);
				end;
			end;
		end;
	end;
	search(data);
end;
local BringElementToFront = function(array, element)
	local index = TS.array_indexOf(array, element);
	if index > -1 then
		local old = array[1];
		array[1] = array[index + 1];
		array[index + 1] = old;
	end;
	return array;
end;
local ConvertObjectToArray = function(object)
	local array = {};
	for index in pairs(object) do
		TS.array_push(array, (object)[index]);
	end;
	return array;
end;
local MaterialList = function(str)
	local t = { 'Plastic', 'Wood', 'Slate', 'Concrete', 'CorrodedMetal', 'DiamondPlate', 'Foil', 'Grass', 'Ice', 'Marble', 'Granite', 'Brick', 'Pebble', 'Sand', 'Fabric', 'SmoothPlastic', 'Metal', 'WoodPlanks', 'Cobblestone' };
	if str then
		BringElementToFront(t, str);
	end;
	return t;
end;
local EnumString = function(e)
	local str = tostring(e);
	do
		local i = #str;
		while i > 0 do
			if string.sub(str, i, i) == '.' then
				return string.sub(str, i + 1, #str);
			end;
			i = i - 1;
		end;
	end;
	warn('Failed to enum string');
	return '';
end;
local Round = function(number, value)
	if not value or value == 1 then
		return math.floor(number + 0.5);
	else
		return math.floor(number / value + 0.5) * value;
	end;
end;
local AlignVectorToGrid = function(vector, value, ignoreY)
	return Vector3.new(Round(vector.X, value), (ignoreY and vector.Y or Round(vector.Y, value)), Round(vector.Z, value));
end;
local RecursiveSearchInstance;
RecursiveSearchInstance = function(search, name)
	if search.Name == name then
		return search;
	end;
	for _, child in pairs(search:GetChildren()) do
		local found = RecursiveSearchInstance(child, name);
		if found then
			return found;
		end;
	end;
end;
local CreateNewEffect = function(effectName, parent)
	local effects = ReplicatedStorage:WaitForChild('Effects');
	local search = RecursiveSearchInstance(effects, effectName);
	if search then
		local clone = (search):Clone();
		clone.Parent = parent;
		return clone;
	end;
end;
local CreateClass = function(cs, properties)
	local newClass = cs.new();
	if properties then
		for index in pairs(properties) do
			newClass[index] = properties[index];
		end;
	end;
	return newClass;
end;
local SimpleVector = function(vect)
	return Vector3.new(vect.X, 0, vect.Z);
end;
local SimpleMagnitude = function(vect0, vect1)
	return (SimpleVector(vect0) - SimpleVector(vect1)).Magnitude;
end;
local GetModelCFrame = function(model)
	return CFrame.new(((model)):GetModelCFrame().p);
end;
local AddPrimaryPart = function(model)
	local primaryPart = Instance.new("Part");
	primaryPart.Name = 'PrimaryPart';
	primaryPart.Anchored = true;
	primaryPart.Transparency = 1;
	primaryPart.Size = Vector3.new();
	primaryPart.CFrame = GetModelCFrame(model);
	primaryPart.Parent = model;
	model.PrimaryPart = primaryPart;
	return primaryPart;
end;
local WeldModel = function(model, weldTo)
	if not weldTo then
		if model.PrimaryPart then
			weldTo = model.PrimaryPart;
		else
			warn('No primary for weld');
			return;
		end;
	end;
	for _, instance in pairs(model:GetChildren()) do
		if instance:IsA('BasePart') then
			instance.Anchored = false;
			if instance ~= weldTo then
				local weld = Instance.new("WeldConstraint", weldTo);
				weld.Part0 = weldTo;
				weld.Part1 = instance;
			end;
		end;
	end;
end;
_exports.VariableValue = VariableValue;
_exports.CreateCompoundedValue = CreateCompoundedValue;
_exports.ModifyCompoundedValue = ModifyCompoundedValue;
_exports.CustomCheckTypeOf = CustomCheckTypeOf;
_exports.ScaleModel = ScaleModel;
_exports.DeepCopy = DeepCopy;
_exports.ObjectArrayLength = ObjectArrayLength;
_exports.PackData = PackData;
_exports.UnpackData = UnpackData;
_exports.BringElementToFront = BringElementToFront;
_exports.ConvertObjectToArray = ConvertObjectToArray;
_exports.MaterialList = MaterialList;
_exports.EnumString = EnumString;
_exports.Round = Round;
_exports.AlignVectorToGrid = AlignVectorToGrid;
_exports.RecursiveSearchInstance = RecursiveSearchInstance;
_exports.CreateNewEffect = CreateNewEffect;
_exports.CreateClass = CreateClass;
_exports.SimpleVector = SimpleVector;
_exports.SimpleMagnitude = SimpleMagnitude;
_exports.GetModelCFrame = GetModelCFrame;
_exports.AddPrimaryPart = AddPrimaryPart;
_exports.WeldModel = WeldModel;
return _exports;
