--description: ³õ¼¶¿ó.lua
--author: laiyongcong
--date: 2009/9/29

--Éú»î¼¼ÄÜ----------
TASK_NPC_IDX = 1564            --
TASK_DAY = 1574            --ÈÕÆÚ
TASK_TIMES = 1569            --µÍÁ½Î»Ë¦¸Ë´ÎÊı£¬Ã¿Ìì×î¶àË¦¸Ë360´Î
--¸ßÁ½Î»²É¿ó´ÎÊı£¬Ã¿Ìì×î¶à360´Î
--Éú»î¼¼ÄÜ----------

function GetPlayerTaskState()
    return 0, 0
end

function no()
    CloseDialog()
end;

function main()
    local skLevel = GetLiveSkillLevel(3) --»ñµÃ²É¿ó¼¼ÄÜµÄµÈ¼¶
    if skLevel < 4 then
        Msg2Player("Kü n¨ng khai kho¸ng cña b¹n kh«ng ®ñ cÊp 4, kh«ng thÓ ®µo §ång kho¸ng trung cÊp.")
        return
    end

    local npcPos, npcX, npcY = GetNpcWorldPos(DialogNpcIdx) --»ñµÃNPCµÄÎ»ÖÃ
    local m, x, y = GetWorldPos()                             --»ñµÃÍæ¼ÒµÄÎ»ÖÃ

    if npcPos ~= m then
        --²»ÔÚÍ¬Ò»ÕÅµØÍ¼ÉÏ±ØÈ»ÊÇ·Ç·¨µÄ
        return
    end

    if (IsEquipItem(0, 8, 1) == 0) and (IsEquipItem(0, 8, 2) == 0) and (IsEquipItem(0, 8, 3) == 0) and (IsEquipItem(0, 8, 4) == 0) and (IsEquipItem(0, 8, 5) == 0) and (IsEquipItem(0, 8, 6) == 0) and (IsEquipItem(0, 8, 7) == 0) and (IsEquipItem(0, 8, 8) == 0) and (IsEquipItem(0, 8, 9) == 0) and (IsEquipItem(0, 8, 10) == 0) then
        -------------------------------------------------------¼ì²éÊÇ·ñ×°±¸º××ì³ú,¾ßÌåÀà±ğ¡¢ÏêÏ¸Àà±ğ¡¢µÈ¼¶
        Msg2Player("B¹n ch­a trang bŞ Cuèc chim, kh«ng thÓ ®µo Kho¸ng Th¹ch.")
        return
    end

    if AbradeEquip(3) > 0 then
        ------------------------------------------------------------×°±¸Ä¥Ëğ
        Msg2Player("Cuèc chim cña b¹n ®· háng, kh«ng thÓ tiÕp tôc ®µo kho¸ng")
        return
    end

    --Added by laiyongcong for ²É¿óÓÅ»¯ at 2010/1/19 begin
    if (HaveIBBuff(251) == 0 and GetNpcTask(DialogNpcIdx, 1) >= 25) then
        Talk(1, "no", "Kh«ng thÓ nhËn thªm ng­êi vµo ®µo kho¸ng n÷a!")
        return

    end
    --Added by laiyongcong for ²É¿óÓÅ»¯ at 2010/1/19 end


    --local dx = npcX - x
    --local dy = npcY - y

    --local dist = (dx * dx + dy * dy)*1024

    --if dist > 30000 then
    --	Msg2Player("¾àÀëÌ«Ô¶£¬ÎŞ·¨¿ª²É¿óÊ¯¡£")			--´óÓÚ100¸öÏñËØµã
    --	return
    --end

    local thisDay = floor(LocalSystemTime() / 86400)
    if thisDay > GetTask(TASK_DAY) then
        SetTask(TASK_TIMES, 0)--ÖØÖÃ²É¿ó´ÎÊıÎª0
        SetTask(TASK_DAY, thisDay)

    elseif GetTaskWord(TASK_TIMES, 2) >= 360 then
        MsgBox("H«m nay b¹n ®· rÊt mÖt råi, tiÕp tôc ®µo Kho¸ng Th¹ch n÷a sÏ kh«ng thÓ nhËn ®­îc Hoµng ®ång, Tö ®ång, Xİch ®ång vµ Thñy Tinh Nguyªn Th¹ch. VÉn muèn tiÕp tôc ®µo kho¸ng chø?", "MineYes", "no")
        return
    end

    DoSkillAction() --²¥·Å¼¼ÄÜ¶¯×÷

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
    nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
    nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
    nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
    nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
    nInterrupt = SetBit(nInterrupt, 9, 1)    --½ÇÉ«ËÀÍö

    BeginLvSkill("\\script\\ontimer\\ÖĞ¼¶²É¿ó×¼±¸¶¯×÷.lua", 1, nInterrupt, "")

    SetTask(TASK_NPC_IDX, DialogNpcIdx)
end

function MineYes()
    CloseDialog()
    DoSkillAction() --²¥·Å¼¼ÄÜ¶¯×÷

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
    nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
    nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
    nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
    nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
    nInterrupt = SetBit(nInterrupt, 9, 1)    --½ÇÉ«ËÀÍö

    BeginLvSkill("\\script\\ontimer\\ÖĞ¼¶²É¿ó×¼±¸¶¯×÷.lua", 1, nInterrupt, "")

    SetTask(TASK_NPC_IDX, DialogNpcIdx)
end
