--description: ÄÏ¼«ÏÉÎÌ
--author: yichuan
--date: 2004/4/9
Task_bingjiao = 1110;
Task_bingjiaoInfo = 1111;

Task_xianguo = 1211;
--·ÃÇóÏÉ¹ûÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ,2Bit±íÊ¾ÈÎÎñ´ı½»,3Bit±íÊ¾ËÕæ§¼º´¦Íê³É,4Bit±íÊ¾ÄÏ¼«ÏÉÎÌ´¦Íê³É,5Bit±íÊ¾¿ä¸¸Í¼ÌÚ´¦Íê³É,6Bit±íÊ¾ÍÁĞĞËï´¦Íê³É,7Bit±íÊ¾²®ÒØ¿¼´¦Íê³É,8Bit±íÊ¾ÈÎÎñ½áÊø

------------ÎÊÃüÖ®Ç© Add by gaojignwei at 2009/04/08 begin--------
Task_Divination = 1375        --1byte:1ÔÚØÔÊ¦´¦ÁìÈÎÎñ 2ÔÚËãÃüÏÈÉú´¦ÁìÈÎÎñ 3ÔÚÄÏ¼«ÏÉÎÌ´¦ÁìÈÎÎñ 4»Ø¸´ÄÏ¼«ÏÉÎÌ¼ÓbuffA 5Áìµ½¾Å×ªµ¤ 6ÔÚËãÃüÏÈÉú´¦¾­Ñé½±Àø
--7µÃµ½Ç© 8Íê³ÉÓ¦Ç©ÈÎÎñ 2byte ²É¼¯ºìÓñ²İµÄ¸öÊı 3byte²É¼¯ÓÄÚ¤²İµÄ¸öÊı 4byteÉ±ËÀ¹íÔ¦µÄ¸öÊı
Task_Label_Type = 1376      --1byte: 1ÄÉ²ÆÇ© 2Ñª¹âÇ© 3ÒËÉ«Ç©
Buff_Make_Drug = 636           --1·ÖÖÓÖÆÒ©buff
Buff_Add_Life = 635           --1Ğ¡Ê±»Ø¸´ÉúÃü¼°ÄÚÁ¦buff
Buff_Polymorph = 404        --°ëĞ¡Ê±±äÉíbuff
Buff_Plutus = 228            --Ìì½«²ÆÉñbuff
Task_Num = 1039                --taskinfoµÄ±àºÅ

------------ÎÊÃüÖ®Ç© Add by gaojignwei at 2009/04/08 end--------

instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

