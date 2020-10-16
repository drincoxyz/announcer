-- https://github.com/drincoxyz/announcer

-- clientside component
if !CLIENT then return end
-- reload disabled
if istable(announcer) then return end

module("announcer", package.seeall)

-- registered announcers
local announcers = {}
-- announcer lookup
local annolookup = {}
-- selected announcer
local selannouncer = nil

-- announcement received
net.Receive("announcer_broadcast", function(len)
	-- line is LZMA compressed
	-- TODO: line doesn't need to be compressed, but this
	--       is easier to do - should probably be changed
	--       eventually though
	local comp = net.ReadData(len)
	local data = util.Decompress(comp)
	data = tonumber(data) || tostring(data)
	-- announcer doesn't exist
	local announcer = announcers[annolookup[selannouncer]]
	if !istable(announcer) then return end
	-- line doesn't exist
	local line = announcer.lines[data]
	if line == nil then return end
	-- play announcement
	-- TODO: the local player probably shouldn't be
	--       emitting the sound, but there's not really
	--       another option that supports sound scripts
	local snd = language.GetPhrase(line)
	LocalPlayer():EmitSound(snd, 0)
end)

-- adds/updates an announcer
-- the first announcer added is selected by default
function Add(id, lines)
	-- add/update announcer
	local announcer = announcers[annolookup[id]]
	if istable(announcer) then
		-- update announcer
		announcer.lines = table.Merge(announcer.lines, lines)
	else
		-- add announcer
		annolookup[id] = table.insert(announcers, {
			id    = id,
			lines = lines,
		})
		-- select first announcer by default
		if !selannouncer then Select(id) end
	end
end

-- selects an announcer
function Select(id)
	-- announcer doesn't exist
	local announcer = announcers[annolookup[id]]
	if !istable(announcer) then return false end
	-- announcer already selected
	if selannouncer == id then return false end
	-- select announcer
	selannouncer = id
	return true
end
