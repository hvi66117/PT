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
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_zhixian, 1) == 7) then
                state = 1
                subState = 0
            elseif (GetJusticEvilCredit() > 0 and GetTaskByte(Task_zhixian, 1) == 9) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_zhixian, 1) == 7) then
                state = 1
                subState = 1
            elseif (GetJusticEvilCredit() > 0 and GetTaskByte(Task_zhixian, 1) == 9) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÒÔ¾Æ»áÓÑ
    startLevel = 53
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
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
            if (GetTaskByte(Task_zhixian, 1) == 17 and GetJusticEvilCredit() > 0) then
                state = 1
                subState = 0
            elseif ((GetTaskByte(Task_zhixian, 1) == 19 and GetJusticEvilCredit() > 0) or (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0)) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskByte(Task_zhixian, 1) == 17 and GetJusticEvilCredit() > 0) then
                state = 1
                subState = 1
            elseif ((GetTaskByte(Task_zhixian, 1) == 19 and GetJusticEvilCredit() > 0) or (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0)) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ÚÍâÉúÖ¦Òıµ¼ÈÎÎñ
    startLevel = 57
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
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
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
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
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
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
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
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
    if ((zhixian_step == 10 or zhixian_step == 12 or (HaveIBBuff(692) > 0 and zhixian_step == 16)) and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end
    -- Added by liuzhiqiang at 2009-5-27 End-----------ÒÔ¾Æ»áÓÑ

    -- Added by liuzhiqiang at 2009-6-2 Begin---------Ê§ÂäÖ®Êé
    if ((zhixian_step == 7 or zhixian_step == 9) and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() > 0) then
        tasks[2].show = 1
    end
    -- Added by liuzhiqiang at 2009-6-2 End-----------Ê§ÂäÖ®Êé

    -- Added by JRT at 2009-6-2 Begin---------¸¯»¨Ö®¶¾
    if (zhixian_step == 6) and (GetPlayerExtLevel() >= 50 and GetJusticEvilCredit() > 0) then
        tasks[3].show = 1
    end
    -- Added by JRT at 2009-6-2 End-----------¸¯»¨Ö®¶¾

    -- Added by ZQ at 2009-6-2 Begin---------¹ÅÍ¼ÖØÉú
    if (zhixian_step == 17 or zhixian_step == 19) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        tasks[4].show = 1
    end
    if (zhixian_step == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        tasks[4].show = 1
    end

    --Added  by LT at 09-06-09 Begin ------------½ÚÍâÉúÖ¦
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)--»ñÈ¡µ±Ç°ÈÎÎñËùÔÚ²½Öè
    if ((GetPlayerExtLevel() >= 59 or GetTaskByte(1481, 1) == 1) and Outoftree_step == 0 and GetJusticEvilCredit() > 0) then
        --------½ÚÍâÉúÖ¦£¨£¨¼¶±ğ´óÓÚ58£¬Íê³ÉÇ°ĞòÈÎÎñ£©»òÕß£¨½ÓÊÜÁËÏÉ/Ä§½ç³âºòÈÎÎñ£©£©²¢ÇÒÎªÏÉÕóÓª
        tasks[5].show = 1
    end
    --Added  by LT at 09-06-09 End-------------½ÚÍâÉúÖ¦

    --Added by LT at 09-06-09 Begin ------------·âÓ¡Ö®¾µ
    if GetPlayerExtLevel() >= 60 and Outoftree_step == 9 and GetJusticEvilCredit() > 0 then
        --------·âÓ¡Ö®¾µ£¨¼¶±ğ´óÓÚ59£¬Íê³ÉÇ°Ğò²½Öè,ÏÉÕóÓª£©
        tasks[6].show = 1
    end
    --Added  by LT at 09-06-09 End

    -- Added by liyudong at 2009-11-11 Begin---------È¡ÏûÈÎÎñ
    --	if( ( zhixian_step == 11 or zhixian_step == 12 or zhixian_step == 13 or zhixian_step == 14 or zhixian_step == 15 or zhixian_step == 16 ) and GetJusticEvilCredit() > 0 ) then
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
    SayTask("Kh«ng ai nh×n thÊy ta…", tasks)
end;

-- Added by liuzhiqiang at 2009-5-27 Begin---------ÒÔ¾Æ»áÓÑ

function wine_friend()
    CloseDialog()

    if (GetTaskByte(Task_zhixian, 1) == 10 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        Talk(3, "no", "Theo ®iÒu tra cña ta, Cæ §å Tµn PhiÕn thø 2 ®ang trn tay téc nh©n <c=r>YÓn Tö Minh<c> cña bé l¹c Di Ph­¬ng. H¾n n¾m gi÷ bİ mËt Ngôc Ph¸p thÇn khİ, nÕu cã ®­îc lßng tin cña téc nh©n bé l¹c sÏ dÔ dµng ®iÒu tra vÒ Tµn PhiÕn h¬n.", GetName() .. "Lµm sao ®Ó cã ®­îc lßng tin cña hä?", "Ta nghe nãi ®¹i phu <c=r>YÓn Phong<c> cña bé l¹c Di Ph­¬ng ®ang cÇn gióp ®ì, ®©y lµ mét c¬ héi tèt ®Êy.")
        Msg2Player("Hoµn thµnh nhiÖm vô tuÇn hoµn cña YÓn Phong, tranh thñ sù tin t­ëng cña téc nh©n bé l¹c Di Ph­¬ng.")
        TaskNote(106, 2)
        SetTaskByte(Task_zhixian, 1, 11)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 12 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        Talk(1, "no", "Xem ra Tµn PhiÕn ®İch thËt Èn chøa bİ mËt vÒ thÇn khİ, ®­îc biÕt <c=r>YÓn Tö Minh<c> rÊt thİch uèng r­îu, kh«ng chõng sÏ r­îu vµo lêi ra.", GetName() .. " §Õn ®©u míi t×m ®­îc r­îu ngon?", "Cã thÓ ng­¬i ch­a biÕt, <c=r>YÓn Phong<c> còng lµ mét tay nÊu r­îu giái, <c=g>Thanh Hoa töu<c> cña h¾n h­¬ng vŞ rÊt thuÇn, ta nghe nãi h¾n th­êng ®em tÆng r­îu cho nh÷ng ai ®· gióp ®ì h¾n.")
        Msg2Player("Hoµn thµnh nhiÖm vô tuÇn hoµn cña YÓn Phong, cã thÓ nhËn ®­îc Thanh Hoa Töu.")
        TaskNote(106, 5)
        SetTaskByte(Task_zhixian, 1, 13)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 16 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0 and HaveIBBuff(692) > 0) then
        local npcMapid, x, y = GetNpcWorldPos(GetTask(Task_stone))
        local distance = floor(((1929 - x) ^ 2 + (3631 - y) ^ 2) ^ 0.5 * 32)
        if (distance > 400) then
            Msg2Player("HuyÒn Th¹ch c¸ch MËt th¸m Tiªn giíi qu¸ xa.")
        else
            Talk(1, "no", "Lµm tèt l¾m, ta sÏ t×m c¸ch më viªn ThÊt Th¸i HuyÒn Th¹ch nµy, ®©y lµ phÇn th­ëng cña ng­¬i. TiÕp theo ®©y ta cÇn t×m tung tİch cña Tµn PhiÕn cuèi cïng, ®îi khi ®¹t cÊp 55 h·y ®Õn t×m ta.")

            local addexp = AddOwnExtendExp(3600000)
            TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
            Msg2Player("Hoµn thµnh DÜ Töu Héi H÷u, nhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")

            TaskNote(106, -1)
            TaskNote(107, 1)
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
    if (zhixian_step == 7 and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() > 0) then
        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "MËt Th¸m Tiªn Giíi:Hµnh trang kh«ng ®ñ chç trèng, h·y s¾p xÕp l¹i råi ®Õn ®©y.")
        else
            Talk(3, "no", "Ta ®· t×m ®­îc manh mèi cña Tµn PhiÕn thø nhÊt: Quanh Ngôc Ph¸p S¬n cã 4 <c=r>Ph¸p trô <c>, nh÷ng <c=r>Ph¸p trô <c> ®­îc c¸c <c=r>Thñ Hé Thó<c> b¶o vÖ, cã thÓ trªn ng­êi chóng cã <c=g>Tµn PhiÕn Cæ §å<c>.", GetName() .. " Sao ta ch­a bao giê thÊy <c=r>Thñ Hé Thó<c> mµ ng­¬i nãi ®Õn?", "B×nh th­êng bän <c=r>Thñ Hé Thó<c> sÏ kh«ng xuÊt hiÖn, trõ khi Ph¸p trô bŞ uy hiÕp. Ta cã 1 <c=g>Hµm Long Ph­ín<c>, cã thÓ dÉn dô chóng xuÊt hiÖn.")

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

    if (zhixian_step == 9 and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() > 0) then

        if (HaveNormalItem(4, 257, 0, 1) == 0) then
            Talk(1, "no", "H·y ®em theo <c=g>Tµn PhiÕn Cæ §å<c> råi ®Õn t×m ta.")
            return
        end

        Talk(1, "no", "Tèt l¾m, vËy lµ ta ®· cã 2 <c=g>Tµn PhiÕn Cæ §å<c>, vÊt v¶ cho ng­¬i qu¸, phÇn th­ëng nµy xin nhËn lÊy. Ta cÇn thªm thêi gian ®Ó ®iÒu tra vÒ nh÷ng Tµn PhiÕn cßn l¹i, ®îi khi ®¹t cÊp 53 h·y h·y quay l¹i t×m ta.")

        SetTaskByte(Task_zhixian, 1, 10)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        local addexp = AddOwnExtendExp(2200000)
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh ThÊt l¹c chi th­, nhËn ®­îc" .. addexp .. " ®iÓm tu luyÖn!")
        SetSubTask(105, -1, 1)
        TaskNote(105, -1)
        TaskNote(106, 1)

        ClearItem(4, 257, 0, 1) --²ĞÆ¬
        ClearItem(6, 1, 523, 0) --º³Áúá¦
    end