-- AS GaoJingwei at 090728 
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

    --ÁéÁ¦ĞŞ¸´
    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        taskProcess = GetTask(14)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveNormalItem(3, 139, 0, 0) >= 10) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveNormalItem(3, 139, 0, 0) >= 10) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end

        end

        index = searchForIndex(state, subState, index)
    end

    --±ù½¾Ö®»¼
    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(Task_bingjiao)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 7) then
                state = 3
                subState = 0
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 7) then
                state = 3
                subState = 1
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            end

        end
        index = searchForIndex(state, subState, index)
    end

    --·ÃÇóÏÊ¹û
    startLevel = 19
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 4) == 0) or (GetTaskBit(Task_xianguo, 4) == 1 and (HaveNormalItem(3, 220, 0, 0) == 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 4) == 1) and (HaveNormalItem(3, 220, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 4) == 0) or (GetTaskBit(Task_xianguo, 4) == 1 and (HaveNormalItem(3, 220, 0, 0) == 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 4) == 1) and (HaveNormalItem(3, 220, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÎÊÃüÖ®Ç©
    startLevel = 27
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Divination, 1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (step == 2) then
                state = 3
                subState = 0
            elseif (step == 3 and HaveNormalItem(3, 144, 0, 0) >= 5 and HaveEventItem(231) >= 1) then
                state = 3
                substate = 0
            elseif (step >= 3 and step < 5) then
                state = 2
                substate = 0
            end
        else
            if (step == 2) then
                state = 3
                subState = 1
            elseif (step == 3 and HaveNormalItem(3, 144, 0, 0) >= 5 and HaveEventItem(231) >= 1) then
                state = 3
                substate = 1
            elseif (step >= 3 and step < 5) then
                state = 2
                substate = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ê§»êÂäÆÇ
    startLevel = 71
    if (GetLevel() >= startLevel) then
        local hp = GetTaskByte(1606, 1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (hp == 2) then
                state = 3
                subState = 0
            end
        else
            if (hp == 2) then
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
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        --		{"°ÙÀïÌôÒ»","renwu1";show=0},
        --		{"Îå»ğÆßÇİ","renwu2";show=0}
        { "<c=yel>Linh Lùc<c>", "lingli"; show = 0 },
        { "<c=yel>B¨ng Lang<c>", "bingjiao"; show = 0 },
        { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 },
        { "<c=yel>VÊn MÖnh Chi Thiªm<c>", "divination"; show = 0 },
        { "<c=yel>ThÊt Hån L¹c Ph¸ch<c>", "instence_renwu"; show = 0 },
    }
    --		UTask_00=GetTask(10);
    --		if (UTask_00 == 1) or (UTask_00 == 3)or (UTask_00 == 9) or (UTask_00 == 11)then	
    --			tasks[1].show=1;
    --		end;
    --		UTask_01=GetTask(11);
    --		if(UTask_01==4)and(HaveEventItem(20)>=1)then
    --					tasks[1].show=1;
    --		end;
    --		if(UTask_01==2)and(HaveNormalItem(3,13,0,0)>=10)then
    --					tasks[1].show=1;
    --		end;
    --		if(UTask_01==0)and(GetLevel()>=3)then
    --					tasks[1].show=1;
    --		end;
    --	Talk(1,"no",10532)
    local step = GetTaskByte(Task_Divination, 1)
    if (step >= 2 and step <= 4) then
        tasks[4].show = 1
    end

    local xg = GetTask(Task_xianguo)

    if (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 4) == 0) then
        tasks[3].show = 1
        -- modified by yaoxin for bug 2011-4
    elseif (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 4) == 1 and IsExistItem(3, 220, 0, 0) == 0) then
        tasks[3].show = 1    --Èç¹ûÖ®Ç°µÄÈÎÎñÒÑ¾­Íê³É µ«ÊÇÈÎÎñÎïÆ·»¹ÏûÊ§ÁË.. ÄÇÃ´Ò»Ñù¿ÉÒÔÊ¹ÓÃÒ¹Ã÷ÖéÖØĞÂÁìÈ¡
    end

    if (GetPlayerType() == 1) then
        local UTask_04 = GetTask(14);
        if (UTask_04 == 1) and (HaveNormalItem(3, 139, 0, 0) >= 10) then
            tasks[1].show = 1;
        end ;
        if (UTask_04 == 0) and (GetLevel() >= 14) then
            tasks[1].show = 1;
        end ;
        if (UTask_04 == 2) and (GetCamp() == 0) then
            SetCamp(7)
            Talk(1, "no", 12269)
            Msg2Player("§i T©y C«n L«n tiªu diÖt 3 B¨ng Lang V­¬ng!")
        end ;
        local nTaskStatus = GetTask(Task_bingjiao)
        if ((nTaskStatus == 0 and GetLevel() >= 14) or nTaskStatus == 7) then
            tasks[2].show = 1
        end


    elseif (GetPlayerType() == 2) then
        TaskNote(913, -1)
    end

    if ((GetTaskByte(instence_Task, 1) == 1 and GetLevel() >= 70)) then
        tasks[5].show = 1
    end
    SayTask(10532, tasks)
end;

