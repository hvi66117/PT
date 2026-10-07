--description:?´ó¸ç
--author: yichuan
--date: 2004/7/19
Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;

--Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 Begin
Task_Partner = 1657
Task_YiboProcess = 1658 -- 1Byte:1Ñ°ÕÒÊ¦¾­ÉÏÏÂÆª 2ÕÒµ½Ê¦¾­ÉÏÏÂÆª 3ÒÑ°ÑÊé½»¸øÁË»ÆÌì»¯ 4Êé»êÒÑ¾­ÊÍ·Å 5ÁÔÉ±³É¹¦ 6ÈÎÎñÍê³É 7ÈÎÎñÊ§°Ü
-- 2Byte:Ê¦¾­ÀàÐÍ/°çÑÝ½ÇÉ« 1ÉÏÆª(Ê¦) 2ÏÂÆª(Í½)
-- 3Byte:1µ±Íæ¼Òµ½ÁË¿ªÆôËÄ¼¶Ê¦ÃÅÈÎÎñÌõ¼þÊ±£¬ÒÑ¾­¸øÍæ¼Ò·¢ÁËÌáÐÑÓÊ¼þ
--Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 End

-- AS GaoJingwei at 090728
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

ShiJing = {
    [1] = { name = "S­ Kinh th­îng-TÇm Phï", Item = { 4, 310, 0, 1, 0, 0 } },

    [2] = { name = "S­ Kinh th­îng", Item = { 4, 301, 0, 1, 0, 0 } },
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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÈËÖ®½«ËÀ
    startLevel = 27
    if (GetLevel() >= startLevel) then
        local UTask_world_2 = GetTask(92)
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if (GetMorphType() == 50 and UTask_world_2 == 2) then
                state = 3
                subState = 0
            elseif (GetMorphType() == 34 and UTask_world_2 == 3) then
                state = 3
                subState = 0
            end
        else
            --À¶É«
            if (GetMorphType() == 50 and UTask_world_2 == 2) then
                state = 3
                subState = 1
            elseif (GetMorphType() == 34 and UTask_world_2 == 3) then
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

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        { "Phu Thª", "renwu1"; show = 0 },
        { "Mua t¸o", "ChangeHulu"; show = 0 },
        { "Mua QuÕ", "ChangeYueGui"; show = 0 },
        { "Y B¸t T TruyÒn", "YiboTask"; show = 0 }
    }
    if (GetTask(Task_PrepareMaterial) == 9) then
        if (HaveEventItemCount(198) < 20) then
            tasks[2].show = 1
        end
        tasks[3].show = 1
    end
    UTask_world_2 = GetTask(92);
    if (GetMorphType() == 50) then
        if (UTask_world_2 == 2) or (UTask_world_2 == 4) then
            tasks[1].show = 1;
        end ;
    end ;
    if (GetMorphType() == 34) then
        if (UTask_world_2 == 2) or (UTask_world_2 == 3) then
            tasks[1].show = 1;
        end ;
    end ;
    --Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 Begin
    if (GetTaskByte(Task_YiboProcess, 1) == 1 and GetTaskByte(Task_YiboProcess, 2) == 1) then
        tasks[4].show = 1
    end
    --Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 End

    --edited by yangtao 2009.8.17
    SayTask(GetName() .. "NhËm ®¹i ca thËt ®¸ng th­¬ng. Huynh Êy kh«ng ph¶i ng­êi ném, nh­ng kh«ng thÓ ®i l¹i, kh«ng thÓ nãi chuyÖn.", tasks)
    --end of edit
end;

--Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 Begin
function YiboTask()
    CloseDialog()
    local item = ShiJing[1].Item
    if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) then
        DelNormalItem(item[1], item[2], item[3], item[4])

        item = ShiJing[2].Item
        AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
        SetTaskByte(Task_YiboProcess, 1, 2)
        InfoBox("NhËm ®¹i ca:N¨m x­a cã 1 ®¹o nh©n cøu ta tho¸t chÕt, vµ ®Ó l¹i 1 th­ quyÓn hÕt søc khã hiÓu, nhê ta giao cho ng­êi h÷u duyªn. §©y cã lÏ lµ vËt anh hïng ®ang t×m, anh hïng cÇm lÊy ®i.")
        Msg2Player("B¹n nhËn ®­îc S­ Kinh-Th­îng")
        TaskNote(1515, 1, "S­ Kinh th­îng")
    else
        Talk(1, "no", "NhËm ®¹i ca:N¨m x­a cã 1 ®¹o nh©n cøu ta tho¸t chÕt, vµ ®Ó l¹i 1 th­ quyÓn hÕt søc khã hiÓu, nhê ta giao cho ng­êi h÷u duyªn. H×nh nh­ anh hïng kh«ng ph¶i lµ ng­êi h÷u duyªn.")
    end
end
--Add By guoqun for ÒÂ²§Ïà´« at 2009.11.26 End

function ChangeHulu()
    MsgBox(11931, "BuyHulu", "no")

end

function ChangeYueGui()
    MsgBox(11932, "BuyYueGuizhongzi", "no")
end

function BuyAgain()
    local Tasks2 = {
        { "Mua t¸o", "ChangeHulu"; show = 0 },
        { "Mua QuÕ", "ChangeYueGui"; show = 0 }
    }
    if (GetTask(Task_PrepareMaterial) == 9) then
        if (HaveEventItemCount(198) < 20) then
            Tasks2[1].show = 1
        end
        Tasks2[2].show = 1
    end
    SayTask(11933, Tasks2)