end

-- Added by liuzhiqiang at 2009-6-2 End-----------Ê§ÂäÖ®Êé

-- Added by ZQ at 2009-6-2 End-----------¹ÅÍ¼ÖØÉú
function gutuchongsheng()
    CloseDialog()
    --½ÓÈÎÎñ
    if (GetTaskByte(Task_zhixian, 1) == 17) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        Talk(1, "book3", "Ta ®· biÕt tung tİch cña Tµn PhiÕn cuèi cïng, nh­ng e lµ cã chót khã kh¨n…", GetName() .. " Sao c¸c h¹ l¹i nãi vËy? Tµn PhiÕn cuèi cïng thËt ra ®ang ë ®©u?", "Ma giíi còng ®ang t×m Ngôc Ph¸p thÇn khİ, Tµn PhiÕn cuèi cïng cña Cæ §å còng bŞ chóng lÊy mÊt, c¸ch ®©y kh«ng xa, cã 1 MËt th¸m Ma giíi, Tµn PhiÕn ®ang trong tay h¾n.")
        return 0
    end

    if (GetTaskByte(Task_zhixian, 1) == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        TaskNote(107, 2)
        return 0
    end

    --½»ÈÎÎñ
    if (GetTaskByte(Task_zhixian, 1) == 19) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        if (HaveNormalItem(4, 257, 0, 1) == 0) then
            Talk(1, "no", "H·y ®em theo <c=g>Tµn PhiÕn Cæ §å<c> råi ®Õn t×m ta.")
            return
        end

        Talk(1, "no", "ThËt lîi h¹i, ng­¬i cã thÓ chÕ phôc bÊy nhiªu ng­êi, ®o¹t l¹i Tµn PhiÕn! Ng­¬i ®· gióp Tiªn giíi t×m l¹i Ngôc Ph¸p thÇn khİ, lËp ®­îc c«ng lín! §©y lµ phÇn th­ëng, h·y nhËn lÊy!")

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
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh Cæ §å Trïng Sinh, nhËn ®­îc" .. addexp .. " kinh nghiÖm vµ 1 trang bŞ xanh.")

        TaskNote(107, -1)

        ClearItem(4, 257, 0, 1) --²ĞÆ¬
        return
    end

    --±äÉí
    if (GetTaskByte(Task_zhixian, 1) == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        Talk(1, "book4", "Ng­êi cña Ma giíi? Hõ, nh©n lóc ta ch­a ®éng thñ, h·y ch¹y cµng xa cµng tèt.", GetName() .. "ThËt ng«ng cuång, h«m nay ta ®Õn ®Ó cho ng­¬i 1 bµi häc! Nh­ng nÕu ng­¬i ngoan ngo·n giao nép Tµn PhiÕn Cæ §å, ta cã thÓ tha cho!", "Víi søc ng­¬i µ? Cø thö xem!")
    end
end

function warmitanmo(warmitanIdx, dlgIndex)
    SetNpcScript(warmitanIdx, "\\script\\¹ÖÎï\\Õ½¶·ÃÜÌ½ÏÉ»ÙÃğ.lua")
    SetNpcTimer(warmitanIdx, "\\script\\ontimer\\Õ½¶·ÃÜÌ½×Ô¼ì.lua", 60)--¸øÕ½¶·NPC¼ÓÒ»·ÖÖÓONTIMER
    SetNpcName(warmitanIdx, "MËt th¸m Tiªn giíi")
    SetNpcCamp(warmitanIdx, 3)

    SetNpcTask(warmitanIdx, 1, 1)--¼ÇÂ¼³õÊ¼ÂÖÑ¯´ÎÊı£¨ÈÎÎñ±äÁ¿£©--1
    SetNpcTask(warmitanIdx, 2, GetNpcLife(warmitanIdx))--»ñµÃµ±Ç°ÑªÁ¿,¼ÇÂ¼³õÊ¼ÑªÁ¿£¨ÈÎÎñnpc±äÁ¿£©
    SetNpcTask(warmitanIdx, 3, dlgIndex)--±£´æ¶Ô»°NPC INDEX
end

function flower_Talk()
    CloseDialog()
    Talk(4, "no", GetName() .. "Ng­¬i lµ ai? Sao l¹i xuÊt hiÖn ë ®©y? Cã ı ®å g×?", "Cïng lµ ng­êi cña Tiªn giíi, h¼n ng­¬i còng nghe nãi gÇn ®©y Ngôc Ph¸p S¬n cã thÇn khİ xuÊt hiÖn, ta phông mÖnh ®Õn ®iÒu tra viÖc nµy.", GetName() .. " Ra vËy, thø lçi ®· m¹o ph¹m.", "Kh«ng sao. Míi ®©y ta t×nh cê cã ®­îc 1 Tµn PhiÕn Cæ §å, d­êng nh­ cã liªn quan ®Õn thÇn khİ, ta ®ang ®iÒu tra tung tİch cña nh÷ng Tµn PhiÕn cßn l¹i, ®îi anh hïng ®¹t ®Õn cÊp 51 h·y quay l¹i!")
    SetTaskByte(Task_zhixian, 1, 7)
    SetSubTask(104, -1, 1)
    TaskNote(104, -1)
    TaskNote(105, 1)
    -- Added by luoyixuan 091228 begin
    refreshNpcTaskState()
    -- Added by luoyixuan 091228 end
end

function book3()
    Talk(2, "no", GetName() .. " Ch¼ng qua lµ vµi tªn trong Ma giíi, h·y ®îi 1 l¸t, xem ta chÕ phôc chóng ®o¹t l¹i Tµn PhiÕn.", "Chí ®¾c ı, tªn nµy c«ng lùc kh«ng nhá, 1 m×nh ng­¬i ®èi phã kh«ng l¹i ®©u, tèt nhÊt nªn t×m vµi ng­êi b¹n ®i cïng.")
    TaskNote(107, 3)
    SetTaskByte(Task_zhixian, 1, 18)
    -- Added by luoyixuan 091228 begin
    refreshNpcTaskState()
    -- Added by luoyixuan 091228 end
end

function book4()
    CloseDialog()
    MsgBox(GetName() .. "Tèt l¾m, vËy ta h·y thö 1 chót!", "book5", "no")
end

function book5()
    CloseDialog()
    local npcindex = GetTask(142)
    if (GetNpcTemplateID(npcindex) ~= 1013) then
        return 0
    end
    local warmitanIdx = AddNpc(1104, 65, SubWorld, 1929 * 32, 3631 * 32)--ADDÕ½¶·NPC
    Msg2CurMapAnnounce("Ma giíi ®ang g©y rèi, hìi c¸c Tiªn giíi ®¹o h÷u, mau ®Õn gióp ta!")
    warmitanmo(warmitanIdx, npcindex)
    CaptureNpc(npcindex)--KILL¶Ô»°NPC

    --ÕóÓª±ä»»
    if (GetTeam() == 0) then
        if (GetJusticEvilCredit() < 0) then
            if (GetTaskByte(Task_zhixian, 1) == 18) then
                SetCamp(4)
            end
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() < 0) then
                SetCamp(4)
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
        --½«ÏÉÄ§½ç³âºòµÄÈÎÎñ±äÁ¿ÖÃÎª²»ÄÜÔÙ²ÎÓë½ÚÍâÉúÖ¦
        SetTaskByte(1481, 1, 2)
        ClearItem(6, 1, 524, 0)
        TaskNote(108, 21)
        -- Added by luoyixuan 091228 begin
        refreshNpcTaskState()
        -- Added by luoyixuan 091228 end
        return
    end

    if (Outoftree_step == 0) then
        Talk(3, "tree3", "Ngôc Ph¸p S¬n qu¶ lµ n¬i thŞ phi! ViÖc t×m kiÕm Ngôc Ph¸p thÇn khİ l¹i gÆp trë ng¹i.", GetName() .. "Tiªn sinh ®ang nãi ®Õn viÖc Cæ ®å bŞ c­íp ph¶i kh«ng.", "Xem ra anh hïng ®· biÕt, bän ¸c nh©n ë Ngôc Ph¸p S¬n ®· ®¶ th­¬ng c¸c ®¹o h÷u, c­íp ®i Cæ §å cã thÓ ghi chĞp tung tİch cña thÇn khİ…")
    end
end

function tree1()
    CloseDialog()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Cæ kİnh nµy lÊy ®­îc tõ trªn ng­êi h¾n, cã lÏ sÏ gióp İch cho ng­¬i, nh­ng hµnh trang cña ng­¬i ®· ®Çy, kh«ng thÓ nhËn ®­îc.")
        return
    else
        Talk(1, "no", "Cæ kİnh nµy lÊy ®­îc tõ trªn ng­êi h¾n, cã lÏ sÏ gióp İch cho ng­¬i.")
        if (IsExistItem(6, 1, 524, 0) == 0) then
            AddNormalItem(6, 1, 524, 0, 0, 0)
            Msg2Player(" §­îc Phong Ên chi kİnh.")
            SetTaskByte(Task_Outoftree, 1, 1)
            SetSubTask(108, 1, 1)
            TaskNote(108, 0)--ÉèÖÃÈÎÎñ±äÁ¿ÎªÒÑ½ÓÈÎÎñ
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
    Talk(2, "tree2", GetName() .. " KÎ nµo to gan nh­ vËy? ThËt ch¼ng xem Tiªn giíi ta ra g×. Ta ph¶i cho chóng bµi häc míi ®­îc.", "KÎ nµy tªn KhiÕu L«i, së tr­êng dïng L«i ph¸p, th­êng xuÊt hiÖn ë §«ng Ngôc Ph¸p S¬n, mong anh hïng gióp chÕ phôc kÎ nµy, ®o¹t l¹i Cæ §å.")
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
            Talk(1, "no", "Cæ §å ®· bŞ h¾n tiªu hñy råi… Ng­¬i cã thÓ ®i t×m <c=g>Phong Ên chi kİnh<c> gióp ta, cã thÓ sÏ t×m ®­îc th«ng tin míi tõ ®©y.")
            Msg2Player("§em Phong Ên chi kİnh giao cho MËt th¸m.")
            return
        end

        --Èç¹ûÔÚ¿ì½İÀ¸£¬Ôò±³°üÄÚ±ØĞëÓĞÒ»¸ö¿Õ£¬Èç¹ûÔÚ±³°ü£¬ÔòÃ»±ØÒª£¬ÒòÎªºóÃæ¿ÉÒÔÉ¾µôµÀ¾ßºóÌÚ³öÒ»¸ö¿Õ
        if (IsHaveSpaceForTreasure(2) == 0 and HaveNormalItemInQuick(6, 1, 524, 0) > 0) then
            Talk(2, "no", GetName() .. "ThËt hæ thÑn, tuy ta ®· chÕ phôc h¾n, nh­ng l¹i kh«ng ®o¹t l¹i ®­îc Cæ §å, xem ra nã ®· bŞ h¾n tiªu hñy råi.", "¤i, Cæ §å ®· bŞ hñy mÊt råi… Ta cã mét sè vËt dông nho nhá, coi nh­ ®¸p t¹ sù vÊt v¶ cña ng­¬i bÊy l©u, nh­ng hµnh trang cña ng­¬i ®· ®Çy, h·y s¾p xÕp råi quay l¹i sau.")
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
        Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc" .. equip_name)

        Talk(2, "no", GetName() .. "ThËt hæ thÑn, tuy ta ®· chÕ phôc h¾n, nh­ng l¹i kh«ng ®o¹t l¹i ®­îc Cæ §å, xem ra nã ®· bŞ h¾n tiªu hñy råi.", "¤i, Cæ §å ®· bŞ hñy mÊt råi… Ta cã mét sè vËt dông nho nhá, coi nh­ ®¸p t¹ sù vÊt v¶ cña ng­¬i bÊy l©u.")
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
    if ((step == 11 or step == 12 or step == 13 or step == 14 or step == 15 or step == 16) and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
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