function divination()
    CloseDialog()
    local step = GetTaskByte(Task_Divination, 1)
    if (step == 2) then
        MsgBox("<c=r>Cöu ChuyÓn Tiªn §¬n<c> ®o¹t t¹o hãa thiªn ®Şa nh­ng luyÖn chÕ kh«ng dÔ, nguyªn liÖu cÇn thiÕt vÉn cßn thiÕu sãt, nÕu nh­ c¸c h¹ cã thÓ thu thËp 5 <c=r>Ngäc Hång Th¶o<c> trªn Thñ D­¬ng S¬n ®ång thêi tiªu diÖt Quû Ngù trªn Kú S¬n vµ Tam S¬n ®o¹t vÒ <c=r>U Minh Th¶o<c> lµ cã thÓ luyÖn chÕ thµnh c«ng.", "yes_divination", "no")
        return
    end

    if (step == 3 and HaveNormalItem(3, 144, 0, 0) >= 5 and HaveEventItem(231) >= 1) then
        --???ÓÄÚ¤²İ
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "Tr¹ng th¸i hiÖn t¹i cña ng­¬i qu¸ nhiÒu, h·y gi¶i bá 1 vµi tr¹ng th¸i h·y quay l¹i tiÕp tôc nhiÖm vô ®i.")
            return
        end

        for i = 1, 5 do
            DelNormalItem(3, 144, 0, 0)
        end
        DelEventItem(231)        --???É¾µôÓÄÚ¤²İ

        SetTaskByte(Task_Divination, 1, 4)
        refreshNpcTaskState()
        AddIBBuff(Buff_Make_Drug)
        Talk(1, "no", "LuyÖn chÕ Tiªn §¬n cÇn 1 kho¶n thêi gian, 1 phót sau h·y quay l¹i.")
        Msg2Player("1 phót sau quay l¹i t×m Nam Cùc Tiªn ¤ng.")
        TaskNote(Task_Num, 3)
    elseif (step == 3) then
        Talk(1, "no", "Ng­¬i mang ®Õn d­îc liÖu kh«ng ®ñ, ta kh«ng thÓ luyÖn chÕ <c=r>Cöu ChuyÓn Tiªn §¬n<c>.")
        Msg2Player("VÉn ch­a thu thËp ®ñ nguyªn liÖu.")
    end

    if (step == 4 and HaveIBBuff(Buff_Make_Drug) > 0) then
        Talk(1, "no", "LuyÖn chÕ Tiªn §¬n cÇn 1 kho¶n thêi gian, anh hïng h·y quay l¹i sau.")
        Msg2Player("Tiªn ®¬n vÉn trong qu¸ tr×nh luyÖn chÕ.")
    elseif (step == 4) then
        if (IsHaveSpaceForTreasure(1) < 1) then
            --???
            Talk(1, "no", "Hµnh trang trªn ng­êi ng­¬i ®· ®Çy, h·y chØnh lı l¹i.")
            return
        end
        SetTaskByte(Task_Divination, 1, 5)
        refreshNpcTaskState()
        AddEventItem(232)                            --???Ôö¼ÓÒ»¿Å¾Å×ªÏÉµ¤
        Talk(1, "no", "Tiªn §¬n ®· luyÖn xong, h·y nhanh chèng ®i gi¶i cøu <c=g>ThÇy t­íng sè T©y Kú<c> ®i.")
        Msg2Player("NhËn ®­îc Cöu ChuyÓn Tiªn §¬n.")
        TaskNote(Task_Num, 4)
    end
end

function yes_divination()
    CloseDialog()
    SetTaskByte(Task_Divination, 1, 3)
    refreshNpcTaskState()
    Msg2Player("NhËn lêi Nam Cùc Tiªn ¤ng, t×m 1 U Minh Th¶o vµ 5 Ngäc Hång Th¶o.")
    Talk(1, "no", GetName() .. "Ta ®i chuÈn bŞ nguyªn liÖu ®©y.")
    TaskNote(Task_Num, 2)
end

