Task_Total_Times = 1460
Task_zhixian = 1471

Task_stone = 1472

Task_Outoftree = 1478

CONST_MIRROR_EQUIP = {

    {
        { name = "Th¸nh DiÖu Kh«i", item = { 0, 7, 18, 1, 0, 1, 1 }, ratio = 1 },
        { name = "Th¸nh DiÖu Yªu §¸i", item = { 0, 6, 18, 1, 0, 1, 1 }, ratio = 2 },
        { name = "Th¸nh DiÖu ChiÕn Ngoa", item = { 0, 5, 18, 1, 0, 1, 1 }, ratio = 3 },
    },

    {
        { name = "H­ Nghi qu¸n", item = { 0, 7, 19, 1, 0, 1, 1 }, ratio = 1 },
        { name = "H­ Nghi C©n", item = { 0, 6, 19, 1, 0, 1, 1 }, ratio = 2 },
        { name = "H­ Nghi Lý", item = { 0, 5, 19, 1, 0, 1, 1 }, ratio = 3 },
    },

    {
        { name = "Loan Vò Trô", item = { 0, 7, 20, 1, 0, 1, 1 }, ratio = 1 },
        { name = "Loan Vò Yªu §¸i", item = { 0, 6, 20, 1, 0, 1, 1 }, ratio = 2 },
        { name = "Loan Vò Ngoa", item = { 0, 5, 20, 1, 0, 1, 1 }, ratio = 3 },
    },

}

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 51
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_zhixian, 1) == 7) then
                state = 1
                subState = 0
            elseif (GetJusticEvilCredit() > 0 and GetTaskByte(Task_zhixian, 1) == 9) then
                state = 3
                subState = 0
            end
        else
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

    startLevel = 53
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
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

    startLevel = 55
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
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

    startLevel = 57
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(1481, 1) == 1 and GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(1481, 1) == 1 and GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 59
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_Outoftree, 1) == 0) then
                state = 1
                subState = 0
            elseif (GetPlayerExtLevel() == 59) then
                state = 2
                subState = 0
            end
        else
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

    startLevel = 60
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_Outoftree, 1) == 9) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_Outoftree, 1) < 9) then
                state = 2
                subState = 0
            end
        else
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

    startLevel = 50
    if (GetPlayerExtLevel() >= startLevel and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_zhixian, 1) == 6) then
                state = 3
                subState = 0
            end
        else
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

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    local tasks = {

        { "DÜ Töu Héi H÷u", "wine_friend"; show = 0 },
        { "ThÊt l¹c chi th­", "lost_book"; show = 0 },
        { "Phï hoa chi ®éc", "flower_Talk"; show = 0 },
        { "Cæ §å Trïng Sinh", "gutuchongsheng"; show = 0 },
        { "TiÕt ngo¹i sinh chi", "outof_tree"; show = 0 },
        { "Phong Ên chi kÝnh", "pressurize_mirror"; show = 0 },

    }

    local zhixian_step = GetTaskByte(Task_zhixian, 1)
    if ((zhixian_step == 10 or zhixian_step == 12 or (HaveIBBuff(692) > 0 and zhixian_step == 16)) and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        tasks[1].show = 1
    end

    if ((zhixian_step == 7 or zhixian_step == 9) and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() > 0) then
        tasks[2].show = 1
    end

    if (zhixian_step == 6) and (GetPlayerExtLevel() >= 50 and GetJusticEvilCredit() > 0) then
        tasks[3].show = 1
    end

    if (zhixian_step == 17 or zhixian_step == 19) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        tasks[4].show = 1
    end
    if (zhixian_step == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        tasks[4].show = 1
    end

    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)
    if ((GetPlayerExtLevel() >= 59 or GetTaskByte(1481, 1) == 1) and Outoftree_step == 0 and GetJusticEvilCredit() > 0) then
        tasks[5].show = 1
    end

    if GetPlayerExtLevel() >= 60 and Outoftree_step == 9 and GetJusticEvilCredit() > 0 then
        tasks[6].show = 1
    end

    if GetTaskByte(Task_Outoftree, 1) == 10 and GetTaskByte(1481, 1) == 1 then
        ClearItem(6, 1, 524, 0)
        SetTaskByte(1481, 1, 2)
        TaskNote(108, -1)
    end

    SetTask(142, DialogNpcIdx)
    SayTask("Kh«ng ai nh×n thÊy ta…", tasks)
end;

function wine_friend()
    CloseDialog()

    if (GetTaskByte(Task_zhixian, 1) == 10 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        Talk(3, "no", "Theo ®iÒu tra cña ta, Cæ §å Tµn PhiÕn thø 2 ®ang trn tay téc nh©n <c=r>YÓn Tö Minh<c> cña bé l¹c Di Ph­¬ng. H¾n n¾m gi÷ bÝ mËt Ngôc Ph¸p thÇn khÝ, nÕu cã ®­îc lßng tin cña téc nh©n bé l¹c sÏ dÔ dµng ®iÒu tra vÒ Tµn PhiÕn h¬n.", GetName() .. "Lµm sao ®Ó cã ®­îc lßng tin cña hä?", "Ta nghe nãi ®¹i phu <c=r>YÓn Phong<c> cña bé l¹c Di Ph­¬ng ®ang cÇn gióp ®ì, ®©y lµ mét c¬ héi tèt ®Êy.")
        Msg2Player("Hoµn thµnh nhiÖm vô tuÇn hoµn cña YÓn Phong, tranh thñ sù tin t­ëng cña téc nh©n bé l¹c Di Ph­¬ng.")
        TaskNote(106, 2)
        SetTaskByte(Task_zhixian, 1, 11)

        refreshNpcTaskState()

        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 12 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        Talk(1, "no", "Xem ra Tµn PhiÕn ®Ých thËt Èn chøa bÝ mËt vÒ thÇn khÝ, ®­îc biÕt <c=r>YÓn Tö Minh<c> rÊt thÝch uèng r­îu, kh«ng chõng sÏ r­îu vµo lêi ra.", GetName() .. " §Õn ®©u míi t×m ®­îc r­îu ngon?", "Cã thÓ ng­¬i ch­a biÕt, <c=r>YÓn Phong<c> còng lµ mét tay nÊu r­îu giái, <c=g>Thanh Hoa töu<c> cña h¾n h­¬ng vÞ rÊt thuÇn, ta nghe nãi h¾n th­êng ®em tÆng r­îu cho nh÷ng ai ®· gióp ®ì h¾n.")
        Msg2Player("Hoµn thµnh nhiÖm vô tuÇn hoµn cña YÓn Phong, cã thÓ nhËn ®­îc Thanh Hoa Töu.")
        TaskNote(106, 5)
        SetTaskByte(Task_zhixian, 1, 13)

        refreshNpcTaskState()

        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 16 and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0 and HaveIBBuff(692) > 0) then
        local npcMapid, x, y = GetNpcWorldPos(GetTask(Task_stone))
        local distance = math.floor(((1929 - x) ^ 2 + (3631 - y) ^ 2) ^ 0.5 * 32)
        if (distance > 400) then
            Msg2Player("HuyÒn Th¹ch c¸ch MËt th¸m Tiªn giíi qu¸ xa.")
        else
            Talk(1, "no", "Lµm tèt l¾m, ta sÏ t×m c¸ch më viªn ThÊt Th¸i HuyÒn Th¹ch nµy, ®©y lµ phÇn th­ëng cña ng­¬i. TiÕp theo ®©y ta cÇn t×m tung tÝch cña Tµn PhiÕn cuèi cïng, ®îi khi ®¹t cÊp 55 h·y ®Õn t×m ta.")

            local addexp = AddOwnExtendExp(3600000)
            TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
            Msg2Player("Hoµn thµnh DÜ Töu Héi H÷u, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")

            TaskNote(106, -1)
            TaskNote(107, 1)
            RemoveIBBuff(692)
            SetTaskByte(Task_zhixian, 1, 17)
            DelNpc(GetTask(Task_stone))

            refreshNpcTaskState()

        end
    end
end

function lost_book()
    CloseDialog()

    local zhixian_step = GetTaskByte(Task_zhixian, 1)
    if (zhixian_step == 7 and GetPlayerExtLevel() >= 51 and GetJusticEvilCredit() > 0) then
        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "MËt Th¸m Tiªn Giíi:Hµnh trang kh«ng ®ñ chç trèng, h·y s¾p xÕp l¹i råi ®Õn ®©y.")
        else
            Talk(3, "no", "Ta ®· t×m ®­îc manh mèi cña Tµn PhiÕn thø nhÊt: Quanh Ngôc Ph¸p S¬n cã 4 <c=r>Ph¸p trô <c>, nh÷ng <c=r>Ph¸p trô <c> ®­îc c¸c <c=r>Thñ Hé Thó<c> b¶o vÖ, cã thÓ trªn ng­êi chóng cã <c=g>Tµn PhiÕn Cæ §å<c>.", GetName() .. " Sao ta ch­a bao giê thÊy <c=r>Thñ Hé Thó<c> mµ ng­¬i nãi ®Õn?", "B×nh th­êng bän <c=r>Thñ Hé Thó<c> sÏ kh«ng xuÊt hiÖn, trõ khi Ph¸p trô bÞ uy hiÕp. Ta cã 1 <c=g>Hµm Long Ph­ín<c>, cã thÓ dÉn dô chóng xuÊt hiÖn.")

            SetTaskByte(Task_zhixian, 1, 8)
            SetSubTask(105, 1, 1)
            ClearItem(6, 1, 523, 0)
            AddNormalItem(6, 1, 523, 0, 0, 0)
            TaskNote(105, 2)

            refreshNpcTaskState()

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

        refreshNpcTaskState()

        local addexp = AddOwnExtendExp(2200000)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh ThÊt l¹c chi th­, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")
        SetSubTask(105, -1, 1)
        TaskNote(105, -1)
        TaskNote(106, 1)

        ClearItem(4, 257, 0, 1)
        ClearItem(6, 1, 523, 0)
    end
