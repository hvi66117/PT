Task_newer13 = 1416

YIBO_110_DESASTER_STATE = 1663

FIFTEEN_DAY_BUFF = 1241

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

    startLevel = 18
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_newer13, 1) == 6) and (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 5) then
                state = 2
                subState = 0
            end
        else
            if (GetTaskByte(Task_newer13, 1) == 6) and (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 6) then
                state = 3
                subState = 1
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 5) then
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
        { "<c=yel>Th©m Nan §o¹t VËt<c>", "renwu18"; show = 0 },
        { "<c=yel>Thiªn KiÕp<c>", "Do_DesaterTask"; show = 0 },
    }
    if (GetPlayerType() == 1) then
        local state18 = GetTaskByte(Task_newer13, 2)
        if (GetLevel() >= 18) and (GetTaskByte(Task_newer13, 1) == 6) and (state18 == 0 or state18 == 6) then
            tasks[1].show = 1
        end

    end

    local taskStep = GetTaskByte(YIBO_110_DESASTER_STATE, 1)

    local pt = GetPlayerType()
    local state = 0
    if (pt == 0) then
        state = GetTask(3)
    elseif (pt == 1) then
        state = GetTask(1)
    else
        state = GetTask(2)
    end

    if (((taskStep == 0) or (taskStep == 4 and state == 123)) and HaveIBBuff(FIFTEEN_DAY_BUFF) > 0) or taskStep == 5 then
        tasks[2].show = 1
    end
    SayTask(11380, tasks)
end;

function Do_DesaterTask()
    CloseDialog()
    local tState = Get_TeamState()
    local taskStep = GetTaskByte(YIBO_110_DESASTER_STATE, 1)
    local pt = GetPlayerType()
    local state = 0
    if (pt == 0) then
        state = GetTask(3)
    elseif (pt == 1) then
        state = GetTask(1)
    else
        state = GetTask(2)
    end

    if (tState == 1) then
        if (taskStep == 0) then
            TaskNote(1518, 0)
            SetTaskByte(YIBO_110_DESASTER_STATE, 1, 1)
            Talk(2, "no", "Tu luyÖn cña anh hïng ®· ®Õn lóc ph¶i ®èi mÆt víi Thiªn KiÕp, chØ cã thay g©n ®æi cèt, chuyÓn vµo Tiªn Ma Giíi míi cã thÓ tr¸nh ®­îc kiÕp n¹n nµy.", "BÇn ®¹o kh«ng d¸m tiÕt lé c¸ch thay g©n ®æi cèt ®Ó trïng sinh thiªn giíi, anh hïng cã thÓ trë vÒ Ngäc H­ Cung cña 10 n¨m tr­íc t×m thiÕu niªn Kh­¬ng Tö Nha ®Ó hái.")
        elseif (taskStep == 4 or taskStep == 5) then
            if (state == 123) then
                local mateIdx = 0
                local selfIdx = PlayerIndex
                if (IsCaptain() == 0) then
                    mateIdx = GetTeamMember(1)
                else
                    mateIdx = GetTeamMember(2)
                end
                PlayerIndex = mateIdx
                local addPRValue = AddMasterPRValue(15)
                TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
                for i = 1, 5 do
                    AddNormalItem(3, 1088, 0, 0, 0, 0)
                end
                Msg2Player("Chóc mõng b¹n nhËn ®­îc 5 S­ ¢n LÖnh")

                PlayerIndex = selfIdx
                WriteLog("V­ît qua kiÕp n¹n cÊp 110")
                TaskNote(1518, -1)
                RemoveIBBuff(FIFTEEN_DAY_BUFF)
                SetTaskByte(YIBO_110_DESASTER_STATE, 1, 2)
                AddOwnExp(1000000)
                Msg2Player("NhËn ®­îc 1000000 kinh nghiÖm")
            else
                InfoBox("Anh hïng ch­a hoµn thµnh nhiÖm vô <c=yel>Cöu Lai<c>, h·y mau chãng hoµn thµnh nhiÖm vô nµy ®Ó tho¸t khái kiÕp n¹n!")
            end
        end
    else
        Talk(1, "no", "ViÖc nµy cÇn s­ ®å tæ ®éi!")
    end
end

