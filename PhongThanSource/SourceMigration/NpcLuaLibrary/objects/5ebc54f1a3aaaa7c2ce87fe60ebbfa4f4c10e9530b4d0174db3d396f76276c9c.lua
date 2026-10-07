-- KSG Headers
Include("\\script\\gvn\\define\\define.lua")

-- Lua 4 pairs
pairs = pairs or function(t)
  return t
end

ipairs = ipairs or function(t)
  for i, _ in t do
    if i == "n" then
      t[i] = nil
    end
  end
  return t
end

-- for talk
function _no()
  CloseDialog()
end

function today(bFull)
  local nYear, nMonth, nDay = GetYMD()
  local nH, nM, nS = GetHMS()
  if bFull then
    return tonumber(format("%d%02d%02d%02d%02d%02d", nYear, nMonth, nDay, nH, nM, nS))
  end
  return tonumber(format("%d%02d%02d", nYear, nMonth, nDay))
end

--- Unpack table's values to variables
--- @param T table Table to unpack
--- @param nStartIdx number Start index
--- @param nEndIdx number End index
function unpack(T, nStartIdx, nEndIdx)
  local nSize = getn(T)
  nStartIdx = nStartIdx or 1
  nEndIdx = nEndIdx or nSize
  if T[nStartIdx] and nStartIdx <= nEndIdx then
    return T[nStartIdx], unpack(T, nStartIdx + 1, nEndIdx)
  end
end

--- Pack the function's parameter into a table
function pack(...)
  return arg
end

Include("\\script\\gvn\\libs\\lib_core.lua")
Include("\\script\\gvn\\libs\\lib_event.lua")
Include("\\script\\gvn\\libs\\lib_debug.lua")
Include("\\script\\gvn\\libs\\lib_table.lua")
Include("\\script\\gvn\\libs\\lib_datetime.lua")
Include("\\script\\gvn\\libs\\lib_player.lua")
Include("\\script\\gvn\\libs\\lib_item.lua")
Include("\\script\\gvn\\libs\\lib_npc.lua")
Include("\\script\\gvn\\libs\\lib_task.lua")
Include("\\script\\gvn\\libs\\lib_award.lua")
Include("\\script\\gvn\\libs\\lib_server.lua")