end

function gutuchongsheng()
    CloseDialog()

    if (GetTaskByte(Task_zhixian, 1) == 17) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        Talk(1, "book3", "Ta ®· biÕt tung tÝch cña Tµn PhiÕn cuèi cïng, nh­ng e lµ cã chót khã kh¨n…", GetName() .. " Sao c¸c h¹ l¹i nãi vËy? Tµn PhiÕn cuèi cïng thËt ra ®ang ë ®©u?", "Ma giíi còng ®ang t×m Ngôc Ph¸p thÇn khÝ, Tµn PhiÕn cuèi cïng cña Cæ §å còng bÞ chóng lÊy mÊt, c¸ch ®©y kh«ng xa, cã 1 MËt th¸m Ma giíi, Tµn PhiÕn ®ang trong tay h¾n.")
        return 0
    end

    if (GetTaskByte(Task_zhixian, 1) == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        TaskNote(107, 2)
        return 0
    end

    if (GetTaskByte(Task_zhixian, 1) == 19) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() > 0) then
        if (HaveNormalItem(4, 257, 0, 1) == 0) then
            Talk(1, "no", "H·y ®em theo <c=g>Tµn PhiÕn Cæ §å<c> råi ®Õn t×m ta.")
            return
        end

        Talk(1, "no", "ThËt lîi h¹i, ng­¬i cã thÓ chÕ phôc bÊy nhiªu ng­êi, ®o¹t l¹i Tµn PhiÕn! Ng­¬i ®· gióp Tiªn giíi t×m l¹i Ngôc Ph¸p thÇn khÝ, lËp ®­îc c«ng lín! §©y lµ phÇn th­ëng, h·y nhËn lÊy!")

        SetTaskByte(Task_zhixian, 1, 20)

        refreshNpcTaskState()

        local addexp = AddOwnExtendExp(6000000)

        if (math.random(1, 2) == 1) then
            AddBlueEquip(0, 2, GetPlayerType() + 18, 1, 0, 0, 1)
        else
            AddBlueEquip(0, 9, GetPlayerType() + 18, 1, 0, 0, 1)
        end
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh Cæ §å Trïng Sinh, nhËn ®­îc " .. addexp .. " kinh nghiÖm vµ 1 trang bÞ xanh.")

        TaskNote(107, -1)

        ClearItem(4, 257, 0, 1)
        return
    end

    if (GetTaskByte(Task_zhixian, 1) == 18) and (GetPlayerExtLevel() >= 55 and GetJusticEvilCredit() < 0) then
        Talk(1, "book4", "Ng­êi cña Ma giíi? Hõ, nh©n lóc ta ch­a ®éng thñ, h·y ch¹y cµng xa cµng tèt.", GetName() .. "ThËt ng«ng cuång, h«m nay ta ®Õn ®Ó cho ng­¬i 1 bµi häc! Nh­ng nÕu ng­¬i ngoan ngo·n giao nép Tµn PhiÕn Cæ §å, ta cã thÓ tha cho!", "Víi søc ng­¬i µ? Cø thö xem!")
    end
