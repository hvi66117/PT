AwardFunc = {}
AwardFunc.szKey = 'fn'

--- Give award by a function
--- @param tbAward table
--- @param szLogTitle string
--- @param nAwardCount number
--- Example of usage
--- local tbAward = {
---   {fn = self.SomeFunction, tbParam = {self}},
--- }
--- KsgAward:Give(tbAward)
---
function AwardFunc:Give(tbAward, szLogTitle, nAwardCount)
  local func = tbAward.fn
  local nAmount = (nAwardCount or 1) * (tbAward.nAmount or 1)
  if type(func) == "function" then
    for _ = 1, nAmount do
      pcall(func, unpack(tbAward.tbParam))
    end
    self:WriteLog(string.format("%s*%d", tostring(func), nAmount), szLogTitle)
  else
    self:WriteLog(string.format("Invalid parameters %s", type(func)), szLogTitle)
  end
end

function AwardFunc:WriteLog(szExtraInfo, szLogTitle)
  if szLogTitle then
    local szName = self.szKey or ""
    WriteLog(szLogTitle .. "\t" .. szName .. "\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t".. szExtraInfo, "KsgAward")
  end
end

return AwardFunc
