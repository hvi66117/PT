--description: Ìì¾ø´«µØÁÒÃÅ -¸±±¾
--author: yangyankun
--date: 2009/12/28
gIceBuff = { 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209 }

-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
TaskInfo_cbal = 1514
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 
--9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø 12=ÁìÈ¡ÁË³ı±©°²Á¼ÈÎÎñ 13=É±ËÀÔ¬Ìì¾ı 14=É±ËÀ½ğ¹âÊ¥Ä¸ 15=É±ËÀËïÌì¾ı 16=Íê³ÉÁË³ı±©°²Á¼ÈÎÎñ
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    if (GetTaskByte(instence_Task, 1) == 13) then
        MsgBox("Anh hïng cã thÓ t×m ra quy luËt thêi gian cña Hµn B¨ng TrËn qu¶ lµ ®¸ng nÓ, hiÖn “Kim Quang TrËn“ ®· më, nh­ng Kim Quang Th¸nh MÉu ph¸p lùc cao c­êng, b¹n muèn tiÕp tôc khiªu chiÕn?", "enterinstence", "no")
    else
        MsgBox("Cöa chuyÓn tiÕp nµy cã thÓ ®­a b¹n ®Õn Kim Quang TrËn, mét khi ®· chuyÓn tiÕp sÏ kh«ng thÓ quay vÒ Hµn B¨ng TrËn.", "enterinstence", "no")
    end
end

function enterinstence()
    CloseDialog()
    local pID = GetNpcTask(DialogNpcIdx, 0)
    if (pID == 0) then
        pID = GetNewInstanceId(5) -- ½ğ¹âÕó
        if (pID == 0) then
            InfoBox("T¹m thêi kh«ng t×m ®­îc Kim Quang TrËn, h·y thö l¹i sau.")--ruoting
            return 0
        end
        SetNpcTask(DialogNpcIdx, 0, pID)
    end

    -- ÒÆ³ıbuff
    for i = 1, getn(gIceBuff) do
        if (HaveIBBuff(gIceBuff[i]) > 0) then
            RemoveIBBuff(gIceBuff[i])
        end
    end
    --> add by yangyankun for ¸±±¾º®±ùÕó at 09-12-30
    RemoveIBBuff(1212)
    --< add by yangyankun for ¸±±¾º®±ùÕó at 09-12-30

    SetInstanceEnterFlag(4, 3)    -- modify by yangyankun at 09-12-31
    EnterInstance(pID, 1787, 3281)
end

function no()
    CloseDialog()
end