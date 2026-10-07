--description:Ò½ÉúÏÉ
--author: lijing
--date:2009/3/26

-------------------------------Óü·¨É½Ö§Ïß-------------------------------
Task_Total_Times = 1460    --ÀÛ¼ÆÈÎÎñ´ÎÊı
Task_zhixian = 1471 --1byte£º1½ÓÈÎÎñ£¬2ÕÒ¶¾À¼²İ£¬3ÕÒÁúÉàÀ¼£¬4ÕÒµ½2¶ä»¨£¬5µ÷Åä£¬6Íê³ÉÖ§ÏßÒ»£»
-- 8½ÓÊ§ÂäÖ®Êé£¬9»ñµÃ¹ÅÍ¼²ĞÆ¬£¬10Íê³ÉÖ§Ïß¶ş
--11½ÓÒÔ¾Æ»áÓÑ£¬12µÚÒ»´ÎÓëÙÈ×ÓÃ÷¶Ô»°£¬13ÃÜÌ½¸æÖªÒÔ¾Æ»áÓÑ£¬14ÓëÙÈ×ÓÃ÷Æ´¾Æ£¬15Íæ¼ÒÊ§°Ü£¬16Íæ¼ÒÊ¤³ö£¬17Íê³ÉÖ§ÏßÈı
--2byte:´ğÌâ¶ÔµÄ´ÎÊı
--3byte:´ğÌâ´íµÄ´ÎÊı
Task_stone = 1472  --¼ÇÂ¼Íæ¼ÒËùÍÆ¾ŞÊ¯Ë÷Òı

--------------------Task_OutoftreeÎªÓü·¨É½Ö§ÏßÈÎÎñÈı---½ÚÍâÉúÖ¦--------------------------------------------
--------------------------Author£ºlitao  date:09/06/09------------------------------------------------------
Task_Outoftree = 1478 --1Byte£º1½ÓÈÎÎñ£¬2¶Ô»°Ğ¥À×£¬3Ê¹ÓÃ·âÓ¡Ö®¾³²¢ÇÒ¶Ô»°¶¡»Õ£¬4ÁÔÉ±Ä§ÎïÖ®»ê£¬5·âÓ¡Ö®¾³¶Ô»°²¢ÁìÈ¡½±Àø£¬6Íê³É½ÚÍâÉúÖ¦£¬6·âÓ¡Ğ¥À×£¬7¶Ô»°¶¡»Õ£¬
--8Ê¹ÓÃ·âÓ¡Ö®¾µ²¢É±Ğ¥À×£¬9¶Ô»°ÏÉÄ§ÃÜÌ½²¢Íê³É·âÓ¡Ö®¾µÈÎÎñ
--2Byte£º0Î´²¶É±µ½³Ë»ÆµÄÄ§ÎïÖ®»ê£¬1ÒÑ¾­²¶É±³Ë»ÆµÄÄ§ÎïÖ®»ê
--3Byte£º0Î´²¶É±µ½ÀæÁéµÄÄ§ÎïÖ®»ê£¬1ÒÑ¾­²¶É±ÀæÁéµÄÄ§ÎïÖ®»ê
--4Byte£º0Î´²¶É±µ½É½ ûµÄÄ§ÎïÖ®»ê£¬1ÒÑ¾­²¶É±É½ ûµÄÄ§ÎïÖ®»ê

--1481±äÁ¿£¬Èç¹ûÎª0±íÊ¾Íæ¼ÒÃ»ÓĞ½ÓÏÉÄ§½ç³âºòÈÎÎñ£¬Èç¹ûÎª1Ôò±íÊ¾ÒÑ¾­½ÓÁËÏÉÄ§½ç³âºò£¬¿ÉÒÔµ½ÏÉÄ§½çÃÜÌ½ÁìÈ¡ĞŞÎª½±Àø,2ÁìÈ¡ÁË½±Àø


CONST_MIRROR_EQUIP = {
    --1Îª¼×Ê¿Ğ¡ÈıÑù
    {
        { name = "Th¸nh DiÖu Kh«i", item = { 0, 7, 18, 1, 0, 1, 1 }, ratio = 1 },
        { name = "Th¸nh DiÖu Yªu ®¸i", item = { 0, 6, 18, 1, 0, 1, 1 }, ratio = 2 },
        { name = "Th¸nh DiÖu ChiÕn ngoa", item = { 0, 5, 18, 1, 0, 1, 1 }, ratio = 3 },
    },
    --2ÎªµÀÊ¿Ğ¡ÈıÑù
    {
        { name = "H­ Nghi qu¸n", item = { 0, 7, 19, 1, 0, 1, 1 }, ratio = 1 },
        { name = "H­ Nghi C©n", item = { 0, 6, 19, 1, 0, 1, 1 }, ratio = 2 },
        { name = "H­ Nghi Lı", item = { 0, 5, 19, 1, 0, 1, 1 }, ratio = 3 },
    },
    --3ÎªÒìÈËĞ¡ÈıÑù
    {
        { name = "Loan Vò Trô", item = { 0, 7, 20, 1, 0, 1, 1 }, ratio = 1 },
        { name = "Loan Vò Yªu ®¸i", item = { 0, 6, 20, 1, 0, 1, 1 }, ratio = 2 },
        { name = "Loan Vò Ngoa", item = { 0, 5, 20, 1, 0, 1, 1 }, ratio = 3 },
    },

}
------------------------------------------------------------------------------------------------------------

