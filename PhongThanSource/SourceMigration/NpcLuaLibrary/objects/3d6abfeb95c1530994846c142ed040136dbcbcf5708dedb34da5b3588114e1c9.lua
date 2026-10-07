--description: ³¬¼¶ÔÂ±ı
--author: yangtao
--date: 2009/9/14

--------------------------- ÖĞÇï»î¶¯ added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:¼ÇÂ¼ÈÎÎñ½ø¶È 1:È¥¶ÄÍ½ÁìÈ¡Ä£¾ß 2:È¥²É¼¯3ÖÖ¹ûÊµ£¬È»ºóÈ¥³¯¸èÀñ¹Ù´¦¶Ò»»ÔÂ±ıÏÚ 
--                    3:È¥ÈıÉ½¹Ø´òÃæ·Û 4:È¥³¬¼¶ÔÂ±ı´¦ÁìÈ¡½±Àø 5:ÈÎÎñÍê³É
-- 2byte:¼ÇÂ¼ÈÎÎñ´ÎÊı
-- 3byte:Ê±¼ä´Á
-- 4byte:¼ÇÂ¼ÊÇ·ñÒÑ¾­ÔÚ³¬¼¶ÔÂ±ı´¦ÁìÈ¡¹ıÌØÊâ½±Àø
Gloal_zhongqiu_num = 257    -- ¼ÇÂ¼·şÎñÆ÷ËùÓĞÍæ¼ÒÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊı
TaskNote_zhongqiu = 1103
--------------------------- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14 -----------------------------

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end

function main()
    local tasks = {
        { "Ngäc thè b¹n phóc", "zhongqiu"; show = 0 },
        { "PhÇn th­ëng hËu hÜ", "ewaijiangli"; show = 0 },
    }
    local Year, Month, Day = GetYMD()
    if ((Year == 2009) and (Month == 10) and (Day >= 3) and (Day <= 15)) then
        tasks[1].show = 1
        tasks[2].show = 1
    end
    SayTask("§ªm trung thu, thiªn th­îng nh©n gian cïng th­ëng nguyÖt, Ngäc thè sø gi¶ muèn m­în søc mäi ng­êi chÕ t¹o quµ tÆng trung thu [B¸nh cung tr¨ng], ®Ó gi¶i nçi sÇu nhí nhµ cña H»ng Nga Tiªn Tö. Ng­êi ch¬i ®¹t cÊp 50 cã thÓ ®Õn TriÒu Ca t×m LÔ Quan tham gia ho¹t ®éng Ngäc thè b¹n phóc, ho¹t ®éng b¾t ®Çu tõ ngµy 3-10 ®Õn 8-10, lóc 18:00 ®Õn 24:00 mçi ngµy, thêi gian nhËn nhiÖm vô tr­íc 23:00!", tasks)
end

function no()
    CloseDialog()
end

function zhongqiu()
    local Progress = GetTaskByte(Task_zhongqiu, 1)
    if ((Progress == 4) and (HaveNormalItem(4, 273, 0, 1) >= 10) and (HaveNormalItem(4, 274, 0, 1) >= 1) and (HaveNormalItem(4, 275, 0, 1) >= 1)) then
        Talk(1, "no", "[B¸nh cung tr¨ng]:Chóc mõng, nhiÖm vô ®· hoµn thµnh!")
        SetTaskByte(Task_zhongqiu, 1, 5)
        ClearItem(4, 273, 0, 1)
        ClearItem(4, 274, 0, 1)
        ClearItem(4, 275, 0, 1)
        ClearItem(3, 144, 0, 0)
        ClearItem(3, 145, 0, 0)
        ClearItem(4, 193, 1, 1)
        local num = LoadIniInteger("Save_num_zhongqiu", 1) + 1
        SaveIniInteger("Save_num_zhongqiu", 1, num)
        TaskNote(TaskNote_zhongqiu, -1)
        AddNormalItemPile(4, 276, 0, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc 1 ThiÖp Ngäc Thè")
        if (1500 == num) then
            AddGlobalNews("Chóc mõng, ®· hoµn thµnh nhiÖm vô chÕ t¹o [B¸nh cung tr¨ng] Ngäc thè sø gi¶ giao cho, mäi ng­êi cã thÓ ®Õn chç [B¸nh cung tr¨ng] nhËn phÇn th­ëng, nh­ng tr­íc khi nhËn phÇn th­ëng, ph¶i hoµn thµnh 1 lÇn nhiÖm vô Ngäc thè b¹n phóc!")
        end
    else
        Talk(1, "no", "[B¸nh cung tr¨ng]:Ng­¬i ph¶i ®i TriÒu Ca gÆp LÔ Quan nhËn nhiÖm vô vµ thu thËp xong ®¹o cô råi ®Õn chç ta nhËn phÇn th­ëng!")
    end
end

function ewaijiangli()
    local num = LoadIniInteger("Save_num_zhongqiu", 1)
    if (num < 1500) then
        Talk(1, "no", "[B¸nh cung tr¨ng]:Nç lùc ch­a ®ñ, chØ hoµn thµnh <c=g>" .. num .. "<c> lÇn nhiÖm vô, hoµn thµnh <c=g>1500<c> lÇn nhiÖm vô míi ®­îc nhËn phÇn th­ëng hËu hÜ!")
    else
        if (GetTaskByte(Task_zhongqiu, 4) == 1) then
            Talk(1, "no", "[B¸nh cung tr¨ng]:H«m nay ng­¬i ®· nhËn phÇn th­ëng råi!")
            return
        end
        local Task_num = GetTaskByte(Task_zhongqiu, 2)
        local Process = GetTaskByte(Task_zhongqiu, 1)
        if ((Task_num < 1) or ((Task_num == 1) and (Process ~= 5))) then
            Talk(1, "no", "[B¸nh cung tr¨ng]:Ng­¬i ch­a hoµn thµnh nhiÖm vô h«m nay, hoµn thµnh xong h·y t×m ta nhËn th­ëng!")
            return
        else
            Talk(1, "no", "[B¸nh cung tr¨ng]:Chóc mõng, nhËn ®­îc phÇn th­ëng B¸nh cung tr¨ng trao tÆng!")
            local probability_yuebing = random(1, 99)
            if (probability_yuebing <= 33) then
                AddIBBuff(882)
            elseif (probability_yuebing <= 66) then
                AddIBBuff(883)
            else
                AddIBBuff(885)
            end
            SetTaskByte(Task_zhongqiu, 4, 1)
        end
    end
end