end

function warmitanmo(warmitanIdx, dlgIndex)
    SetNpcScript(warmitanIdx, "\\script\\¹ÖÎï\\Õ½¶·ÃÜÌ½ÏÉ»ÙÃð.lua")
    SetNpcTimer(warmitanIdx, "\\script\\ontimer\\Õ½¶·ÃÜÌ½×Ô¼ì.lua", 60)
    SetNpcName(warmitanIdx, "MËt th¸m Tiªn giíi")
    SetNpcCamp(warmitanIdx, 3)

    SetNpcTask(warmitanIdx, 1, 1)
    SetNpcTask(warmitanIdx, 2, GetNpcLife(warmitanIdx))
    SetNpcTask(warmitanIdx, 3, dlgIndex)
end

function flower_Talk()
    CloseDialog()
    Talk(4, "no", GetName() .. "Ng­¬i lµ ai? Sao l¹i xuÊt hiÖn ë ®©y? Cã ý ®å g×?", "Cïng lµ ng­êi cña Tiªn giíi, h¼n ng­¬i còng nghe nãi gÇn ®©y Ngôc Ph¸p S¬n cã thÇn khÝ xuÊt hiÖn, ta phông mÖnh ®Õn ®iÒu tra viÖc nµy.", GetName() .. " Ra vËy, thø lçi ®· m¹o ph¹m.", "Kh«ng sao. Míi ®©y ta t×nh cê cã ®­îc 1 Tµn PhiÕn Cæ §å, d­êng nh­ cã liªn quan ®Õn thÇn khÝ, ta ®ang ®iÒu tra tung tÝch cña nh÷ng Tµn PhiÕn cßn l¹i, ®îi anh hïng ®¹t ®Õn cÊp 51 h·y quay l¹i!")
    SetTaskByte(Task_zhixian, 1, 7)
    SetSubTask(104, -1, 1)
    TaskNote(104, -1)
    TaskNote(105, 1)

    refreshNpcTaskState()