-- Added by luoyixuan at 0901228 begin
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --Ê§ÂäÖ®Êé
    startLevel = 51
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetJusticEvilCredit() < 0 and GetTaskByte(Task_zhixian, 1) == 7) then
                state = 1
                subState = 0
            elseif (GetJusticEvilCredit() < 0 and GetTaskByte(Task_zhixian, 1) == 9) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetJusticEvilCredit() < 0 and GetTaskByte(Task_zhixian, 1) == 7) then
                state = 1
                subState = 1
            elseif (GetJusticEvilCredit() < 0 and GetTaskByte(Task_zhixian, 1) == 9) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÒÔ¾Æ»áÓÑ
    startLevel = 53
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() < 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(Task_zhixian, 1) == 10) then
                state = 1
                subState = 0
            elseif (GetTaskByte(Task_zhixian, 1) == 12 or (HaveIBBuff(692) > 0 and GetTaskByte(Task_zhixian, 1) == 16)) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_zhixian, 1) >= 11 and GetTaskByte(Task_zhixian, 1) <= 16) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_zhixian, 1) == 10) then
                state = 1
                subState = 1
            elseif (GetTaskByte(Task_zhixian, 1) == 12 or (HaveIBBuff(692) > 0 and GetTaskByte(Task_zhixian, 1) == 16)) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_zhixian, 1) >= 11 and GetTaskByte(Task_zhixian, 1) <= 16) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --¹ÅÍ¼ÖØÉú
    startLevel = 55
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(Task_zhixian, 1) == 17 and GetJusticEvilCredit() < 0) then
                state = 1
                subState = 0
            elseif ((GetTaskByte(Task_zhixian, 1) == 19 and GetJusticEvilCredit() < 0) or (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0)) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_zhixian, 1) == 17 and GetJusticEvilCredit() < 0) then
                state = 1
                subState = 1
            elseif ((GetTaskByte(Task_zhixian, 1) == 19 and GetJusticEvilCredit() < 0) or (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0)) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ÚÍâÉúÖ¦Òıµ¼ÈÎÎñ
    startLevel = 57
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() < 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(1481, 1) == 1 and GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(1481, 1) == 1 and GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ÚÍâÉúÖ¦
    startLevel = 59
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() < 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 1
                subState = 0
            elseif (GetPlayerExtLevel() == 59) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 1
                subState = 1
            elseif (GetPlayerExtLevel() == 59) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ÚÍâÉúÖ¦
    startLevel = 60
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() < 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(Task_Outoftree, 1) == 9) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_Outoftree, 1) < 9) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_Outoftree, 1) == 9) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_Outoftree, 1) < 9) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --¸¯»¨Ö®¶¾
    startLevel = 50
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() < 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskByte(Task_zhixian, 1) == 6) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_zhixian, 1) == 6) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- Added by luoyixuan 091228 end

