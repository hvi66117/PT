Task_ibyq = 1613
Task_yq = 1614

Task_szxh = 1615

Task_szbzxy = 1616
Task_szbzdis = 1617
Family_szxh = 21

TaskNote_szxh = 1503

function main(l, t, npcindex)

    local fudi_info = {
        [1] = { name = "Th­íc Kim Phóc §Þa", pxid = 1507 },
        [2] = { name = "ThiÖn Thñy Phóc §Þa", pxid = 1558 },
        [3] = { name = "óc Méc Phóc §Þa", pxid = 1557 },
        [4] = { name = "XÝch Háa Phóc §Þa", pxid = 1559 },
        [5] = { name = "Kh«i Thæ Phóc §Þa", pxid = 1560 },
    }

    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    if (GetTaskByte(Task_szxh, 1) ~= 1) then
        Msg2Player("B¹n ®· b¾t ®­îc kÎ chñ m­u.")
        return
    end

    if (npcindex == 0) then
        Msg2Player("Ph¶i chØ chuét vµo Tú H­u.")
        return
    end

    local mapid, x, y = GetWorldPos()
    local mapid1, npcx, npcy = GetNpcWorldPos(npcindex)

    local npcTemplateID = GetNpcTemplateID(npcindex)
    local fudiidx = GetTaskByte(Task_szxh, 2)
    if (fudi_info[fudiidx].pxid ~= npcTemplateID) then
        Talk(1, "no", "§õng lµm h¹i nh÷ng sinh linh v« téi, b¹n ph¶i ®i <c=g>" .. fudi_info[fudiidx].name .. "<c> b¾t <c=g>Tú H­u<c>.")
        return
    end

    local distance = math.floor(((npcx - x) ^ 2 + (npcy - y) ^ 2))
    if (distance > 300) then
        Msg2Player("B¹n c¸ch Tú H­u qu¸ xa, h­¬ng th¬m cña Thiªn Tóy Lan kh«ng thÓ ph¸t huy t¸c dông.")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, dï sö dông Thiªn Tóy Lan dô ®­îc Tú H­u, còng kh«ng cã chç trèng ®ùng b¶o vËt bÞ trém.")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 1)
    SetPlayerTarget(npcindex)
    BeginMotion(Task_szxh, 1, 8, "\\script\\motion\\ÓÕ²¶õùõ÷.lua", nInterrupt)
end;

function no()
    CloseDialog()
end;
