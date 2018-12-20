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
local src;
src = function(v)
	if v:IsA('Folder') then
		TS.array_forEach(v:GetChildren(), src);
	end;
	if v:IsA('ModuleScript') then
		if string.find(v.Name, '_server') then
			warn('require :: ', v.Name);
			require(v);
		end;
	end;
end;
warn('Loading Game');
local extensions = ReplicatedStorage.ext;
TS.array_forEach(BuildOrder, function(name)
	local directory = extensions:FindFirstChild(name);
	if directory then
		warn('Loading server directory |', directory.Name);
		src(directory);
	else
		warn('Failed to load directory | ', name);
	end;
end);