function main()
    local tasks = {
        --		{"ÂòÂôÎïÆ·","buy"; show = 1 },
        { "DÜ Töu Héi H÷u", "wine_friend"; show = 0 },
        { "ThÊt l¹c chi th­", "lost_book"; show = 0 },
        { "Phï hoa chi ®éc", "flower_Talk"; show = 0 },
        { "Cæ §å Trïng Sinh", "gutuchongsheng"; show = 0 },
        { "TiÕt ngo¹i sinh chi", "outof_tree"; show = 0 },
        { "Phong Ên chi kİnh", "pressurize_mirror"; show = 0 },
        --		{"È¡ÏûÈÎÎñ", "quxiao"; show = 0},   --Add by liyudong at 2009-11-11
    }

    -- Added by liuzhiqiang at 2009-5-27 Begin---------ÒÔ¾Æ»áÓÑ
    local zhixian_step = GetTaskByte(Task_zhixian, 1)
    if ((zhixian_step == 10 or zhixian_step == 12 or (HaveIBBuff(692) > 0 and zhixian_step == 16)) and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() < 0) then
        tasks[1].show = 1
    end
    -- Added by liuzhiqiang at 2009-5-27 End-----------ÒÔ¾Æ»áÓÑ

    -- Added by liuzhiqiang at 2009-6-2 Begin---------Ê§ÂäÖ®Êé
    if ((zhixian_step == 7 or zhixian_step == 9) and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() < 0) then
        tasks[2].show = 1
    end
    -- Added by liuzhiqiang at 2009-6-2 End-----------Ê§ÂäÖ®Êé

    -- Added by JRT at 2009-6-2 Begin---------¸¯»¨Ö®¶¾
    if (zhixian_step == 6) and (GetPlayerExtLevel() >= 50 and GetJusticEvilCredit() < 0) then
        tasks[3].show = 1
    end
    -- Added by JRT at 2009-6-2 End-----------¸¯»¨Ö®¶¾

    -- Added by ZQ at 2009-6-2 Begin---------¹ÅÍ¼ÖØÉú
    if (zhixian_step == 17 or zhixian_step == 19) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        tasks[4].show = 1
    end

    if (zhixian_step == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        tasks[4].show = 1
    end
    -- Added by ZQ at 2009-6-2 End-----------¹ÅÍ¼ÖØÉú

    --Added  by LT at 09-06-09 Begin ------------½ÚÍâÉúÖ¦
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)--»ñÈ¡µ±Ç°ÈÎÎñËùÔÚ²½Öè
    if ((GetPlayerExtLevel() >= 59 or GetTaskByte(1481, 1) == 1) and Outoftree_step == 0 and GetJusticEvilCredit() < 0) then
        --------½ÚÍâÉúÖ¦£¨£¨¼¶±ğ´óÓÚ58£¬Íê³ÉÇ°ĞòÈÎÎñ£©»òÕß£¨½ÓÊÜÁËÏÉ/Ä§½ç³âºòÈÎÎñ£©£©²¢ÇÒÎªÏÉÕóÓª
        tasks[5].show = 1
    end
    --Added  by LT at 09-06-09 End-------------½ÚÍâÉúÖ¦

    --Added  by LT at 09-06-09 Begin ------------·âÓ¡Ö®¾µ
    if GetPlayerExtLevel() >= 60 and Outoftree_step == 9 and GetJusticEvilCredit() < 0 then
        --------·âÓ¡Ö®¾µ£¨¼¶±ğ´óÓÚ59£¬Íê³ÉÇ°Ğò²½Öè£©
        tasks[6].show = 1
    end
    --Added  by LT at 09-06-09 End

    -- Added by liyudong at 2009-11-11 Begin---------È¡ÏûÈÎÎñ
    --	if( ( zhixian_step == 11 or zhixian_step == 12 or zhixian_step == 13 or zhixian_step == 14 or zhixian_step == 15 or zhixian_step == 16 ) and GetJusticEvilCredit() < 0 ) then
    --		tasks[7].show = 1
    --	end
    -- Added by liyudong at 2009-11-11 End-----------È¡ÏûÈÎÎñ

    --Add By Guoqun for Bug fsb00034066 at 2011-02-23 Begin
    if GetTaskByte(Task_Outoftree, 1) == 10 and GetTaskByte(1481, 1) == 1 then
        ClearItem(6, 1, 524, 0)
        SetTaskByte(1481, 1, 2)
        TaskNote(108, -1)
    end
    --Add By Guoqun for Bug fsb00034066 at 2011-02-23 End 

    SetTask(142, DialogNpcIdx)

    SayTask("kh«ng ai cã thÓ thÊy ®­îc ta …", tasks)
end;

-- Added by liuzhiqiang at 2009-5-27 Begin---------ÒÔ¾Æ»áÓÑ

