Task_baichuan = 1364
Global_luohou = 180

task_deer = 1467

yanluo_npc = 1334

Tower_Camp = {
    { desc = "Canh Th­¬ng" },
    { desc = "Quú Vò" },
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

    startLevel = 46
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 3) then
                state = 3
                subState = 0
            end
        else
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 3) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 47
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 4) then
                state = 1
                subState = 0
            elseif (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 5) then
                state = 3
                subState = 0
            end
        else
            if (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 4) then
                state = 1
                subState = 1
            elseif (GetJusticEvilCredit() > 0 and GetTaskByte(Task_baichuan, 1) == 5) then
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
    if (beginNpc() == 0) then
        local tasks = {
            { "ChuyÓn tiÕp", "send"; show = 0 },
            { "B¸ch Xuyªn Héi Tô", "baichuan"; show = 0 },
        }

        local bianliang = GetTaskByte(Task_baichuan, 1)

        if (GetJusticEvilCredit() > 0) then
            tasks[1].show = 1
        end

        if (GetPlayerExtLevel() >= 46 and (bianliang == 3 or bianliang == 4 or bianliang == 5) and GetJusticEvilCredit() > 0) then
            tasks[2].show = 1
        end

        SayTask("Ng­êi trong Thiªn Nh¹c kh«ng ai kh«ng biÕt râ Phong CÊm ThuËt, ng­êi tu ®¹o sau khi chÕt hån ph¸ch kh«ng mÊt ®i, ®Òu cã thÓ trë thµnh hé ph¸p kú trËn, kú trËn c«ng dông kh¸c nhau nh­ng cÇn ph¶i vËn lùc Tiªn, Ma ®¹o thÓ míi ®­îc. Ta lµ Can Kim thÓ, hµng tiªn nh©n.", tasks)
    end
end;

function send()
    CloseDialog()
    NewWorld(74, 1974, 3668)
end

function baichuan()
    CloseDialog()

    if (GetPlayerExtLevel() >= 46 and GetTaskByte(Task_baichuan, 1) == 3 and GetJusticEvilCredit() > 0) then
        renwu()
        return
    end

    if (GetPlayerExtLevel() >= 47 and GetTaskByte(Task_baichuan, 1) == 4 and GetJusticEvilCredit() > 0) then
        luohou()
        return
    end

    if (GetPlayerExtLevel() >= 47 and GetTaskByte(Task_baichuan, 1) == 5 and GetJusticEvilCredit() > 0) then
        success()
        return
    end

end

function renwu()
    CloseDialog()

    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end

    if (GetPlayerExtLevel() >= 46 and GetTaskByte(Task_baichuan, 1) == 3 and GetJusticEvilCredit() > 0) then
        if (GetPlayerExtLevel() < 47) then
            Talk(1, "no", "§¹i Uy Thiªn Long nhiÒu lÇn gióp Thiªn Nh¹c ta, hiÖn c¸c h¹ ®ang gÆp n¹n, chóng ta gióp ®ì lµ ®iÒu ®­¬ng nhiªn, trÊn ®éng t¹i BÊt Chu S¬n lµ do th­îng giíi <c=g>Ngôc Ph¸p S¬n<c> cã biÕn cè, cã mét thÕ lùc tµ ¸c ®ang nh»m chiÕm ®o¹t n¬i ®©y, nÕu nh­ ng­¬i cã lßng gióp ®ì, ®¼ng cÊp tiªn mµ ®¹t <c=g>47<c> h·y quay l¹i ®©y.")
            TaskNote(1037, 4, Tower_Camp[gdCamp].desc)
        else
            Talk(2, "no", " <c=g>La HÇu<c> lµ di téc cña hung thÇn th­îng cæ, lµ thiªn ®Şch cña chóng ta, hiÖn ®· biÕt chóng ta lËp trËn ph¸p thñ hé BÊt Chu S¬n, h¾n nhÊt ®Şnh sÏ mß ®Õn quÊy nhiÔu. NÕu nh­ tiªu diÖt ®­îc h¾n, duy tr× trËn ph¸p, BÊt Chu S¬n sÏ cã thÓ duy tr× ®­îc thanh tŞnh", "NÕu ch­a tËn tay tiªu diÖt La HÇu còng ®õng buån phiÒn, cã thÓ quay vÒ gÆp ta, sÏ cã c¸ch kh¸c!")
        end

        local addexp = AddOwnExtendExp(5000000)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh nhiÖm vô B¸ch Xuyªn Héi Tô, nhËn ®­îc <c=g>" .. addexp .. "<c> tu luyÖn")
        SetTaskByte(Task_baichuan, 1, 4)

        refreshNpcTaskState()

    end
end

function luohou()
    CloseDialog()

    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end
    if (GetPlayerExtLevel() >= 47 and GetTaskByte(Task_baichuan, 1) == 4 and GetJusticEvilCredit() > 0) then
        TaskNote(1037, 5, Tower_Camp[gdCamp].desc)
        MsgBox("La HÇu ®Õn tËp kİch, nhÊt ®Şnh ®ang lÈn trèn quanh ®©y, chóng ta ph¶i duy tr× trËn ph¸p kh«ng ®­îc ph©n t©m, nªn cÇn sù gióp ®ì cña ng­¬i, ng­¬i sÏ ®i tiªu diÖt nã chø?", "yes", "no")
    end
end

