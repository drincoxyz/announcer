-- https://github.com/drincoxyz/announcer

-- serverside component
if !SERVER then return end
-- reload disabled
if istable(announcer) then return end

module("announcer", package.seeall)

util.AddNetworkString "announcer_broadcast"

-- broadcasts an announcement
function Broadcast(line, ...)
	local pl = {...}
	-- players already given as table
	if istable(pl[1]) then pl = pl[1] end
	-- compress line as LMZA string
	local comp = util.Compress(tostring(line))
	local len  = comp:len()
	-- write line
	net.Start "announcer_broadcast"
	net.WriteData(comp, len)
	-- send announcement
	if #pl > 0 then
		net.Send(pl)
	else
		net.Broadcast()
	end
end