function wine_friend()
    CloseDialog()

    if (GetTaskByte(Task_zhixian, 1) == 10 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() < 0) then
        Talk(3, "no", "Theo ®iÒu tra cña ta, m¶nh thø 2 Cæ §å Tµn PhiÕn cã lÏ trong tay <c=r>YÓn Tö Minh<c> ng­êi bé l¹c Di Ph­¬ng. Ng­êi bé l¹c Di Ph­¬ng n¾m gi÷ trong tay bİ mËt cña thÇn binh Ngôc Ph¸p S¬n, ta nghÜ tr­íc tiªn ng­¬i nªn lÊy ®­îc lßng tİn nhiÖm cña hä sau ®ã míi t×m tung tİch cña Tµn PhiÕn cã lÏ sÏ dÔ dµng h¬n.", GetName() .. "Lµm sao ®Ó cã ®­îc lßng tin cña hä?", "Ta nghe nãi ®¹i phu <c=r>YÕn Phong<c> bé l¹c Di Ph­¬ng ®ang cÇn ng­êi gióp ®ì, ®©y cã thÓ lµ c¬ héi tèt cho ng­¬i.")
        Msg2Player("Hoµn thµnh nhiÖm vô tuÇn hoµn cña YÓn Phong, tranh thñ sù tin t­ëng cña téc nh©n bé l¹c Di Ph­¬ng.")
        TaskNote(106, 2)
        SetTaskByte(Task_zhixian, 1, 11)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 12 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() < 0) then
        Talk(1, "no", "xem ra tµn phiÕn qu¶ thËt Èn giÊu bİ mÊt cña thÇn binh, ta nghe nãi <c=r>YÓn Tö Minh<c> rÊt thİch uèng r­îu, cã thÓ r­îu sÏ lµm h¾n nãi ra sù thËt.", GetName() .. " §Õn ®©u míi t×m ®­îc r­îu ngon?", "Cã thÓ ng­¬i kh«ng biÕt, <c=r>YÕn Phong<c> chİnh lµ mét cao thñ nÊu r­îu, <c=g>Thanh Hoa Töu<c> mµ h¾n nÊu ra, h­¬ng vŞ cùc nång nµn, ta cßn nghe nãi h¾n th­êng tÆng r­îu cho ng­êi ®· gióp anh ta.")
        Msg2Player("Hoµn thµnh nhiÖm vô tuÇn hoµn cña YÓn Phong, cã thÓ nhËn ®­îc Thanh Hoa Töu.")
        TaskNote(106, 5)
        SetTaskByte(Task_zhixian, 1, 13)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 16 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() < 0 and HaveIBBuff(692) > 0) then
        local npcMapid, x, y = GetNpcWorldPos(GetTask(Task_stone))
        local distance = floor(((1795 - x) ^ 2 + (3361 - y) ^ 2) ^ 0.5 * 32)
        if (distance > 400) then
            Msg2Player("HuyÒn Th¹ch c¸ch MËt Th¸m Ma Giíi qu¸ xa.")
        else
            Talk(1, "no", "Lµm tèt l¾m! Ta sÏ thi ph¸p më ra m¶nh ThÊt Th¸i HuyÒn Th¹ch nµy, ®©y lµ phÇn th­ëng cña ng­¬i. TiÕp theo ta cÇn ®iÒu tra tung tİch cña m¶nh Tµn PhiÕn cuèi cïng, ng­¬i ®¹t cÊp 55 h·y ®Õn t×m ta")

            local addexp = AddOwnExtendExp(3600000)
            TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
            Msg2Player("Hoµn thµnh DÜ Töu Héi H÷u, nhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")

            TaskNote(106, -1)
            TaskNote(107, 0)
            RemoveIBBuff(692)
            SetTaskByte(Task_zhixian, 1, 17)
            DelNpc(GetTask(Task_stone))
            -- Added by luoyixuan 091228 begin
            refreshNpcTaskState()
            -- Added by luoyixuan 091228 end
        end
    end
end

-- Added by liuzhiqiang at 2009-5-27 End-----------ÒÔ¾Æ»áÓÑ

-- Added by liuzhiqiang at 2009-6-2 Begin---------Ê§ÂäÖ®Êé

function lost_book()
    CloseDialog()

    local zhixian_step = GetTaskByte(Task_zhixian, 1)
    if (zhixian_step == 7 and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() < 0) then
        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "Hµnh trang kh«ng ®ñ chç, s¾p xÕp råi h·y quay l¹i.")
        else
            Talk(3, "no", "Ta ®· ®iÒu tra ®­îc mét vµi tung tİch m¶nh Tµn PhiÕn thø nhÊt, xung quanh Ngôc Ph¸p S¬n cã 4 täa <c=r>Ph¸p trô<c>, nh÷ng <c=r>Ph¸p trô<c> nµy ®­îc mét sè <c=r>Thñ Hé Thó<c> b¶o vÖ, trªn ng­êi chóng cã thÓ cã mang theo  <c=g>Cæ §å Tµn PhiÕn<c>", GetName() .. " Sao ta ch­a bao giê thÊy <c=r>Thñ Hé Thó<c> mµ ng­¬i nãi ®Õn?", "Nh÷ng <c=r>Thñ Hé Thó<c> nµy th«ng th­êng chóng kh«ng xuÊt hiÖn, trõ khi Ph¸p trô bŞ uy hiÕp bªn ngoµi. Ta cã m¶nh <c=g>Hµm Long Ph­ín<c>, cã thÓ m­în nã dÉn dô chóng xuÊt hiÖn.")
            SetTaskByte(Task_zhixian, 1, 8)
            SetSubTask(105, 1, 1)
            ClearItem(6, 1, 523, 0)
            AddNormalItem(6, 1, 523, 0, 0, 0) --º³Áúá¦que
            TaskNote(105, 2)
            -- Added by luoyixuan 091228 begin
            refreshNpcTaskState()
            -- Added by luoyixuan 091228 end
        end
        return
    end

    if (zhixian_step == 9 and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() < 0) then

        if (HaveNormalItem(4, 257, 0, 1) == 0) then
            Talk(1, "no", "H·y mang <c=g>Cæ §å Tµn PhiÕn <c> vÒ gÆp ta.")
            return
        end

        Talk(1, "no", "Tèt l¾m nh­ vËy lµ chóng ta cã ®­îc 2 m¶nh <c=g>Cæ §å Tµn PhiÕn<c> råi, phÇn th­ëng nµy ng­¬i h·y nhËn lÊy. Giê ®©y ta cÇn chót thêi gian ®Ó ®iÒu tra tóng tİch cña nh÷ng Tµn PhiÕn kh¸c, h·y ®¹t ®Õn cÊp 53 råi quay l¹i t×m ta")

        SetTaskByte(Task_zhixian, 1, 10)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        local addexp = AddOwnExtendExp(2200000)
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh ThÊt l¹c chi th­, nhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")
        SetSubTask(105, -1, 1)
        TaskNote(105, -1)
        TaskNote(106, 0)

        ClearItem(4, 257, 0, 1) --²ĞÆ¬
        ClearItem(6, 1, 523, 0) --º³Áúá¦
    end
