TASK_lateral = 1200
TASK_lateral_1 = 1201

function GetPlayerTaskState()
    return 0, 0
end

function main()
    local idx = 1

    if (HaveNormalItem(6, 1, 12, 1) <= 0) then
        no()
        if (HaveNormalItem(6, 1, 12, 0) > 0) then
            idx = 0
        else
            return
        end
    end

    local thisnumber = GetTask(137)

    local i = math.random(1, 200);
    local Name = GetName()
    if (i <= 1) then

        Earn(100000)
        ScrollMessage("Më th¨m, b¹n nhËn ®­îc 10 v¹n!")
        AddGlobalCountNews("Më th¨m, <c=g>" .. Name .. "<c>, may m¾n nhËn ®­îc 10 v¹n!", 3)


    elseif (i <= 46) then

        AddNormalItemPile(3, 63, 0, 1, 0, 0, 0)
        ScrollMessage("Më quÎ x¨m, nhËn ®­îc Thñy Linh phï!")
    elseif (i <= 160) then

        AddNormalItemPile(3, 62, 0, 1, 0, 0, 0)
        ScrollMessage("Më th¨m, b¹n nhËn ®­îc 1 tÊm Thæ Linh phï!")

        local val = GetTask(TASK_lateral)
        if (GetBit(val, 5) == 1) and (GetBit(val, 7) == 0) then
            SetTaskBit(TASK_lateral, 7, 1)
            if (GetBit(val, 6) == 1) then
                Msg2Player(" Giao Thæ Linh Phï cho Thiªn Hïng")
                TaskNote(700, 3)
            else
                TaskNote(700, 2, (3 - GetByte(GetTask(TASK_lateral_1), 1)))
            end
        end
    else

        ScrollMessage("Ng¹i qu¸! Th­îng thiªn lÇn nµy kh«ng ban th­ëng…")
    end ;

    local nYear, nMon, nDay = GetYMD()
    local nHour, nMin, nSec = GetHMS()
    if (nYear == 2014 and nMon == 7 and (nDay > 15 or (nDay == 15 and nHour >= 10)) and nDay <= 31) then
        if (math.random(1, 100) <= 1 and IsHaveSpaceForTreasure(2) > 0 and GetTaskBit(1900, 17) == 0) then
            SetTaskBit(1900, 17, 1)
            AddNormalItemBind(8, 1584, 2, 0, 0, 0, 1)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc thªm 1 ÂíÉÏÓĞ¶ÔÏóÁé³è±äÉí·û.")
            AddGlobalNews(GetName() .. "ÔÚ´ò¿ªÓ¦Ç©Ê±ÒâÍâ nhËn ®­îc ÂíÉÏÓĞ¶ÔÏóÁé³è±äÉí·û, thËt qu¸ may m¾n!")
            WriteLog("NhËn ®­îc ÂíÉÏÓĞ¶ÔÏóÁé³è")
        end
    end

    DelNormalItem(6, 1, 12, idx)

end;

function no()
    CloseDialog()
end;
