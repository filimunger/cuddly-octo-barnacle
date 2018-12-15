local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local BindInputs;
local UserInputService = require(TS.getModule("rbx-services", script.Parent).out).UserInputService;
local _0 = TS.import(script.Parent, "input-codes");
local T_InputNames, InputCodes = _0.T_InputNames, _0.InputCodes;
BindInputs = function(...)
	local a = { ... };
	local search;
	search = function(bool, input)
		TS.array_forEach(a, function(t)
			if (bool and not t[2]) or (not bool and not t[3]) then
				return;
			end;
			if input.KeyCode == t[1] or input.UserInputType == t[1] then
				local fn = t[(bool and 1 or 2) + 1];
				if fn then
					fn();
				end;
			end;
			if TS.typeof(t[1]) == 'string' then
				local supposedKey = InputCodes[t[1]];
				if input.KeyCode == supposedKey or input.UserInputType == supposedKey then
					local fn = t[(bool and 1 or 2) + 1];
					if fn then
						fn();
					end;
				end;
			end;
		end);
	end;
	local foundFirstFunction, foundSecondFunction = false, false;
	for _, set in pairs(a) do
		if set[2] then
			foundFirstFunction = true;
		end;
		if set[3] then
			foundSecondFunction = true;
		end;
		if foundFirstFunction and foundSecondFunction then
			break;
		end;
	end;
	local connection1, connection2;
	if foundFirstFunction then
		connection1 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed then
				search(true, input);
			end;
		end);
	end;
	if foundSecondFunction then
		connection2 = UserInputService.InputEnded:Connect(function(input)
			search(false, input);
		end);
	end;
	return connection1, connection2;
end;
BindInputs({ 'Ability1', function()
end });
_exports.BindInputs = BindInputs;
return _exports;