end

-- Added by liuzhiqiang at 2009-6-2 End-----------Ê§ÂäÖ®Êé

-- Added by ZQ at 2009-6-2 End-----------¹ÅÍ¼ÖØÉú
function gutuchongsheng()
    CloseDialog()
    --½ÓÈÎÎñ
    if (GetTaskByte(Task_zhixian, 1) == 17) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        Talk(1, "book", "Tung tİch cña m¶nh tµn phiÕn cuèi cïng ta còng ®· cã ®­îc råi, nh­ng vÊn ®Ò lÇn n÷a e r»ng cã chót khã kh¨n …", GetName() .. " VËy m¶nh tµn phiÕn cuèi cïng hiÖn ®ang ë ®au?", "Ng­êi trong tiªn giíi còng ®ang truy t×m Ngôc Ph¸p ThÇn Binh, Cæ §å Tµn PhiÕn cuèi cïng còng bŞ chóng giµnh lÊy råi, c¸ch ®©y kh«ng xa cã 1 Ët Th¸m Tiªn Giíi, chİnh h¾n ®ang n¾m gi÷ tµn phiÕn.")
        return 0
    end
    if (GetTaskByte(Task_zhixian, 1) == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        TaskNote(107, 3)
        return 0
    end
    --½»ÈÎÎñ
    if (GetTaskByte(Task_zhixian, 1) == 19) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        if (HaveNormalItem(4, 257, 0, 1) == 0) then
            Talk(1, "no", "H·y mang <c=g>Cæ §å Tµn PhiÕn <c> vÒ gÆp ta.")
            return
        end

        Talk(1, "no", "ThËt lµ lîi h¹i, ng­¬i qu¶ nhiªn cã thÓ chÕ phôc ®­îc ng­êi ®ã, ®o¹t vÒ tµn phiÕn! Ng­¬i gióp Ma giíi chóng ta thu ®­îc Ngôc Ph¸p ThÇn Binh lµ lËp ®­îc c«ng lín! §©y lµ phÇn th­ëng thËt xøng ®¸ng víi ng­¬i!")
        SetTaskByte(Task_zhixian, 1, 20)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        local addexp = AddOwnExtendExp(6000000)
        --¼ÓÀ¶É«×°±¸
        if (random(1, 2) == 1) then
            AddBlueEquip(0, 2, GetPlayerType() + 18, 1, 0, 0, 1) --ÒÂ·ş
        else
            AddBlueEquip(0, 9, GetPlayerType() + 18, 1, 0, 0, 1) --Åû·ç
        end

        TopMessage("NhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")
        Msg2Player("Hoµn thµnh Cæ §å Trïng Sinh, nhËn ®­îc" .. addexp .. " kinh nghiÖm vµ 1 trang bŞ xanh.")

        TaskNote(107, -1)

        ClearItem(4, 257, 0, 1) --²ĞÆ¬
        return
    end

    --ÃÜÌ½±äÉí
    if (GetTaskByte(Task_zhixian, 1) == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        Talk(1, "book2", "Ng­êi cña Tiªn giíi? Hõ, h·y nh©n lóc ta ch­a ®éng thñ th× biÕn khái ®©y mau.", GetName() .. "ThËt ng«ng cuång, h«m nay ta ®Õn ®Ó cho ng­¬i 1 bµi häc! Nh­ng nÕu ng­¬i ngoan ngo·n giao nép Tµn PhiÕn Cæ §å, ta cã thÓ tha cho!", "Cì ng­¬i ­? Muèn ®Õn thö kh«ng!")
    end
end

function warmitanmo(warmitanIdx, dlgIndex)
    SetNpcScript(warmitanIdx, "\\script\\¹ÖÎï\\Õ½¶·ÃÜÌ½Ä§»ÙÃğ.lua")
    SetNpcTimer(warmitanIdx, "\\script\\ontimer\\Õ½¶·ÃÜÌ½×Ô¼ì.lua", 60)--¸øÕ½¶·NPC¼ÓÒ»·ÖÖÓONTIMER
    SetNpcName(warmitanIdx, "MËt th¸m Ma giíi")
    SetNpcCamp(warmitanIdx, 4)

    SetNpcTask(warmitanIdx, 1, 1)--¼ÇÂ¼³õÊ¼ÂÖÑ¯´ÎÊı£¨ÈÎÎñ±äÁ¿£©--1
    SetNpcTask(warmitanIdx, 2, GetNpcLife(warmitanIdx))--»ñµÃµ±Ç°ÑªÁ¿£İ¼ÇÂ¼³õÊ¼ÑªÁ¿£¨ÈÎÎñnpc±äÁ¿£©
    SetNpcTask(warmitanIdx, 3, dlgIndex) --±£´æ¶Ô»°NPC INDEX
end

function flower_Talk()
    CloseDialog()
    Talk(4, "no", GetName() .. "Ng­¬i lµ ai? Cã m­u ®å g×?", "Th× ra lµ ng­êi cña Ma giíi gièng nh­ ta. Ch¾c r»ng ng­¬i còng biÕt lµ gÇn ®©y cã tin lan truyÒn r»ng xuÊt hiÖn thÇn binh trªn Ngôc Ph¸p S¬n, ta ®ang phông mÖnh ®Òu tra viÖc nµy.", GetName() .. " Ra vËy, thø lçi ®· m¹o ph¹m.", "kh«ng sao, kh«ng sao. H«m tr­íc ta t×nh cê cã ®­îc 1 m¶nh Cæ §å Tµn PhiÕn, cã liªn quan ®Õn thÇn binh, hiÖn ta ®ang ®iÒu tra tung tİch cña c¸c m¶nh tµn phiÕn kh¸c, nÕu ng­¬i cã tiÖn sau nµy ®¹t ®Õn cÊp 51 h·y ®Õn trî gióp ta t×m Cæ §å Tµn PhiÕn.")
    SetTaskByte(Task_zhixian, 1, 7)
    SetSubTask(104, -1, 1)
    TaskNote(104, -1)
    TaskNote(105, 0)
    -- Added by luoyixuan 091228 begin
    refreshNpcTaskState()
    -- Added by luoyixuan 091228 end
end

function book()
    Talk(2, "no", GetName() .. " kh«ng lÏ lµ ng­êi cña Tiªn giíi, xin ®îi vµi kh¾c ®Ó ta ®i d¹y chóng mét bµi häc, ®o¹t vÒ tµn phiÕn.", "xin ®õng qu¸ s¬ ı, ng­êi nµy kh«ng dÔ ®èi phã, víi søc 1 ng­êi ta e r»ng khã lßng ®Şch l¹i, tèt nhÊt nªn t×m vµi ®ång ®åi cïng ®i.")
    TaskNote(107, 2)
    SetTaskByte(Task_zhixian, 1, 18)
    -- Added by luoyixuan 091228 begin
    refreshNpcTaskState()
    -- Added by luoyixuan 091228 end
end

function book2()
    CloseDialog()
    MsgBox(GetName() .. "Tèt l¾m, vËy ta h·y thö 1 chót!", "book1", "no")
end

function book1()
    CloseDialog()
    local npcindex = GetTask(142)
    if (GetNpcTemplateID(npcindex) ~= 1014) then
        return 0
    end
    local warmitanIdx = AddNpc(1105, 65, SubWorld, 1795 * 32, 3361 * 32)--ADDÕ½¶·NPC
    Msg2CurMapAnnounce("§¹o h÷u Ma giíi h·y mau ®Õn gióp ta!")
    warmitanmo(warmitanIdx, npcindex)
    CaptureNpc(npcindex)--KILL¶Ô»°NPC

    --ÕóÓª±ä»»
    if (GetTeam() == 0) then
        if (GetJusticEvilCredit() > 0) then
            if (GetTaskByte(Task_zhixian, 1) == 18) then
                SetCamp(3)
            end
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0) then
                SetCamp(3)
            end
        end
        PlayerIndex = oldPlayer
    end
end
-- Added by ZQ at 2009-6-2 End-----------¹ÅÍ¼ÖØÉú

---Task Name£º½ÚÍâÉúÖ¦----------------
--Adde  by LT
--Time:09-06-09
-------------------------------------½ÚÍâÉúÖ¦--Begin ----------------
function outof_tree()
    CloseDialog()
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)--»ñÈ¡µ±Ç°ÈÎÎñËùÔÚ²½Öè
    if (GetTaskByte(1481, 1) == 1) then
        --Èç¹û½ÓÁËÏÉÄ§½ç³âºòÈÎÎñ£¬Ôò¸øÓë¾­Ñé½±Àø
        Talk(3, "no", "Kh«ng biÕt anh hïng ®Õn ®©y cã viÖc g×?", GetName() .. " ¸i dµ, kİnh nµy do 1 vŞ ®ång ®¹o ®· ñy th¸c ta, nhê ta b¸o ®Õn c¸c h¹ r»ng khi anh ta ®ang t×m kiÕm thÇn binh th× bŞ mét ng­êi lai lŞch bÊt minh tËp kİch, cæ ®å còng bŞ ®o¹t ®i.", "Ra vËy, ta nhÊt ®Şnh ph¶i t×m ra kÎ ng«ng cuång nµy, b¸o thï cho ®¹o h÷u. Anh hïng ®¹t cÊp 59 th× quay l¹i t×m ta, cïng bµn kÕ ho¹ch phôc thï.")
        --ĞèÒªÈôÍ¦Ôö¼ÓĞŞÎª½±Àø
        local addexp = AddOwnExtendExp(850000)
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")
        ClearItem(6, 1, 524, 0)
        --½«ÏÉÄ§½ç³âºòµÄÈÎÎñ±äÁ¿ÖÃÎª²»ÄÜÔÙ²ÎÓë½ÚÍâÉúÖ¦
        SetTaskByte(1481, 1, 2)
        TaskNote(108, 20)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end

    if (Outoftree_step == 0) then
        Talk(3, "tree3", "¸i dµ, Ngôc Ph¸p S¬n qu¶ nhiªn lµ vïng ®Êt thŞ phi! ViÖc truy t×m Ngôc Ph¸p ThÇn Binh lu«n gÆp trë ng¹i.", GetName() .. "Tiªn sinh ®ang nãi ®Õn viÖc Cæ ®å bŞ c­íp ph¶i kh«ng.", "xem ra anh hïng còng ®· nghe tin ®ån, ng­êi hung ¸c Ngôc Ph¸p S¬n c¶ gan sat th­¬ng ®¹o h÷u ®ang trªn ®­êng t×m ThÇn Binh, c­íp ®i cæ ®å ghi chĞp tung tİch cña thÇn binh …")
    end