end

function BuyHulu()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy.")
    elseif (GetCash() >= 100 and AddEventItem(198) ~= 0) then
        CloseDialog()
        Pay(100)
        --		AddEventItem( 198 )
        TopMessage(11934)
        Msg2Player("NhËn ®­îc t¸o.")
        BuyAgain()
    else
        Talk(1, "BuyAgain", 11935)
    end
end

function BuyYueGuizhongzi()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy.")
    elseif (GetCash() >= 50 and AddNormalItemPile(6, 1, 276, 1, 0, 0) ~= 0) then
        CloseDialog()
        Pay(50)
        --		AddNormalItemPile(6,1,276,1,0,0)
        TopMessage(11936)
        Msg2Player("NhËn ®­îc h¹t quÕ.")
        BuyAgain()
    else
        Talk(1, "BuyAgain", 11937)
    end
end

function renwu1()
    UTask_world_2 = GetTask(92);
    --edited by yangtao 2009.8.14
    --ÈËÖ®½«ËÀÈÎÎñÐÞ¸ÄÎª×Ô¶¯±äÉí
    if (GetMorphType() == 50) then
        local f = GetCompeteFlag()
        if (f == 1) then
            Talk(1, "no", "Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ tù ®éng biÕn th©n thµnh Ngäc N÷, h·y ®îi tr¹ng th¸i chiÕn ®Êu kÕt thóc råi tiÕp tôc nhiÖm vô.")
            return
        else
            if (GetMorphType() == 364) or (GetMorphType() == 34) or (GetMorphType() == 420) or (GetMorphType() == 419) or (GetMorphType() == 411) then
                Talk(1, "no", "ë tr¹ng th¸i nµy kh«ng thÓ tù ®éng biÕn th©n thµnh Ngäc N÷, h·y ®îi tr¹ng th¸i kÕt thóc råi míi tiÕp tôc nhiÖm vô.")
                return
            else
                if (GetTaskByte(1357, 1) == 3 and GetMorphType() == 16) then
                    Talk(1, "no", "§ang ë tr¹ng th¸i ngôy trang Thiªn H¹o, h·y ®i thu phôc <c=r>Thñ lÜnh Giang Quy<c>!")
                    return
                elseif (GetTaskByte(1357, 1) == 4 and GetMorphType() == 24) then
                    Talk(1, "no", "Ng­¬i ®ang trong tr¹ng th¸i nguþ trang thñ lÜnh Giang Quy, h·y ®i diÖt trõ <c=r>30 Thiªn H¹o<c>!")
                    return
                end
                PolyMorph(34, 1, 0, -1, 300)
            end ;
        end
        if (UTask_world_2 == 2) or (UTask_world_2 == 4) then
            Talk(1, "no", GetName() .. "NhËm ®¹i ca ®· nh×n thÊy <color=yellow>Phi Thè<color>, m¾t huynh Êy hiÖn râ nÐt vui mõng, trong ¸nh m¾t cßn thÓ hiÖn t×nh yªu ®èi víi thª tö.")
            Msg2Player("NhËm ®¹i ca ®· nh×n thÊy Phi Thè.")
            SetTask(92, UTask_world_2 + 1)
            TaskNote(26, 2)
            refreshNpcTaskState()
        end ;
    else
        if (GetMorphType() == 34) then
            local f = GetCompeteFlag()
            if (f == 1) then
                Talk(1, "no", "Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ tù ®éng biÕn th©n thµnh Love, h·y ®îi tr¹ng th¸i chiÕn ®Êu kÕt thóc råi tiÕp tôc nhiÖm vô.")
                return
            else
                if (GetMorphType() == 364 or GetMorphType() == 36 or GetMorphType() == 420 or GetMorphType() == 419 or GetMorphType() == 411) then
                    Talk(1, "no", "ë tr¹ng th¸i nµy kh«ng thÓ biÕn th©n thµnh Love, h·y ®îi tr¹ng th¸i kÕt thóc råi tiÕp tôc nhiÖm vô.")
                    return
                else
                    if (GetTaskByte(1357, 1) == 3 and GetMorphType() == 16) then
                        Talk(1, "no", "§ang ë tr¹ng th¸i ngôy trang Thiªn H¹o, h·y ®i thu phôc <c=r>Thñ lÜnh Giang Quy<c>!")
                        return
                    elseif (GetTaskByte(1357, 1) == 4 and GetMorphType() == 24) then
                        Talk(1, "no", "Ng­¬i ®ang trong tr¹ng th¸i nguþ trang thñ lÜnh Giang Quy, h·y ®i diÖt trõ <c=r>30 Thiªn H¹o<c>!")
                        return
                    end
                    PolyMorph(249, 1, 0, -1, 300)
                end ;
            end
            if (UTask_world_2 == 2) or (UTask_world_2 == 3) then
                Talk(1, "no", GetName() .. "NhËm ®¹i ca ®· nh×n thÊy <color=yellow>Ngäc N÷<color>, m¾t huynh Êy hiÖn râ nÐt vui mõng, trong ¸nh m¾t cßn thÓ hiÖn t×nh yªu ®èi víi thª tö.")
                Msg2Player("NhËm ®¹i ca ®· thÊy ®­îc Ngäc n÷.")
                SetTask(92, UTask_world_2 + 2)
                TaskNote(26, 4)
                refreshNpcTaskState()
            end ;
        end ;
    end ;
    --end of edit
end;

function no()
    CloseDialog()
end;