end

function book3()
    Talk(2, "no", GetName() .. " Ch¼ng qua lµ vµi tªn trong Ma giíi, h·y ®îi 1 l¸t, xem ta chÕ phôc chóng ®o¹t l¹i Tµn PhiÕn.", "Chí ®¾c ý, tªn nµy c«ng lùc kh«ng nhá, 1 m×nh ng­¬i ®èi phã kh«ng l¹i ®©u, tèt nhÊt nªn t×m vµi ng­êi b¹n ®i cïng.")
    TaskNote(107, 3)
    SetTaskByte(Task_zhixian, 1, 18)

    refreshNpcTaskState()

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
    local warmitanIdx = AddNpc(1104, 65, SubWorld, 1929 * 32, 3631 * 32)
    Msg2CurMapAnnounce("Ma giíi ®ang g©y rèi, hìi c¸c Tiªn giíi ®¹o h÷u, mau ®Õn gióp ta!")
    warmitanmo(warmitanIdx, npcindex)
    CaptureNpc(npcindex)

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

function outof_tree()
    CloseDialog()
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)
    if (GetTaskByte(1481, 1) == 1) then
        Talk(3, "no", "Kh«ng biÕt anh hïng ®Õn ®©y cã viÖc g×?", GetName() .. " ¸i dµ, kÝnh nµy do 1 vÞ ®ång ®¹o ®· ñy th¸c ta, nhê ta b¸o ®Õn c¸c h¹ r»ng khi anh ta ®ang t×m kiÕm thÇn binh th× bÞ mét ng­êi lai lÞch bÊt minh tËp kÝch, cæ ®å còng bÞ ®o¹t ®i.", "Ra vËy, ta nhÊt ®Þnh ph¶i t×m ra kÎ ng«ng cuång nµy, b¸o thï cho ®¹o h÷u. Anh hïng ®¹t cÊp 59 th× quay l¹i t×m ta, cïng bµn kÕ ho¹ch phôc thï.")

        local addexp = AddOwnExtendExp(850000)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")

        SetTaskByte(1481, 1, 2)
        ClearItem(6, 1, 524, 0)
        TaskNote(108, 21)

        refreshNpcTaskState()

        return
    end

    if (Outoftree_step == 0) then
        Talk(3, "tree3", "Ngôc Ph¸p S¬n qu¶ lµ n¬i thÞ phi! ViÖc t×m kiÕm Ngôc Ph¸p thÇn khÝ l¹i gÆp trë ng¹i.", GetName() .. "Tiªn sinh ®ang nãi ®Õn viÖc Cæ ®å bÞ c­íp ph¶i kh«ng.", "Xem ra anh hïng ®· biÕt, bän ¸c nh©n ë Ngôc Ph¸p S¬n ®· ®¶ th­¬ng c¸c ®¹o h÷u, c­íp ®i Cæ §å cã thÓ ghi chÐp tung tÝch cña thÇn khÝ…")
    end
