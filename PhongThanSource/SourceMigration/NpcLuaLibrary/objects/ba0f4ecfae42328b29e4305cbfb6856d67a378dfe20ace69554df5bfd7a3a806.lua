--description: ·çºíÕó´«ËÍÃÅ
--author: yangtao
--date: 2009-9-24

instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTaskByte(instence_Task, 1) == 10) then
        MsgBox("Theo t×nh b¸o tõ Thiªn Tù-Phong Hèng TrËn, §æng Thiªn Qu©n cã Thñ LÖnh cã thÓ biÕt tung tİch cña Ng­êi ném. Cöa chuyÓn tiÕp nµy sÏ ®­a b¹n vÒ T©y Kú, x¸c ®Şnh ®i?", "yes", "no")
    else
        MsgBox("Cöa chuyÓn tiÕp nµy sÏ ®­a b¹n vÒ T©y Kú, x¸c nhËn vµo?", "yes", "no")
    end
end

function yes()
    no()
    SetInstanceEnterFlag(3, 3)
    RemoveIBBuff(881)
    SetFightState(0)
    NewWorld(20, 1456, 3082)
end

function no()
    CloseDialog()
end