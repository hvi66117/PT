Task_Mischief = 1357

hanguiID = 24
tianwuID = 16

function OnDeath(npcidx)
    local process = GetTaskByte(Task_Mischief, 1)
    if (process == 3 and GetMorphType() == 16) then
        PolyMorph(24, 1, 0, -1, 900)
        SetTaskByte(Task_Mischief, 1, 4)
        SetTaskByte(Task_Mischief, 4, 0)
        TopMessage("B¹n ®éi lèt cña <c=r>H¹n Quy ®Çu lÜnh<c>, c¶i trang thµnh <c=r>H¹n Quy<c>.")
        Msg2Player("B¹n ®éi lèt cña H¹n Quy ®Çu lÜnh, mau ®i trõ khö 30 Thiªn Ng«.")
    end

end

function no()
    CloseDialog()
end
