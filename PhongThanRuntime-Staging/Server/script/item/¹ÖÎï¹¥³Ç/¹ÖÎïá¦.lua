gNPCgwfID = 1502

TOTEM_POS_ARRAY = {
    [0] = { nWorldX = 1730, nWorldY = 3258 },
    [1] = { nWorldX = 1739, nWorldY = 3294 },
    [2] = { nWorldX = 1718, nWorldY = 3271 },
    [3] = { nWorldX = 1709, nWorldY = 3280 },
    [4] = { nWorldX = 1859, nWorldY = 3192 },
}

function main()

    local mapid, px, py = GetWorldPos()
    px = math.floor(px / 8)
    py = math.floor(py / 16)

    local myTongName = GetTongName()
    local sTong, sCity, nTime, nState = GetShortBattleByInfo(myTongName)
    local fightday = math.floor(nTime / 86400)
    local today = math.floor(LocalSystemTime() / 86400)

    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    if (CityTongName ~= sTong) then


        Talk(1, "no", "CuÈc chi’n l«n nµy, <c=g>" .. sTong .. "<c> ph∏t ÆÈng x©m l≠Óc l∑nh Æﬁa cÒa bπn, tπo ra tÊn th t to lÌn. Bπn chÿ cﬂn c∏ch ph∂n k›ch lπi <c=g>" .. sTong .. "<c>.")
        return 0
    end

    local H, M, S = GetHMS()

    local isSecondDay = today - fightday
    if ((H == 20) and (M < 30) and (isSecondDay == 1)) then

    else

        Talk(1, "no", "Ngµy th¯ 2 QuËc chi’n, tı 20:00-20:30 c„ th” ph∂n k›ch lπi l∑nh Æﬁa Æ∑ tuy™n chi’n.")
        return 0
    end

    local nWorldX = TOTEM_POS_ARRAY[typeIdx].nWorldX * 32
    local nWorldY = TOTEM_POS_ARRAY[typeIdx].nWorldY * 32
    Msg2Player("Bπn Æ∑ dıng TÙ HÂn Ph≠Ìn thµnh c´ng.")

    Msg2TongMember("QuËc v≠¨ng <bc=r> <RoleName=\"" .. GetName() .. "\"></bc> ph∏t ÆÈng ph∂n k›ch chi’n vÌi <bc=b>" .. CityTongName .. "</bc>, TÙ HÂn Ph≠Ìn Î [" .. math.floor(nWorldX / 32 / 8) .. "," .. math.floor(nWorldY / 32 / 16) .. "] ngoµi thµnh.")
    Msg2TongMemberByTongName(CityTongName, "<bc=blk>" .. myTongName .. "</bc> Æ∑ ph∏t ÆÈng ph∂n k›ch chi’n vÌi l∑nh Æﬁa chÛng ta, h∑y chu»n bﬁ chi’n Æ u!")

    WriteLog(myTongName .. " ph∏t ÆÈng ph∂n k›ch chi’n vÌi l∑nh Æﬁa" .. CityTongName .. "!")

    local nNpcIdx = AddNpc(gNPCgwfID, 1, SubWorld, nWorldX, nWorldY)
    SetNpcTimer(nNpcIdx, "\\script\\ontimer\\∑¥ª˜’Ω∂® ±.lua", 1)
    SetNpcTask(nNpcIdx, 1, 0)
    SetNpcTask(nNpcIdx, 2, 1)
    SetNpcName(nNpcIdx, "[" .. myTongName .. "] TÙ HÂn Ph≠Ìn")
    Talk(1, "no", "TÙ HÂn Ph≠Ìn Æ∆t Î [" .. math.floor(nWorldX / 32 / 8) .. "," .. math.floor(nWorldY / 32 / 16) .. "] ngoµi thµnh.")

    local citygateidx = GetCityGateNpcIdxByNpc(nNpcIdx)
    SetNpcTask(citygateidx, 1, 1)
    SetBarrierState(citygateidx, 1)

    DelNormalItem(6, 1, 704, 1)
end

function no()
    CloseDialog()
end