end

function tree1()
    CloseDialog()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "M¶nh kİnh cæ nµy ®o¹t ®­îc tõ ng­êi ®ã, cã thÓ sÏ gióp ng­¬i ®­îc vµo viÖc g× ®ã, nh­ng hiÖn giê hµnh trang cña ng­¬i ®· ®Çy ta kh«ng thÓ giao nã cho ng­¬i ®­îc.")
        return
    else
        Talk(1, "no", "M¶nh kİnh cæ nµy ®o¹t ®­îc tõ ng­êi ®ã, cã thÓ sÏ gióp ng­¬i ®­îc vµo viÖc g× ®ã.")
        if (IsExistItem(6, 1, 524, 0) == 0) then
            AddNormalItem(6, 1, 524, 0, 0, 0)
            Msg2Player(" §­îc Phong Ên chi kİnh.")
            SetTaskByte(Task_Outoftree, 1, 1)
            TaskNote(108, 0)--ÉèÖÃÈÎÎñ±äÁ¿ÎªÒÑ½ÓÈÎÎñ
            SetSubTask(108, 1, 1)
            Msg2Player("§Õn §«ng Ngôc Ph¸p S¬n, t×m KhiÕu L«i.")
            -- Added by luoyixuan 091228 begin
            refreshNpcTaskState()
            -- Added by luoyixuan 091228 end
        end
    end

