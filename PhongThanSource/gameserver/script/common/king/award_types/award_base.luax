AwardBase = {}

AwardBase.szKey = ""

AwardBase.pFunc = nil

AwardBase.szMsgFormat = nil

AwardBase.isValid = function(nAmount)
  return nAmount > 0
end

AwardBase.onInvalid = function(nAmount)
  -- Do something here or override this function
end

function AwardBase:Reg()
  KsgAward:RegType(self.szKey, self)
end

function AwardBase:new(szKey)
  local tb = {}
  for k, v in pairs(AwardBase) do
    tb[k] = v
  end

  tb.szKey = szKey

  return tb
end

function AwardBase:Give(tbAward, szLogTitle, nAwardCount)
  nAwardCount = nAwardCount or 1
  local var = tbAward[self.szKey]
  if not var then
    return nil
  end

  local nAmount = var * nAwardCount * (tbAward.nAmount or 1)
  if type(self.pFunc) == "function" then
    if not self.isValid(nAmount) then
      return self.onInvalid(nAmount)
    end
    self.pFunc(nAmount)
    self:Msg2Player(nAmount)
    self:WriteLog(nAmount, szLogTitle)
    return 1
  end
end

function AwardBase:Msg2Player(nAmount)
  if self.szMsgFormat then
    KsgPlayer:Msg(string.format(self.szMsgFormat, nAmount))
  end
end

function AwardBase:WriteLog(nAmount, szLogTitle)
  if szLogTitle then
    local szName = self.szKey or ""
    WriteLog(szLogTitle .. "\t" .. szName .. "\tFactionId = " .. KsgPlayer:GetFactionId() .. "\t".. nAmount, "KsgAward")
  end
end

return AwardBase