end

function tree1()
    CloseDialog()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Cæ kÝnh nµy lÊy ®­îc tõ trªn ng­êi h¾n, cã lÏ sÏ gióp Ých cho ng­¬i, nh­ng hµnh trang cña ng­¬i ®· ®Çy, kh«ng thÓ nhËn ®­îc.")
        return
    else
        Talk(1, "no", "Cæ kÝnh nµy lÊy ®­îc tõ trªn ng­êi h¾n, cã lÏ sÏ gióp Ých cho ng­¬i.")
        if (IsExistItem(6, 1, 524, 0) == 0) then
            AddNormalItem(6, 1, 524, 0, 0, 0)
            Msg2Player(" §­îc Phong Ên chi kÝnh.")
            SetTaskByte(Task_Outoftree, 1, 1)
            SetSubTask(108, 1, 1)
            TaskNote(108, 0)
            Msg2Player("§Õn §«ng Ngôc Ph¸p S¬n, t×m KhiÕu L«i.")

            refreshNpcTaskState()

        end
    end

end

function tree2()
    CloseDialog()
    MsgBox(GetName() .. " §­îc, t¹i h¹ nhÊt ®Þnh sÏ cho tªn ng«ng cuång nµy 1 bµi häc!", "tree1", "no")
end

function tree3()
    CloseDialog()
    Talk(2, "tree2", GetName() .. " KÎ nµo to gan nh­ vËy? ThËt ch¼ng xem Tiªn giíi ta ra g×. Ta ph¶i cho chóng bµi häc míi ®­îc.", "KÎ nµy tªn KhiÕu L«i, së tr­êng dïng L«i ph¸p, th­êng xuÊt hiÖn ë §«ng Ngôc Ph¸p S¬n, mong anh hïng gióp chÕ phôc kÎ nµy, ®o¹t l¹i Cæ §å.")
end

