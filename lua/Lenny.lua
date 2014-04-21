--[[
Lennys Scripts by Lenny. (STEAM_0:0:30422103)
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/.
Credit to the author must be given when using/sharing this work or derivative work from it.
]]

--[[
Right here is the new "smart" loading for Lenny's scripts. This ensures that everything is as up to date
as it can be, without having any drawbacks. (other than githubs response times)

DEVELOPERS
Do not load using this file if you want to make any changes to the scripts
load from lennyOffline instead

Here's how it works in a few easy steps: 

- We ask github for the files we should load
	~ if successful, we load them
		- we also save them do the data folder (not included yet)
	- elseif unsuccessful we try to load a previously saved version from the data folder
	- elseif that's unsuccessful too, we just load from the lua folder as we did previously

ProTip: 
Start at last line to understand this
]]	

Lenny = {} -- ohoh global table.... watch out!!!!!

local function ReloadLennys()
	include("Lenny.lua")
end
concommand.Add("lenny_reload", ReloadLennys)

local function onFileRetrieved(content)
	RunString(content)
	--TODO save shit to txt
end

local function getFilesFromCloud(files)
	for k, v in pairs(files) do
		--I would get the files from the github API, but we are unauthenticated and thus limited to 60 api calls per hour (would just be enough to load the scripts twice at the time of writing - also a pain for debugging this)
		--So I hate it but we need to get files from raw github
		v.url = string.Replace(v.url, "https://github", "https://raw.githubusercontent")
		v.url = string.Replace(v.url, "blob/", "")

		http.Fetch(v.url, onFileRetrieved, onFailedToRetrieve)
	end
end

local function cleanFileTabl(fileList)
	local files = {}
	for k, v in pairs(fileList) do
		files[k] = {name = name, url = v.html_url, shaHash = v.sha}
	end
	getFilesFromCloud(files)
end

local function onFailedToRetrieve(error)
	MsgC(Color(255, 0, 0), "\nLenny's scripts:\n\t"..error)
	MsgC(Color(0, 255, 255), "\n\nTrying to reload from locally stored version...")

	include("lennyOffline.lua")
end

local function onFileListRetrieved(contents)
	local fileList = util.JSONToTable(contents)

	if !fileList then --checking if we actually got a filelist and not an error message
		onFailedToRetrieve("failed to convert filelist to json")
	elseif fileList.message then
		onFailedToRetrieve("couldn't find script folder in cloud: "..fileList.message)
	else
		cleanFileTabl(fileList)
	end
end

http.Fetch("https://api.github.com/repos/LennyPenny/Lennys/contents/lua/Lenny", onFileListRetrieved, onFailedToRetrieve)

MsgC(Color(0,255,255), "\nAll of Lennys scripts initialized!\n\n")