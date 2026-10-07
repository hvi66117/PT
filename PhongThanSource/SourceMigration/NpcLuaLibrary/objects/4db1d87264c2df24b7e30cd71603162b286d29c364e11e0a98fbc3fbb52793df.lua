--description: ½ğ¹âÕó´«ËÍÃÅ
--author: yangtao
--date: 2009/12/21

JINGUANG_BUFF = 1213    -- ½ğ¹âÕóµÄbuff±àºÅ

-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
TaskInfo_cbal = 1514
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 
--9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø 12=ÁìÈ¡ÁË³ı±©°²Á¼ÈÎÎñ 13=É±ËÀÔ¬Ìì¾ı 14=É±ËÀ½ğ¹âÊ¥Ä¸ 15=É±ËÀËïÌì¾ı 16=Íê³ÉÁË³ı±©°²Á¼ÈÎÎñ
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (GetTaskByte(instence_Task, 1) == 14) then
        MsgBox("Kim Quang Th¸nh MÉu ®· bŞ ®¸nh b¹i, nh­ng kh«ng ®Ó l¹i manh mèi vÒ Thñ LÖnh, cöa chuyÓn tiÕp nµy cã thÓ ®­a b¹n ®Õn §Şa Tù-Hãa HuyÕt TrËn, mét khi ®· chuyÓn tiÕp sÏ kh«ng thÓ quay vÒ Kim Quang TrËn, x¸c ®Şnh vµo?", "enterinstence", "no")
    else
        MsgBox("Cöa chuyÓn tiÕp nµy cã thÓ ®­a b¹n ®Õn §Şa Tù-Hãa HuyÕt TrËn, mét khi ®· chuyÓn tiÕp sÏ kh«ng thÓ quay vÒ Kim Quang TrËn, x¸c ®Şnh vµo?", "enterinstence", "no")
    end
end

function enterinstence()
    CloseDialog()
    local pID = GetNpcTask(DialogNpcIdx, 0)
    if (pID == 0) then
        -- ´«ËÍÈç»¯ÑªÕó
        pID = GetNewInstanceId(6)
        if (pID == 0) then
            InfoBox("T¹m thêi kh«ng t×m ®­îc Hãa HuyÕt TrËn, h·y thö l¹i sau.")
            return 0
        end
        SetNpcTask(DialogNpcIdx, 0, pID)
    end

    RemoveIBBuff(JINGUANG_BUFF)
    SetInstanceEnterFlag(5, 3)
    EnterInstance(pID, 1627, 3359)
end

function no()
    CloseDialog()
end