function Get_TeamState()
    if (GetTeamSize() == 2) then
        local mateIdx = 0
        local selfIdx = PlayerIndex
        if (IsCaptain() == 0) then
            mateIdx = GetTeamMember(1)
        else
            mateIdx = GetTeamMember(2)
        end
        local str = GetMantleMasterName()

        PlayerIndex = mateIdx
        local mateName = GetName()
        PlayerIndex = selfIdx

        if (mateName == str) then
            return 1
        else
            return 0
        end
    end
    return 0
end

function no()
    CloseDialog()
end;

function CompleteMission18()

    AddItemPileNum(1, 0, 0, 0, 10)
    AddItemPileNum(1, 3, 0, 0, 10)
    Msg2Player("NhËn ®­îc 10 TiÓu Hång §¬n vµ 10 TiÓu Hoµn §¬n.")

    Talk(1, "no", "Ta sÏ chuyÓn ®ÕnNhiªn §¨ng §¹o Nh©n, ta tÆng ng­¬i 1 trang bÞ cÊp 20 xem nh­ lµ phÇn th­ëng c«ng lao.")
    SetTaskByte(Task_newer13, 2, 7)

    AddOwnExp(13000)
    if (math.random(1, 2) == 1) then
        AddBlueEquip(0, 2, 1, 2, 0, 1, 1)
    else
        AddBlueEquip(0, 9, 1, 2, 0, 1, 1)
    end
    DelEventItem(241)

    Msg2Player("NhËn 1 trang bÞ cÊp 20 vµ 13000 kinh nghiÖm. ")

    SetSubTask(208, -1, 1)

    TaskNote(208, 7)

    refreshNpcTaskState()


end

function renwu18()
    CloseDialog()
    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 == 0) then
        MsgBox("<c=g>Tiªn C¬ Häa<c> chÝnh lµ ch©n phÈm l­u truyÒn tõ th­îng cæ, ng­êi trong TriÖt Gi¸o lu«n muèn chiÕm lµ cña riªng, ®o¹t giÊu t¹i <c=r>T©y C«n L«n<c>, ®Ó tr¸nh tai m¾t ng­êi kh¸c ®Ö tö TriÖt Gi¸o biÕn hãa thµnh qu¸i vËt T©y C«n L«n trÊn gi÷ b¸u vËt, ng­¬i h·y ®i ®o¹t Tiªn C¬ Häa vÒ tõ chóng.", "yes_picture", "no")
    elseif (state18 == 6) then
        if (HaveNormalItem(1, 0, 0, 0) == 0 and HaveNormalItem(1, 3, 0, 0) == 0) then
            if (IsHaveSpaceForTreasure(3) > 0) then
                CompleteMission18()
            else
                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ hoµn thµnh nhiÖm vô.")
            end

        elseif ((HaveNormalItem(1, 0, 0, 0) > 0 and HaveNormalItem(1, 3, 0, 0) == 0) or (HaveNormalItem(1, 0, 0, 0) == 0 and HaveNormalItem(1, 3, 0, 0) > 0)) then

            if (IsHaveSpaceForTreasure(2) > 0) then
                CompleteMission18()
            else
                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ hoµn thµnh nhiÖm vô.")
            end

        else

            if (IsHaveSpaceForTreasure(1) > 0) then

                CompleteMission18()

            else

                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ hoµn thµnh nhiÖm vô.")

            end

        end


    end
end

function yes_picture()

    TaskNote(208, -1)
    for i = 1, 5 do
        AddNormalItemBind(3, 13, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 9, 0, 0, 0, 0, 1)
    end

    Talk(2, "no", GetName() .. "Ta nguyÖn ý trî gióp tiªn sinh.", "Víi n¨ng lùc hiÖn nay cña ng­¬i vÉn ch­a ph¶i lµ ®èi thñ cña h¾n, nh­ng ng­¬i cã thÓ ®Õn t×m <c=r>Tiªu Th¨ng<c> hái m­în  <c=g>Thiªn C¬ Ch©u<c> tiªu diÖt h¾n.")
    SetTaskByte(Task_newer13, 2, 1)
    Msg2Player("§Õn t×m Tiªu Th¨ng hái m­în Thiªn C¬ Ch©u ®i tiªu diÖt ph¶n ®å TriÖt Gi¸o.")

    SetSubTask(208, 1, 1)

    TaskNote(208, 0)

    refreshNpcTaskState()

end


