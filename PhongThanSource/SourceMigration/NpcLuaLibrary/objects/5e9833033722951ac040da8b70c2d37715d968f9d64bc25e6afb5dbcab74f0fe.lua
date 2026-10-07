--ÑªÊé.lua
--author: jiaruoting
--date:2009/10/28

instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø
--2byte:0=Î´½Ó 1=½Ó 2=É±µØÁÒBOSS 3=½ÓÏŞÊ±É±·çºğ 4=Íê³É 
function main()
    CloseDialog()
    if (GetTaskByte(instence_Task, 2) == 0) then
        Talk(2, "no", GetName() .. ": §©y h×nh nh­ lµ th­ cÇu cøu göi cho Vâ V­¬ng, ch¾c ch¾n lµ do T­íng LÜnh Qu©n Chu bŞ nhèt trong trËn viÕt!", GetName() .. ": Ng­êi nµy ch¾c lµ x«ng vµo ThËp TuyÖt TrËn, bŞ yªu ma v©y khèn, e ®· kh«ng cßn toµn m¹ng!...İt nhÊt ta còng cã thÓ gióp y b¸o thï!")
        Msg2Player("C«ng ph¸ Thiªn Tù Tam TrËn, t×m ®­îc ng­êi ®· viÕt th­ cÇu cøu!")
        SetTaskByte(instence_Task, 2, 1)
        TaskNote(1206, 0)
        DelNormalItem(6, 1, 749, 0)
    else
        Talk(1, "no", GetName() .. ": Háng råi! Th­ cÇu cøu ®· bŞ giã thæi bay...")
        DelNormalItem(6, 1, 749, 0)
    end
end

function no()
    CloseDialog()
end