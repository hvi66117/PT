rjBuff = 1480
xmBuff = 2095

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local tasks = {
        { "ÈË¼äË«±¶Ö÷Ìâ", "rj1"; show = 1 },
        { "ÈË¼äÈı±¶Ö÷Ìâ", "rj2"; show = 1 },
        { "ÏÉÄ§Ë«±¶Ö÷Ìâ", "xm1"; show = 1 },
        { "ÏÉÄ§Èı±¶Ö÷Ìâ", "xm2"; show = 1 },
    }
    SetTask(142, itemID)
    SayTask("[Ë«±¶Ö÷Ìâ]: ÊÇÔÚ<c=g>1 giê<c>ÄÚNhiÖm vô chñ ®Ò NgµyµÄ»ù´¡½±ÀøÌá¸ß100%×´Ì¬\n[Èı±¶Ö÷Ìâ]: ÊÇÔÚ<c=g>20·ÖÖÓ<c>ÄÚNhiÖm vô chñ ®Ò NgµyµÄ»ù´¡½±ÀøÌá¸ß200%×´Ì¬\n<c=r>Ë«±¶ vµ Èı±¶ÎŞ·¨¹²´æ<c>, ÇëÑ¡ÔñÄãĞèÒªµÄ¹¦ÄÜ:", tasks)
end

function rj1()
    no()
    local itemID = GetTask(142)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local bHaveBuff = HaveIBBuff(rjBuff)
    local nBuffLevel = GetIBBuffLevel(rjBuff) + 1

    if (bHaveBuff > 0 and nBuffLevel ~= 1) then
        Talk(1, "no", "ThËt xin lçi, ÄãÉíÉÏÓĞÆäËû±¶ÊıµÄ×´Ì¬, Á½Õß²»¹²´æ")
        return
    end

    DelItemByID(itemID)
    AddIBBuff(rjBuff, 3600, 0)
    Msg2Player("Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i Ğ¡Ê±µÄÈË¼ä tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.")
    WriteLog("[Phï chñ §Ò ngµy][¼ÓÈË¼äË«±¶]")
    Talk(1, "no", "Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i Ğ¡Ê±µÄÈË¼ä tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.")
end

function rj2()
    no()
    local itemID = GetTask(142)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local bHaveBuff = HaveIBBuff(rjBuff)
    local nBuffLevel = GetIBBuffLevel(rjBuff) + 1

    if (bHaveBuff > 0 and nBuffLevel ~= 2) then
        Talk(1, "no", "ThËt xin lçi, ÄãÉíÉÏÓĞÆäËû±¶ÊıµÄ×´Ì¬, Á½Õß²»¹²´æ")
        return
    end

    DelItemByID(itemID)
    AddIBBuff(rjBuff, 1200, 1)
    Msg2Player("Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i 20·ÖÖÓµÄÈË¼äÖ÷ÌâÈÕÈı±¶×´Ì¬.")
    WriteLog("[Phï chñ §Ò ngµy][¼ÓÈË¼äÈı±¶]")
    Talk(1, "no", "Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i 20·ÖÖÓµÄÈË¼äÖ÷ÌâÈÕÈı±¶×´Ì¬.")
end

function xm1()
    no()
    local itemID = GetTask(142)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local bHaveBuff = HaveIBBuff(xmBuff)
    local nBuffLevel = GetIBBuffLevel(xmBuff) + 1

    if (bHaveBuff > 0 and nBuffLevel ~= 1) then
        Talk(1, "no", "ThËt xin lçi, ÄãÉíÉÏÓĞÆäËû±¶ÊıµÄ×´Ì¬, Á½Õß²»¹²´æ")
        return
    end

    DelItemByID(itemID)
    AddIBBuff(xmBuff, 3600, 0)
    Msg2Player("Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i Ğ¡Ê±µÄÏÉÄ§ tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.")
    WriteLog("[Phï chñ §Ò ngµy][¼ÓÏÉÄ§Ë«±¶]")
    Talk(1, "no", "Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i Ğ¡Ê±µÄÏÉÄ§ tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.")
end

function xm2()
    no()
    local itemID = GetTask(142)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    local bHaveBuff = HaveIBBuff(xmBuff)
    local nBuffLevel = GetIBBuffLevel(xmBuff) + 1

    if (bHaveBuff > 0 and nBuffLevel ~= 2) then
        Talk(1, "no", "ThËt xin lçi, ÄãÉíÉÏÓĞÆäËû±¶ÊıµÄ×´Ì¬, Á½Õß²»¹²´æ")
        return
    end

    DelItemByID(itemID)
    AddIBBuff(xmBuff, 1200, 1)
    Msg2Player("Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i 20·ÖÖÓµÄÏÉÄ§Ö÷ÌâÈÕÈı±¶×´Ì¬.")
    WriteLog("[Phï chñ §Ò ngµy][¼ÓÏÉÄ§Èı±¶]")
    Talk(1, "no", "Äú³É¹¦Ê¹ÓÃPhï chñ §Ò ngµy, ¶Ò»»ÁË 1 c¸i 20·ÖÖÓµÄÏÉÄ§Ö÷ÌâÈÕÈı±¶×´Ì¬.")
end

function no()
    CloseDialog()
end;
