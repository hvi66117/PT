--ÙÈ²®Òæ.lua
--author:gaojingwei
--date:2009/5/18

Task_Process = 1458   --1byte:1½ÓÈÎÎñ£¬2µÃµ½ÙÈ²®ÒæµÄ½±Àø£¬3ÁìÈ¡ÁÔÉ±³Ë»ÆµÄÈÎÎñ£¬4ÊÍ·Å³Ë»ÆNpc£¬5ÊÍ·ÅÕ½¶·³Ë»Æ£¬ 6Õ½Ê¤³Ë»Æ´óÍõ 7Ã»ÓĞ°´ÕÕÒªÇóÕ½Ê¤³Ë»Æ´óÍõ 8ÒÑ¾­½ÓÁËµÚÒ»´ÎÈÎÎñ
--2byte:µ±Ìì½ÓÈÎÎñ´ÎÊı£»3byte:1µ¥±¶£¬2Ë«±¶£»4byte:É±ËÀ³Ë»ÆµÄ¸öÊı
Task_Type = 1459      --1byte:1½ÓµÄÊÇÃîÊÖÉñÒ½µÄÈÎÎñ£¬2½ÓµÄÊÇÁ¶ÖÆÃÔÒ©µÄÈÎÎñ 2byte:1±íÊ¾ÒÑ¾­½××ö¹ıµÚÒ»´ÎÃîÊÖÉñÒ½ÈÎÎñ
Task_Total_Times = 1460    --ÀÛ¼ÆÈÎÎñ´ÎÊı
Task_Accept_Day = 1461  --½ÓÈÎÎñµÄÈÕÆÚ
Task_Coordinate = 1462  --1word:ËøÑıÕòx×ø±ê£»2word£ºy×ø±ê
Task_MonsterID = 1463    --³Ë»Æ(ÀçÁéÊ¬µÄID)
Task_Free_Time = 1464    --³Ë»Æ´óÍõ(×çÖäÖ®ÀçÁéÊ¬)µÄindex
Task_Yiqi = 1532

chenghuangNpcID = 1005    --³Ë»Æ´óÍõNpcµÄtemplateID
chenghuangID = 1003        --³Ë»Æ´óÍõµÄtemplateID
lilingNpcID = 1006        --ÏÄÁéÊ¬´óÍõNpcµÄtemplateID
lilingID = 1004            --ÏÄÁéÊ¬´óÍõµÄtemplateID
amberNum = 3            --ĞèÒª½ÉÄÉµÄçúçêÖ®ĞÄµÄ¸öÊı
blastID = 1007            --ËøÑıÕòµÄID
buffID = 682            --ËøÑıÕòbuffµÄID
------------------------------------ËÑÑ°×åÈË--------------------------------------------------
g_SearchClansMan = 1483  --   1byte  0Ã»½Ó  1½ÓÁË  2ÕĞ³öÏÉÄ§½ç³àºò 3Íê³ÉÈÎÎñ 4Ê§°Ü  5½áÊø  7ÕÙ»½³öÁË×åÈË  3byteµôÂäÁèÔªÖé¸ÅÂÊ    2byte x 4byte y

g_Distance = 222

g_ClansMan = 223

------------------------------ºÏ³É×°±¸----------------------------------
Task_compose = 1555

questyKey = {
    [1] = { name = "Canh Håi Hån", key = 250 },
    [2] = { name = "Ng­ H×nh th¶o", key = 251 },
    [3] = { name = "Long Ng¹n th¶o", key = 252 }
}

taskItem = {
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517, 0 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

stuff = {
    [1] = { name = "Tinh luyÖn Ngoa", material = "Khu«n Hµi", nItem = { 3, 341, 0, 0 }, maItem = { 3, 338, 0, 0 } },
    [2] = { name = "Tinh luyÖn §Çu Kh«i", material = "Khu«n §Çu kh«i", nItem = { 3, 339, 0, 0 }, maItem = { 3, 336, 0, 0 } },
    [3] = { name = "Tinh luyÖn Yªu ®¸i", material = "Khu«n Yªu ®¸i", nItem = { 3, 340, 0, 0 }, maItem = { 3, 337, 0, 0 } }
}

equip = {
    [1] = { name = "Th¸nh DiÖu ChiÕn Ngoa", material = "Th¸nh DiÖu Lôc Tinh Th¹ch", mould = "Tinh luyÖn Ngoa", dye = "ThÇn Hµnh Vò Ngoa", nItem = { 0, 5, 36, 1 }, maItem = { 3, 449, 0, 0 }, mouldItem = { 3, 341, 0, 0 }, dyeItem = { 3, 452, 0, 0 }, number = 14 },
    [2] = { name = "Th¸nh DiÖu Kh«i", material = "Th¸nh DiÖu Lôc Tinh Th¹ch", mould = "Tinh luyÖn §Çu Kh«i", dye = "Ngäc §Ønh Kim Kh«i", nItem = { 0, 7, 36, 1 }, maItem = { 3, 449, 0, 0 }, mouldItem = { 3, 339, 0, 0 }, dyeItem = { 3, 453, 0, 0 }, number = 10 },
    [3] = { name = "Th¸nh DiÖu Yªu ®¸i", material = "Th¸nh DiÖu Lôc Tinh Th¹ch", mould = "Tinh luyÖn Yªu ®¸i", dye = "T­¬ng Ngäc Cæn §¸i", nItem = { 0, 6, 36, 1 }, maItem = { 3, 449, 0, 0 }, mouldItem = { 3, 340, 0, 0 }, dyeItem = { 3, 454, 0, 0 }, number = 12 },
    [4] = { name = "H­ Nghi Lı", material = "H­ Nghi Lôc Tinh Th¹ch", mould = "Tinh luyÖn Ngoa", dye = "ThÇn Hµnh Vò Ngoa", nItem = { 0, 5, 37, 1 }, maItem = { 3, 450, 0, 0 }, mouldItem = { 3, 341, 0, 0 }, dyeItem = { 3, 452, 0, 0 }, number = 14 },
    [5] = { name = "H­ Nghi qu¸n", material = "H­ Nghi Lôc Tinh Th¹ch", mould = "Tinh luyÖn §Çu Kh«i", dye = "Ngäc §Ønh Kim Kh«i", nItem = { 0, 7, 37, 1 }, maItem = { 3, 450, 0, 0 }, mouldItem = { 3, 339, 0, 0 }, dyeItem = { 3, 453, 0, 0 }, number = 10 },
    [6] = { name = "H­ Nghi C©n", material = "H­ Nghi Lôc Tinh Th¹ch", mould = "Tinh luyÖn Yªu ®¸i", dye = "T­¬ng Ngäc Cæn §¸i", nItem = { 0, 6, 37, 1 }, maItem = { 3, 450, 0, 0 }, mouldItem = { 3, 340, 0, 0 }, dyeItem = { 3, 454, 0, 0 }, number = 12 },
    [7] = { name = "Loan Vò Ngoa", material = "Loan Vò Lôc Tinh Th¹ch", mould = "Tinh luyÖn Ngoa", dye = "ThÇn Hµnh Vò Ngoa", nItem = { 0, 5, 38, 1 }, maItem = { 3, 451, 0, 0 }, mouldItem = { 3, 341, 0, 0 }, dyeItem = { 3, 452, 0, 0 }, number = 14 },
    [8] = { name = "Loan Vò Trô", material = "Loan Vò Lôc Tinh Th¹ch", mould = "Tinh luyÖn §Çu Kh«i", dye = "Ngäc §Ønh Kim Kh«i", nItem = { 0, 7, 38, 1 }, maItem = { 3, 451, 0, 0 }, mouldItem = { 3, 339, 0, 0 }, dyeItem = { 3, 453, 0, 0 }, number = 10 },
    [9] = { name = "Loan Vò Yªu ®¸i", material = "Loan Vò Lôc Tinh Th¹ch", mould = "Tinh luyÖn Yªu ®¸i", dye = "T­¬ng Ngäc Cæn §¸i", nItem = { 0, 6, 38, 1 }, maItem = { 3, 451, 0, 0 }, mouldItem = { 3, 340, 0, 0 }, dyeItem = { 3, 454, 0, 0 }, number = 12 },
}
----------------------
--æ¶ÂŞË«Ê÷ made yaoxin 09/7/27
task_poluo_renwu = 1525 --1byte ×´Ì¬ 1¼¤»î
-----

-- AS yangshuang at 091229
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


    --ËÑÑ°×åÈË
    startLevel = 57
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(g_SearchClansMan, 1) == 0) then
                state = 1
                subState = 0
            elseif (GetTaskByte(g_SearchClansMan, 1) == 3) then
                state = 3
                subState = 0
            elseif (GetTaskByte(g_SearchClansMan, 1) == 1 or GetTaskByte(g_SearchClansMan, 1) == 2 or GetTaskByte(g_SearchClansMan, 1) == 4 or GetTaskByte(g_SearchClansMan, 1) == 7) then
                state = 2
                subState = 0
            end
        else
            if (GetTaskByte(g_SearchClansMan, 1) == 0) then
                state = 1
                subState = 1
            elseif (GetTaskByte(g_SearchClansMan, 1) == 3) then
                state = 3
                subState = 1
            elseif (GetTaskByte(g_SearchClansMan, 1) == 1 or GetTaskByte(g_SearchClansMan, 1) == 2 or GetTaskByte(g_SearchClansMan, 1) == 4 or GetTaskByte(g_SearchClansMan, 1) == 7) then
                state = 2
                subState = 0
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
-- AE yangshuang at 091229 end


