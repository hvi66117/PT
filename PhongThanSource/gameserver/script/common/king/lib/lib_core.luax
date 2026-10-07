--- @class KsgLib
KsgLib = KsgLib or {}

--- Get the number from a range
--- @param nPosition number
--- @param nStart number
--- @param nEnd number
--- @return number|nil
function KsgLib:GetValueFromRange(nPosition, nStart, nEnd)
  if nStart > nEnd then
    return nil
  end
  local nIndex = 0
  for i = nStart, nEnd do
    nIndex = nIndex + 1
    if nIndex == nPosition then
      return i
    end
  end

  return nil
end

--- Check if the number is within a range
--- @param nValue number Number to check
--- @param nStart number
--- @param nEnd number
--- @return boolean
function KsgLib:IsInRange(nValue, nStart, nEnd)
  return nValue >= nStart and nValue <= nEnd
end

--- Trim spaces from the string
--- @param szString string
--- @return string
function KsgLib:Trim(szString)
  local szStart, szLast = string.find(szString, "%S+.*%S+")
  if (szStart == nil or szLast == nil) then
    return szString
  end

  return string.sub(szString, szStart, szLast)
end

function KsgLib:Split(szString, szSeparator)
  szSeparator = szSeparator or ","
  local strArray = {}
  local nStartIndex = 1
  local nSeparatorLen = string.len(szSeparator)
  local nIndex = string.find(szString, szSeparator, nStartIndex)
  if not nIndex then
    strArray[1] = szString
    return strArray
  end
  local i = 1
  while nIndex do
    strArray[i] = string.sub(szString, nStartIndex, nIndex - 1)
    i = i + 1
    nStartIndex = nIndex + nSeparatorLen
    nIndex = string.find(szString, szSeparator, nStartIndex)
  end

  strArray[i] = string.sub(szString, nStartIndex, string.len(szString))

  return strArray
end

function KsgLib:IsRate(nPercent)
  local nRateTotal = 10000000
  local nRandom = math.random(1, nRateTotal)
  local nRate = math.floor(nPercent * nRateTotal / 100)

  return nRandom <= nRate
end

function KsgLib:Exp2String(nExp, szLabel)
  szLabel = szLabel or " kinh nghiÖm"
  if nExp >= 1e6 and nExp < 1e9 then
    return string.format("%d.%d triÖu ®iÓm %s", math.floor(nExp / 1e6), math.fmod(nExp, 1e6), szLabel)
  end
  if nExp >= 1e9 then
    local nBillion = math.floor(nExp / 1e9)
    local nMillion = math.fmod(nExp, 1e9)
    if nMillion > 0 then
      return string.format("%d tû %d.%d triÖu ®iÓm %s", nBillion, math.floor(nMillion / 1e6), math.fmod(nMillion, 1e6), szLabel)
    end

    return string.format("%d tû ®iÓm %s", nBillion, szLabel)
  end

  return string.format("%d ®iÓm %s", nExp, szLabel)
end

