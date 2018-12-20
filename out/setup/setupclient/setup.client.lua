local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local ReplicatedStorage = require(TS.getModule("rbx-services", script.Parent).out).ReplicatedStorage;
local BuildOrder = TS.import("ReplicatedStorage", "build-order").BuildOrder;
wait(0.5);
warn('Loading Client Game');
local extensions = ReplicatedStorage.ext;
local src;
src = function(v)
	if v:IsA('Folder') then
		TS.array_forEach(v:GetChildren(), src);
	end;
	if v:IsA('ModuleScript') then
		if string.find(v.Name, '_client') then
			warn('require :: ', v.Name);
			require(v);
		end;
	end;
end;
TS.array_forEach(BuildOrder, function(name)
	local directory = extensions:FindFirstChild(name);
	if directory then
		warn('Loading client directory |', directory.Name);
		src(directory);
	else
		warn('Failed to load directory | ', name);
	end;
end);