function main()
    local tasks = {
        { "DiÖu Thñ ThÇn Y", "doctorlable"; show = 0 },
        { "LuyÖn Hãa MËt D­îc", "druglable"; show = 0 },
        { "Hñy N.vô", "cancelTask"; show = 0 },
        { "Sù kiÖn Ngôc Ph¸p Phong Yªn", "yffyhelp"; show = 1 },
        { "T×m téc nh©n", "SearchClansman"; show = 0 },
        { "Sa La Song Thô", "sal_begin"; show = 0 },
        { "<c=g>Trang bŞ hîp thµnh<c>", "composeEquip"; show = 1 }, --Add by liuzhiqiang at 2009/6/26
    }
    --add by fengce at 2009.6.9 --

    if (GetPlayerExtLevel() >= 57 and (GetTaskByte(g_SearchClansMan, 1) <= 4 or GetTaskByte(g_SearchClansMan, 1) == 7)) then
        if (GetTaskByte(g_SearchClansMan, 1) ~= 0) then
            tasks[3].show = 1
        end
        tasks[5].show = 1
    end

    --end by fengce at 2009.6.9 --

    --add by guoqun at 2009.11.8 --
    if (GetPlayerExtLevel() >= 51 and (GetTaskByte(1459, 1) == 0 or GetTaskByte(1459, 1) == 1)) then
        tasks[1].show = 1

        if (GetTaskByte(1459, 1) == 1) then
            tasks[2].show = 0
        end
    end

    if (GetTask(1460) >= 60 and GetPlayerExtLevel() >= 56 and (GetTaskByte(1459, 1) == 0 or GetTaskByte(1459, 1) == 2)) then
        tasks[2].show = 1

        if (GetTaskByte(1459, 1) == 2) then
            tasks[1].show = 0
        end
    end
    --end by guoqun at 2009.11.8 --

    if (GetPlayerExtLevel() >= 65) and (IsJEMainTaskComplete(2) == 1) and (GetJusticEvilCredit() > 0) then
        if (GetTask(task_poluo_renwu) == 0) and (IsJEMainTaskComplete(3) == 0) then
            tasks[6].show = 1
        end
    end
    SayTask("Ta lµ ®Çu lÜnh bé l¹c ë Ngôc Ph¸p S¬n, ngµn n¨m nay bän ta kh«ng ngõng chèng l¹i ma vËt, tuy khã kh¨n nh­ng còng rÊt vui. Nh­ng gÇn ®©y «n dŞch hoµnh hµnh, ta ®µnh bã tay, thËt hæ thÑn víi tæ tiªn!", tasks)
end
--add by guoqun at 2009.11.16--
function doctorlable()
    local tasks3 = {
        { "DiÖu Thñ ThÇn Y", "superDoctor1"; show = 1 },
        { "Hñy N.vô", "cancelDoctor"; show = 0 }
    }

    local step = GetTaskByte(Task_Process, 1);
    if (step > 0 and step <= 6) then
        tasks3[2].show = 1
    end
    SayTask("YÓn Phong lµ d­îc s­ giái nhÊt cña bé téc chóng t«i, nh­ng ®· l©u kh«ng cã tin tøc cña cËu Êy.", tasks3)
end

function druglable()
    local tasks4 = {
        { "LuyÖn Hãa MËt D­îc", "superDoctor2"; show = 1 },
        { "Hñy N.vô", "cancelDoctor"; show = 0 }
    }
    local step = GetTaskByte(Task_Process, 1);
    if (step > 0 and step <= 6) then
        tasks4[2].show = 1
    end
    SayTask("YÓn Phong lµ d­îc s­ giái nhÊt cña bé téc chóng t«i, nh­ng ®· l©u kh«ng cã tin tøc cña cËu Êy.", tasks4)
end
--end by guoqun 2009.11.16--

function superDoctor1()
    SetTask(140, 1)
    superDoctor(1)
end

function superDoctor2()
    SetTask(140, 2)
    superDoctor(2)
end

