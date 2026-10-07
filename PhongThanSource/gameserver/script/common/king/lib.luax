-- KSG Headers
require("king/define/define.luax")

-- for talk
function _no()
  CloseDialog()
end

function today(bFull)
  local nYear, nMonth, nDay = GetYMD()
  local nH, nM, nS = GetHMS()
  if bFull then
    return tonumber(string.format("%d%02d%02d%02d%02d%02d", nYear, nMonth, nDay, nH, nM, nS))
  end
  return tonumber(string.format("%d%02d%02d", nYear, nMonth, nDay))
end


--- Pack the function's parameter into a table
function pack(...)
  return arg
end

require("king/lib/lib_core.luax")
require("king/lib/lib_event.luax")
require("king/lib/lib_debug.luax")
require("king/lib/lib_table.luax")
require("king/lib/lib_datetime.luax")
require("king/lib/lib_player.luax")
require("king/lib/lib_item.luax")
require("king/lib/lib_npc.luax")
require("king/lib/lib_task.luax")
require("king/lib/lib_award.luax")
require("king/lib/lib_server.luax")
