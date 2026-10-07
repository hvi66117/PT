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
  if nValue >= nStart and nValue <= nEnd then
    return 1
  end

  return nil
end

--- Trim spaces from the string
--- @param szString string
--- @return string
function KsgLib:Trim(szString)
  local szStart, szLast = strfind(szString, "%S+.*%S+")
  if (szStart == nil or szLast == nil) then
    return szString
  end

  return strsub(szString, szStart, szLast)
end

function KsgLib:Split(szString, szSeparator)
  szSeparator = szSeparator or ","
  local strArray = {}
  local nStartIndex = 1
  local nSeparatorLen = strlen(szSeparator)
  local nIndex = strfind(szString, szSeparator, nStartIndex)
  if not nIndex then
    strArray[1] = szString
    return strArray
  end
  local i = 1
  while nIndex do
    strArray[i] = strsub(szString, nStartIndex, nIndex - 1)
    i = i + 1
    nStartIndex = nIndex + nSeparatorLen
    nIndex = strfind(szString, szSeparator, nStartIndex)
  end

  strArray[i] = strsub(szString, nStartIndex, strlen(szString))

  return strArray
end

function KsgLib:IsRate(nPercent)
  local nRateTotal = 10000000
  local nRandom = random(1, nRateTotal)
  local nRate = floor(nPercent * nRateTotal / 100)
  if nRandom <= nRate then
    return 1
  end

  return nil
end

function KsgLib:IsRateNew(nPercent)
  local nRateTotal = 10000
  local nRandom = random(1, nRateTotal)
  local nRate = floor(nPercent * nRateTotal / 100)
  if nRandom <= nRate then
    return 1
  end

  return nil
end

function KsgLib:Exp2String(nExp, szLabel)
  szLabel = szLabel or "kinh nghiÖm"
  if nExp >= 1e6 and nExp < 1e9 then
    return format("%d.%d triÖu ®iÓm %s", floor(nExp / 1e6), mod(nExp, 1e6), szLabel)
  end
  if nExp >= 1e9 then
    local nBillion = floor(nExp / 1e9)
    local nMillion = mod(nExp, 1e9)
    if nMillion > 0 then
      return format("%d tû %d.%d triÖu ®iÓm %s", nBillion, floor(nMillion / 1e6), mod(nMillion, 1e6), szLabel)
    end

    return format("%d tû ®iÓm %s", nBillion, szLabel)
  end

  return format("%d ®iÓm %s", nExp, szLabel)
end

