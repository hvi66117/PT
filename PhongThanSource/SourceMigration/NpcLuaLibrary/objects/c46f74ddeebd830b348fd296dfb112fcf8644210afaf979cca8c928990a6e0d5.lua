--ºµ¹êÍ·Áì.lua
--author: Gaojingwei
--date: 2009/03/25
---------Àë¼äÖ®¼Æ-----------
Task_Mischief = 1357  --1byte:0Ã»ÁìÈÎÎñ£»1£ºÁìÈ¡ÁË²¶×½ÈÎÎñ£»2£ºÍê³É²¶×½£¬ÁìÈ¡ÁË½±Àø£»3£ºÁìÈ¡ÁËÁÔÉ±ºµ¹êÊ×ÁìµÄÈÎÎñ£»4:ÒÑ±ä³Éºµ¹ê×´Ì¬£»5£ºÍê³ÉÈÎÎñ
--2byte:²¶×½ºµ¹êµÄ¸öÊı;3byte:²¶×½ÌìÎâµÄ¸öÊı£»4£ºÁÔÉ±ÌìÎâµÄ¸öÊı
hanguiID = 24        --ºµ¹êID
tianwuID = 16        --ÌìÎâID
---------Àë¼äÖ®¼Æ-----------


function OnDeath(npcidx)
    local process = GetTaskByte(Task_Mischief, 1)
    if (process == 3 and GetMorphType() == 16) then
        PolyMorph(24, 1, 0, -1, 900)
        SetTaskByte(Task_Mischief, 1, 4)        --±äÉíÎªºµ¹ê×´Ì¬
        SetTaskByte(Task_Mischief, 4, 0)
        TopMessage("B¹n ®éi lèt cña <c=r>Giang Quy ®Çu lÜnh<c>, c¶i trang thµnh <c=r>Giang Quy<c>.")
        Msg2Player("B¹n ®éi lèt cña Giang Quy ®Çu lÜnh, mau ®i trõ khö 30 Thiªn H¹o.")
    end

end

function no()
    CloseDialog()
end