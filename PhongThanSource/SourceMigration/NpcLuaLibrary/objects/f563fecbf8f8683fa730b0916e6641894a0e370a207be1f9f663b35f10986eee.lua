--description:ÏÉ£ºĞş×Ó.ÕòĞĞÊ¹
--author: yaoxin
--date: 2009/2/23

--ÌìÔÀÑÖÂŞ
yanluo_renwu = 1333 --ÈÎÎñ²½Öè(1½Ó,2É±ËÀÇÕÔ­,3É±ËÀÀëÖì,»ØÈ¥ÁìÈÎÎñ,4ÕÒÆë5¸ö¿ªÆô·¨Õó,½øÈëÕó,100Íê³É)
yanluo_npc = 1334 --¼ÇÂ¼½øÈëµÄnpcIndex
yanluo_teamtask = 2 --¶ÓÎéÈÎÎñ±äÁ¿, 0Îª²»¿ÉÓënpc¶Ô»°,1-6Îª¿É¶Ô»°µ«ÊÇÓĞÈË²»ÔÚnpcÄÚ,7ÎªÈ«ÔÚnpcÄÚ
yanluo_teamtask_id = 3 --¶ÓÎéÈÎÎñ±äÁ¿, ¶Ó³¤µÄid

--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 begin
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

    --ÌìÔÀÑÖÂŞ
    startLevel = 26
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() > 0) then
        local task = GetTaskByte(yanluo_renwu, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            --½ğÉ«
            if (task == 0) then
                state = 1
                subState = 0
            elseif (task == 3) or (task == 4) then
                state = 3
                subState = 0
            elseif (task == 1) or (task == 2) then
                state = 2
                subState = 0
            end
        else
            --À¶É«
            if (task == 0) then
                state = 1
                subState = 1
            elseif (task == 3) or (task == 4) then
                state = 3
                subState = 1
            elseif (task == 1) or (task == 2) then
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
--Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 end

function main()
    if (beginNpc() == 0) then
        local tasks = {
            { "Thiªn Nh¹c Diªm La", "renwu26"; show = 0 },
            { "Hñy báThiªn Nh¹c Diªm La", "renwu26_cancel"; show = 0 },
        }
        if (GetPlayerExtLevel() >= 26) then
            local state26 = GetTask(yanluo_renwu)
            if (state26 < 100) and (GetJusticEvilCredit() > 0) then
                if (state26 == 0) then
                    tasks[1].show = 1
                elseif (HaveNormalItem(6, 1, 444, 0) > 0) and (state26 == 3 or state26 == 4) then
                    tasks[1].show = 1
                else
                    tasks[2].show = 1
                end
            end
        end
        SayTask("Thiªn Nh¹c lµ mét n¬i Èn tµng cña Th­îng giíi. Ph¸p trËn nµy gäi lµ Tö Ngä Qu¸n. Ta v× truy b¾t mét ®¹o ph¹m ë Thiªn Nh¹c mµ l¹c ®Õn ®©y", tasks)
    end
end;
------------------ÌìÔÀÑÖÂŞ------------------------------
function renwu26()
    CloseDialog()
    local state26 = GetTask(yanluo_renwu)
    if (state26 == 0) then
        MsgBox("Chóng ta bè trËn nµy ®Ó v©y h·m Ma ®Çu hung thó, nh­ng giê Ph¸p b¶o ®Ó trÊn ph¸p trËn ®· bŞ lÊy trém, hung thó rÊt cã thÓ sÏ ph¸ ®­îc trËn. Anh hïng cã thÓ gióp ta ®i t×m l¹i ®­îc kh«ng?", "yanluo_yes", "no")
    elseif (state26 == 3) then
        if (HaveNormalItem(6, 1, 444, 0) > 0) then
            Talk(2, "no", "Muèn tiªu diÖt Ma ®Çu nµy cÇn ph¶i cã ng­êi khëi ®éng ®­îc ph¸p trËn. Ng­¬i ph¶i t×m ®­îc <c=g>5<c> ng­êi cïng phe cÊp Tiªn Ma trªn <c=g>20<c> ®Õn ®Ó më trËn, viÖc lín tÊt thµnh!", "NÕu trong ®éi ngò cña ng­¬i ®· cã NhÊt Khİ Tö V©n Sa, th× cã thÓ cïng nhau hoµn thµnh!")
            SetTask(yanluo_renwu, 4)
            refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
            TaskNote(95, 3)
            Msg2Player("T×m thªm 5 ng­êi cïng trËn doanh vµ cã cÊp Tiªn Ma trªn 20 tæ ®éi ®Õn ®©y lµ cã thÓ khëi ®éng trËn ph¸p")
        else
            Talk(1, "no", "B¶o vËt NhÊt Khİ Tö V©n Sa ®©u? §­a nã cho ta, ta míi cã thÓ më ®­îc ph¸p trËn!")
        end
    elseif (state26 == 4) then
        local membercount = GetTeamSize()
        if (IsCaptain() == 1) and (membercount == 6) then
            local oldplayer = PlayerIndex
            local key = 0
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                if (GetPlayerExtLevel() >= 20) and (GetJusticEvilCredit() > 0) then
                    key = key + 1
                elseif (GetPlayerExtLevel() < 20) then
                    Msg2Team(GetName() .. "_®¼ng cÊp ch­a ®ñ 20, kh«ng thÓ më trËn ph¸p!")
                else
                    Msg2Team(GetName() .. " kh«ng cïng phe víi ®éi tr­ëng!")
                end
            end
            PlayerIndex = oldplayer

            if (key == 6) then
                Talk(1, "no", "Ng­¬i vµ ®ång ®éi cña m×nh mçi ng­êi t×m 1 <c=g>TrÊn Hµnh Sø<c> ®èi tho¹i, sau khi ®èi tho¹i hoµn tÊt th× sö dông <c=g>NhÊt Khİ Tö V©n Sa<c> ®Ó më ph¸p trËn.")
                TaskNote(95, 4)
                SetTeamTask(yanluo_teamtask, 1)
                SetTeamTask(yanluo_teamtask_id, GetPlayerID())
                Msg2Team("<HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73,229,221]\">T×m ph¸p trËn Tö Ngä Qu¸n")
            else
                SetTeamTask(yanluo_teamtask, 0)
                Talk(1, "no", "CÇn cã <c=g>5<c> Tiªn Ma ®¼ng cÊp <c=g> trªn 20<c> cïng phe víi nhau míi ®­îc, nÕu kh«ng bän ta rÊt khã thi triÓn ph¸p lùc.")
            end
        else
            Talk(1, "no", "CÇn cã <c=g>5<c> Tiªn Ma ®¼ng cÊp <c=g> trªn 20<c> cïng phe víi nhau, ph¶i do ng­¬i ®¶m nhiÖm <c=g>§éi tr­ëng<c>, nÕu kh«ng bän ta rÊt khã thi triÓn ph¸p lùc.")
        end
    end
end

function yanluo_yes()
    CloseDialog()
    if (GetTask(yanluo_renwu) > 0) or (GetJusticEvilCredit() <= 0) then
        return 0
    end
    SetTask(yanluo_renwu, 1)
    refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
    TaskNote(95, 0)
    Talk(1, "no", "Kh«ng cã ph¸p b¶o <c=g>NhÊt Khİ Tö V©n Sa<c> th× kh«ng thÓ xoay chuyÓn ®­îc ph¸p trËn nµy! H«m ®ã khi Ph¸p b¶o bŞ mÊt, ta cã nh×n thÊy <c=g>Ma Kh©m Nguyªn<c> ®i ra tõ ®©y. H·y ®i t×m Ma Kh©m Nguyªn, nhÊt ®Şnh lµ cã manh mèi!")
    Msg2Player("§i t×m Ma Kh©m Nguyªn, xem thö cã ph¶i lµ h¾n ®ang gi÷ b¶o vËt!")
    TopMessage("NhËn nhiÖm vô <c=g>Thiªn Nh¹c Diªm La<c>")
    SetSubTask(95, 1, 1)
end

function renwu26_cancel()
    --È¡Ïû
    CloseDialog()
    MsgBox(" Kh«ng sao! Søc bän ta vÉn cßn cã thÓ gi÷ trËn thªm mét thêi gian n÷a! Anh hïng thong th¶ quay l¹i sau còng ®­îc!", "cancel_yanluo", "no")
end

function cancel_yanluo()
    CloseDialog()
    ClearItem(6, 1, 444, 0)--Ò»Æø×ÏÔÆÉ´
    SetTask(yanluo_renwu, 0)
    refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
    Talk(1, "no", " Kh«ng sao! Søc bän ta vÉn cßn cã thÓ gi÷ trËn thªm mét thêi gian n÷a!")
    TaskNote(95, -1)
end

function beginNpc()
    CloseDialog()
    if (GetTeamSize() ~= 6) or (GetJusticEvilCredit() <= 0) or (GetPlayerExtLevel() < 20) or (team_renwu() == 0) then
        if (GetTask(yanluo_npc) == DialogNpcIdx) then
            local npcidx = GetTask(yanluo_npc)
            PlayerInOrOut(0, npcidx)
            NpcPolyMorph(npcidx, -1)
            SetTask(yanluo_npc, 0)
            refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
            RemoveIBBuff(535)
        end
        return 0
    end

    SetTask(142, DialogNpcIdx)
    refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
    if (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        if (DialogNpcIdx == GetTask(yanluo_npc)) then
            MsgBox(" Muèn gi¶i bá tr¹ng th¸i trªn ng­êi kh«ng?", "out", "no")
        end
    else
        if (GetSiegeWeaponPlayerCount(DialogNpcIdx) >= 1) then
            Talk(1, "no", " Ta kh«ng thÓ cïng lóc phô thÓ cho nhiÒu ng­êi! Ng­¬i h·y quay l¹i sau nhĞ!")
            return 1
        end
        MsgBox(" Ta lËp tøc phô thÓ cho ng­¬i ®©y! S½n sµng tiÕp nhËn ch­a?", "enter", "no")
    end
    return 1
end

function team_renwu()
    if (GetTeamTask(yanluo_teamtask) <= 0) then
        return 0
    end

    local membercount = GetTeamSize()
    local oldPlayer = PlayerIndex
    for i = 1, membercount do
        PlayerIndex = GetTeamMember(i)
        if (GetTeamTask(yanluo_teamtask_id) == GetPlayerID()) then
            if (GetTask(yanluo_renwu) >= 3) and (GetTask(yanluo_renwu) < 100) and (HaveNormalItem(6, 1, 444, 0) > 0) then
                PlayerIndex = oldPlayer
                return 1
            end
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
    SetTeamTask(yanluo_teamtask, GetTeamTask(yanluo_teamtask) + 1)
    local ty = GetPlayerType()
    local sex = GetSex()
    NpcPolyMorph(npcidx, 865 + ty * 2 + sex)
    SetTask(yanluo_npc, npcidx)
    refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
    PlayerInOrOut(1, npcidx)
end;

function out()
    CloseDialog()
    local npcidx = GetTask(yanluo_npc)
    if (npcidx == GetTask(142)) then
        RemoveIBBuff(535)
        SetTeamTask(yanluo_teamtask, GetTeamTask(yanluo_teamtask) - 1)
        NpcPolyMorph(npcidx, -1)
        SetTask(yanluo_npc, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 
        PlayerInOrOut(0, npcidx)
    end
end;

---------------------------------------------------------------------------------

function no()
    CloseDialog()
end;

function OnDeath(carriagenpcindex)
end