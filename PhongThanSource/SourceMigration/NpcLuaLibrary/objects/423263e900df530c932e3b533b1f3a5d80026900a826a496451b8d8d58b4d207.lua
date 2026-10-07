Include("script\\gvn\\events\\monthly\\event_monthly_add_item.lua")
KsgTask = KsgTask or {}

KsgTask.tbIds = {
  Version = 2999,
  Compensation = 3000,
  GiftCode = 3001,
  Event_Top = 3002,
  Exp_Type = 3003,

  Undefined1 = 3004, -- Ch­a sö dông nh÷ng task nµy
  Undefined2 = 3005,
  Undefined3 = 3006,

  Event_Version = 3007,
  Event_UseCount1 = 3008,
  Event_Accumulate1 = 3009,
  Event_UseCount2 = 3010,
  Event_Accumulate2 = 3011,

  ServerId = 3012,

  Consume_Version = 3013,
  Consume_Accumulate = 3014,
  Consume_Coin = 3015,

  ThuocTinh_Version = 3016,
  ThuocTinh_Used1 = 3017,
  ThuocTinh_Used2 = 3018,
  ThuocTinh_Used3 = 3019,
  ThuocTinh_Used4 = 3020,
  ThuocTinh_Used5 = 3021,
  ThuocTinh_Used6 = 3022,
  ThuocTinh_Used7 = 3023,
  ThuocTinh_Used8 = 3024,
  ThuocTinh_Used9 = 3025,
  ThuocTinh_Used10 = 3026,
  ThuocTinh_Used11 = 3027,
  ThuocTinh_Used12 = 3028,

  TaskID_DenBu = 3029,
  TaskID_Event_Reset = 3030,

  WB_TaskIDVersion = 3031,
  WB_TaskID1 = 3032,
  WB_TaskID2 = 3033,
  WB_TaskID3 = 3034,
  WB_TaskID4 = 3035,

  TaskID_BKTM = 3036,
  TaskID_BKTM_Date =3037,

  TaskID_NewPlayerCard = 3038,

  TopConsume_Version = 3039,
  TopConsume_Award = 3040,
  TopConsume_Coin = 3041,

  TaskChangeItem = 3042,
  TaskLockItem = 3043,

  Event_UseCount3 = 3044,
  Event_Accumulate3 = 3045,
  
  Buff_Long_Den1 = 3046,
  Buff_Long_Den2 = 3047,
  Buff_Long_Den2 = 3048,
  
  TaskID_LimitGift = 3049,
  TaskID_GiftExp = 3050,
  TaskID_LimitGift_Reset = 3051,
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
  return GetBit(self:Get(nTaskId), nBit)
end

function KsgTask:SetBit(nTaskId, nBit, nValue)
  if not nValue or nValue > 1 then
    return
  end

  self:Set(nTaskId, SetBit(self:Get(nTaskId), nBit, nValue))
end

function KsgTask:GetByte(nTaskId, nByte)
  return GetByte(self:Get(nTaskId), nByte)
end

function KsgTask:SetByte(nTaskID, nByte, nValue)
  if not nValue or nValue > 255 then
    return
  end
  self:Set(nTaskID, SetByte(self:Get(nTaskID), nByte, nValue))
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

function KsgTask:OnFinish(nTaskId)
  local nTaskValue = self:Get(nTaskId)

  if (nTaskId == 1355) then
    -- Ngò S¾c Hån
    local nTurn = GetTaskByte(nTaskId, 2)
    if (nTurn == 2 or nTurn == 4 or nTurn == 5) then
      AddMaterialEventMonthly(2)
    end
  elseif (nTaskId == 1379) then
    -- Trïng Quy Tiªn VÞ
    local nTurn = GetTaskByte(nTaskId, 2)
    if (nTurn == 2 or nTurn == 3 or nTurn == 4) then
      AddMaterialEventMonthly(2)
    end
  elseif (nTaskId == 764) then
    -- Quay Cµn Kh«n
    local nTurn = nTaskValue
    if (nTurn == 4 or nTurn == 7 or nTurn == 10 or nTurn == 12) then
      AddMaterialEventMonthly(2)
    end
  elseif (nTaskId == 962) then
    -- Siªu §é
    if (nTaskValue == 4 or nTaskValue == 7) then
      AddMaterialEventMonthly(2)
    end;
  elseif (nTaskId == 916) then
    -- Th¸m Qu©n
    local nTurn = nTaskValue
    if (nTurn == 3 or nTurn == 4 or nTurn == 5) then
      AddMaterialEventMonthly(2)
     end
  elseif (nTaskId == 917) then
    -- §¹o Cô
    local nTurn = nTaskValue
    if (nTurn == 2 or nTurn == 3 or nTurn == 4) then
      AddMaterialEventMonthly(2)
    end
  elseif (nTaskId == 768) then
    -- V¹n Tiªn TrËn
    if (nTaskValue == 1 or nTaskValue == 3 or nTaskValue == 5 or nTaskValue == 7 or nTaskValue == 9 or nTaskValue == 12) then
      AddMaterialEventMonthly(2)
    end;
  elseif (nTaskId == 958) then
    -- VËn L­¬ng
    if (nTaskValue ==  2 or nTaskValue == 4 or nTaskValue == 7) then
      AddMaterialEventMonthly(2)
    end;
  elseif (nTaskId == 766) then
    -- Bµo Th­¬ng
    local nTurn = nTaskValue
    if (nTurn == 3 or nTurn == 5 or nTurn == 7) then
      AddMaterialEventMonthly(2)
     end
  elseif (nTaskId == 1139) then
    -- Tèng Töu
    local nTurn = GetByte(nTaskValue, 2)
    if (nTurn == 2 or nTurn == 3 or nTurn == 4) then
      AddMaterialEventMonthly(2)
     end
  elseif (nTaskId == 1143) then
    -- Thiªn Cèng
    local nTurn = GetByte(nTaskValue, 1)
    if (nTurn == 3 or nTurn == 4 or nTurn == 5) then
      AddMaterialEventMonthly(2)
     end
  elseif (nTaskId == 1309) then
    -- H« Tiªn Ho¸n Ma
    local nTurn = GetTaskByte(nTaskId, 2)
    if (nTurn == 2 or nTurn == 4 or nTurn == 5) then
      AddMaterialEventMonthly(2)
     end
  elseif (nTaskId == 1329) then
    -- Nam Minh Ly Háa
    local nTurn = GetTaskByte(nTaskId, 1)
    if (nTurn == 2 or nTurn == 4 or nTurn == 6 or nTurn == 8 or nTurn == 9) then
      AddMaterialEventMonthly(2)
     end
  end
end
