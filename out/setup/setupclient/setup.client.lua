local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local ReplicatedStorage = require(TS.getModule("rbx-services", script.Parent).out).ReplicatedStorage;
local BuildOrder = TS.import("ReplicatedStorage", "build-order").BuildOrder;
wait(2);
warn('Loading Client Game');
local extensions = ReplicatedStorage.ext;
TS.array_forEach(BuildOrder, function(name)
	local directory = extensions:FindFirstChild(name);
	if directory then
		warn('Loading client directory |', directory.Name);
		TS.array_forEach(directory:GetChildren(), function(v)
			if TS.isA(v, "ModuleScript") then
				if string.find(v.Name, '_client') then
					warn('req :: ', v.Name);
					require(v);
				end;
			end;
		end);
	else
		warn('Failed to load client directory | ', name);
	end;
end);
