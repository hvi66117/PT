function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (GetIBBuffTimes(2094) >= 10) then
        Msg2Player("ÄúÉíÉÏÓĞÌ«¶à¸Ã×´Ì¬, ÇëÏÈÍê³ÉÏÉÄ§NhiÖm vô chñ ®Ò Ngµy, ÔÙÊ¹ÓÃ¸ÃµÀ¾ß.")
        return
    end

    DelItemByID(itemID)
    AddIBBuff(2094)
    Msg2Player("Äú³É¹¦Ê¹ÓÃÏÉÄ§Phï nhiÖm vô Chñ ®Ò ngµy.")
    WriteLog("[Phï chñ ®Ò ngµy Tiªn Ma][¼Óbuff]")
end

function no()
    CloseDialog()
end;
