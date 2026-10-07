--- @class KsgNpc
KsgNpc = KsgNpc or {}

KsgNpc.MAX_SAY_OPTIONS = 12
KsgNpc.MAX_INPUT_NUMBER = 2000

KsgNpc.tbDialogData = {}
KsgNpc.tbMsgBoxData = {}
KsgNpc.tbInputDialog = {}

---Talk to npc
---@param szMsg string
---@param bMsgToPlayer? boolean
---@param szCallback? string
function KsgNpc:Talk(szMsg, bMsgToPlayer, szCallback)
  szCallback = szCallback or "_no"
  Talk(1, szCallback, szMsg)
  if bMsgToPlayer then
    KsgPlayer:Msg(szMsg)
  end
end

---Talk to npc
---@param szCallback? string
function KsgNpc:TalkEx(szCallback, ...)
  szCallback = szCallback or "_no"
  local nTalkCount = #arg
  if nTalkCount < 1 then
    return
  end
  Talk(#arg, szCallback, unpack(arg))
end

--- Ask client for number
--- @param szTitle string
--- @param fn function
--- @param tbArg? table
function KsgNpc:AskNumber(szTitle, fn, tbArg)
  tbArg = tbArg or {}
  self.tbInputDialog[PlayerIndex] = { fn = fn, tbArg = tbArg }
  InputDialog(szTitle, 2, "X¸c nhËn/_InputDialog_Yes", "§ãng/_InputDialog_No")
end

---Set max input number
---@param nNum number
function KsgNpc:SetMaxInputNumber(nNum)
  self.MAX_INPUT_NUMBER = nNum
end

function _InputDialog_No()
  KsgNpc.tbInputDialog[PlayerIndex] = {}
end

function _InputDialog_Yes(nAmount)
  if not nAmount then
    return
  end
  nAmount = tonumber(nAmount)
  if nAmount < 0 then
    return KsgNpc:Talk("Sè l­îng nhËp vµo kh«ng hîp lÖ", true)
  end
  if nAmount > KsgNpc.MAX_INPUT_NUMBER then
    return KsgNpc:Talk(string.format("Sè l­îng nhËp vµo kh«ng ®­îc v­ît qu¸ %d", KsgNpc.MAX_INPUT_NUMBER), true)
  end
  local tbInputDialog = KsgNpc.tbInputDialog[PlayerIndex]
  KsgNpc.tbInputDialog[PlayerIndex] = {}

  local func = tbInputDialog.fn
  local tbArg = tbInputDialog.tbArg

  table.insert(tbArg, nAmount)
  pcall(func, unpack(tbArg))
end

---Say to npc
---@param szTitle string
---@param tbOpt table
function KsgNpc:Say(szTitle, tbOpt)
  self.tbDialogData[PlayerIndex] = {}

  local tbSayOpt = {}
  local nTotalOption = 0
  for i, v in pairs(tbOpt) do
    if nTotalOption >= self.MAX_SAY_OPTIONS then
      break
    end
    local szFun = "_Say_Option_" .. i
    if v[2] then
      self.tbDialogData[PlayerIndex][i] = pack(unpack(v, 2))
    end
    table.insert(tbSayOpt, string.format("%s/%s", v[1], szFun))
    nTotalOption = nTotalOption + 1
  end

  Say(szTitle, #tbSayOpt, tbSayOpt)
end

function _Say_Option_1()
  KsgNpc:_Say_Option(1)
end
function _Say_Option_2()
  KsgNpc:_Say_Option(2)
end
function _Say_Option_3()
  KsgNpc:_Say_Option(3)
end
function _Say_Option_4()
  KsgNpc:_Say_Option(4)
end
function _Say_Option_5()
  KsgNpc:_Say_Option(5)
end
function _Say_Option_6()
  KsgNpc:_Say_Option(6)
end
function _Say_Option_7()
  KsgNpc:_Say_Option(7)
end
function _Say_Option_8()
  KsgNpc:_Say_Option(8)
end
function _Say_Option_9()
  KsgNpc:_Say_Option(9)
end
function _Say_Option_10()
  KsgNpc:_Say_Option(10)
end
function _Say_Option_11()
  KsgNpc:_Say_Option(11)
end
function _Say_Option_12()
  KsgNpc:_Say_Option(12)
end

function KsgNpc:_Say_Option(nSelectIdx)
  CloseDialog()
  local tbCallback = self.tbDialogData[PlayerIndex][nSelectIdx]
  self.tbDialogData[PlayerIndex] = {}
  if not tbCallback then
    return
  end
  KsgLib:Callback(tbCallback)
end

function KsgNpc:MsgBox(szTitle, szCallbackYes, szCallbackNo)
  local szYes = szCallbackYes or "_no"
  local szNo = szCallbackNo or "_no"

  MsgBox(szTitle, szYes, szNo)
end

function KsgNpc:MsgBoxEx(szTitle, tbCallback, szOnCancel)
  local szCancel = szOnCancel or "_no"
  self.tbMsgBoxData[PlayerIndex] = tbCallback
  MsgBox(szTitle, "_MsgBox_OnConfirm", szCancel)
end

function _MsgBox_OnConfirm()
  return KsgNpc:_MsgBox_OnConfirm()
end

function _no()
  CloseDialog()
end

function KsgNpc:_MsgBox_OnConfirm()
  CloseDialog()
  local tbCallback = self.tbMsgBoxData[PlayerIndex]
  self.tbMsgBoxData[PlayerIndex] = {}
  if not tbCallback then
    return
  end
  KsgLib:Callback(tbCallback)
end

function KsgNpc:CurrentNpcId()
  return GetNpcID(DialogNpcIdx)
end

function KsgNpc:Add(tbOption)
  local nNpcIdx = AddNpc(tbOption.nNpcId, tbOption.nLevel or 1, tbOption.nMapIdx or SubWorld, tbOption.nX, tbOption.nY)
  if nNpcIdx > 0 then
    SetNpcName(nNpcIdx, tbOption.szName)

    if tbOption.szScript then
      SetNpcScript(nNpcIdx, tbOption.szScript)
    end

    if tbOption.nLifeTime then
      SetNpcTimer(nNpcIdx, tbOption.szDestroyScript, tbOption.nLifeTime)
    end

    if(tbOption.szAIScript) then
      SetAIScript(nNpcIdx, tbOption.szAIScript)
    end
    if(tbOption.nGuardLevel) then
      SetGuardLevel(nNpcIdx, tbOption.nGuardLevel)
    end
  end

  return nNpcIdx
end
function KsgNpc:Delete(nNpcIdx)
  return DelNpc(nNpcIdx)
end

function KsgNpc:DeleteCurrentTargetNpc()
  return KsgNpc:Delete(DialogNpcIdx)
end

function KsgNpc:GetCurrentNpcTask(nTaskIdx)
  return self:GetTask(DialogNpcIdx, nTaskIdx)
end

function KsgNpc:SetTask(nNpcId, nTaskIdx, nValue)
  return SetNpcTask(nNpcId, nTaskIdx, nValue)
end

function KsgNpc:GetTask(nNpcId, nTaskIdx)
  return GetNpcTask(nNpcId, nTaskIdx)
end

function KsgNpc:GetTask(nNpcId, nTaskIdx)
  return GetNpcTask(nNpcId, nTaskIdx)
end

return KsgNpc
