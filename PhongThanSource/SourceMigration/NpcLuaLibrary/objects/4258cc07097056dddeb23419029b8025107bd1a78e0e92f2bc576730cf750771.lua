--description: ºìÉ°Õó-µñÏñ
--author: liujifang
--date: 2010-10-29

--¸±±¾±äÁ¿£º
instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_Step = 30                         --¸±±¾½ø¶È(1É±ËÀÒ»²àµÄÌØÊâ¹Ö£¬2É±ËÀÁ½Ö»ÌØÊâ¹Ö£¬3É±ËÀÃùÉ³ÏÉ£¬4É±ËÀÉ³Áú£¬5É±ËÀÕÅÌì¾ı£¬6ÎäÍõËÀÍö)
instance_ShaHun_Num = 31                   --¾Ş´óÉ³»ê´æÔÚµÄ¸öÊı
instance_ShaLingLeft_Num = 32              --×ó²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊı
instance_ShaLingRight_Num = 33             --ÓÒ²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊı
instance_BossIdx = 34                      --1ºÅBOSSÃùÉ³ÏÉµÄindex
instance_DoorMid = 35                      --ÖĞ¼äµÄ×èµ²ÃÅ
instance_LastNpc = 36                      --36-40ÎªÎäÍõºÍµñÏñµÄindex
instance_WuWangBoss = 41                   --Õ½¶·ÎäÍõµÄindex
instance_TrapDoor = 42                     --42-44Õ½¶·ÎäÍõµÄindex
--¸±±¾±äÁ¿

--NPCTASK: 2=¼ÇÂ¼Ã¿´ÎË¢¹ÖµÄ¸öÊı£¬3=¼ÇÂ¼Í£Ö¹Ë¢¹ÖµÄÊ±¼ä£¬4=¼ÇÂ¼ÊÇ·ñÒÑ¾­Ë¢³ö2ºÅBOSS(1ÊÇ0·ñ)
--5=ÅĞ¶ÏÊÇ·ñ¿ÉÒÔË¢ºìÉ°ÕóÁé(0¿ÉÒÔ1²»¿ÉÒÔ)£¬6=¼ÇÂ¼Ë¢¹ÖµÄ´ÎÊı£¬


function main()
    --add by liujifang for ºìÉ°ÕóÓÅ»¯ at 2010-12-09 begin
    if (PlayerIndex < 0) then
        return
    end
    --add by liujifang for ºìÉ°ÕóÓÅ»¯ at 2010-12-09 end

    local mapid, x, y = GetWorldPos()

    if (isinarea(x, y) == 0) then
        MsgBox("B¹n x¸c nhËn muèn ®Õn khu trung t©m b¶o vÖ Vò V­¬ng chø?", "YesNewWorld", "no")
    else
        Talk(1, "no", "§¸nh b¹i Tr­¬ng Thiªn Qu©n míi cã thÓ më ®­îc cöa nµy.")
        return
    end

end;

function isinarea(x, y)
    local item = {
        [1] = { { 1623, 3229 }, { 1586, 3189 }, { 1625, 3149 }, { 1661, 3187 } },
    }
    local temp = {}
    local k, x1, key = 0, 0, 0

    temp = item[1]
    for j = 1, 4 do

        k = mod(j + 1, getn(temp) + 1)
        if (k == 0) then
            k = 1
        end
        if (temp[j][2] ~= temp[k][2]) then
            -- p1p2 Óë y=p0.yÆ½ĞĞ
            if (y >= min(temp[j][2], temp[k][2])) then
                --½»µãÔÚp1p2ÑÓ³¤ÏßÉÏ
                if (y < max(temp[j][2], temp[k][2])) then
                    --½»µãÔÚp1p2ÑÓ³¤ÏßÉÏ
                    --Çó½»µãx×ø±ê

                    if (temp[k][2] - temp[j][2] == 0) then
                        return 0
                    end

                    x1 = (y - temp[j][2]) * (temp[k][1] - temp[j][1]) / (temp[k][2] - temp[j][2]) + temp[j][1]

                    if (x1 > x) then
                        key = key + 1 --Ö»Í³¼Æµ¥±ß½»µã
                    end
                end
            end
        end
    end

    if (mod(key, 2) == 1) then
        return 1
    end

    return 0
end

function YesNewWorld()
    no()

    local nInstanceID, nLastEnterDate, nTodayEnterCount, nTotalEnterCount, nEnterFlag = GetInstanceEnterInfo(10)

    EnterInstance(nInstanceID, 1625, 3188)

end

function no()
    CloseDialog()
end