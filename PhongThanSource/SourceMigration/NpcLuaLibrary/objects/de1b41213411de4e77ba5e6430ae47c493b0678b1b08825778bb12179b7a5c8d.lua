--description: Ìì¾ø´«µØÁÒÃÅ -¸±±¾
--author: yaoxin
--date: 2009/9/7

instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    if (GetTaskByte(instence_Task, 1) == 8) then
        MsgBox("Thiªn Tù-Thiªn TuyÖt TrËn kh«ng t×m thÊy manh mèi, cöa chuyÓn tiÕp sÏ ®­a b¹n ®Õn Thiªn Tù-§Şa LiÖt TrËn, mét khi ®· chuyÓn tiÕp sÏ kh«ng thÓ quay vÒ Thiªn Tù-Thiªn TuyÖt TrËn.", "enterinstence", "no")
    else
        MsgBox("Cöa chuyÓn tiÕp nµy cã thÓ ®­a b¹n ®Õn Thiªn Tù-§Şa LiÖt TrËn, mét khi ®· chuyÓn tiÕp sÏ kh«ng thÓ quay vÒ Thiªn Tù-Thiªn TuyÖt TrËn.", "enterinstence", "no")
    end
end

function enterinstence()
    CloseDialog()
    local pID = GetNpcTask(DialogNpcIdx, 0)
    if (pID == 0) then
        pID = GetNewInstanceId(2)--µØÁÒÕó
        if (pID == 0) then
            InfoBox("T¹m thêi kh«ng t×m ®­îc Thiªn Tù-§Şa LiÖt TrËn, h·y thö l¹i sau.")--ruoting
            return 0
        end
        SetNpcTask(DialogNpcIdx, 0, pID)
    end
    RemoveIBBuff(867)
    SetInstanceEnterFlag(1, 3)
    EnterInstance(pID, 1688, 3179)
end

function no()
    CloseDialog()
end