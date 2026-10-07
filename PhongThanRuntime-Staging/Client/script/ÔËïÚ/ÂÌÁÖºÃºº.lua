--description: ÂÌÁÖºÃºº
--author: yaoxin
--date: 2007/06/12
--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-14


--957:  1£¬½ÓÁ¸³µµÄÊ±¼ä£¬ 2 ½ÙÁ¸³µµÄÊ±¼ä£¬ Ê±¼ä¶¼ÊÇmod(£¬256)
Task_cure = 1229-- ÀÛ¼ÆÇå³ý×´Ì¬µÄ´ÎÊý

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    tasks = {
        { "Lôc l©m", "receive"; show = 0 },
        { "Kim Bµi Lôc L©m §¹o TÆc", "receive1"; show = 0 },
        { "Kh«i phôc tr.th¸i", "cure"; show = 0 },
    }
    if (HaveIBBuff(302) >= 1) then
        tasks[1].show = 1
    end ;

    -- Add By Zhang Jin for ÔËÁ¸ÓÅ»¯ at 2010-04-23 begin
    if (HaveIBBuff(1306) >= 1) then
        tasks[2].show = 1
    end ;
    -- Add By Zhang Jin for ÔËÁ¸ÓÅ»¯ at 2010-04-23 end

    if (HaveIBBuff(454) >= 1 or HaveIBBuff(455) >= 1 or HaveIBBuff(456) >= 1 or HaveIBBuff(457) >= 1) then
        tasks[3].show = 1
    end
    SayTask(13088, tasks)
end;

-- Add By Zhang Jin for ÔËÁ¸ÓÅ»¯ at 2010-04-23 begin
function receive1()
    if (HaveIBBuff(1306) >= 1) then
        local NowTime = mod(floor(LocalSystemTime() / 86400), 256)
        local LastTime = GetTaskByte(957, 2) --×îºóÒ»´Î½ÙÁ¸ÈÎÎñµÄÏµÍ³Ê±¼ä		
        local r = random(250, 500)
        local m1 = GetLevel() * r
        if (NowTime ~= LastTime) then
            SetTaskByte(957, 2, NowTime)
            m1 = m1 * 4
            Talk(1, "no", "Lôc L©m h¶o h¸n:Kh«ng hæ víi danh hiÖu “Kim Bµi Lôc L©m §¹o TÆc“! LÇn chÆn ®­êng ®Çu tiªn h«m nay lµm rÊt tèt, <c=r>" .. m1 .. "<c> l­îng, h·y nhËn chót t©m ý cña ta!")
        else
            Talk(1, "no", "Lôc L©m h¶o h¸n:Kh«ng hæ víi danh hiÖu “Kim Bµi Lôc L©m §¹o TÆc“! <c=r>" .. m1 .. "<c> l­îng, h·y nhËn chót t©m ý cña ta!")
        end ;

        RemoveIBBuff(1306)
        Earn(m1)
        TopMessage("B¹n nhËn ®­îc phÇn th­ëng <c=r>" .. m1 .. "<c> l­îng.")
        Msg2Player("B¹n nhËn ®­îc" .. m1 .. " b¹c, ®ång thêi mÊt danh hiÖu Kim Bµi Lôc L©m §¹o TÆc.")

        if (IsTongMember() > 0) then
            AddTongAttr(0, 2)
            Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\">Mang vÒ danh hiÖu “Kim Bµi Lôc L©m §¹o TÆc“ cho Lôc L©m h¶o h¸n, l·nh ®Þa nhËn ®­îc 2 ®iÓm H­ng thÞnh</bc>")
        end
    else
        Talk(1, "no", "Lôc L©m h¶o h¸n:Ng­¬i kh«ng cã danh hiÖu “Kim Bµi Lôc L©m §¹o TÆc“.")
    end
end;
-- Add By Zhang Jin for ÔËÁ¸ÓÅ»¯ at 2010-04-23 end

function receive()
    if (HaveIBBuff(302) >= 1) then
        local NowTime = mod(floor(LocalSystemTime() / 86400), 256)
        local LastTime = GetTaskByte(957, 2)--×îºóÒ»´Î½ÙÁ¸ÈÎÎñµÄÏµÍ³Ê±¼ä		
        local r = random(250, 500)
        local m1 = GetLevel() * r
        if (NowTime ~= LastTime) then
            SetTaskByte(957, 2, NowTime)
            m1 = m1 * 4
            Talk(1, "no", "Lôc L©m h¶o h¸n:ThËt kh«ng hæ danh hiÖu “Lôc L©m ®¹o tÆc“! LÇn chÆn ®­êng ®Çu tiªn h«m nay lµm rÊt tèt, <c=r>" .. m1 .. "<c> l­îng, h·y nhËn chót t©m ý cña ta!")
        else
            Talk(1, "no", "ThËt kh«ng hæ danh lµ Lôc l©m ®¹o tÆc! §©y <c=r>" .. m1 .. "<c> l­îng, h·y nhËn chót t©m ý cña ta!")
        end ;

        RemoveIBBuff(302)
        Earn(m1)
        TopMessage("B¹n nhËn ®­îc phÇn th­ëng <c=r>" .. m1 .. "<c> l­îng.")
        Msg2Player("B¹n nhËn ®­îc" .. m1 .. "l­îng, mÊt x­ng hiÖu Lôc l©m ®¹o tÆc!")

    else
        Talk(1, "no", 13089)
    end
end;

function no()
    CloseDialog()
end;

function cure()
    local nums = fgetNums()
    MsgBox("Muèn gi¶i trõ tr¹ng th¸i nµy, ph¶i cã <c=g>" .. nums .. "<c> ®iÓm Danh väng. Gi¶i trõ chø?", "yes_cure", "no")--liuying
end

function yes_cure()
    local nums = fgetNums()
    if (GetCredit() >= nums) then
        DecCredit(nums)
        for i = 1, 4 do
            if (GetIBBuffTimes(453 + i) >= 1) then
                CostIBBuff(453 + i, 1)
                break
            end
        end
        SetTask(Task_cure, GetTask(Task_cure) + 1)
        TopMessage("B¹n dïng" .. nums .. " ®iÓm Danh väng gi¶i trõ tr¹ng th¸i!")
        Msg2Player("Tr¹ng th¸i ®· ®­îc hñy")
        CloseDialog()
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ" .. nums .. " ®iÓm Danh väng, kh«ng thÓ gi¶i trõ tr¹ng th¸i!")
    end
end

function fgetNums()
    Item_cure = {    --´ÎÊý, ¿Û³ýÉùÍû
        [1] = { 1, 5 },
        [2] = { 2, 10 },
        [3] = { 3, 15 },
        [4] = { 4, 20 },
        [5] = { 5, 30 },
        [6] = { 6, 40 },
        [7] = { 7, 50 },
        [8] = { 8, 60 },
        [9] = { 9, 70 },
        [10] = { 10, 80 },
    }
    local realnums = GetTask(Task_cure) + 1
    for i = 10, 1, -1 do
        if (realnums >= Item_cure[i][1]) then
            return Item_cure[i][2]
        end
    end
    return Item_cure[1][2]
end
