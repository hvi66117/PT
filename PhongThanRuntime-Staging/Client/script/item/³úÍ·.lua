Task_Buff_Time = 1518
Global_Fragment = 245

function main()
    local H, M, S = GetHMS()
    if (IsEightDays() ~= 1 or H < 21 or (H == 23 and M > 58) or GetGlobalValueWord(Global_Fragment, 1) >= 2840) then
        Talk(1, "no", "Cuèc: VËt nµy chØ cã thÓ sö dông trong thêi gian <c=g>ho¹t ®éng thu thËp To¸i phiÕn<c>!")
        return
    end

    if (GetLevel() < 30) then
        Talk(1, "no", "Cuèc: Ng¹i qu¸! B¹n ch­a ®¹t cÊp 30, kh«ng thÓ sö dông vËt nµy!")
        return
    end

    if (IsTongMember() ~= 1) then
        Talk(1, "no", "Cuèc: Ng¹i qu¸! B¹n ch­a cã l·nh ®Þa, kh«ng thÓ sö dông vËt nµy!")
        return
    end

    if (HaveIBBuff(756) > 0) then
        Talk(1, "no", "Cuèc: Ng¹i qu¸! B¹n ®ang trong tr¹ng th¸i ®µo To¸i phiÕn, kh«ng thÓ tiÕp tôc sö dông vËt nµy!")
        return
    end

    if (GetIBBuffCount() >= 26) then
        Talk(1, "no", "Cuèc: B¹n ®ang cã qu¸ nhiÒu tr¹ng th¸i trªn ng­êi, kh«ng thÓ më ®­îc vËt nµy! Xin bá bít mét sè tr¹ng th¸i!")
        return
    end

    if (HaveNormalItem(6, 1, 542, 1) <= 0) and (HaveNormalItemInQuick(6, 1, 542, 1) <= 0) then
        Talk(1, "no", "Ng¹i qu¸! B¹n kh«ng mang theo Cuèc.")
        return
    end

    AddIBBuff(756)
    local nowTime = LocalSystemTime()
    SetTask(Task_Buff_Time, nowTime)

    if (HaveNormalItemInQuick(6, 1, 542, 1) > 0) then
        DelNormalItemInQuick(6, 1, 542, 1)
    elseif (HaveNormalItem(6, 1, 542, 1) > 0) then
        DelNormalItem(6, 1, 542, 1)
    end

end

function no()
    CloseDialog()
end
