--µØÁÒÕó´«ËÍÃÅ.lua
--author:GaoJingwei
--date:090929

instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTaskByte(instence_Task, 1) == 9) then
        MsgBox("Trong Thiªn Tù-§Şa LiÖt TrËn kh«ng cã manh mèi g×, cöa chuyÓn tiÕp nµy sÏ ®­a b¹n ®Õn Thiªn Tù-Phong Hèng TrËn, sau khi vµo sÏ kh«ng thÓ trë l¹i Thiªn Tù-§Şa LiÖt TrËn, x¸c nhËn vµo?", "enterinstence", "no")
    else
        MsgBox("Cöa chuyÓn tiÕp nµy sÏ ®­a b¹n ®Õn Thiªn Tù-Phong Hèng TrËn, sau khi vµo sÏ kh«ng thÓ trë l¹i Thiªn Tù-§Şa LiÖt TrËn, x¸c nhËn vµo?", "enterinstence", "no")
    end
end

function enterinstence()
    CloseDialog()
    local pID = GetNpcTask(DialogNpcIdx, 0)
    if (pID == 0) then
        pID = GetNewInstanceId(3)            --·çºğÕó
        if (pID == 0) then
            InfoBox("T¹m thêi kh«ng t×m thÊy Thiªn Tù-Phong Hèng TrËn, h·y thö l¹i sau.")
            return
        end
        SetNpcTask(DialogNpcIdx, 0, pID)
    end
    RemoveIBBuff(868)
    SetInstanceEnterFlag(2, 3)
    EnterInstance(pID, 1495, 3293)

end

function no()
    CloseDialog()
end