function KsgLib:CheckMaterial(tbRequirements, szMsgHead, szMsgFooter, bNotTalk, bDesc)
  local bPassed = true
  local nItemCount = 0
  local szJoinString = ", "
  local szMessage = szMsgHead or "Anh hïng ch­a ®¹t ®iÒu kiÖn yªu cÇu: <enter>"
  local nIndex = 0
  for szConditionName, mCondition in pairs(tbRequirements) do
    nIndex = nIndex + 1
    if nIndex == 1 then
      szJoinString = ""
    else
      szJoinString = ", "
    end

    if type(mCondition) == "number" then
      if szConditionName == 'nMoney' then
        local szColor = "green"
        if KsgPlayer:GetMoney() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>%d v¹n l­îng b¹c<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nCostCoinIdx' then
        local szColor = "green"
        local _, Cv, Cfs = GetCostCoinInfoByIdx(mCondition)
        if KsgPlayer:GetCoin(true) < Cv then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>%s Th«ng B¶o<color>", szJoinString, szColor, Cfs)
      end

      if szConditionName == 'nBindCoin' then
        local szColor = "green"
        if KsgPlayer:GetBindCoin() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>%d Linh B¶o<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == "nCopperCash" then
        local szColor = "green"
        if KsgPlayer:GetCopperCash() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>%d tiÒn ®ång<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nLevel' then
        local szColor = "green"
        if KsgPlayer:GetLevel() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>®¹t cÊp %d<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nLevelEx' then
        local szColor = "green"
        if KsgPlayer:GetLevelEx() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>®¹t cÊp %d Tiªn Ma<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nRepute' then
        local szColor = "green"
        if KsgPlayer:GetRepute() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>danh väng ®¹t %d ®iÓm<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nReputeTienMa' then
        local szColor = "green"
        if KsgPlayer:GetReputeTienMa() < mCondition then
          bPassed = false
          szColor = "red"
        end
        if bDesc then
          szColor = "yellow"
        end
        szMessage = szMessage .. string.format("%s<color=%s>danh väng Tiªn Ma ®¹t %d ®iÓm<color>", szJoinString, szColor, mCondition)
      end
    end

    if type(mCondition) == "table" and szConditionName == 'tbItems' then
      for _, tbItem in pairs(mCondition) do
        if tbItem.tbProp and type(tbItem.tbProp) == "table" then
          local szColor = "green"
          local szName = tbItem.szName
          if KsgItem:Count(tbItem.tbProp) < tbItem.nAmount then
            bPassed = false
            szColor = "red"
          end
          if bDesc then
            szColor = "yellow"
          end
          local szItemDescText = "CÇn "
          nItemCount = nItemCount + 1
          if nItemCount > 1 then
            szItemDescText = ", "
          end
          szMessage = szMessage .. string.format("%s<color=%s>%s%d %s<color>", szJoinString, szColor, szItemDescText, tbItem.nAmount, szName)
        end
      end
    end
  end
  if bDesc then
    return szMessage
  end
  if not bPassed then
    if not bNotTalk then
      szMsgFooter = szMsgFooter or "Xin anh hïng h·y chuÈn bÞ ®Çy ®ñ!"
      KsgNpc:Talk(szMessage .. string.format("<enter>§iÒu kiÖn <color=green>mµu xanh<color> lµ ®· ®¹t, <color=red>mµu ®á<color> lµ ch­a ®¹t.<enter>%s", szMsgFooter))
    end
  end

  return bPassed
end

function KsgLib:MaterialDescription(tbRequirements, szMsgHead, szMsgFooter)
  return KsgLib:CheckMaterial(tbRequirements, szMsgHead, szMsgFooter, 1, 1)
end

function KsgLib:PayMaterial(tbRequirements, szMsgHead, szMsgFooter, bNotTalk)
  if not KsgLib:CheckMaterial(tbRequirements, szMsgHead, szMsgFooter, bNotTalk) then
    return false
  end
  local nPassedCondition = 0
  for szConditionName, mCondition in pairs(tbRequirements) do

    if type(mCondition) == "number" then
      if szConditionName == "nMoney" then
        KsgPlayer:PayMoney(mCondition)
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nCostCoinIdx" then
        CostCoinByIdx(mCondition)
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nBindCoin" then
        KsgPlayer:PayBindCoin(mCondition)
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nCopperCash" then
        KsgPlayer:PayCopperCash(mCondition)
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nLevel" and KsgPlayer:GetLevel() >= mCondition then
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nLevelEx" and KsgPlayer:GetLevelEx() >= mCondition then
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nRepute" and KsgPlayer:GetRepute() >= mCondition then
        nPassedCondition = nPassedCondition + 1
      end

      if szConditionName == "nReputeTienMa" and KsgPlayer:GetReputeTienMa() >= mCondition then
        nPassedCondition = nPassedCondition + 1
      end
    end

    if type(mCondition) == "table" and szConditionName == 'tbItems' then
      local nSubPass = 0
      for _, tbItem in pairs(mCondition) do
        if tbItem.tbProp and type(tbItem.tbProp) == "table" then
          if KsgItem:Delete(tbItem.tbProp, tbItem.nAmount) > 0 then
            nSubPass = nSubPass + 1
          end
        end
      end
      if nSubPass == KsgTable:Count(mCondition) then
        nPassedCondition = nPassedCondition + 1
      end
    end
  end

  return nPassedCondition == KsgTable:Count(tbRequirements)
