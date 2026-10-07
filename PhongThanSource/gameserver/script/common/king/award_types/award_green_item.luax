AwardGreenItem = {}
AwardGreenItem.szKey = 'nGreenItem'

AwardGreenItem.tbTienMaCfg = {
  [1] = { nParticularId = 15, tbQuestItemParticulars = { 27, 33 } }, -- HuyÒn Khung - Minh Quang - Thiªn Léc
  [2] = { nParticularId = 21, tbQuestItemParticulars = { 30, 36 } } -- Thanh DiÖu - H­ Nghi, Loan Vò
}

--- Give green items
--- @param tbItem table
--- @param szLogTitle string
--- @param nAwardCount number
--- Example of usage
--- local tbItem = {
---   nGreenItem = KsgItem.NON, nBind = 1, nLevel = 2, nTienMa = 1, nQuest = 1, nFactionId = KsgPlayer.GIAP_SI
--- }
--- KsgAward:Give(tbItem)
---
function AwardGreenItem:Give(tbItem, szLogTitle, nAwardCount)
  local nAmount = (nAwardCount or 1) * (tbItem.nAmount or 1)
  local nLevel = tbItem.nLevel or 1
  local nTienMa = tbItem.nTienMa or 0
  local nBind = tbItem.nBind or 0
  local nQuest = tbItem.nQuest or 0
  local nItemType = tbItem.nGreenItem
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
  local nItemParticular
  if nTienMa == 1 then
    nItemParticular = self.tbTienMaCfg[nLevel].nParticularId
    if nQuest == 1 then
      nItemParticular = KsgTable:Random(self.tbTienMaCfg[nLevel].tbQuestItemParticulars)
    end
    if nLevel > 2 then
      -- Tien ma hien chi co 2 bo 3x va 6x
      nLevel = 2
    end
  else
    nItemParticular = 3
    if nQuest == 1 then
      nItemParticular = KsgTable:Random({ 6, 9 })
    end
  end

  nItemParticular = nItemParticular + nFactionId

  local nItemId
  local nOkCount = 0
  local szName = tbItem.szName or ""
  for _ = 1, nAmount do
    nItemId = AddNormalItemBind(0, nItemType, nItemParticular, nLevel, 0, 0, nBind)
    szName = tbItem.szName or GetItemName(nItemId)
    if nItemId > 0 then
      nOkCount = nOkCount + 1
    end
  end

  if nItemId and szName ~= "" then
    KsgPlayer:Msg(string.format("NhËn ®­îc %d %s.", nAmount, szName))
  end
  local szExtraInfo = string.format("[%s] (%d, %d, %d, %d) Added success = %d, failed = %d.", szName, 0, nItemType, nItemParticular, nLevel, nOkCount, nAmount - nOkCount)

  self:WriteLog(szExtraInfo, szLogTitle)
end

function AwardGreenItem:WriteLog(szExtraInfo, szLogTitle)
  if szLogTitle then
    local szName = self.szKey or ""
    WriteLog(szLogTitle .. "\t" .. szName .. "\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t".. szExtraInfo, "KsgAward")
  end
end

return AwardGreenItem
