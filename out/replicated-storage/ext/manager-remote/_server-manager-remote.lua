local TS = require(game:GetService("ReplicatedStorage").RobloxTS.Include.RuntimeLib);
local _exports;
local ReplicatedStorage = require(TS.getModule("rbx-services", script.Parent).out).ReplicatedStorage;
local eventFolder = Instance.new("Folder", ReplicatedStorage);
eventFolder.Name = 'Events';
_exports = true;
return _exports;
