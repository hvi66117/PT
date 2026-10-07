AwardDoPho = {}
AwardDoPho.szKey = 'nDoPho'

AwardDoPho.tbCfg = {
  [1] = { -- Ph¸ qu©n
    [KsgItem.NON] = 278,
    [KsgItem.DAILUNG] = 281,
    [KsgItem.GIAY] = 284,
    [KsgItem.PHIPHONG] = 287,
    [KsgItem.AO] = 290,
  },
  [2] = { -- Ph¸ qu©n LiÖt
    [KsgItem.NON] = 910,
    [KsgItem.DAILUNG] = 913,
    [KsgItem.GIAY] = 916,
    [KsgItem.PHIPHONG] = 919,
    [KsgItem.AO] = 922,
  },
  [3] = { -- Ph¸ qu©n Th¸nh
    [KsgItem.NON] = 925,
    [KsgItem.DAILUNG] = 928,
    [KsgItem.GIAY] = 931,
    [KsgItem.PHIPHONG] = 934,
    [KsgItem.AO] = 937,
  },
}

function AwardDoPho:Give(tbItem, szLogTitle, nAwardCount)
  local nAmount = (nAwardCount or 1) * (tbItem.nAmount or 1)
  local nBind = tbItem.nBind or 0
  local nItemType = tbItem.nDoPho
  local nRandom = tbItem.nRandom or 0
  local nRandomFaction = tbItem.nRandomFaction or 0
  local tbRandom = tbItem.tbRandom
  local nLevel = tbItem.nLevel or 1
  if nRandom == 1 then
    nItemType = KsgLib:RandomItemPart()
    if type(tbRandom) == "table" then
      nItemType = KsgTable:Random(tbRandom)
    end
  end
  local nFactionId = tbItem.nFactionId or KsgPlayer:GetFactionId()
  if nRandomFaction == 1 then
    nFactionId = KsgLib:RandomFactionId()
  end
  local nItemParticular = self.tbCfg[nLevel][nItemType]
  nItemParticular = nItemParticular + nFactionId

  local nItemId
  local nOkCount = 0
  local szName = tbItem.szName or ""
  for _ = 1, nAmount do
    nItemId = AddNormalItemBind(6, 1, nItemParticular, 0, 0, 0, nBind)
    szName = tbItem.szName or GetItemName(nItemId)
    if nItemId > 0 then
      nOkCount = nOkCount + 1
    end
  end

  if nItemId and szName ~= "" then
    KsgPlayer:Msg(string.format("NhËn ®­îc %d %s.", nAmount, szName))
  end
  local szExtraInfo = string.format("[%s] Added success = %d, failed = %d.", szName, nOkCount, nAmount - nOkCount)

  self:WriteLog(szExtraInfo, szLogTitle)
end

function AwardDoPho:WriteLog(szExtraInfo, szLogTitle)
  if szLogTitle then
    local szName = self.szKey or ""
    WriteLog(szLogTitle .. "\t" .. szName .. "\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t".. szExtraInfo, "KsgAward")
  end
end

return AwardDoPho