function pressurize_mirror()
    CloseDialog()
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)
    if (Outoftree_step == 9) then


        if (HaveNormalItem(6, 1, 524, 0) == 0 and HaveNormalItemInQuick(6, 1, 524, 0) == 0) then
            Talk(1, "no", "Cæ §å ®· bÞ h¾n tiªu hñy råi… Ng­¬i cã thÓ ®i t×m <c=g>Phong Ên chi kÝnh<c> gióp ta, cã thÓ sÏ t×m ®­îc th«ng tin míi tõ ®©y.")
            Msg2Player("§em Phong Ên chi kÝnh giao cho MËt th¸m.")
            return
        end

        if (IsHaveSpaceForTreasure(2) == 0 and HaveNormalItemInQuick(6, 1, 524, 0) > 0) then
            Talk(2, "no", GetName() .. "ThËt hæ thÑn, tuy ta ®· chÕ phôc h¾n, nh­ng l¹i kh«ng ®o¹t l¹i ®­îc Cæ §å, xem ra nã ®· bÞ h¾n tiªu hñy råi.", "¤i, Cæ §å ®· bÞ hñy mÊt råi… Ta cã mét sè vËt dông nho nhá, coi nh­ ®¸p t¹ sù vÊt v¶ cña ng­¬i bÊy l©u, nh­ng hµnh trang cña ng­¬i ®· ®Çy, h·y s¾p xÕp råi quay l¹i sau.")
            TopMessage("Hµnh trang ®· ®Çy")
            Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn th­ëng.")
            return
        end

        if (DelNormalItem(6, 1, 524, 0) == 0) then
            DelNormalItemInQuick(6, 1, 524, 0)
        end
        SetTaskByte(Task_Outoftree, 1, 10)
        TaskNote(108, -1)

        refreshNpcTaskState()

        local addexp = AddOwnExtendExp(5000000)
        Msg2Player("NhiÖm vô hoµn thµnh, nhËn ®­îc " .. addexp .. " kinh nghiÖm vµ 1 trang bÞ xanh.")

        local TypeofPlayer = GetPlayerType() + 1
        local RandofEquip = math.random(1, 3)
        AddBlueEquip(myunpack(CONST_MIRROR_EQUIP[TypeofPlayer][RandofEquip].item))
        local equip_name = CONST_MIRROR_EQUIP[TypeofPlayer][RandofEquip].name
        TopMessage("NhËn ®­îc <c=water>" .. equip_name .. "<c>")
        Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc " .. equip_name)

        Talk(2, "no", GetName() .. "ThËt hæ thÑn, tuy ta ®· chÕ phôc h¾n, nh­ng l¹i kh«ng ®o¹t l¹i ®­îc Cæ §å, xem ra nã ®· bÞ h¾n tiªu hñy råi.", "¤i, Cæ §å ®· bÞ hñy mÊt råi… Ta cã mét sè vËt dông nho nhá, coi nh­ ®¸p t¹ sù vÊt v¶ cña ng­¬i bÊy l©u.")
    end
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end

function quxiao()
    CloseDialog()
    MsgBox("B¹n x¸c nhËn muèn hñy bá nhiÖm vô?", "quxiao_confirm", "no")
end

function quxiao_confirm()
    CloseDialog()
    local step = GetTaskByte(Task_zhixian, 1)
    if ((step == 11 or step == 12 or step == 13 or step == 14 or step == 15 or step == 16) and GetPlayerExtLevel() >= 53 and GetJusticEvilCredit() > 0) then
        ClearItem(4, 256, 0, 1)
        SetTaskByte(Task_zhixian, 1, 10)
        SetTaskByte(Task_zhixian, 2, 0)
        SetTaskByte(Task_zhixian, 3, 0)
        local stoneIdx = GetTask(Task_stone)
        if (stoneIdx ~= 0) then
            DelNpc(stoneIdx)
            RemoveIBBuff(692)
        end
        TaskNote(106, -1)
        Msg2Player("Hñy bá nhiÖm vô DÜ Töu Héi H÷u")
    end
end

function no()
    CloseDialog()
end
