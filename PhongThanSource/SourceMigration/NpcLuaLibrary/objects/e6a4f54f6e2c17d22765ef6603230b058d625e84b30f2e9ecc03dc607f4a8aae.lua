nStartDate = 20230120
nEndDate = 20230221

function AddMaterialEventMonthly(nNum)
  if  IsActive() then
    for _ = 1, nNum do
      AddNormalItemPile(6, 1, 6013, 1, 0, 0);
    end
    AddNormalItemPile(6, 1, 6015, 1, 0, 0);
    Msg2Player("B¹n nhËn ®­îc <c=green>" .. nNum .. " Tói Quµ Th¸ng 1")
    Msg2Player("B¹n nhËn ®­îc <c=green> 1 G¹o NÕp")

    WriteEventLog("Vui TÕt §oµn Viªn", "Material", "Tói Quµ Th¸ng 1", "", "");
  end
end

function WriteEventLog(NameEvent, Type, Param1, Param2, Param3)
  NameEvent = checkparam(NameEvent, "");
  Type = checkparam(Type, "");
  Param1 = checkparam(Param1, "");
  Param2 = checkparam(Param2, "");
  Param3 = checkparam(Param3, "");

  local str = "<" .. NameEvent .. ">\t<" .. Type .. ">\t" .. Param1 .. "\t" .. Param2 .. "\t" .. Param3;
  WriteLog(str);
end;

function checkparam(param, default)
  if param == nil then
    param = default;
  end ;
  return param;
end;

function IsActive()
  local nNow = today()

  return nNow >= nStartDate and nNow <= nEndDate
end

function today(bFull)
  local nYear, nMonth, nDay = GetYMD()
  local nH, nM, nS = GetHMS()
  if bFull then
    return tonumber(format("%d%02d%02d%02d%02d%02d", nYear, nMonth, nDay, nH, nM, nS))
  end
  return tonumber(format("%d%02d%02d", nYear, nMonth, nDay))
end
