AwardOrangeItem = {}
AwardOrangeItem.szKey = 'nOrangeItem'

AwardOrangeItem.MagicIds_Cfg = {
  [KsgItem.NON] = 1001,
  [KsgItem.DAILUNG] = 1101,
  [KsgItem.GIAY] = 1201,
  [KsgItem.PHIPHONG] = 1301,
  [KsgItem.AO] = 1401,
}

--- Give orange items
--- @param tbItem table: Award list settings
--- @param szLogTitle string: Log title
--- @param nAwardCount number: Number of awards
--- Example of usage:
--- local tbItem = {
---   nOrangeItem = KsgItem.NON, nLevel = 10, nFactionId = KsgPlayer.GIAP_SI
--- }
--- KsgAward:Give(tbItem)
---
function AwardOrangeItem:Give(tbItem, szLogTitle, nAwardCount)
  local nAmount = (nAwardCount or 1) * (tbItem.nAmount or 1)
  local nLevel = tbItem.nLevel or 9
  local nItemType = tbItem.nOrangeItem
  local nRandom = tbItem.nRandom or 0
  local nRandomFaction = tbItem.nRandomFaction or 0
  local tbRandom = tbItem.tbRandom
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
  local nMagicId = self.MagicIds_Cfg[nItemType] + nFactionId

  local nItemId
  local nOkCount = 0
  local szName = tbItem.szName or ""

  for _ = 1, nAmount do
    nItemId = AddNormalItem3(0, nItemType, nFactionId, nLevel, 0, 1, nMagicId)
    szName = tbItem.szName or GetItemName(nItemId)
    if nItemId > 0 then
      nOkCount = nOkCount + 1
    end
  end

  if nItemId and szName ~= "" then
    KsgPlayer:Msg(string.format("NhËn ®­îc %d %s.", nAmount, szName))
  end
  local szExtraInfo = string.format("[%s] (%d, %d, %d, %d - %d) Added success = %d, failed = %d.", szName, 0, nItemType, nFactionId, nLevel, nMagicId, nOkCount, nAmount - nOkCount)

  self:WriteLog(szExtraInfo, szLogTitle)
end

function AwardOrangeItem:WriteLog(szExtraInfo, szLogTitle)
  if szLogTitle then
    local szName = self.szKey or ""
    WriteLog(szLogTitle .. "\t" .. szName .. "\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t".. szExtraInfo, "KsgAward")
  end
end

return AwardOrangeItem