function yes()
    CloseDialog()
    local nMapNpcIndex = GetGlobalValue(Global_luohou)
    if (nMapNpcIndex == 0) then
        local mapid = SubWorldID2Idx(74)
        local luohouIdx = AddNpc(927, 50, mapid, 1944 * 32, 3731 * 32)
        SetNpcTask(luohouIdx, 1, GetPlayerID())
        SetNpcTask(luohouIdx, 2, PlayerIndex)
        SetGlobalValue(Global_luohou, luohouIdx)
        SetNpcName(luohouIdx, "La HÇu")
        SetNpcTimer(luohouIdx, "\\script\\ontimer\\ÂŞºíÉ¾³ı×Ô¼º.lua", 1800)

    elseif (nMapNpcIndex ~= 0 and GetNpcTask(nMapNpcIndex, 1) == GetPlayerID()) then
        Talk(1, "no", "La HÇu ®· xuÊt hiÖn, h·y ®i tiªu diÖt nã.")
    else
        Talk(1, "no", "§· cã vŞ anh hïng hiÖp sÜ chiÕn ®Êu víi La HÇu, ng­¬i h·y quay l¹i sau.")
    end
end

function success()
    CloseDialog()
    if (GetPlayerExtLevel() >= 47 and GetTaskByte(Task_baichuan, 1) == 5 and GetJusticEvilCredit() > 0) then
        Talk(1, "no", "La HÇu ®· bŞ tiªu diÖt, BÊt Chu S¬n ®· lÊy l¹i sù thanh tŞnh, ®©y lµ c«ng lao cña ng­¬i, nh­ng mµ ®õng qu¸ ®¾c ı, tªn trËn ph¸p nµy lµ <c=g>Canh Quı Lôc Kú Phong<c>, chuyªn trÊn ¸p 1 tªn ma ®Çu, trõ ®i ma ®Çu nµy BÊt Chu S¬n míi thËt sù an tŞnh, nh­ng mµ kh«ng biÕt cÇn ngµy th¸ng n¨m nµo n÷a. LÇn nµy ng­¬i ®· hoµn thµnh nhiÖm vô, xin nhËn phÇn th­ëng!")
        local addexp = AddOwnExtendExp(6000000)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh B¸ch Xuyªn Héi Tô, nhËn ®­îc <c=g>" .. addexp .. "<c> tu luyÖn")
        TaskNote(1037, -1)
        SetTaskByte(Task_baichuan, 1, 6)
        SetSubTask(1037, -1, 1)

        refreshNpcTaskState()

    end
end

function no()
    CloseDialog()
end;

function beginNpc()
    CloseDialog()
    if (GetTeamSize() ~= 6) or (GetPlayerExtLevel() < 50) or (team_renwu() == 0) then
        if (GetTask(yanluo_npc) == DialogNpcIdx) then
            local npcidx = GetTask(yanluo_npc)
            PlayerInOrOut(0, npcidx)
            NpcPolyMorph(npcidx, -1)
            SetTask(yanluo_npc, 0)
            RemoveIBBuff(535)
        end
        return 0
    end

    SetTask(142, DialogNpcIdx)
    if (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        if (DialogNpcIdx == GetTask(yanluo_npc)) then
            MsgBox("Muèn gi¶i bá tr¹ng th¸i trªn ng­êi kh«ng?", "out", "no")
        end
    else
        if (GetSiegeWeaponPlayerCount(DialogNpcIdx) >= 1) then
            Talk(1, "no", "Ta kh«ng thÓ cïng lóc phô thÓ cho nhiÒu ng­êi! Ng­¬i h·y quay l¹i sau nhĞ!")
            return 1
        end
        MsgBox("Ta lËp tøc phô thÓ cho ng­¬i ®©y! S½n sµng tiÕp nhËn ch­a? Ph¸p lùc ta cã h¹n chØ cã thÓ duy tr× trong thêi gian <c=g>3 phót<c>.", "enter", "no")
    end
    return 1
end

function team_renwu()
    if (HaveIBBuff(687) == 0) then
        return 0
    end

    local playerid = GetWorldEventValue(3, 16)
    if (playerid == 0) then
        return 0
    end

    local membercount = GetTeamSize()
    local oldPlayer = PlayerIndex
    for i = 1, membercount do
        PlayerIndex = GetTeamMember(i)
        if (playerid == GetPlayerID()) then
            if (GetTaskByte(task_deer, 4) == 1) and (GetWorldEventValue(3, 18) == 1) and (HaveNormalItem(6, 1, 519, 0) > 0) then
                PlayerIndex = oldPlayer
                return 1
            end
        elseif (GetTaskByte(task_deer, 4) == 1) and (GetWorldEventValue(3, 18) == 1) then
            PlayerIndex = oldPlayer
            return 1
        end
    end
    PlayerIndex = oldPlayer
    return 0
end

function enter()
    CloseDialog()
    local npcidx = GetTask(142)
    if (GetTeamSize() ~= 6) or (GetSiegeWeaponPlayerCount(npcidx) >= 1) or (team_renwu() == 0) then
        return 0
    end

    local skill, type = GetCreatureInfo()
    if (type >= 0) then
        SetCreatureType(skill, type)
    end ;
    AddIBBuff(535)
    SetTeamTask(1, GetTeamTask(1) + 1)
    local ty = GetPlayerType()
    local sex = GetSex()
    NpcPolyMorph(npcidx, 865 + ty * 2 + sex)
    SetTask(yanluo_npc, npcidx)
    PlayerInOrOut(1, npcidx)
end;

function out()
    CloseDialog()
    local npcidx = GetTask(yanluo_npc)
    if (npcidx == GetTask(142)) then
        RemoveIBBuff(535)
        SetTeamTask(1, GetTeamTask(1) - 1)
        NpcPolyMorph(npcidx, -1)
        SetTask(yanluo_npc, 0)
        PlayerInOrOut(0, npcidx)
    end
end;

function OnDeath(carriagenpcindex)
end


