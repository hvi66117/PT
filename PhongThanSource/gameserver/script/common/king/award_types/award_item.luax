AwardItem = {}
AwardItem.szKey = 'tbProp'

AwardItem.tbStackableItem_Genres = {
  1, 3, 5, 6
}

--- Give items
--- @param tbItem table
--- @param szLogTitle string
--- @param nAwardCount number
--- Example of usage:
--- local tbItem = {
---   tbProp = {8, 159, 3, 0}, nBind = 1, nAmount = 1 -- Di Ngo¹i phï siªu cÊp
--- }
--- KsgAward:Give(tbItem)
---
function AwardItem:Give(tbItem, szLogTitle, nAwardCount)
  local nAmount = (nAwardCount or 1) * (tbItem.nAmount or 1)
  local bStackable
  local nG = tbItem.tbProp[1]
  local nD = tbItem.tbProp[2]
  local nP = tbItem.tbProp[3]
  local nLevel = tbItem.tbProp[4]
  local nBind = tbItem.nBind or 0
  local nSeries = tbItem.nSeries or 0
  local nLuck = tbItem.nLuck or 0
  local nQuality = tbItem.nQuality or 0
  local nItemId
  local nOkCount = 0
  local szName = tbItem.szName
  if KsgTable:Contains(self.tbStackableItem_Genres, nG) then
    bStackable = 1
  end
  local fn = AddNormalItem
  if bStackable then
    fn = AddNormalItemPile
  end
  for _ = 1, nAmount do
    nItemId = fn(nG, nD, nP, nLevel, nSeries, nLuck)
    szName = szName or GetItemName(nItemId)
    if nItemId > 0 then
      nOkCount = nOkCount + 1
      SetItemBind(nItemId, nBind)
    end
  end
  local szMsgGlobal
  if szName and szName ~= "" then
    local szMsg = string.format("NhËn ®­îc %d %s", nAmount, szName)
    KsgPlayer:Msg(szMsg)
    ScrollMessage(szMsg)
    if nQuality == 1 then
      szMsgGlobal = string.format("%s vËn may béc ph¸t, nhËn ®­îc %d %s!!!", GetName(), nAmount, szName)
    end
    if type(nQuality) == 'string' then
      szMsgGlobal = string.format(nQuality, GetName(), nAmount, szName)
    end
    if szMsgGlobal and szMsgGlobal ~= "" then
      AddGlobalNews(szMsgGlobal)
      Msg2SubWorld(szMsgGlobal)
    end
  end

  local szExtraInfo = string.format("[%s] (%d, %d, %d, %d) Added success = %d, failed = %d.", szName or "", nG, nD, nP, nLevel, nOkCount, nAmount - nOkCount)

  self:WriteLog(szExtraInfo, szLogTitle)
end

function AwardItem:WriteLog(szExtraInfo, szLogTitle)
  if szLogTitle then
    local szName = self.szKey or ""
    WriteLog(szLogTitle .. "\t" .. szName .. "\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t" .. szExtraInfo, "KsgAward")
  end
end

return AwardItem