function bingjiao()
    local nTaskStatus = GetTask(Task_bingjiao)
    if (nTaskStatus == 0) then
        MsgBox(12269, "AcceptBingjiao", "no")
    elseif (nTaskStatus == 7) then
        local nExp = 5000
        AddOwnExp(nExp)
        TopMessage("NhËn ®­îc" .. nExp .. "kinh nghiÖm")
        Msg2Player("NhËn ®­îc" .. nExp .. "kinh nghiÖm.")
        SetTask(Task_bingjiao, 10)
        ----Íê³ÉÈÎÎñ
        refreshNpcTaskState()
        --AS GaoJingwei 090730
        SetSubTask(913, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(913, -1)

        local prop = random(39, 59)
        --		local prop1 = random(1,2)
        AddNormalItem(6, 1, prop, 1, 0, 0, 0)
        MsgBox(12270, "new")
        if (GetTask(Task_bingjiao) == 10) then
            SyncBibleState(902, 0, 1)
        end
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end
end
function new()
    Talk(1, "no", 12271)
end;

function AcceptBingjiao()
    SetTask(Task_bingjiao, 1)
    SetTask(Task_bingjiaoInfo, 0)
    SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 1, 4))
    SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 2, 12))
    refreshNpcTaskState()
    --AS GaoJingwei 090730
    SetSubTask(913, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(913, 0)
    Talk(1, "no", 12272)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function lingli()
    UTask_04 = GetTask(14);
    if (UTask_04 == 1) and (HaveNormalItem(3, 139, 0, 0) >= 10) then
        Talk(1, "no", 12273)
        for i = 1, 10 do
            DelNormalItem(3, 139, 0, 0) ---Ñ©¹Ç
        end ;
        AddOwnExp(3000)
        --for i = 1,5 do
        --AddNormalItem(5,0,0,1,0,0)
        --end
        AddItemPileNum(5, 0, 0, 1, 10)        --added by hyz 090713 for ĞÂÊÖÓÅ»¯  
        TopMessage(12274)
        Msg2Player("NhËn ®­îc 3000 kinh nghiÖm vµ 10 Håi thµnh phï.")
        --				AddNormalItem(7,58,62,1,0,0) 
        SetTask(14, 2)
        refreshNpcTaskState()
        --				Msg2Player("µÃµ½²É¿óÉú»î¼¼ÄÜÊé¡¶ÅÌ¹Å¿ªÌì¡·£¬¶øÇÒÄã´Ó´ËÒ²²»ÔÙÊÇĞÂÊÖÁË¡£")
        --				SetCamp(7)
        --AS GaoJingwei 090730
        SetSubTask(4, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(4, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
    if (UTask_04 == 0) and (GetLevel() >= 14) then
        --		Talk(2,"yuanyi",10529,10530)
        MsgBox(10529, "yes_1", "no")
    end ;
end;

function yuanyi()
    MsgBox(10531, "yes_1", "no")
end;

function yes_1()
    Talk(1, "no", 12275)
    SetTask(14, 1)
    refreshNpcTaskState()
    Msg2Player("T×m 10 TuyÕt Cèt cho Nam Cùc Tiªn ¤ng!")
    --AS GaoJingwei 090730
    SetSubTask(4, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(4, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function renwu1()
    UTask_00 = GetTask(10);
    if (UTask_00 == 1) then
        Talk(1, "no", 10533)
        SetTask(10, UTask_00 + 4)
        refreshNpcTaskState()
        TaskNote(1, 2)
        Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
    if (UTask_00 == 3) then
        Talk(1, "no", 10533)
        SetTask(10, UTask_00 + 4)
        refreshNpcTaskState()
        TaskNote(1, 4)
        Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
    if (UTask_00 == 9) then
        Talk(1, "no", 10533)
        SetTask(10, UTask_00 + 4)
        refreshNpcTaskState()
        TaskNote(1, 5)
        Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
    if (UTask_00 == 11) then
        Talk(1, "no", 10533)
        SetTask(10, UTask_00 + 4)
        refreshNpcTaskState()
        TaskNote(1, 7)
        Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thİch.")
    end ;
end;

function renwu2()
    UTask_01 = GetTask(11);
    if (UTask_01 == 4) and (HaveEventItem(20) >= 1) then
        Talk(1, "no", 10534)
        Earn(600)
        AddOwnExp(500)
        SetTask(11, 5)
        refreshNpcTaskState()
        DelEventItem(20)
        TaskNote(2, 4)
        Msg2Player("LÊy ®­îc lo¹i löa thİch hîp, nhËn phÇn th­ëng 600 l­îng + 500 ®iÓm kinh nghiÖm cña Nam Cùc Tiªn ¤ng.")
    end ;
    if (UTask_01 == 2) and (HaveNormalItem(3, 13, 0, 0) >= 10) then
        Talk(1, "no", 10535)
        for i = 1, 10 do
            DelNormalItem(3, 13, 0, 0)
        end ;
        TaskNote(2, 2)
        Msg2Player("§Õn gÆp Nhiªn §¨ng ®¹o nhËn löa ®em vÒ cho Nam Cùc Tiªn ¤ng.")
        SetTask(11, 3)
        refreshNpcTaskState()
    end ;
    if (UTask_01 == 0) and (GetLevel() >= 3) then
        MsgBox(10536, "yes_2", "no")
    end ;

end;

function yes_2()
    Talk(1, "no", 10537)
    SetTask(11, 1)
    refreshNpcTaskState()
    TaskNote(2, 0)
    Msg2Player("§Õn gÆp Hoµng Long ch©n nh©n lÊy 10 B¨ng c¬ cho Nam Cùc Tiªn ¤ng.")
end;

function no()
    CloseDialog()
end;

function xianguo()
    local str = "Ta ®ang cÇn mét sè ch©u b¸u ®Ó luyÖn tiªn ®¬n míi. NÕu ng­¬i gióp ta t×m ®­îc th× viªn Háa t¸o nµy sÏ thuéc vÒ ng­¬i, nã cã thÓ gióp ng­¬i tr­êng sinh bÊt tö!"
    if (HaveNormalItem(3, 218, 0, 0) > 0) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ nhËn.")
            return
        end

        Talk(3, "no", str, GetName() .. ": Ta cã 1 viªn D¹ Minh Ch©u, ng­¬i kh«ng chª chø?", "§óng lµ thø ta cÇn råi! C¶m ¬n nhĞ!")
        --¼õµôÒ»¿Å
        DelNormalItem(3, 218, 0, 0)
        --Ôö¼ÓÒ»¿Å»ğÔæ
        AddNormalItem(3, 220, 0, 0, 0, 0)
        if (GetBit(GetTask(Task_xianguo), 4) ~= 1) then
            AddOwnExp(1000)
            TopMessage(14443)
            Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        end

        SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 4, 1))
        refreshNpcTaskState()
        if (GetTask(Task_xianguo) == 125) then
            SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            refreshNpcTaskState()
            TaskNote(73, 1)
            --AS by hyz 090713 for ĞÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅĞ¶Ï)
        else
            local count = 0
            local tb = GetTask(Task_xianguo)
            local tmp_t = {
                "Sïng Thµnh ®¹i doanh-T« §¾c Kû (192,198)", "Ngäc H­ Cung-Nam Cùc Tiªn ¤ng (209,191)", "Xi V­u mé-VËt tæ Khoa phô (199,204)", "TriÒu Ca-Thæ Hµnh T«n (214,184)", "T©y Kú-B¸ Êp Kh¶o (168,195)"
            }
            local tmp_num = {}

            for i = 3, 7 do
                if (GetBit(tb, i) == 0) then
                    count = count + 1
                    tmp_num[count] = i - 2
                end
            end

            --²âÊÔ
            --Msg2Player("count:"..count)
            --Msg2Player("tmp_num[count]:"..tmp_t[ tmp_num[count] ])

            if (count == 1) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]])
            elseif (count == 2) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]])
            elseif (count == 3) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]])
            elseif (count == 4) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]], tmp_t[tmp_num[4]])
            else
                TaskNote(73, 1)
                SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
                refreshNpcTaskState()
            end

            --AE by hyz 090713 for ĞÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅĞ¶Ï)
        end

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", str, GetName() .. ": HiÖn t¹i ta ch­a cã.SÏ quay l¹i sau nhĞ!")
    end
