KsgItem = KsgItem or {}

KsgItem.MAX_STACK = 200
KsgItem.COPPER_CASH_MAX_STACK = 200

KsgItem.AO = 2
KsgItem.GIAY = 5
KsgItem.DAILUNG = 6
KsgItem.NON = 7
KsgItem.PHIPHONG = 9

function KsgItem:Count(...)
  local nArgSize = #arg
  if nArgSize == 1 then
    local tbItem = arg[1]
    if type(tbItem) == "table" then
      local nG, nD, nP, nLevel = unpack(tbItem)
      return HaveNormalItem(nG, nD, nP, nLevel)
    end
  end
  if nArgSize == 4 then
    local nG, nD, nP, nLevel = unpack(arg)
    return HaveNormalItem(nG, nD, nP, nLevel)
  end
  return 0
end

function KsgItem:Delete(...)
  local nArgSize = #arg
  local nDeleted = 0
  local nAmount
  local nG, nD, nP, nLevel
  if nArgSize == 2 then
    local tbItem = arg[1]
    nAmount = arg[2]
    if type(tbItem) == "table" and type(nAmount) == "number" then
      nG, nD, nP, nLevel = unpack(tbItem)
    end
  elseif nArgSize == 5 then
    nG, nD, nP, nLevel, nAmount = unpack(arg)
  end
  if nG and type(nAmount) == "number" then
    for _ = 1, nAmount do
      local nResult = DelNormalItem(nG, nD, nP, nLevel)
      if nResult == 1 then
        nDeleted = nDeleted + 1
      end
    end
  end
  return nDeleted
end

function KsgItem:DeleteAll(...)
  local nArgSize = #arg
  if nArgSize == 1 then
    local tbItem = arg[1]
    if type(tbItem) == "table" then
      local nG, nD, nP, nLevel = unpack(tbItem)
      return ClearItem(nG, nD, nP, nLevel) == 1
    end
  end
  if nArgSize == 4 then
    return ClearItem(unpack(arg)) == 1
  end

  return nil
end

--- Pack item G, D, P to Id
--- @param nG number: Item genre
--- @param nD number: Item detail
--- @param nP number: Item particular
function KsgItem:PackItemId(nG, nD, nP)
  return nG * 1e8 + nD * 1e5 + nP
end

--- Unpack item Id to G, D, P
--- @param nId number: Item Id
function KsgItem:UnPackItemId(nId)
  local nG = math.floor(nId / 1e8)
  nId = math.mod(nId, 1e8)
  local nD = math.floor(nId / 1e5)
  nId = math.mod(nId, 1e5)
  local nP = math.floor(nId)

  return nG, nD, nP
end

--- Drop items to the ground when NPC deaths
--- @param nNpcIdx number: Npc Index
--- @param tbProp table: Item props
--- @param nPlayerIdx number: Player index, default is the current player
--- @return boolean
function KsgItem:Drop(nNpcIdx, tbProp, nPlayerIdx)
  nPlayerIdx = nPlayerIdx or PlayerIndex
  if type(tbProp) == "table" and #tbProp >= 4 then
    for i = 5, 6 do
      if not tbProp[i] then
        tbProp[i] = 0
      end
    end
    return ThrowItem(nNpcIdx, nPlayerIdx, unpack(tbProp))
  end
  return 0
end

return KsgItem