end

---
--- Get a list of all players in the team
--- @return table Player list
---
function KsgLib:GetAllTeamMembers()
  local tbTeamMembers = {}
  local nTeamSize = GetTeamSize()
  for i = 1, nTeamSize do
    table.insert(tbTeamMembers, GetTeamMember(i))
  end
  return tbTeamMembers
end

---
--- Send a message to a team
--- @param szMsg any
--- @param nType number MSG, TALK, SAY
---
function KsgLib:Msg2Team(szMsg, nType)
  szMsg = tostring(szMsg)
  local nTeamSize = GetTeamSize()
  if GetTeam() == 0 then
    KsgPlayer:Msg(szMsg, nType)
    return 0
  end
  local nOldPlayerIdx = PlayerIndex
  for i = 1, nTeamSize do
    PlayerIndex = GetTeamMember(i)
    KsgPlayer:Msg(szMsg, nType)
  end
  PlayerIndex = nOldPlayerIdx
end

--- Execute function on on all players in the team
--- @param func function: Function to execute
function KsgLib:TeamOperate(func, ...)
  local tbPlayers = self:GetAllTeamMembers()
  local nSize = #tbPlayers
  if nSize < 1 then
    return func(unpack(arg))
  end
  local nOldPlayerIdx = PlayerIndex
  for i = 1, nSize do
    PlayerIndex = tbPlayers[i]
    func(unpack(arg))
  end
  PlayerIndex = nOldPlayerIdx
end

--- Execute function on all players in the list
--- @param tbPlayers table: Player list
--- @param func function: Function to execute
function KsgLib:OperatePlayers(tbPlayers, func, ...)
  local nPlayerCount = #tbPlayers
  local OldPlayerIndex = PlayerIndex
  if nPlayerCount > 0 then
    for i = 1, nPlayerCount do
      PlayerIndex = tbPlayers[i]
      if PlayerIndex > 0 then
        func(unpack(arg))
      end
    end
  end
  PlayerIndex = OldPlayerIndex
end

--- Get position value
--- @param nSource number
--- @param nStart number
--- @param nEnd number
function KsgLib:GetPosValue(nSource, nStart, nEnd)
  return math.floor(math.fmod(nSource, 10 ^ (nEnd)) / (10 ^ (nStart - 1)))
end

--- Set position value
--- @param nSource number
--- @param nSetValue number
--- @param nStart number
--- @param nEnd number
function KsgLib:SetPosValue(nSource, nSetValue, nStart, nEnd)
  local nHead = math.floor(nSource / (10 ^ nEnd)) * (10 ^ nEnd)
  local nTail = math.fmod(nSource, 10 ^ (nStart - 1))
  local nBody = nSetValue * (10 ^ (nStart - 1))
  return (nHead + nBody + nTail)
end

--- Callback
--- @param tbCallback table
function KsgLib:Callback(tbCallback)
  local varFunc = tbCallback[1]
  local szType = type(varFunc)
  if szType == "function" then
    pcall(varFunc, unpack(tbCallback, 2))
  end
end

--- Get random faction id
--- @return number Faction id
function KsgLib:RandomFactionId()
  ---@diagnostic disable-next-line: return-type-mismatch
  return KsgTable:Random({ KsgPlayer.GIAP_SI, KsgPlayer.DAO_SI, KsgPlayer.DI_NHAN })
end

--- Get random item parts
--- @return number Item part id
function KsgLib:RandomItemPart()
  ---@diagnostic disable-next-line: return-type-mismatch
  return KsgTable:Random({ KsgItem.AO, KsgItem.GIAY, KsgItem.DAILUNG, KsgItem.NON, KsgItem.PHIPHONG })
end

return KsgLib