end;

function instence_renwu()
    if (IsHaveSpaceForTreasure(1) == 1) then
        Talk(3, "no", "Ta biÕt lı do anh hïng ®Õn ®©y, lóc n·y 1 hån 1 ph¸ch cña Tö Nha bay ®Õn C«n L«n, ta ®· ®­a hån ph¸ch ®ã vµo hå l«, anh hïng h·y mau ®em vÒ T©y Kú giao cho D­¬ng TiÔn míi cã thÓ cøu m¹ng Tö Nha!", GetName() .. "§a t¹ tiªn «ng, nh­ng t¹i sao Kh­¬ng thõa t­íng l¹i hån l×a khái x¸c?", "V× V¨n Th¸i S­ mêi ®Ö tö TriÖt Gi¸o dïng yªu thuËt lËp ThËp TuyÖt trËn, hiÖn ®ang cã m«n nh©n cña TriÖt Gi¸o lËp ®µn trong trËn, dïng 1 h×nh ném cã tªn Tö Nha c©u mÊt 2 hån 6 ph¸ch cña h¾n. NÕu muèn cøu Tö Nha, cÇn ph¶i t×m ®­îc h×nh ném ®ã.")
        Msg2Player("§em Hå L« Hån Ph¸ch vÒ T©y Kú cho D­¬ng TiÔn.")
        AddEventItem(285)
        SetTaskByte(instence_Task, 1, 3)
        TaskNote(1204, 1)
    else
        Talk(2, "no", "Ta biÕt lı do anh hïng ®Õn ®©y, lóc n·y 1 hån 1 ph¸ch cña Tö Nha bay ®Õn C«n L«n, ta ®· ®­a hån ph¸ch ®ã vµo hå l«, anh hïng h·y mau ®em vÒ T©y Kú giao cho D­¬ng TiÔn míi cã thÓ cøu m¹ng Tö Nha!", "VËn chuyÓn vËt nµy cÇn hÕt søc cÈn thËn, hµnh trang cña anh hïng ®· ®Çy, h·y s¾p xÕp råi quay l¹i!")--
    end
end
