local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports = {};
local BindFunctionToRemote, EngageRemoteObject, CallRemote;
local _0 = require(TS.getModule("rbx-services", script.Parent).out);
local ReplicatedStorage, RunService, Players = _0.ReplicatedStorage, _0.RunService, _0.Players;
local T_ManagedRemotes = TS.import(script.Parent, "remote-hub").T_ManagedRemotes;
BindFunctionToRemote = function(remoteName, remoteFunction)
	local a = ReplicatedStorage.Events:FindFirstChild(remoteName);
	if a then
		local isServer = RunService:IsServer();
		if TS.isA(a, "RemoteEvent") then
			return (isServer and a.OnServerEvent:Connect(remoteFunction) or a.OnClientEvent:Connect(remoteFunction));
		elseif TS.isA(a, "RemoteFunction") then
			if isServer then
				a.OnServerInvoke = remoteFunction;
			else
				a.OnClientInvoke = remoteFunction;
			end;
			return (isServer and 'OnServerInvoke' or 'OnClientInvoke');
		end;
	else
		warn('Failed to bind function to remote |', remoteName);
	end;
end;
EngageRemoteObject = function(object)
	local events = ReplicatedStorage:WaitForChild('Events');
	for index in pairs(object) do
		local fn = object[index];
		local remote = Instance.new("RemoteEvent", events);
		remote.Name = index;
		BindFunctionToRemote(index, fn);
	end;
end;
CallRemote = function(remoteName, ...)
	local args = { ... };
	local newArgs = {};
	for index in pairs(args) do
		TS.array_push(newArgs, args[index]);
	end;
	local a = ReplicatedStorage.Events:FindFirstChild(remoteName);
	if a then
		local isServer = RunService:IsServer();
		if TS.isA(a, "RemoteEvent") then
			if isServer then
				a:FireAllClients(unpack(newArgs));
			else
				a:FireServer(unpack(newArgs));
			end;
		elseif TS.isA(a, "RemoteFunction") then
			if isServer then
				local players = Players:GetPlayers();
				for _, player in pairs(players) do
					a:InvokeClient(player, unpack(newArgs));
				end;
			else
				return a:InvokeServer(unpack(newArgs));
			end;
		end;
	else
		warn('Could not locate remote |', remoteName);
	end;
end;
_exports.BindFunctionToRemote = BindFunctionToRemote;
_exports.EngageRemoteObject = EngageRemoteObject;
_exports.CallRemote = CallRemote;
return _exports;
