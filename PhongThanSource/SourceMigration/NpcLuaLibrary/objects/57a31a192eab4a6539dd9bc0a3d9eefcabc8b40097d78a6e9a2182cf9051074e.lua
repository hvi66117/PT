--- @class KsgNpc
KsgNpc = KsgNpc or {}

KsgNpc.MAX_SAY_OPTIONS = 12
KsgNpc.MAX_INPUT_NUMBER = 2000

KsgNpc.tbDialogData = {}
KsgNpc.tbMsgBoxData = {}
KsgNpc.tbInputDialog = {}

function KsgNpc:Talk(szMsg, bMsgToPlayer, szCallback)
  szCallback = szCallback or "_no"
  Talk(1, szCallback, szMsg)
  if bMsgToPlayer then
    KsgPlayer:Msg(szMsg)
  end
end

--- Ask client for number
--- @param szTitle string
--- @param fn function
--- @param tbArg table
function KsgNpc:AskNumber(szTitle, fn, tbArg)
  tbArg = tbArg or {}
  self.tbInputDialog[PlayerIndex] = { fn = fn, tbArg = tbArg }
  InputDialog(szTitle, 2, "X¸c nhËn/_InputDialog_Yes", "§ãng/_InputDialog_No")
end

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
    return KsgPlayer:Msg("Sè l­îng nhËp vµo kh«ng hîp lÖ")
  end
  if nAmount > KsgNpc.MAX_INPUT_NUMBER then
    return KsgPlayer:Msg(format("Sè l­îng nhËp vµo kh«ng ®­îc v­ît qu¸ %d", KsgNpc.MAX_INPUT_NUMBER))
  end
  local tbInputDialog = KsgNpc.tbInputDialog[PlayerIndex]
  KsgNpc.tbInputDialog[PlayerIndex] = {}

  local func = tbInputDialog.fn
  local tbArg = tbInputDialog.tbArg

  tinsert(tbArg, nAmount)
  call(func, tbArg)
end

function KsgNpc:Say(szTitle, tbOpt)
  self.tbDialogData[PlayerIndex] = {}

  local tbSayOpt = {}
  local nTotalOption = 0
  for i, v in pairs(tbOpt) do
    if nTotalOption >= self.MAX_SAY_OPTIONS then
      break
    end
    local szFun = "_SayEx_Option_" .. i
    if v[2] then
      self.tbDialogData[PlayerIndex][i] = pack(unpack(v, 2))
    end
    tinsert(tbSayOpt, format("%s/%s", v[1], szFun))
    nTotalOption = nTotalOption + 1
  end

  Say(szTitle, getn(tbSayOpt), tbSayOpt)
end

function _SayEx_Option_1()
  KsgNpc:_SayEx_Option(1)
end
function _SayEx_Option_2()
  KsgNpc:_SayEx_Option(2)
end
function _SayEx_Option_3()
  KsgNpc:_SayEx_Option(3)
end
function _SayEx_Option_4()
  KsgNpc:_SayEx_Option(4)
end
function _SayEx_Option_5()
  KsgNpc:_SayEx_Option(5)
end
function _SayEx_Option_6()
  KsgNpc:_SayEx_Option(6)
end
function _SayEx_Option_7()
  KsgNpc:_SayEx_Option(7)
end
function _SayEx_Option_8()
  KsgNpc:_SayEx_Option(8)
end
function _SayEx_Option_9()
  KsgNpc:_SayEx_Option(9)
end
function _SayEx_Option_10()
  KsgNpc:_SayEx_Option(10)
end
function _SayEx_Option_11()
  KsgNpc:_SayEx_Option(11)
end
function _SayEx_Option_12()
  KsgNpc:_SayEx_Option(12)
end

function KsgNpc:_SayEx_Option(nSelectIdx)
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

function KsgNpc:_MsgBox_OnConfirm()
  CloseDialog()
  local tbCallback = self.tbMsgBoxData[PlayerIndex]
  self.tbMsgBoxData[PlayerIndex] = {}
  if not tbCallback then
    return
  end
  KsgLib:Callback(tbCallback)
end

