local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local ReplicatedStorage, Workspace, ServerStorage = _0.ReplicatedStorage, _0.Workspace, _0.ServerStorage;
local BuildOrder = TS.import("ReplicatedStorage", "build-order").BuildOrder;
local serverDirectory = Workspace:FindFirstChild('ServerStorage');
if serverDirectory then
	for _, object in pairs(serverDirectory:GetChildren()) do
		object.Parent = ServerStorage;
	end;
end;
local replicatedDirectory = Workspace:FindFirstChild('ReplicatedStorage');
if replicatedDirectory then
	for _, object in pairs(replicatedDirectory:GetChildren()) do
		object.Parent = ReplicatedStorage;
	end;
end;
if Workspace:FindFirstChild('Bin') then
	Workspace.Bin:Destroy();
end;
warn('Loading Game');
local extensions = ReplicatedStorage.ext;
TS.array_forEach(BuildOrder, function(name)
	local directory = extensions:FindFirstChild(name);
	if directory then
		warn('Loading directory |', directory.Name);
		TS.array_forEach(directory:GetChildren(), function(v)
			if TS.isA(v, "ModuleScript") then
				if string.find(v.Name, '_server') then
					warn('req :: ', v.Name);
					require(v);
				end;
			end;
		end);
	else
		warn('Failed to load directory | ', name);
	end;
end);