end

function tree2()
    CloseDialog()
    MsgBox(GetName() .. " §­îc, t¹i h¹ nhÊt ®Şnh sÏ cho tªn ng«ng cuång nµy 1 bµi häc!", "tree1", "no")

end

function tree3()
    CloseDialog()
    Talk(2, "tree2", GetName() .. "Tªn nµy c¶ gan nh­ vËy sao? ThËt lµ kh«ng xem ng­êi trong Ma giíi chóng ta ra g×, hiÖn giê h¾n ®ang ë ®©u? Ta sÏ th©n chinh ®i xö lı h¾n.", "H¾n tªn lµ TiÕu L«i, giái dông L«i Ph¸p, th­êng xuÊt hiÖn t¹i phİa §«ng Ngôc Ph¸p S¬n, hy väng ng­¬i cã thÓ tiªu diÖt h¾n ®o¹t vÒ cæ ®å.")

end
-----------------------------------------½ÚÍâÉúÖ¦----End----------------

---Task Name£º·âÓ¡Ö®¾µ----------------
--Adde  by LT
--Time:09-06-09
-------------------------------------·âÓ¡Ö®¾µ--Begin --------------------
function pressurize_mirror()
    CloseDialog()
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1) --»ñÈ¡µ±Ç°ÈÎÎñËùÔÚ²½Öè
    if (Outoftree_step == 9) then
        --Èç¹ûÍæ¼ÒÒÑ¾­É±ËÀĞ¥À×
        --ÊÕ»Ø·âÓ¡Ö®¾µ,Èç¹ûÉíÉÏÃ»ÓĞ·âÓ¡Ö®¾³£¬Ôò·µ»Ø
        --Íæ¼Ò±ØĞë½«·âÓ¡Ö®¾³´øÔÚÉíÉÏ»òÕß¿ì½İÀ¸ÄÚ
        if (HaveNormalItem(6, 1, 524, 0) == 0 and HaveNormalItemInQuick(6, 1, 524, 0) == 0) then
            Talk(1, "no", "«i, cæ ®å kh«ng ngê l¹i bŞ h¾n hñy ®i … ng­¬i cã thÓ mang cho ta <c=g>Kİnh Phong Ên<c> kh«ng, cã thÓ ta sÏ t×m ®­îc mét sè tµn tİch trong ®ã.")
            Msg2Player("§em Phong Ên chi kİnh giao cho MËt th¸m.")
            return
        end

        --Èç¹ûÔÚ¿ì½İÀ¸£¬Ôò±³°üÄÚ±ØĞëÓĞÒ»¸ö¿Õ£¬Èç¹ûÔÚ±³°ü£¬ÔòÃ»±ØÒª£¬ÒòÎªºóÃæ¿ÉÒÔÉ¾µôµÀ¾ßºóÌÚ³öÒ»¸ö¿Õ
        if (IsHaveSpaceForTreasure(2) == 0 and HaveNormalItemInQuick(6, 1, 524, 0) > 0) then
            Talk(2, "no", GetName() .. "ThËt hæ thÑn, tuy ta ®· chÕ phôc h¾n, nh­ng l¹i kh«ng ®o¹t l¹i ®­îc Cæ §å, xem ra nã ®· bŞ h¾n tiªu hñy råi.", "¸i dµ, Cæ §å ®· bŞ hñy råi …dï g× ®i ch¨ng n÷a ng­¬i còng ®· b¸o thï cho vŞ ®ång ®¹o ®· khuÊt, ®©y cã mét mãn quµ nhá xem nh­ lµ phÇn th­ëng cña ta, nh­ng hµnh trang cña ng­¬i ®· ®Çy, chØnh lı l¹i h·y ®Õn gÆp ta.")
            TopMessage("Hµnh trang ®· ®Çy")
            Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn th­ëng.")
            return
        end

        --Èç¹ûÊÇÔÚ¿ì½İÀ¸£¬Ôò´Ó¿ì½İÀ¸É¾³ı£¬Èç¹ûÊÇÔÚ±³°ü£¬Ôò´Ó±³°üÉ¾³ı
        if (DelNormalItem(6, 1, 524, 0) == 0) then
            DelNormalItemInQuick(6, 1, 524, 0)
        end
        SetTaskByte(Task_Outoftree, 1, 10) --ÉèÖÃÈÎÎñ±äÁ¿ÎªÒÑÍê³É·âÓ¡Ö®¾µ
        TaskNote(108, -1)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end

        --Ôö¼ÓĞŞÎªºÍËæ¼´À¶É«×°±¸
        local addexp = AddOwnExtendExp(5000000)
        Msg2Player("NhiÖm vô hoµn thµnh, nhËn ®­îc" .. addexp .. " kinh nghiÖm vµ 1 trang bŞ xanh.")
        --ÅĞ¶ÏÖ°Òµ£¬60À¶É«×°±¸£¨Ğ¡3¼şËæ»ú£¬°´Ö°Òµ·Ö£©

        local TypeofPlayer = GetPlayerType() + 1
        local RandofEquip = random(1, 3)
        AddBlueEquip(myunpack(CONST_MIRROR_EQUIP[TypeofPlayer][RandofEquip].item))
        local equip_name = CONST_MIRROR_EQUIP[TypeofPlayer][RandofEquip].name
        TopMessage("NhËn ®­îc <c=water>" .. equip_name .. "<c>")
        Msg2Player("Hoµn thµnh Phong Ên chi kİnh, nhËn ®­îc" .. equip_name)

        Talk(2, "no", GetName() .. "ThËt hæ thÑn, tuy ta ®· chÕ phôc h¾n, nh­ng l¹i kh«ng ®o¹t l¹i ®­îc Cæ §å, xem ra nã ®· bŞ h¾n tiªu hñy råi.", "¸i dµ, Cæ §å ®· bŞ hñy råi …dï g× ®i ch¨ng n÷a ng­¬i còng ®· b¸o thï cho vŞ ®ång ®¹o ®· khuÊt, ®©y cã mét mãn quµ nhá xem nh­ lµ phÇn th­ëng cña ta.")
    end
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end
-----------------------------------------·âÓ¡Ö®¾µ----End-----------

