TASK_NPC_IDX = 1564
TASK_DAY = 1574
TASK_TIMES = 1569

function GetPlayerTaskState()
    return 0, 0
end

function no()
    CloseDialog()
end;

function main()
    local skLevel = GetLiveSkillLevel(3)
    if skLevel < 4 then
        Msg2Player("Kü n¨ng khai kho¸ng cña b¹n kh«ng ®ñ cÊp 4, kh«ng thÓ ®µo §ång kho¸ng trung cÊp.")
        return
    end

    local npcPos, npcX, npcY = GetNpcWorldPos(DialogNpcIdx)
    local m, x, y = GetWorldPos()

    if npcPos ~= m then
        return
    end

    if (IsEquipItem(0, 8, 1) == 0) and (IsEquipItem(0, 8, 2) == 0) and (IsEquipItem(0, 8, 3) == 0) and (IsEquipItem(0, 8, 4) == 0) and (IsEquipItem(0, 8, 5) == 0) and (IsEquipItem(0, 8, 6) == 0) and (IsEquipItem(0, 8, 7) == 0) and (IsEquipItem(0, 8, 8) == 0) and (IsEquipItem(0, 8, 9) == 0) and (IsEquipItem(0, 8, 10) == 0) then
        Msg2Player("B¹n ch­a trang bÞ Cuèc chim, kh«ng thÓ ®µo Kho¸ng Th¹ch.")
        return
    end

    if AbradeEquip(3) > 0 then
        Msg2Player("Cuèc chim cña b¹n ®· háng, kh«ng thÓ tiÕp tôc ®µo kho¸ng")
        return
    end

    if (HaveIBBuff(251) == 0 and GetNpcTask(DialogNpcIdx, 1) >= 25) then
        Talk(1, "no", "Kh«ng thÓ nhËn thªm ng­êi vµo ®µo kho¸ng n÷a!")
        return

    end

    local thisDay = math.floor(LocalSystemTime() / 86400)
    if thisDay > GetTask(TASK_DAY) then
        SetTask(TASK_TIMES, 0)
        SetTask(TASK_DAY, thisDay)

    elseif GetTaskWord(TASK_TIMES, 2) >= 360 then
        MsgBox("H«m nay b¹n ®· rÊt mÖt råi, tiÕp tôc ®µo Kho¸ng Th¹ch n÷a sÏ kh«ng thÓ nhËn ®­îc Hoµng ®ång, Tö ®ång, XÝch ®ång vµ Thñy Tinh Nguyªn Th¹ch. VÉn muèn tiÕp tôc ®µo kho¸ng chø?", "MineYes", "no")
        return
    end

    DoSkillAction()

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)

    BeginLvSkill("\\script\\ontimer\\ÖÐ¼¶²É¿ó×¼±¸¶¯×÷.lua", 1, nInterrupt, "")

    SetTask(TASK_NPC_IDX, DialogNpcIdx)
end

function MineYes()
    CloseDialog()
    DoSkillAction()

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)

    BeginLvSkill("\\script\\ontimer\\ÖÐ¼¶²É¿ó×¼±¸¶¯×÷.lua", 1, nInterrupt, "")

    SetTask(TASK_NPC_IDX, DialogNpcIdx)
end
