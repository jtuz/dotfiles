-- vim: ts=4 sw=4 noet ai cindent syntax=lua

--[[
Conky, a system monitor, based on torsmo
]]

conky.config = {
    out_to_x = false,
    out_to_console = true,
    short_units = true,
    update_interval = 1
}

home = os.getenv("HOME")
dofile(home .. '/.config/i3/conky/04.modular/' .. 'jsonhelper.lua')
dofile(home .. '/.config/i3/conky/04.modular/' .. 'jsonparts.lua')

--[[
-- if you care about performance, comment-out this variable.
disabled = ''
--  .. parts.cputemp .. ',' 
--  .. parts.download .. ','
--  .. parts.upload .. ','
    .. parts.mpd .. ','
    .. parts.mem .. ','
    .. parts.uptime .. ','
    .. parts.host .. ','
    .. parts.volume .. ','
    .. parts.machine
]]

enabled = ''
    .. parts.edownload .. ','
    .. parts.eupload .. ','
    .. parts.memory .. ','
    .. parts.cpu0 .. ','
	.. parts.mpd .. ','
    .. parts.volume .. ','
    .. parts.battery
  
conky.text = [[ 
[ 
]] .. enabled .. [[,
]] .. parts.date .. [[, 
]] .. parts.time .. [[ 
],
]]