function superDoctor(type)
    CloseDialog()
    local item = taskItem[1].Item
    local step = GetTaskByte(Task_Process, 1)
    if (GetTaskByte(Task_Type, 3) ~= 1 and GetTask(Task_Total_Times) == 0) then
        -- µÚÒ»´Î½ÓÈÎÎñ£¬Ö»ĞèÒªÌáÊ¾ÆäÈ¥Ñ°ÕÒÙÈ·ç
        Talk(1, "no", "Ng­¬i ®Õn ®©y lµm g×? <c=g>YÓn Phong<c> kh«ng biÕt ®· ®i ®©u, ng­¬i cã gÆp cËu Êy kh«ng?")
        SetTask(Task_Process, 0)                                --ËùÓĞºÍÈÎÎñÏà¹ØµÄ±äÁ¿Çå0
    elseif (type == 1 and GetTaskByte(Task_Type, 3) == 1) then
        --´ú±íµÚÒ»´ÎÈÎÎñ
        if (HaveEventItem(questyKey[1].key) > 0) then
            SetTaskByte(Task_Process, 1, 2)
            MsgBox("§a t¹ anh hïng, nÕu anh hïng cã thÓ mang ®Õn cho ta <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>, vµ 100 v¹n b¹c, cã thÓ ®æi ®­îc <c=yel>Khu Ma phï<c>, lóc ®ã bé téc cña ta sÏ ®­îc cøu.", "Doctor_Start", "no")
        else
            Talk(1, "no", "HiÖn nay Ngôc Ph¸p S¬n yªu ma hoµnh hµnh, téc ta l¹i cã «n dŞch, ch¼ng lÏ trêi muèn téc ta diÖt vong?")
        end
    elseif (step == 0 and GetTaskByte(Task_Type, 3) == 2) then
        local str = ""
        if (type == 2) then
            str = "vµ <c=yel>Hæ Ph¸ch Chi T©m<c><c=g>3 c¸i<c>"
        end

        --Add By Guoqun for Bug ÈÎÎñÖ»ÄÜ×öÒ»´Î at 2010-11-09 Begin
        local nOldTime = GetTask(Task_Accept_Day) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
        local nCurTime = floor(LocalSystemTime() / 86400)
        if nOldTime ~= nCurTime then
            SetTaskByte(Task_Process, 2, 0)
        end
        --Add By Guoqun for Bug ÈÎÎñÖ»ÄÜ×öÒ»´Î at 2010-11-09 End

        local temp = GetTaskByte(Task_Process, 2)
        local nTimes, addtimes = todayfreetimes(temp)

        local alltimes = GetTaskByte(1477, 3)
        if (nTimes == 0) then
            --µ±ÌìµÚÒ»´Î½ÓÈÎÎñ
            MsgBox("NÕu anh hïng cã thÓ mang ®Õn cho ta <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c> " .. str .. ", 100 v¹n b¹c cã thÓ ®æi ®­îc <c=yel>Khu Ma phï<c>, lóc ®ã bé téc cña ta sÏ ®­îc cøu.", "yiqiBuff_1", "no")
        elseif (nTimes <= 4 or alltimes >= addtimes) then
            local pm_free = payMoneyfree(addtimes)
            local task = {
                { "N¹pTµiTuLuyÖn", "yiqiBuff_3"; show = 0 },
                { "V« C¨n Hoa", "coin_renwu"; show = 0 },
            }
            if (alltimes >= addtimes) then
                task[1].show = 1
            else
                coin_renwu()
                return 0
            end
            if (nTimes <= 4) then
                task[2].show = 1
            end
            if (type == 2) then
                str = "vµ <c=yel>Hæ Ph¸ch Chi T©m<c><c=g>3 c¸i<c>"
            end
            SayTask("HiÖn t¹i ng­¬i tİch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. " b¹c, cã thÓ nhËn thªm nhiÖm vô, nhiÖm vô nµy kh«ng tİnh vµo chi tiÕt thu phİ. NhÊn chän “N¹p tµi tu luyÖn“ nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn ®Ó chÕ t¹o <c=yel>Khu Ma phï<c> th× 100 v¹n b¹c, <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i 10  " .. str .. "kh«ng thÓ thiÕu.", task)
        else
            Talk(1, "no", "B¹n ®· hoµn thµnh tÊt c¶ nhiÖm vô h«m nay, ngµy mai h·y quay l¹i.")
        end
    else
        Talk(1, "no", "Anh hïng vÉn ch­a t×m thÊy <c=g>YÓn Phong<c> sao? CËu Êy cÇn gÆp ng­¬i, cËu Êy ®ang ë h­íng T©y Nam Ngôc Ph¸p S¬n.")
    end
end

function Doctor_Start()
    CloseDialog()

    local temp = GetTaskByte(Task_Process, 2)
    local nTimes, addtimes = todayfreetimes(temp)
    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = 1000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø


    if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
        Talk(1, "no", "CÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c> ®Ó chÕ biÕn <c=yel>Canh hoµn hån<c>.")
        return
    end

    if (GetCash() < pm) then
        --modify by liuzhiqiang
        Talk(1, "no", "Ng­¬i kh«ng ®ñ b¹c.")
        return
    end

    if (IsHaveSpaceForTreasure(1) ~= 1) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, s¾p xÕp råi h·y quay l¹i.")
        return
    end

    for i = 1, 10, 1 do
        DelNormalItem(3, 311, 0, 0)
        DelNormalItem(3, 312, 0, 0)
    end

    Talk(1, "no", "§a t¹ anh hïng! Th× ra <c=g>YÓn Phong<c> m¹o hiÓm lªn nói t×m Linh th¶o. Nh­ng cËu Êy chØ lµ mét Th¶o d­îc s­, kh«ng th¹o viÖc trõ yªu diÖt ma, ng­¬i h·y gióp ta mang <c=yel>Khu Ma phï<c> cho cËu Êy phßng th©n!")
    Msg2Player("NhËn ®­îc <c=yel>Khu Ma phï<c>")
    if (GetTaskByte(Task_Type, 1) == 1) then
        TaskNote(1077, 1)
    else
        TaskNote(1078, 1)
    end

    DelEventItem(questyKey[1].key)

    SetTaskByte(Task_Process, 1, 2)            --ÈÎÎñµÚÒ»²½
    SetTaskByte(Task_Process, 2, 1)            --ÈÎÎñ´ÎÊı
    SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
    SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0

    SetTaskByte(Task_Type, 3, 1)          --Á½ÖÖÂüºÍÇ®ÒÑ¾­½»¸¶
    SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
    --local nNum = GetTask(Task_Total_Times)
    --nNum = nNum + 1
    --SetTask(Task_Total_Times, nNum)			--×ÜµÄÈÎÎñ´ÎÊı¼Ó1

    SetTaskByte(Task_Type, 1, 1)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
    SetTask(Task_MonsterID, 0)                --¹ÖÎïID
    SetTask(Task_Coordinate, 0)

    local item = taskItem[1].Item
    AddNormalItem(item[1], item[2], item[3], item[4], 0, 0)
    Talk(1, "no", "§©y lµ chÕ t¹o ®Æc biÖt cña ta <c=yel>" .. taskItem[1].name .. "<c>, nhÊt ®Şnh ph¶i gióp ta tËn tay giao cho<c=g>YÓn Phong<c>, cËu Êy ë phİa T©y Nam Ngôc Ph¸p S¬n, cËu Êy cßn nhá tuæi ®· ®i h¸i thuèc, cã c¸i nµy sÏ an toµn h¬n.")
    TopMessage("NhËn ®­îc <c=yel>" .. taskItem[1].name)
    TaskNote(1077, 1)
    SyncBibleState(1077, 2, 1)
    if (GetTask(Task_Total_Times) >= 60) then
        SyncBibleState(1078, 2, 1)
    end
end

function cancelTask()
    CloseDialog()
    --add by liyudong at 2009/11/11 begin
    local step = GetTaskByte(g_SearchClansMan, 1)
    if (GetPlayerExtLevel() >= 57 and (step == 1 or step == 2 or step == 3 or step == 4 or step == 7)) then
        MsgBox("B¹n ®ång ı bá nhiÖm vô T×m Téc Ng­êi kh«ng?", "quxiao_confirm", "no")
        return
    end
    --add by liyudong at 2009/11/11 end
    --MsgBox("ÙÈ²®Òæ£ºÎÒ²¿×åÖ®ÈË¾ö²»ÃãÇ¿ÍâÈËÎªÎÒ×å±¼²¨ÊÜÀÛ£¬½ñÎÒ×åËäÓ¦ÌìÔÖÈË»ö£¬Ò²²»Ô¸ÓĞÇóÓÚÈË¡£ÈôÓ¢ĞÛÎŞÒâ°ïÖúÎÒ×å£¬Ò»ÇĞË³Ó¦×ÔÈ»°É......", "yesCancel", "no")
end

function cancelDoctor()
    CloseDialog()
    MsgBox("Bé téc cña chóng t«i tuyÖt ®èi kh«ng miÔn c­ìng ng­êi ngoµi v× chóng t«i mµ b«n ba chŞu khæ, tuy chóng t«i ®ang ph¶i ®èi mÆt víi th¶m häa thiªn tai, nh­ng vÉn kh«ng muèn cÇu xin ng­êi kh¸c. NÕu nh­ anh hïng kh«ng muèn gióp chóng t«i, th«i th× cø chÊp nhËn nh­ vËy......", "yesCancel", "no")
end

function yesCancel()
    CloseDialog()
    local item = taskItem[1].Item
    if (GetTask(Task_Accept_Day) ~= floor(LocalSystemTime() / 86400)) then
        ClearItem(item[1], item[2], item[3], item[4])
        for i = 1, 3 do
            DelEventItem(questyKey[i].key)
        end
        RemoveIBBuff(buffID)
        SetTask(Task_Process, 0)                                --ËùÓĞºÍÈÎÎñÏà¹ØµÄ±äÁ¿Çå0
        SetTaskByte(Task_Type, 1, 0)
        SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
        SetTask(Task_MonsterID, 0)
        SetTaskByte(Task_Type, 3, 2)
        Msg2Player("§· tõ bá nhiÖm vô")
        TaskNote(1077, -1)
    else
        ClearItem(item[1], item[2], item[3], item[4])
        for i = 1, 3 do
            DelEventItem(questyKey[i].key)
        end
        RemoveIBBuff(buffID)
        SetTaskByte(Task_Process, 1, 0)
        SetTaskWord(Task_Process, 2, 0)--log¸Ä°æ
        SetTaskByte(Task_Type, 1, 0)
        SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
        SetTask(Task_MonsterID, 0)
        SetTaskByte(Task_Type, 3, 2)
        Msg2Player("§· tõ bá nhiÖm vô")
        TaskNote(1077, -1)
    end
end

function yiqiBuff_1()

    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("B¹n cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, b¹n cã ®ång ı sö dông kh«ng?", "costYiqi_1", "Doctor_yesStart")
    else
        Doctor_yesStart()
    end
end

function yiqiBuff_2()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("B¹n cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, b¹n cã ®ång ı sö dông kh«ng?", "costYiqi_2", "Doctor_oddTask")
    else
        Doctor_oddTask()
    end
end

function yiqiBuff_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("B¹n cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, b¹n cã ®ång ı sö dông kh«ng?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function yiqiBuff_4()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("B¹n cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, b¹n cã ®ång ı sö dông kh«ng?", "costYiqi_4", "Doctor_doubleTask")
    else
        Doctor_doubleTask()
    end
end

function coin_renwu()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local tasks = {
        { "Tu luyÖn th­êng", "yiqiBuff_2"; show = 1 },
        { "Tu luyÖn nh©n ®«i", "yiqiBuff_4"; show = 1 }
    }
    SayTask("Mçi ngµy ta chØ cho ng­¬i 1 c¬ héi nhiÖm vô, nÕu muèn lµm tiÕp, ngoµi nguyªn liÖu, cÇn thªm 1 <c=yel>" .. taskItem[4].name .. " HoÆc" .. Cfs .. " TiÒn ®ång<c>, ta sÏ cho ng­¬i 1 lÇn c¬ héi nhiÖm vô; nÕu nh­ mang ®Õn cho ta <c=g>2<c> <c=yel>" .. taskItem[4].name .. " HoÆc" .. 2 * Cfs .. " TiÒn ®ång<c>, sÏ nhËn ®­îc phÇn th­ëng nh©n ®«i.", tasks)
end

function costYiqi_1()
    CloseDialog()
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        Doctor_yesStart()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function costYiqi_2()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        Doctor_oddTask()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function costYiqi_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function costYiqi_4()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        Doctor_doubleTask()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khİ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function Doctor_yesKill()
    CloseDialog()
    local item = taskItem[1].Item
    if (GetTaskByte(Task_Process, 1) == 2 and ((HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0))) then
        SetTaskByte(Task_Process, 1, 3)
        SetTask(Task_MonsterID, 0)
        SetTask(Task_Free_Time, 0)
        Talk(1, "no", "<c=r>ThiÕt Tinh ®¹i v­¬ng<c> lµ thñ lÜnh ThiÕt Tinh cña nói nµy, b×nh th­êng İt khi xuÊt hiÖn, h«m nay bŞ thu hót bëi mïi h­¬ng cña Linh th¶o. NÕu anh hïng cã thÓ hµng phôc ThiÕt Tinh nhiÒu lÇn, nghiÖp ch­íng nµy nhÊt ®Şnh sÏ xuÊt hiÖn!")
        Msg2Player("Tiªu diÖt ThiÕt Tinh dÉn dô ThiÕt Tinh §¹i V­¬ng xuÊt hiÖn")
        TaskNote(1077, 2)
    end
end

function Doctor_yesStart()
    CloseDialog()
    local temp = GetTaskByte(Task_Process, 2)
    local nTimes, addtimes = todayfreetimes(temp)
    --	local nType = GetTaskByte(Task_Type, 1)
    local nType = GetTask(140)

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = 1000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (nTimes == 0) then

        if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
            Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>")
            return
        end

        if (nType == 2 and HaveNormalItem(3, 425, 0, 0) < 3) then
            Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Hæ Ph¸ch Chi T©m<c> <c=g>3 c¸i<c>.")
            return
        end

        if (GetCash() < pm) then
            --modify by liuzhiqiang
            Talk(1, "no", "Ng­¬i kh«ng ®ñ b¹c.")
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "Hµnh trang ®· ®Çy, s¾p xÕp råi h·y quay l¹i.")
            return
        end

        for i = 1, 10, 1 do
            DelNormalItem(3, 311, 0, 0)
            DelNormalItem(3, 312, 0, 0)
        end

        if (nType == 2) then
            local item = taskItem[2].Item
            for i = 1, 3 do
                DelNormalItem(item[1], item[2], item[3], item[4])
            end

            Msg2Player("Trõ 3 Hæ Ph¸ch Chi T©m.")
        end

        Msg2Player("Trõ 10 Man §µ La Hoa vµ 10 Man Ch©u Sa Hoa")
        Msg2Player("Trõ 1000000 b¹c")
        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm
            WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
            Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm
            WriteLog(GetName() .. "Trõ ®iÓm nh©n nghÜa ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
            Msg2Player("Trõ ®iÓm nh©n nghÜa ®Ó hñy" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
        Pay(pm)

        SetTaskByte(Task_Process, 1, 2)            --ÈÎÎñµÚÒ»²½
        SetTaskByte(Task_Process, 2, 1)            --ÈÎÎñ´ÎÊı
        SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
        SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0
        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
        local nNum = GetTask(Task_Total_Times)
        nNum = nNum + 1
        SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1

        SetTaskByte(Task_Type, 1, nType)            --±ê¼Ç½ÓÈÎÎñÀàĞÍ nType¼ÇÂ¼ÁËÈÎÎñÀàĞÍ1£ºÃîÊÖÉñÒ½2£ºÁ¶ÖÆÃØÒ©
        SetTask(Task_MonsterID, 0)                --¹ÖÎïID
        SetTask(Task_Coordinate, 0)
        local item = taskItem[1].Item
        AddNormalItem(item[1], item[2], item[3], item[4], 0, 0) -- Ìí¼ÓÇıÄ§·ûµÀ¾ß
        Talk(1, "no", "Cho ng­¬i 1 <c=yel>Khu Ma phï<c>, mau ®i t×m <c=g>YÓn Phong<c>")
        Msg2Player("§©y lµ nhiÖm vô thø 1 cña ngµy h«m nay, nhËn ®­îc 1" .. taskItem[1].name)
        TopMessage("NhËn ®­îc <c=yel>" .. taskItem[1].name)
        TaskNote(1077, 1)    --ÌáÊ¾Ï£ÍûÄã°ÑÇıÄ§·û´ø¸øÙÈ·ç»¤Éí
        SyncBibleState(1077, 2, 1) --°ÑÒÑ¾­½ÓµÄÈÎÎñÉèÖÃÎªÂÌÉ«
        if (GetTask(Task_Total_Times) >= 60) then
            SyncBibleState(1078, 2, 1)
        end
    end
end

function Doctor_oddTask()
    CloseDialog()
    local step = GetTaskByte(Task_Process, 1)
    local temp = GetTaskByte(Task_Process, 2)
    local nTimes, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)            --???
    local item = taskItem[4].Item

    local nType = GetTask(140)

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = 1000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (step == 0) then

        if (HaveNormalItem(item[1], item[2], item[3], item[4]) == 0) and (GetCoin() < Cv) then
            Talk(1, "no", "Mçi ngµy ta chØ cho ng­¬i 1 c¬ héi nhiÖm vô, nÕu muèn lµm tiÕp, ngoµi nguyªn liÖu, cÇn thªm <c=yel>1" .. taskItem[4].name .. " HoÆc" .. Cfs .. " TiÒn ®ång<c>")    --ĞèÒª½«¶ÔÓ¦µÄÍ¨±¦ÊıÁ¿Ò²ÏÔÊ¾
            return
        end

        if (nType == 2) then
            if (HaveNormalItem(3, 425, 0, 0) < 3) then
                Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Hæ Ph¸ch Chi T©m<c> <c=g>3 c¸i<c>.")
                return
            end
        end

        if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
            Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>.")
            return
        end

        if (GetCash() < pm) then
            Talk(1, "no", "Ng­¬i kh«ng ®ñ b¹c.")
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "Hµnh trang ®· ®Çy, s¾p xÕp råi h·y quay l¹i.")
            return
        end

        Accept_Doctor_oddTask(pm, lastMoney)
    end
end

function Accept_Doctor_oddTask(pm, lastMoney)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local temp = GetTaskByte(Task_Process, 2) + 1
    local nTimes, addtimes = todayfreetimes(temp)
    local item = taskItem[4].Item
    local itemID = FindAValidIBItem(item[1], item[2], item[3], item[4])
    local nType = GetTask(140)

    if (itemID > 0) then
        CostIBItem(itemID)
    elseif (GetCoin() >= Cv) then
        --???
        CostCoinByIdx(115)
    else
        return
    end

    for i = 1, 10, 1 do
        DelNormalItem(3, 311, 0, 0)
        DelNormalItem(3, 312, 0, 0)
    end

    for i = 1, 3, 1 do
        DelNormalItem(3, 425, 0, 0)
    end

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        CostIBBuff(767, 1)
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney - pm
        WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
        Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy" .. change .. ".")
    elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        PayHelpScore(1)
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney - pm
        WriteLog(GetName() .. "Trõ ®iÓm nh©n nghÜa ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
        Msg2Player("Trõ ®iÓm nh©n nghÜa ®Ó hñy" .. change .. ".")
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
    Pay(pm)

    SetTaskByte(Task_Process, 1, 2)            --ÈÎÎñµÚÒ»²½
    SetTaskByte(Task_Process, 2, temp)        --ÈÎÎñ´ÎÊı
    SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
    SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0
    SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
    local nNum = GetTask(Task_Total_Times)
    nNum = nNum + 1
    SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1
    SetTaskByte(Task_Type, 3, 2)
    SetTaskByte(Task_Type, 1, nType)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
    SetTask(Task_MonsterID, 0)
    SetTask(Task_Coordinate, 0)
    local item = taskItem[1].Item
    AddNormalItem(item[1], item[2], item[3], item[4], 0, 0) -- Ìí¼ÓÇıÄ§·ûµÀ¾ß
    Talk(1, "no", "§©y lµ chÕ t¹o ®Æc biÖt cña ta <c=yel>" .. taskItem[1].name .. "<c>, nhÊt ®Şnh ph¶i gióp ta giao tËn tay cho <c=g>YÓn Phong<c>, cËu Êy ë phİa T©y Nam Ngôc Ph¸p S¬n, cËu Êy cßn nhá tuæi, cã c¸i nµy sÏ an toµn h¬n.")
    Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. nTimes .. "NhËn nhiÖm vô, nhËn ®­îc 1" .. taskItem[1].name)
    TopMessage("NhËn ®­îc <c=yel>" .. taskItem[1].name)
    TaskNote(1077, 1)
    if (nTimes == 5) then
        SyncBibleState(1077, 3, 1)
        if (GetTask(Task_Total_Times) >= 60) then
            SyncBibleState(1078, 3, 1)
        end
    end
end

function Doctor_doubleTask()
    CloseDialog()
    local step = GetTaskByte(Task_Process, 1)
    local temp = GetTaskByte(Task_Process, 2)
    local nTimes, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local item = taskItem[4].Item

    if (step == 0) then
        if (HaveNormalItem(item[1], item[2], item[3], item[4]) >= 2) or (GetCoin() >= 2 * Cv) or (HaveNormalItem(item[1], item[2], item[3], item[4]) >= 1 and GetCoin() >= Cv) then
            Accept_Doctor_doubleTask()
        else
            Talk(1, "no", "Mçi ngµy ta chØ cho ng­¬i 1 c¬ héi nhiÖm vô, nÕu muèn lµm tiÕp, ngoµi nguyªn liÖu, cÇn thªm <c=g>2<c>®ãa<c=yel>" .. taskItem[4].name .. " HoÆc" .. 2 * Cfs .. " TiÒn ®ång<c>")    --ĞèÒª½«¶ÔÓ¦µÄÍ¨±¦ÊıÁ¿Ò²ÏÔÊ¾
        end
    end
end

function Accept_Doctor_doubleTask()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local temp = GetTaskByte(Task_Process, 2) + 1
    local nTimes, addtimes = todayfreetimes(temp)
    local item = taskItem[4].Item
    local nType = GetTask(140)

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = 1000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        --que
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
        Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>.")
        return
    end

    if (nType == 2 and (HaveNormalItem(3, 425, 0, 0) < 3)) then
        Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Hæ Ph¸ch Chi T©m<c> <c=g>3 c¸i<c>.")
        return
    end

    if (GetCash() < pm) then
        Talk(1, "no", "Ng­¬i kh«ng ®ñ b¹c.")
        return
    end

    if (IsHaveSpaceForTreasure(1) ~= 1) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, s¾p xÕp råi h·y quay l¹i.")
        return
    end

    if (HaveNormalItem(item[1], item[2], item[3], item[4]) >= 2) then
        --ÏÈ¿ÛµÀ¾ß
        local itemID = 0
        itemID = FindAValidIBItem(item[1], item[2], item[3], item[4])
        CostIBItem(itemID)
        itemID = FindAValidIBItem(item[1], item[2], item[3], item[4])
        CostIBItem(itemID)
    elseif (GetCoin() >= Cv and HaveNormalItem(item[1], item[2], item[3], item[4]) >= 1) then
        local itemID = 0
        itemID = FindAValidIBItem(item[1], item[2], item[3], item[4])
        CostIBItem(itemID)
        CostCoinByIdx(115)
    elseif (GetCoin() >= 2 * Cv) then
        --ºó¿ÛÍ¨±¦
        CostCoinByIdx(115)
        CostCoinByIdx(115)
    else
        return
    end

    for i = 1, 10, 1 do
        DelNormalItem(3, 311, 0, 0)
        DelNormalItem(3, 312, 0, 0)
    end

    for i = 1, 3, 1 do
        DelNormalItem(3, 425, 0, 0)
    end

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        CostIBBuff(767, 1)
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney - pm
        WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
        Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy" .. change .. ".")
    elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        PayHelpScore(1)
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney - pm
        WriteLog(GetName() .. "Trõ ®iÓm nh©n nghÜa ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
        Msg2Player("Trõ ®iÓm nh©n nghÜa ®Ó hñy" .. change .. ".")
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
    Pay(pm)

    SetTaskByte(Task_Process, 1, 2)            --ÈÎÎñµÚÒ»²½
    SetTaskByte(Task_Process, 2, temp)        --ÈÎÎñ´ÎÊı
    SetTaskByte(Task_Process, 3, 2)            --±íÊ¾µ¥±¶ÈÎÎñ
    SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0

    local nNum = GetTask(Task_Total_Times)
    nNum = nNum + 1
    SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1
    SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
    SetTaskByte(Task_Type, 1, nType)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
    SetTaskByte(Task_Type, 3, 2)
    SetTask(Task_MonsterID, 0)
    SetTask(Task_Coordinate, 0)
    local item = taskItem[1].Item
    AddNormalItem(item[1], item[2], item[3], item[4], 0, 0) -- Ìí¼ÓÇıÄ§·ûµÀ¾ß
    Talk(1, "no", "§©y lµ chÕ t¹o ®Æc biÖt cña ta <c=yel>" .. taskItem[1].name .. "<c>, nhÊt ®Şnh ph¶i gióp ta giao tËn tay cho <c=g>YÓn Phong<c>, cËu Êy ë phİa T©y Nam Ngôc Ph¸p S¬n, cËu Êy cßn nhá tuæi, cã c¸i nµy sÏ an toµn h¬n.")
    Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. nTimes .. "NhËn nhiÖm vô, nhËn ®­îc 1" .. taskItem[1].name)
    TopMessage("NhËn ®­îc <c=yel>" .. taskItem[1].name)
    TaskNote(1077, 1)
    if (nTimes == 5) then
        SyncBibleState(1077, 3, 1)
        if (GetTask(Task_Total_Times) >= 60) then
            SyncBibleState(1078, 3, 1)
        end
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
        end
    end
    return value, free
end

function payMoneyfree(nums)
    --	if (nums > 7) then
    --		nums = 7
    --	end
    --	local n_times = {50,50,50,100,100,100,100}
    local m = 4000 * GetPlayerExtLevel() --»ùÊı4000*lv
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(Task_Process, 2)
    local nTimes, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local nType = GetTask(140)

    local apm = payMoneyfree(addtimes)
    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = 1000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
    if (GetCash() >= pm) then

        if (nType == 2) then
            if (HaveNormalItem(3, 425, 0, 0) < 3) then
                Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Hæ Ph¸ch Chi T©m<c> <c=g>3 c¸i<c>.")
                return
            end
        end

        if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
            Talk(1, "no", "§æi <c=yel>Khu Ma phï<c> cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>.")
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "Hµnh trang ®· ®Çy, s¾p xÕp råi h·y quay l¹i.")
            return
        end

        if (nTimes == 0) then
            Doctor_yesStart()
            return 1
        else
            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end
        end

        for i = 1, 10, 1 do
            DelNormalItem(3, 311, 0, 0)
            DelNormalItem(3, 312, 0, 0)
        end

        for i = 1, 3, 1 do
            DelNormalItem(3, 425, 0, 0)
        end

        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney + apm - pm
            WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
            Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney + apm - pm
            WriteLog(GetName() .. "Trõ ®iÓm nh©n nghÜa ®Ó hñy nhiÖm vô DiÖu Thñ ThÇn Y" .. change .. ".")
            Msg2Player("Trõ ®iÓm nh©n nghÜa ®Ó hñy" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
        Pay(pm)

        SetTaskByte(Task_Process, 1, 2)            --ÈÎÎñµÚÒ»²½
        SetTaskByte(Task_Process, 2, temp)        --ÈÎÎñ´ÎÊı
        SetTaskWord(Task_Process, 2, 1)--log¸Ä°æ	--±íÊ¾µ¥±¶ÈÎÎñ
        --SetTaskByte(Task_Process, 4, 0)		--É±ËÀ³Ë»Æ¸öÊıÇå0

        local nNum = GetTask(Task_Total_Times) + 1
        SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1
        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
        SetTaskByte(Task_Type, 1, nType)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
        SetTaskByte(Task_Type, 3, 2)
        SetTask(Task_MonsterID, 0)                --¹ÖÎïID
        SetTask(Task_Coordinate, 0)
        local item = taskItem[1].Item
        AddNormalItem(item[1], item[2], item[3], item[4], 0, 0) -- Ìí¼ÓÇıÄ§·ûµÀ¾ß
        Talk(1, "no", "§©y lµ chÕ t¹o ®Æc biÖt cña ta <c=yel>" .. taskItem[1].name .. "<c>, nhÊt ®Şnh ph¶i gióp ta giao tËn tay cho <c=g>YÓn Phong<c>, cËu Êy ë phİa T©y Nam Ngôc Ph¸p S¬n, cËu Êy cßn nhá tuæi, cã c¸i nµy sÏ an toµn h¬n.")
        Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
        Msg2Player("§©y lµ ­u ®·i tİch lòy rêi game lÇn thø" .. addtimes .. " lÇn nhËn thªm nhiÖm vô DiÖu Thñ ThÇn Y, nhËn ®­îc 1 " .. taskItem[1].name)
        TopMessage("NhËn ®­îc <c=yel>" .. taskItem[1].name)
        TaskNote(1077, 1)
    else
        Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn!")
    end
end

function no()
    CloseDialog()
end

function yffyhelp()
    --by songlei 2009.6.11

    CloseDialog()

    local tasks1 = {
        { "Thêi gian næ ra", "fqsj"; show = 1 },
        { "Qu¸ tr×nh chiÕn tranh", "zzgc"; show = 1 },
        { "Khãa trËn doanh", "jzzt"; show = 1 },
        { "Tiªu chuÈn th¾ng b¹i", "sfbz"; show = 1 },
        { "Dò T©m Th¶o", "ysc"; show = 1 },
        { "Tôc MÖnh Hoa", "xmh"; show = 1 },
    }
    SayTask("L·o phu ®· biÕt tin hai giíi Tiªn Ma l¹i dËy chiÕn tranh, ®­îc biÕt gÇn ®©y TiÒn Phong T­íng SÜ cña hai giíi ®· kĞo ®Õn ®©y, e lµ ®ang chuÈn bŞ tranh giµnh Ngôc Ph¸p S¬n M¹ch, téc Di Ph­¬ng ta l¹i n»m ngay vŞ trİ hiÓm yÕu, lµ n¬i yÕu ®Şa cña binh gia, ch¾c ch¾n khãi löa chiÕn tranh sÏ b¾t ®Çu tõ ®©y!", tasks1)
end

function fqsj()
    Talk(1, "yffyhelp", "Mçi ngµy vµo lóc <c=g>1 giê<c>, <c=g>10 giê<c>, <c=g>15 giê<c> vµ <c=g>21 giê<c>, tiÒn phong hai giíi tiªn ma sÏ tËp kÕt chung quanh th«n, næ ra cuéc chiÕn tranh giµnh quyÒn thèng trŞ m¶nh ®Êt nµy, cuéc chiÕn khèc liÖt nµy sÏ kĞo dµi kho¶ng <c=g>25 phót<c>, trong thêi gian nµy viÖc gi¶i cøu hån ph¸ch cña bé téc còng sÏ t¹m g¸c l¹i.")
end
function zzgc()
    Talk(2, "yffyhelp", "Sau khi b¾t ®Çu tÊn c«ng, c¸ch kho¶ng mét thêi gian sÏ cã t­íng sÜ tiÒn phong hai giíi tiªn ma tËp kÕt t¹i Tu La Ph¸p TrËn ë gi÷a th«n. CÇn chó ı, trong ®éi t­íng sÜ tiÒn phong, <c=g>sÜ tèt tiÒn phong<c> thuéc cÊp thÊp nhÊt, <c=g>thñ lÜnh tiÒn phong<c> thuéc cÊp trung b×nh, ", " <c=g>TiÒn Phong Thèng So¸i<c> sÏ xuÊt hiÖn trong ®ît tÊn c«ng cuèi cïng, cÊp cµng cao ®é s¸t th­¬ng cµng lín, nÕu tu luyÖn ch­a ®¹t th× khi gÆp §Çu LÜnh hay Thèng So¸i nªn tr¸nh ®i!")
end
function jzzt()
    Talk(1, "yffyhelp", "§Ó tr¸nh bŞ T­íng SÜ phe m×nh ngé th­¬ng, dòng sÜ Tiªn Ma vµo th«n sau khi næ ra L·nh Thæ Tranh §o¹t ChiÕn ®Òu ®­îc tù ®éng khãa phe PK, cho ®Õn khi chiÕn tranh kÕt thóc! NÕu ng­¬i kh«ng ph¶i phÇn tö hiÕu chiÕn, chØ cÇn rêi khái th«n sÏ ®­îc gi¶i khãa ngay.")
end
function sfbz()
    Talk(2, "yffyhelp", "Khi cuéc chiÕn diÔn ra, nÕu <c=g>sÜ tèt tiÒn phong<c> tö trËn, ®èi ph­¬ng ®­îc t¨ng <c=yel>1 ®iÓm<c> chiÕn c«ng; <c=g>thñ lÜnh tiÒn phong<c> tö trËn, ®èi ph­¬ng ®­îc t¨ng <c=yel>3 ®iÓm<c> chiÕn c«ng; <c=g>thèng so¸i tiÒn phong<c> tö trËn, ®èi ph­¬ng ®­îc t¨ng <c=yel>10 ®iÓm<c> chiÕn c«ng!", "Khi chiÕn tranh kÕt thóc, chiÕn c«ng cña phe nµo cao h¬n, sÏ ®­îc téc Di Ph­¬ng ñng hé, cã thÓ c¾m cê chiÕn ë xung quanh th«n, ngoµi ra cßn nhiÒu lîi thÕ kh¸c ®ang chê ng­¬i ®İch th©n t×m hiÓu.")
end
function ysc()
    Talk(1, "yffyhelp", "Tiªn giíi tiÒn phong lu«n mang <c=g>Dò th­¬ng th¶o<c> bªn ng­êi, lo¹i nµy th­êng mäc bªn bê s«ng Thiªn Hµ, dïng trŞ th­¬ng cã t¸c dông gi¶m ®au! NÕu muèn cã nã, nh÷ng dòng sÜ gia nhËp vµo ma giíi sÏ gi÷ cho phe PK cña m×nh lµ phe <c=yel>vµng<c>, khi diÖt trõ t­íng sÜ tiªn giíi tiÒn phong sÏ nhËn ®­îc.")
end
function xmh()
    Talk(1, "yffyhelp", "Ma giíi tiÒn phong lu«n mang <c=g>Tôc mÖnh hoa<c> bªn ng­êi, lo¹i nµy th­êng mäc ë ®Çu nguån Hoµng TuyÒn, cã t¸c dông ®Æc biÖt gióp hoµn hån duy tr× sù sèng khi träng th­¬ng! NÕu muèn cã nã, nh÷ng dòng sÜ gia nhËp vµo tiªn giíi sÏ gi÷ cho phe PK cña m×nh lµ phe <c=yel>lam<c>, khi diÖt trõ t­íng sÜ ma giíi tiÒn phong sÏ nhËn ®­îc.")
end

--author:fengce add at 2009.6.9 --

function SearchClansman()

    if (GetPlayerExtLevel() >= 57 and GetTaskByte(g_SearchClansMan, 1) == 0) then
        Talk(3, "clansman1", GetName() .. "Ng­¬i tr«ng cã vÎ lo ©u, YÓn téc tr­ëng, kh«ng biÕt viÖc g× lµm ng­¬i lo l¾ng ®Õn vËy?", "Kh«ng giÊu anh hïng, l·o phu cã viÖc cÇn nhê. Ch¾c anh hïng còng biÕt, gÇn ®©y Ngôc Ph¸p S¬n yªu ma hoµnh hµnh, mÊy ngµy tr­íc cßn tÊn c«ng th«n lµng, b¾t nhiÒu téc nh©n bé l¹c ta, ta rÊt lo l¾ng.")
    elseif (GetPlayerExtLevel() >= 57 and GetTaskByte(g_SearchClansMan, 1) == 1) then
        Talk(1, "no", "Ngôc Ph¸p yªu ma b¾t téc nh©n ta, ta l¹i kh«ng cã c¸ch g×, ®óng lµ hæ thÑn.")  --Ñ°ÕÒÏÉÄ§³àºò

    elseif (GetPlayerExtLevel() >= 57 and GetTaskByte(g_SearchClansMan, 1) == 2) then

        Talk(1, "no", "Anh hïng vÉn ch­a t×m ®­îc nh÷ng ng­êi bŞ b¾t µ? Ch¼ng lÏ ®©y lµ ı trêi?")

    elseif (GetPlayerExtLevel() >= 57 and GetTaskByte(g_SearchClansMan, 1) == 3) then

        Talk(3, "clansman2", "Anh hïng ®óng lµ cøu tinh cña téc ta, ®©y lµ chót lßng thµnh cña c¶ téc, xin h·y nhËn lÊy.", "L·o phu cßn 1 viÖc cÇn nhê, mong anh hïng h·y cøu tİnh m¹ng téc nh©n Di Ph­¬ng!", GetName() .. "Téc tr­ëng cø dÆn dß, t¹i h¹ sÏ cè hÕt søc.")    --Íê³ÉÈÎÎñ
        TaskNote(109, 4)
        ------Íê³ÉÈÎÎñ£¿£¿£¿
        ClearItem(6, 1, 526, 0)   --É¾³ıÁèÔªÖé
        SetTaskByte(g_SearchClansMan, 1, 5)
        SetSubTask(109, -1, 1)
        local nFactExp = AddOwnExtendExp(3500000)
        Msg2Player("NhiÖm vô hoµn thµnh, nhËn ®­îc" .. floor(nFactExp) .. " §iÓm tu hµnh.")
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end


    elseif (GetPlayerExtLevel() >= 57 and GetTaskByte(g_SearchClansMan, 1) == 4) then
        Talk(1, "no", "Anh hïng vÉn ch­a t×m ®­îc nh÷ng ng­êi bŞ b¾t µ? Ch¼ng lÏ ®©y lµ ı trêi?")
        SetTaskByte(g_SearchClansMan, 1, 2)
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end

    elseif (GetPlayerExtLevel() >= 57 and GetTaskByte(g_SearchClansMan, 1) == 7) then
        ---- modified by yaoxin at 2009-08-13
        if (GetNpcTask(GetTask(g_ClansMan), 0) ~= GetPlayerID() or (GetNpcTemplateID(GetTask(g_ClansMan)) ~= 1097)) then
            ---- modified by yaoxin at 2009-08-13
            MsgBox("XuÊt hiÖn sù cè råi, cã ph¶i b¾t ®Çu t×m l¹i téc nh©n", "yes_2", "no")
            return
        end

        Talk(1, "no", "Anh hïng vÉn ch­a t×m ®­îc nh÷ng ng­êi bŞ b¾t µ? Ch¼ng lÏ ®©y lµ ı trêi?")
        --SetTaskByte(g_SearchClansMan,1,2)

    else

        return
    end
end

mapChihouCoord = -- ³àºò×ø±ê
{

    { x = 227 * 8, y = 207 * 16 },
    { x = 215 * 8, y = 215 * 16 },
    { x = 245 * 8, y = 205 * 16 },
    { x = 255 * 8, y = 213 * 16 },
    { x = 250 * 8, y = 222 * 16 },
    { x = 234 * 8, y = 232 * 16 },
}

mapClansmanCoord = --×åÈË×ø±ê
{
    { x = 241 * 8, y = 199 * 16 },
    { x = 214 * 8, y = 200 * 16 },
    { x = 243 * 8, y = 233 * 16 },
    { x = 250 * 8, y = 229 * 16 },
}

function yes_1()
    CloseDialog()
    Talk(2, "no", GetName() .. " ViÖc nµy xin YÓn téc tr­ëng yªn t©m, t¹i h¹ sÏ cè hÕt søc, nh­ng kh«ng biÕt lµm c¸ch nµo t×m ®­îc nh÷ng ng­êi bŞ b¾t?", "Yªu ma Ngôc Ph¸p S¬n sau khi b¾t ®­îc ng­êi sèng sÏ dïng ph¸p thuËt che giÊu hä, nh­ng chóng còng sÏ ®em theo <c=g>L¨ng Nguyªn Ch©u<c> ®Ó ph¸ gi¶i thuËt Èn th©n, nÕu anh hïng ®o¹t ®­îc <c=g>L¨ng Nguyªn Ch©u<c>, cã thÓ dïng nã ®Ó t×m téc nh©n Di Ph­¬ng.")
    SetTaskByte(g_SearchClansMan, 1, 1)
    TaskNote(109, 0)
    SetSubTask(109, 1, 1)

    local t_rand1 = nil
    t_rand1 = random(1, getn(mapChihouCoord))
    SetTaskByte(g_SearchClansMan, 2, t_rand1)

    local t_rand2 = nil
    t_rand2 = random(1, getn(mapClansmanCoord))
    SetTaskByte(g_SearchClansMan, 4, t_rand2)   --µ¼Èë×ø±êË÷Òı£¬ÒÔ±¸AI×Ô¶¯Ñ°Â·ÆğÊ¼Ê¹ÓÃ
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end

end

function clansman1()
    CloseDialog()
    MsgBox("NÕu anh hïng cã thÓ t×m l¹i téc nh©n cña ta, l·o phu sÏ rÊt biÕt ¬n.", "yes_1", "no")
    TaskNote(-1)    --½ÓÈÎÎñ
end

function clansman2()
    CloseDialog()
    Talk(3, "no", "Ng­êi ®­îc anh hïng cøu ®· nãi víi ta, 1 Cæ ThÇn vèn thï bé l¹c ta ®· ®Õn Ngôc Ph¸p S¬n, h¾n sÏ san b»ng téc Di Ph­¬ng ®Ó trót hËn. NÕu anh hïng chŞu ra tay gióp ®ì, ®îi ®Õn cÊp 62 cã thÓ ®i t×m Vu S­ <c=r>YÓn Thóc Di<c> t×m hiÓu sù t×nh.")
end

function yes_2()
    CloseDialog()
    SetTaskByte(g_SearchClansMan, 1, 2)
    Talk(1, "no", "H·y nhanh chèng ®i t×m téc nh©n ®i");
    TaskNote(109, 1)
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
end

------Add by liuzhiqiang at 2009/06/26 start -----

function composeEquip()
    local tasks = {
        { "Nguyªn liÖu hîp thµnh", "composeMat"; show = 1 },
        { "Hîp thµnh trang bŞ", "composeEqu"; show = 1 },
        { "Quy t¾c hîp thµnh", "methord"; show = 1 }
    }
    SayTask("VËt phÈm phi th­êng sÏ cã t¸c dông ®Æc biÖt cña nã, ta cÇn nguyªn liÖu ®Æc biÖt ®Ó t¹o cho ng­¬i.", tasks)
end

function composeMat()
    CloseDialog()

    local selection = {}
    local nCount = getn(stuff)

    for i = 1, nCount do
        selection[i] = stuff[i].name .. "/onSelectMat"
    end

    selection[nCount + 1] = "Quay vÒ tÇng trªn/composeEquip"                            --·µ»ØÉÏÒ»²ã

    if (getn(selection) > 0) then
        Say("H·y chän vËt phÈm cÇn ghĞp", getn(selection), selection)
    else
        Talk(1, "no", "RÊt tiÕc! VËt phÈm kh«ng phï hîp.")
    end
end

function onSelectMat(nNum)
    CloseDialog()

    nNum = nNum + 1
    SetTaskByte(Task_compose, 1, nNum)

    local maItem = stuff[nNum].maItem
    if (HaveNormalItem(maItem[1], maItem[2], maItem[3], maItem[4]) < 90) then
        Talk(1, "no", "GhĞp" .. stuff[nNum].name .. "CÇn 90 " .. stuff[nNum].material .. ", ng­¬i kh«ng ®ñ nguyªn liÖu, kh«ng thÓ hîp thµnh.")
        return
    end
    MsgBox("GhĞp thµnh 1 <c=yel>" .. stuff[nNum].name .. "<c>CÇn 90 " .. stuff[nNum].material .. ", cã x¸c suÊt thµnh c«ng rÊt lín, ng­¬i ®ång ı ghĞp kh«ng?\n<c=yel>Nh¾c nhë: <c>Dïng [Thiªn Chïy B¸ch LuyÖn] cã thÓ ghĞp thµnh c«ng 100%.", "composeGua", "no")

end

function composeGua()
    CloseDialog()

    local select_nNum = GetTaskByte(Task_compose, 1)
    local maItem = stuff[select_nNum].maItem
    if (HaveNormalItem(maItem[1], maItem[2], maItem[3], maItem[4]) < 90) then
        Talk(1, "no", "Ng­¬i kh«ng cã ®ñ " .. stuff[select_nNum].material .. ", ta kh«ng thÓ hîp thµnh cho ng­¬i.")
        return
    end

    if (HaveNormalItem(8, 532, 2, 0) > 0) then
        MsgBox("NÕu nh­ ng­¬i ®­a cho ta <c=yel>Thiªn Chïy B¸ch LuyÖn<c> sÏ cã x¸c suÊt 100% thµnh c«ng. Ng­¬i cã ®ång ı cho ta Thiªn Chïy B¸ch LuyÖn kh«ng?", "withStone", "no")
    else
        noStone()
    end
end

function withStone()
    CloseDialog()

    local select_nNum = GetTaskByte(Task_compose, 1)
    local maItem = stuff[select_nNum].maItem
    if (HaveNormalItem(maItem[1], maItem[2], maItem[3], maItem[4]) < 90) then
        Talk(1, "no", "Ng­¬i kh«ng cã ®ñ " .. stuff[select_nNum].material .. ", ta kh«ng thÓ hîp thµnh cho ng­¬i.")
        return
    end

    if (HaveNormalItem(8, 532, 2, 0) <= 0) then
        Talk(1, "no", "Ng­¬i kh«ng cã Thiªn Chïy B¸ch LuyÖn.")
        return
    end

    DelNormalItem(8, 532, 2, 0)        --¿Û³ıÇ§´¸°ÙÁ¶
    for i = 1, 90, 1 do
        DelNormalItem(maItem[1], maItem[2], maItem[3], maItem[4])
    end

    local nItem = stuff[select_nNum].nItem
    AddNormalItem(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0)
    Talk(1, "no", "Chóc mõng b¹n! NhËn ®­îc 1 <c=yel>" .. stuff[select_nNum].name .. ".<c>")
    Msg2Player("NhËn ®­îc 1" .. stuff[select_nNum].name .. ".")
end

function noStone()
    CloseDialog()

    local select_nNum = GetTaskByte(Task_compose, 1)
    local maItem = stuff[select_nNum].maItem
    if (HaveNormalItem(maItem[1], maItem[2], maItem[3], maItem[4]) < 90) then
        Talk(1, "no", "Ng­¬i kh«ng cã ®ñ " .. stuff[select_nNum].material .. ", ta kh«ng thÓ hîp thµnh cho ng­¬i.")
        return
    end
    for i = 1, 90, 1 do
        DelNormalItem(maItem[1], maItem[2], maItem[3], maItem[4])
    end
    local r = random(1, 100)
    local nItem = stuff[select_nNum].nItem
    if (r <= 80) then
        AddNormalItem(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0)
        Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc 1 " .. stuff[select_nNum].name .. ".")
        Msg2Player("NhËn ®­îc 1" .. stuff[select_nNum].name .. ".")
    else
        Talk(1, "no", "VËn may lÇn nµy h¬i kĞm, ghĞp thÊt b¹i!")
    end
end

function composeEqu()
    CloseDialog()

    local selection = {}
    local nCount = getn(equip)

    for i = 1, nCount do
        selection[i] = equip[i].name .. "/onSelectEqu"
    end

    selection[nCount + 1] = "Quay vÒ tÇng trªn/composeEquip"                            --·µ»ØÉÏÒ»²ã

    if (getn(selection) > 0) then
        Say("H·y chän vËt phÈm cÇn ghĞp: ", getn(selection), selection)
    else
        Talk(1, "no", "RÊt tiÕc! VËt phÈm kh«ng phï hîp.")
    end
end

function onSelectEqu(nNum)
    CloseDialog()

    nNum = nNum + 1
    if (nNum < 1 or nNum > 9) then
        return
    end

    local nItem = equip[nNum].nItem                                        --×°±¸
    local maItem = equip[nNum].maItem                                    --¾§Ê¯
    local mouldItem = equip[nNum].mouldItem                            --²ÄÁÏ
    local dyeItem = equip[nNum].dyeItem                                    --²ÄÁÏ

    if (HaveNormalItem(maItem[1], maItem[2], maItem[3], maItem[4]) < equip[nNum].number) then
        Talk(1, "composeEqu", "GhĞp" .. equip[nNum].name .. "CÇn" .. equip[nNum].number .. " <c=g>" .. equip[nNum].material .. "<c>, ng­¬i kh«ng ®ñ nguyªn liÖu.")
        return
    end

    if (HaveNormalItem(mouldItem[1], mouldItem[2], mouldItem[3], mouldItem[4]) < 2) then
        Talk(1, "composeEqu", "GhĞp" .. equip[nNum].name .. "CÇn 2 <c=g>" .. equip[nNum].mould .. "<c>, ng­¬i kh«ng ®ñ nguyªn liÖu.")
        return
    end

    if (HaveNormalItem(dyeItem[1], dyeItem[2], dyeItem[3], dyeItem[4]) <= 0) then
        Talk(1, "composeEqu", "GhĞp" .. equip[nNum].name .. "CÇn <c=g>" .. equip[nNum].dye .. "<c>, ng­¬i kh«ng ®ñ nguyªn liÖu.")
        return
    end

    for i = 1, equip[nNum].number, 1 do
        DelNormalItem(maItem[1], maItem[2], maItem[3], maItem[4])        --É¾µô¾§Ê¯
    end

    for i = 1, 2 do
        DelNormalItem(mouldItem[1], mouldItem[2], mouldItem[3], mouldItem[4])    --É¾µô²ÄÁÏ1
    end

    DelNormalItem(dyeItem[1], dyeItem[2], dyeItem[3], dyeItem[4])            --É¾µô²ÄÁÏ2
    AddNormalItem(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0)
    Talk(1, "no", "Chóc mõng b¹n! NhËn ®­îc 1 <c=g>" .. equip[nNum].name .. "<c>.")
    Msg2Player("NhËn ®­îc 1 mãn" .. equip[nNum].name)
end

function methord()
    Talk(2, "methord1", "<c=yel>Trang bŞ hîp thµnh: <c>\n10 Th¸nh DiÖu Lôc Tinh Th¹ch+2 §Çu Kh«i Tinh LuyÖn+1 Ngäc §Ønh Kim Kh«i=<c=g>Th¸nh DiÖu Kh«i<c>\n10 H­ Nghi Lôc Tinh Th¹ch+2 §Çu Kh«i Tinh LuyÖn+1 Ngäc §Ønh Kim Kh«i=<c=g>H­ NghÜa Qu¸n<c>\n10 Loan Vò Lôc Tinh Th¹ch+2 §Çu Kh«i Tinh LuyÖn+1 Ngäc §Ønh Kim Kh«i=<c=g>Loan Vò Trô<c>", "12 Th¸nh DiÖu Lôc Tinh Th¹ch+2 Yªu §¸i Tinh LuyÖn+1 T­¬ng Ngäc Cæn §¸i=<c=g>Th¸nh DiÖu Yªu §¸i<c>\n12 H­ Nghi Lôc Tinh Th¹ch+2 Yªu §¸i Tinh LuyÖn+1 T­¬ng Ngäc Cæn §¸i=<c=g>H­ Nghi C©n<c>\n12 Loan Vò Lôc Tinh Th¹ch+2 Yªu §¸i Tinh LuyÖn+1 T­¬ng Ngäc Cæn §¸i=<c=g>Vò Loan Yªu §¸i<c>") --que
end

function methord1()
    Talk(1, "no", "14 Th¸nh DiÖu Lôc Tinh Th¹ch+2 Ngoa Tinh LuyÖn+1 ThÇn Hµnh Vò Ngoa=<c=g>Th¸nh DiÖu ChiÕn Ngoa<c>\n14 H­ Nghi Lôc Tinh Th¹ch+2 Ngoa Tinh LuyÖn+1 ThÇn Hµnh Vò Ngoa=<c=g>H­ Nghi L÷<c>\n14 Loan Vò Lôc Tinh Th¹ch+2 Ngoa Tinh LuyÖn+1 ThÇn Hµnh Vò Ngoa=<c=g>Loan Vò Ngoa<c>")
end


------Add by liuzhiqiang at 2009/06/26 end -----


------------------Add by yaoxin at 09/07/27 end -----
function sal_begin()
    CloseDialog()
    MsgBox("Ng­¬i muèn ®Õn B¶n TuyÒn? Theo ta ®­îc biÕt, nÕu ch­a ®é kiÕp, khi ®Õn B¶n TuyÒn Th¸nh §Şa chØ khiÕn Thiªn Nh©n Ngò Suy nhanh chãng ®Õn ®©y. Nh­ng v× ng­¬i ®· gióp ta rÊt nhiÒu, nªn ta sÏ cho ng­¬i biÕt mét vµi ®iÒu.", "sal_begin_yes", "no")
end

function sal_begin_yes()
    CloseDialog()
    if (GetTask(task_poluo_renwu) > 0) then
        return 0
    end
    TaskNote(112, 0)
    Msg2Player("§i t×m <HyperLinkWorldPos=\"òİòö×Ó[75,254,238]\">")
    SetTask(task_poluo_renwu, 1)
    Talk(1, "no", "GÇn ®©y cã 2 nh©n vËt bİ Èn ®Õn Ngôc Ph¸p S¬n, nghe nãi hä ®Õn tõ B¶n TuyÒn Th¸nh §Şa, lóc nµy hä ®ang thu thËp Th­¬ng Long Gi¸c, nÕu nh­ ng­¬i cã thÓ gióp hä thu thËp b¶o vËt nµy,  cã thÓ hä sÏ cho ng­¬i biÕt c¸ch ®Õn B¶n TuyÒn mµ kh«ng gÆp kiÕp n¹n.")
end
-------------------------------------------

function quxiao_confirm()
    CloseDialog()
    local step = GetTaskByte(g_SearchClansMan, 1)
    if (GetPlayerExtLevel() >= 57 and (step == 1 or step == 2 or step == 3 or step == 4 or step == 7)) then
        SetTaskByte(g_SearchClansMan, 1, 0) --È¡ÏûËÑÑ°×åÈËÈÎÎñÎªÎ´½Ó
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end
        ClearItem(6, 1, 526, 0)   --É¾³ıÁèÔªÖé
        local clansmanIdx = GetTask(g_ClansMan)
        if (clansmanIdx ~= 0) then
            DelNpc(clansmanIdx)
        end
        TaskNote(109, -1)
        Msg2Player("Hñy nhiÖm vô T×m téc ng­êi")
    end
end