---Task Name£ºÈ¡ÏûÈÎÎñ----------------
--Adde  by liyudong
--Time:09-11-11
-------------------------------------È¡ÏûÈÎÎñ--Begin --------------------
function quxiao()
    CloseDialog()
    MsgBox("B¹n x¸c nhËn muèn hñy bá nhiÖm vô?", "quxiao_confirm", "no")
end

function quxiao_confirm()
    CloseDialog()
    local step = GetTaskByte(Task_zhixian, 1)
    if ((step == 11 or step == 12 or step == 13 or step == 14 or step == 15 or step == 16) and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() < 0) then
        ClearItem(4, 256, 0, 1)   --Çå»¨¾Æ
        SetTaskByte(Task_zhixian, 1, 10) --ÉèÖÃÖ§ÏßÈÎÎñÎª¿ÉÒÔÔÙ½ÓÒÔ¾Æ»áÓÑÈÎÎñ
        SetTaskByte(Task_zhixian, 2, 0)
        SetTaskByte(Task_zhixian, 3, 0)   --ÉèÖÃ´ğÌâ¹éÁã
        local stoneIdx = GetTask(Task_stone)
        if (stoneIdx ~= 0) then
            DelNpc(stoneIdx)
            RemoveIBBuff(692)
        end
        TaskNote(106, -1)
        Msg2Player("Hñy bá nhiÖm vô DÜ Töu Héi H÷u")
    end
end
-------------------------------------È¡ÏûÈÎÎñ--end -------------------
function no()
    CloseDialog()
end