function KsgLib:CheckMaterial(tbRequirements, szMsgHead, szMsgFooter, bNotTalk, bDesc)
  local nPass = 1
  local nItemCount = 0
  local szJoinString = ", "
  local szMessage = szMsgHead or "C¸c h¹ ch­a ®¹t ®iÒu kiÖn yªu cÇu: <enter>"
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
          nPass = 0
          szColor = "red"
        end
        szMessage = szMessage .. format("%s<color=%s>%d v¹n l­îng b¹c<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == "nCopperCash" then
        local szColor = "green"
        if KsgPlayer:GetCopperCash() < mCondition then
          nPass = 0
          szColor = "red"
        end
        szMessage = szMessage .. format("%s<color=%s>%d tiÒn ®ång<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nLevel' then
        local szColor = "green"
        if KsgPlayer:GetLevel() < mCondition then
          nPass = 0
          szColor = "red"
        end
        szMessage = szMessage .. format("%s<color=%s>®¹t cÊp %d<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nLevelEx' then
        local szColor = "green"
        if KsgPlayer:GetLevelEx() < mCondition then
          nPass = 0
          szColor = "red"
        end
        szMessage = szMessage .. format("%s<color=%s>®¹t cÊp %d Tiªn Ma<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nRepute' then
        local szColor = "green"
        if KsgPlayer:GetRepute() < mCondition then
          nPass = 0
          szColor = "red"
        end
        szMessage = szMessage .. format("%s<color=%s>danh väng ®¹t %d ®iÓm<color>", szJoinString, szColor, mCondition)
      end

      if szConditionName == 'nReputeTienMa' then
        local szColor = "green"
        if KsgPlayer:GetReputeTienMa() < mCondition then
          nPass = 0
          szColor = "red"
        end
        szMessage = szMessage .. format("%s<color=%s>danh väng Tiªn Ma ®¹t %d ®iÓm<color>", szJoinString, szColor, mCondition)
      end
    end

    if type(mCondition) == "table" and szConditionName == 'tbItems' then
      for _, tbItem in pairs(mCondition) do
        if tbItem.tbProp and type(tbItem.tbProp) == "table" then
          local szColor = "green"
          local szName = tbItem.szName
          if KsgItem:Count(tbItem.tbProp) < tbItem.nAmount then
            nPass = 0
            szColor = "red"
          end
          local szItemDescText = "®em theo "
          nItemCount = nItemCount + 1
          if nItemCount > 1 then
            szItemDescText = ", "
          end
          szMessage = szMessage .. format("%s<color=%s>%s%d %s<color>", szJoinString, szColor, szItemDescText, tbItem.nAmount, szName)
        end
      end
    end
  end
  if bDesc then
    return szMessage
  end
  if nPass == 0 then
    if not bNotTalk then
      szMsgFooter = szMsgFooter or "Xin c¸c h¹ h·y chuÈn bÞ ®Çy ®ñ!"
      KsgNpc:Talk(szMessage .. format("<enter>§iÒu kiÖn <color=green>mµu xanh<color> lµ ®· ®¹t, <color=red>mµu ®á<color> lµ ch­a ®¹t.<enter>%s", szMsgFooter))
    end
  end

  return nPass == 1
end

function KsgLib:MaterialDescription(tbRequirements, szMsgHead, szMsgFooter)
  return KsgLib:CheckMaterial(tbRequirements, szMsgHead, szMsgFooter, 1, 1)
end

function KsgLib:PayMaterial(tbRequirements, bNotTalk)
  if not KsgLib:CheckMaterial(tbRequirements, nil, nil, bNotTalk) then
    return nil
  end
  local nPassedCondition = 0
  for szConditionName, mCondition in tbRequirements do

    if type(mCondition) == "number" then
      if szConditionName == "nMoney" then
        KsgPlayer:PayMoney(mCondition)
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
      for _, tbItem in mCondition do
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
    tinsert(tbTeamMembers, GetTeamMember(i))
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
  local nSize = getn(tbPlayers)
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

function KsgLib:TeamOperateWithLevelReq(func, ...)
  local mapid, x, y = GetWorldPos()
  local tbPlayers = self:GetAllTeamMembers()
  local nSize = getn(tbPlayers)
  if nSize < 1 then
    if GetLevel() >= 50 then
      return func(unpack(arg))
    end
  end
  local nOldPlayerIdx = PlayerIndex
  for i = 1, nSize do
    PlayerIndex = tbPlayers[i]
    if GetLevel() >= 50 then
      func(unpack(arg))
    end
  end
  PlayerIndex = nOldPlayerIdx
end

function KsgLib:TeamOperateVanTienTranTho()
  -- TÝnh n¨ng ChuyÓn Sinh 1 & 2 - BaoNLT created - 20121127
  local nMapID, _nX, _nY = GetWorldPos();
  --local nServerID = LoadIniInteger("ServerID_2010", "ID")
  if (nMapID >= 79 and nMapID <= 82 ) then
    local nLucky = random(1, 100)
    if (nLucky <= 1) then
      if (GetTeam() ~= 0) then
        -- L­u l¹i index hiÖn t¹i cña nh©n vËt
        local OldPlayer = PlayerIndex;

        -- DuyÖt tõng thµnh viªn trong ®éi
        for nIndex = 1, GetTeamSize() do
          PlayerIndex = GetTeamMember(nIndex);
          AddNormalItemPile(3, 1200, 0, 0, 0, 0);
          --WriteVNGFeatureLog(48, "ChuyÓn Sinh", "Gift", "§¸nh boss V¹n Tiªn TrËn", "", "Cöu ChuyÓn Tiªn §an", "", 1, "", 1)
          ScrollMessage("NhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");
          Msg2Player("<ChuyÓn Sinh> B¹n nhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");

        end;
        -- LÊy l¹i index cho nh©n vËt
        PlayerIndex = OldPlayer;
      else
        AddNormalItemPile(3, 1200, 0, 0, 0, 0);
        --WriteVNGFeatureLog(48, "ChuyÓn Sinh", "Gift", "§¸nh boss V¹n Tiªn TrËn", "", "Cöu ChuyÓn Tiªn §an", "", 1, "", 1)
        ScrollMessage("NhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");
        Msg2Player("<ChuyÓn Sinh> B¹n nhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");

      end;
    end;
  end
end

--- Execute function on all players in the list
--- @param tbPlayers table: Player list
--- @param func function: Function to execute
function KsgLib:OperatePlayers(tbPlayers, func, ...)
  local nPlayerCount = getn(tbPlayers)
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
  return floor(mod(nSource, 10 ^ (nEnd)) / (10 ^ (nStart - 1)))
end

--- Set position value
--- @param nSource number
--- @param nSetValue number
--- @param nStart number
--- @param nEnd number
function KsgLib:SetPosValue(nSource, nSetValue, nStart, nEnd)
  local nHead = floor(nSource / (10 ^ nEnd)) * (10 ^ nEnd)
  local nTail = mod(nSource, 10 ^ (nStart - 1))
  local nBody = nSetValue * (10 ^ (nStart - 1))
  return (nHead + nBody + nTail)
end

--- Callback
--- @param tbCallback table
function KsgLib:Callback(tbCallback)
  local varFunc = tbCallback[1]
  local szType = type(varFunc)
  if szType == "function" then
    call(varFunc, pack(unpack(tbCallback, 2)))
  end
end

--- Get random faction id
--- @return number Faction id
function KsgLib:RandomFactionId()
  return KsgTable:Random({ KsgPlayer.GIAP_SI, KsgPlayer.DAO_SI, KsgPlayer.DI_NHAN })
end

--- Get random item parts
--- @return number Item part id
function KsgLib:RandomItemPart()
  return KsgTable:Random({ KsgItem.AO, KsgItem.GIAY, KsgItem.DAILUNG, KsgItem.NON, KsgItem.PHIPHONG })
end
