function OnTimer(npcidx)
    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    if (GetTongName() == CityTongName) then
        Msg2TongMember(GetName() .. "Thñ hé ThÇn thó nguyªn thÇn ®· tiªu t¸n! Ph¶i ®îi c¬ héi chuyÓn thÕ lu©n håi lÇn sau!")
    end
    DelNpc(npcidx)


end;
