KsgTask = KsgTask or {}

KsgTask.tbIds = {
  Version = 2999,
  Compensation = 3000,
  GiftCode = 3001,
  Event_Top = 3002,
  _Event_Top_Reserved = 3003, -- Ch­a dïng

  TestServer = 3004,
  Newbie = 3005,

  _Undefined1 = 3006, -- Ch­a sö dông task nµy
  _Undefined2 = 3007,
  _Undefined3 = 3008,
  _Undefined4 = 3009,
  _Undefined5 = 3010,
  _Undefined6 = 3011,

  ServerId = 3012,

  EventMidAutumn_Version = 3013,
  EventMidAutumn_ExpType = 3014,
  EventMidAutumn_UseCount1 = 3015,
  EventMidAutumn_UseCount2 = 3016,
  EventMidAutumn_UseCount3 = 3017,
  EventMidAutumn_Accumulate1 = 3018,
  EventMidAutumn_Accumulate2 = 3019,
  EventMidAutumn_Accumulate3 = 3020,

  -- MAIN TASK
  CanKhonLuan = 764,
  BaoThuong = 766,
  VanTienTran = 768,
  ThamQuan = 916,
  ThuThapDaoCu = 917,
  VanLuong = 958,
  SieuDo = 962,
  TongTuu = 1139,
  XaoDoatThienCong = 1143,
  HoTienHoanMa = 1309,
  NamMinhLyHoa = 1329,
  NguSacHon = 1355,
  TrungQuyTienMa = 1379,
}

KsgTask.tbBytes = {
  -- for task ServerId = 3012,
  LOGIN_SERVER_ID = 1,
  LAST_LOGIN_SERVER_ID = 2,
  LAST_SERVER_ID = 3,
  REGISTER_TRANSFER_SERVER_ID = 4,
  -- end task ServerId
}

function KsgTask:Modify(nTaskId, nValue)
  self:Set(nTaskId, self:Get(nTaskId) + nValue)
end

function KsgTask:GetBit(nTaskId, nBit)
  return GetTaskBit(nTaskId, nBit)
end

function KsgTask:SetBit(nTaskId, nBit, nValue)
  SetTaskBit(nTaskId, nBit, nValue)
end

function KsgTask:GetByte(nTaskId, nByte)
  return GetTaskByte(nTaskId, nByte)
end

function KsgTask:SetByte(nTaskId, nByte, nValue)
  SetTaskByte(nTaskId, nByte, nValue)
end

function KsgTask:Get(nTaskId)
  return GetTask(nTaskId)
end

function KsgTask:Set(nTaskId, nValue)
  SetTask(nTaskId, nValue)
end

function KsgTask:GetPosValue(nTaskId, nStart, nEnd)
  local nTaskValue = self:Get(nTaskId)

  return KsgLib:GetPosValue(nTaskValue, nStart, nEnd)
end

function KsgTask:SetPosValue(nTaskId, nSetValue, nStart, nEnd)
  local nTaskValue = self:Get(nTaskId)
  nTaskValue = KsgLib:SetPosValue(nTaskValue, nSetValue, nStart, nEnd)

  return self:Set(nTaskId, nTaskValue)
end

return KsgTask
