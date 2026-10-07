function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (GetIBBuffTimes(1523) >= 10) then
        Msg2Player("Trªn ng­êi ®· cã qu¸ nhiÒu tr¹ng th¸i nµy, h·y hoµn thµnh nhiÖm vô chñ ®Ò ngµy, míi cã thÓ sö dông vËt phÈm nµy.")
        return
    end

    DelItemByID(itemID)
    AddIBBuff(1523)
    Msg2Player("Sö dông thµnh c«ng phï nhiÖm vô chñ ®Ò ngµy")
    WriteLog("[Phï nhiÖm vô Chñ ®Ò ngµy][¼Óbuff]")
end

function no()
    CloseDialog()
end;
