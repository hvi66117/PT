--ÙÈ·ç.lua
--author:gaojingwei
--date:2009/5/18

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-28
Task_Process = 1458   --1byte:1½ÓÈÎÎñ£¬2µÃµ½ÙÈ²®ÒæµÄ½±Àø£¬3ÁìÈ¡ÁÔÉ±³Ë»ÆµÄÈÎÎñ£¬4ÊÍ·Å³Ë»ÆNpc£¬5ÊÍ·ÅÕ½¶·³Ë»Æ£¬ 6Õ½Ê¤³Ë»Æ´óÍõ£¬ 7Ã»ÓĞ°´ÕÕÒªÇóÕ½Ê¤³Ë»Æ´óÍõ
--2byte:µ±Ìì½ÓÈÎÎñ´ÎÊı£»3byte:1µ¥±¶£¬2Ë«±¶£»4byte:É±ËÀ³Ë»ÆµÄ¸öÊı
Task_Type = 1459      --1byte:1½ÓµÄÊÇÃîÊÖÉñÒ½µÄÈÎÎñ£¬2½ÓµÄÊÇÁ¶ÖÆÃÔÒ©µÄÈÎÎñ£¬2byte:1±íÊ¾ÒÑ¾­×ö¹ıÔËËÍ¹ı»Ø»êÌÀ¡£  3Byte:1±íÊ¾µÚÒ»´ÎÈÎÎñÒÑ¾­½ÉÄÉË«ÂüºÍ100Íò 2±íÊ¾µÚ1´ÎÈÎÎñÒÑ¾­Íê³É
Task_Total_Times = 1460    --ÀÛ¼ÆÈÎÎñ´ÎÊı
Task_Accept_Day = 1461  --½ÓÈÎÎñµÄÈÕÆÚ
Task_Coordinate = 1462  --1word:ËøÑıÕòx×ø±ê£»2word£ºy×ø±ê
Task_MonsterID = 1463    --³Ë»Æ(ÀçÁéÊ¬µÄID)
Task_Free_Time = 1464    --³Ë»Æ´óÍõ(×çÖäÖ®ÀçÁéÊ¬)µÄindex

chenghuangNpcID = 1005    --³Ë»Æ´óÍõNpcµÄtemplateID
chenghuangID = 1003        --³Ë»Æ´óÍõµÄtemplateID
lilingNpcID = 1006        --ÏÄÁéÊ¬´óÍõNpcµÄtemplateID
lilingID = 1004            --ÏÄÁéÊ¬´óÍõµÄtemplateID
amberNum = 3            --ĞèÒª½ÉÄÉµÄçúçêÖ®ĞÄµÄ¸öÊı
blastID = 1007            --ËøÑıÕòµÄID
buffID = 682            --ËøÑıÕòbuffµÄID
Task_flower = 1471  --1byte£º1½ÓÈÎÎñ£¬2ÕÒ¶¾À¼²İ£¬3ÕÒÁúÉàÀ¼£¬4ÕÒµ½2¶ä»¨£¬5µ÷Åä£¬6Íê³ÉÖ§ÏßÒ»£»
-- 8½ÓÊ§ÂäÖ®Êé£¬9»ñµÃ¹ÅÍ¼²ĞÆ¬£¬10Íê³ÉÖ§Ïß¶ş
--11½ÓÒÔ¾Æ»áÓÑ£¬12µÚÒ»´ÎÓëÙÈ×ÓÃ÷¶Ô»°£¬13ÃÜÌ½¸æÖªÒÔ¾Æ»áÓÑ£¬14ÓëÙÈ×ÓÃ÷Æ´¾Æ£¬15Íæ¼ÒÊ§°Ü£¬16Íæ¼ÒÊ¤³ö£¬17Íê³ÉÖ§ÏßÈı
--2byte:´ğÌâ¶ÔµÄ´ÎÊı
--3byte:´ğÌâ´íµÄ´ÎÊı
Task_question = 1473 --1byte£º¾ÆµÄÊ¹ÓÃ´ÎÊı 2byte:ÊÇ·ñ¸Õ¿ªÊ¼´ğÌâ£¨0£º¸Õ¿ªÊ¼£»1£º´ğÁËÒ»µÀÒÔÉÏ£© 3byte:ÌâÄ¿µÄË÷Òı 4byte:ÌâÄ¿ÊıÁ¿

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

--- AS yangshuang at 091229
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


    --¸¯»¨Ö®¶¾
    startLevel = 50
    if (GetPlayerExtLevel() >= startLevel) then
        local flower50 = GetTaskByte(Task_flower, 1)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (flower50 == 0) then
                state = 1
                subState = 0
            elseif ((flower50 == 5) and (HaveEventItem(255) >= 1) and (HaveIBBuff(690) == 1)) then
                state = 3
                subState = 0
            elseif ((flower50 >= 1) and (flower50 < 6)) then
                state = 2
                subState = 0
            end
        else
            if (flower50 == 0) then
                state = 1
                subState = 1
            elseif ((flower50 == 5) and (HaveEventItem(255) >= 1) and (HaveIBBuff(690) == 1)) then
                state = 3
                subState = 1
            elseif ((flower50 >= 1) and (flower50 < 6)) then
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


------Add by liuzhiqiang at 2009/8/14---------ÒåÆø
Task_Yiqi = 1532

function main()
    local tasks = {
        { "DiÖu Thñ ThÇn Y", "superDoctor"; show = 0 },
        { "LuyÖn Hãa MËt D­îc", "makeDrug"; show = 0 },
        { "Hñy N.vô", "cancelTask"; show = 0 },
        { "Phï hoa chi ®éc", "flower"; show = 0 }
    }

    local extLevel = GetPlayerExtLevel()
    local nTimes = GetTask(Task_Total_Times)
    local step = GetTaskByte(Task_Process, 1)

    if (extLevel >= 51 and (step <= 7) and (step >= 0) and (GetTaskByte(Task_Type, 3) ~= 2 or step ~= 0) and GetTaskByte(Task_Type, 1) ~= 2) then
        tasks[1].show = 1
    end

    if ((extLevel >= 56) and (nTimes >= 60) and (step >= 0) and (step <= 7) and GetTaskByte(Task_Type, 1) == 2) then
        tasks[2].show = 1
    end

    if (step > 0 and step <= 6) then
        tasks[3].show = 1
    end

    if (extLevel >= 50) and (GetTaskByte(Task_flower, 1) < 6) then
        tasks[4].show = 1
    end
    SayTask("Ta lµ ®¹i phu cña bé téc trªn nói nµy, v× bÖnh dŞch hoµnh hµnh trªn Ngôc Ph¸p S¬n gÇn ®©y, nhiÒu ng­êi trong bé téc ®· bŞ l©y nhiÔm, bÖnh t×nh nguy kŞch. Uæng ta häc y mÊy chôc n¨m trêi l¹i kh«ng t×m ra c¸ch ch÷a trŞ cho hä.", tasks)
end

function countExp()
    local expe = 0
    if (GetTaskByte(Task_Type, 1) == 1) then
        --ÃîÊÖÉñÒ½µÄ½±Àø
        if (GetTaskByte(Task_Process, 3) == 1) then
            expe = GetPlayerExtLevel() * 8000
        elseif (GetTaskByte(Task_Process, 3) == 2) then
            expe = GetPlayerExtLevel() * 16000
        end
    elseif (GetTaskByte(Task_Type, 1) == 2) then
        --Á¶ÖÆÃØÒ©µÄ½±Àø
        if (GetTaskByte(Task_Process, 3) == 1) then
            expe = GetPlayerExtLevel() * 10000
        elseif (GetTaskByte(Task_Process, 3) == 2) then
            expe = GetPlayerExtLevel() * 20000
        end
    end
    return expe
end

---ÃîÊÖÉñÒ½ÈÎÎñ
function superDoctor()
    CloseDialog()
    local step = GetTaskByte(Task_Process, 1)
    if (GetTask(Task_Accept_Day) ~= floor(LocalSystemTime() / 86400)) then
        --Ç°Ò»ÌìµÄÈÎÎñÈç¹ûÃ»ÓĞÊÍ·Å³ö³Ë»Æ»¹¿É¼ÌĞøÍê³É
        --Modified By Guoqun for Bug:fsb00032702 Begin
        if (GetTaskByte(Task_Type, 3) ~= 2) then
            -- µÚÒ»´Î½ÓÈÎÎñ£¬1´ú±íµÚÒ»´ÎÈÎÎñÒÑ¾­Íê³É
            --Modified By Guoqun for Bug:fsb00032702 End
            if (GetTask(Task_Total_Times) == 0) then
                if (GetTaskByte(Task_Type, 3) ~= 1) then
                    -- ·Çµ±Ìì½ÓµÄÈÎÎñ£¬Ò²¿ÉÒÔ¼ÌĞø×ö
                    --MsgBox("ÙÈ·ç£ºÓü·¨É½±¾À´Ò²Éú³¤×Å<c=yel>ÂüÍÓÂŞ»ª<c>ºÍ<c=yel>ÂüÖéÉ³»ª<c>£¬µ«×î½üÎÒÈ´Ñ°²»¼ûÁË£¬ÕâĞ©¿ÉÊÇ¾ÈÃüµÄÁéÒ©°¡£¡Ó¢ĞÛÈôÊÇÄÜ°ïÎÒ´øÀ´<c=yel>ÂüÍÓÂŞ»ª<c>ºÍ<c=yel>ÂüÖéÉ³»ª<c>¸÷<c=g>10<c>¸ö£¬ÒÔ¼°100Íò½ğÇ®£¬ÎÒµÄ×åÈË¾ÍÓĞ¾ÈÁË¡£", "Doctor_yesStart", "no")
                    SetTaskByte(Task_Process, 1, 1)            --ÈÎÎñµÚÒ»²½
                    SetTaskByte(Task_Process, 2, 1)            --ÈÎÎñ´ÎÊı
                    SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
                    SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0
                    SetTaskByte(Task_Type, 3, 1)          --Á½ÖÖÂüºÍÇ®ÒÑ¾­½»¸¶
                    SetTaskByte(Task_Type, 1, 1)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
                    local nNum = GetTask(Task_Total_Times)
                    nNum = nNum + 1
                    SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1
                    SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                    AddEventItem(questyKey[1].key)
                    Talk(1, "no", "GÇn ®©y Ngôc Ph¸p S¬n bÖnh dŞch hoµnh hµnh, rÊt nhiÒu ng­êi trong bé téc bŞ l©y nhiÔm. §©y lµ do ta chÕ t¹o <c=yel>" .. questyKey[1].name .. "<c>, nhÊt ®Şnh ph¶i tËn tay mang ®Õn cho téc tr­ëng <c=g>YÓn B¸ İch<c> t¹i trung khu th«n trÊn trªn Ngôc Ph¸p S¬n.")
                    Msg2Player("§©y lµ nhiÖm vô thø 1 cña ngµy h«m nay, nhËn ®­îc 1" .. questyKey[1].name)
                    TopMessage("NhËn ®­îc <c=yel>" .. questyKey[1].name)
                    TaskNote(1077, 0)
                    SyncBibleState(1077, 2, 1)
                    --Add by luoyixuan 2009/12/30 begin
                    refreshNpcTaskState()
                    --Add by luoyixuan 2009/12/30 end
                    offlineTotimes()
                end
            else
                --modified by liujifang for ÏÉÄ§½çÈÎÎñbugĞŞÕı at 2012-11-15 begin
                if (GetTask(Task_Total_Times) >= 1) then
                    --modified by liujifang for ÏÉÄ§½çÈÎÎñbugĞŞÕı at 2012-11-15 end
                    if (step == 1) then
                        Talk(1, "no", "Thêi gian kh«ng cßn nhiÒu, h·y nhanh chèng mang <c=yel>" .. questyKey[1].name .. "<c> giao cho téc tr­ëng <c=g>YÓn B¸ İch<c>!")
                    elseif (step == 2 and GetTaskByte(Task_Type, 3) == 1) then
                        local item = taskItem[1].Item
                        if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0) then
                            MsgBox("Sau khi anh hïng rêi khái ®©y, ta l¹i chÕ t¹o mét sè <c=yel>" .. questyKey[1].name .. "<c>, kh«ng ngê <c=r>ThiÕt Tinh ®¹i v­¬ng<c> ngöi ®­îc mïi Linh th¶o, bÌn c­íp ®i sè Linh th¶o cßn l¹i, anh hïng cã ®ång ı ®uæi theo lÊy l¹i kh«ng?", "Doctor_yesKill", "no")
                        else
                            --Ã»ÓĞÇıÄ§·û
                            Talk(1, "no", "ThÕ nµo, <c=yel>Håi Hån Than<c> mµ ta phèi chÕ cã c«ng hiÖu kh«ng?")
                        end
                    elseif (step >= 3 and step <= 5) then
                        Talk(1, "no", "<c=yel>Khu Ma phï<c> lµ b¶o bèi cña <c=g>YÓn V©n<c>. Sö dông nã cã thÓ nhËn ®­îc 1 Táa Yªu TrËn ph¸p, trËn ph¸p nµy cã thÓ chÕ ngù søc m¹nh kim cang bÊt ho¹i cña <c=r>ThiÕt Tinh ®¹i v­¬ng<c>, h·y nhanh chãng ®i chÕ phôc h¾n ®i!")
                    elseif (step == 6) then
                        if (HaveEventItem(questyKey[2].key) > 0) then
                            RemoveIBBuff(buffID)
                            local expe = countExp()
                            DelEventItem(questyKey[2].key)
                            AddOwnExtendExp(expe)
                            Talk(2, "no", GetName() .. " YÓn Phong huynh ®Ö, ta vÉn ch­a ®o¹t l¹i nh÷ng th¶o d­îc bŞ mÊt tõ <c=r>ThiÕt Tinh §¹i V­¬ng<c>, nh­ng ta t×m ®­îc lo¹i th¶o d­îc nµy, huynh xem xem, kh«ng biÕt cã thÓ gióp İch g× cho huynh kh«ng.", "§©y… ®©y chİnh lµ <c=yel>Ng­ H×nh Th¶o<c>! Ta cø r­ëng r»ng chóng chØ ®­îc ghi nhËn trong s¸ch y häc, kh«ng ngê c¸c h¹ l¹i cã ®­îc nã, c«ng hiÖu cña nã cßn m¹nh h¬n c¶ Håi Hån Than. Nh÷ng tu luyÖn nµy c¸c h¹ rÊt xøng ®¸ng cã ®­îc.")
                            Msg2Player("NhËn ®­îc" .. expe .. " tu luyÖn")
                            TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. expe .. "<c> tu luyÖn")
                            SetTask(Task_Process, 0)          --ËùÓĞºÍÈÎÎñÏà¹ØµÄ±äÁ¿Çå0
                            SetTaskByte(Task_Type, 2, 1)      --ÉèÖÃ¸ÃÈÎÎñÒÑ¾­Íê³ÉµÚÒ»´Î
                            SetTaskByte(Task_Type, 1, 0)
                            SetTaskByte(Task_Type, 3, 2)      --±ê¼ÇµÚÒ»´ÎÈÎÎñÒÑ¾­Íê³É
                            SetTask(Task_Coordinate, 0)
                            offlineTotimes()                                        --ËøÑıÕòµÄ×ø±ê
                            SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                            SetTask(Task_MonsterID, 0)
                            TaskNote(1077, -1)
                            SyncBibleState(1077, 1, 1)
                            --Add by luoyixuan 2009/12/30 begin
                            refreshNpcTaskState()
                            --Add by luoyixuan 2009/12/30 end

                            if (GetTask(Task_Total_Times) >= 60) then
                                SyncBibleState(1078, 1, 1)
                            end

                            -- Added by liuzhiqiang at 2009-6-3 Begin---------ÒÔ¾Æ»áÓÑ
                            if (GetTaskByte(Task_flower, 1) <= 15) then
                                if (IsHaveSpaceForTreasure(1) == 1) then
                                    if (IsExistItem(4, 256, 0, 1) == 0) then
                                        local num = random(1, 100)
                                        if (num <= 15) then
                                            ClearItem(4, 256, 0, 1)
                                            AddNormalItem(4, 256, 0, 1, 0, 0)
                                            SetTaskByte(Task_question, 1, 3)
                                        end
                                    end
                                end
                            end
                            -- Added by liuzhiqiang at 2009-6-3 End-----------ÒÔ¾Æ»áÓÑ
                        else
                            Talk(1, "no", "C¸c h¹ vÉn ch­a t×m vÒ linh th¶o ­? Kh«ng lÏ téc ta ®· ®Õn håi diÖt vong!")
                            return
                        end
                    elseif (step == 7) then
                        Talk(1, "no", "Ng­¬i kh«ng dïng <c=yel>Khu Ma phï<c>, th«i vËy, lÇn sau nªn chó ı, <c=yel>Khu Ma phï<c> nµy lµ do YÓn V©n chÕ t¹o. Uy lùc v« song, ai ngê……")
                        TopMessage("ThËt tiÕc, ch­a thÓ hoµn thµnh nhiÖm vô")
                        Msg2Player("ThËt tiÕc nhiÖm vô ®· thÊt b¹i.")
                        local item = taskItem[1].Item
                        ClearItem(item[1], item[2], item[3], item[4])
                        for i = 1, 3 do
                            DelEventItem(questyKey[i].key)
                        end
                        RemoveIBBuff(buffID)
                        SetTask(Task_Process, 0)                                --ËùÓĞºÍÈÎÎñÏà¹ØµÄ±äÁ¿Çå0
                        SetTaskByte(Task_Type, 1, 0)
                        SetTaskByte(Task_Type, 3, 2)
                        SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
                        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                        SetTask(Task_MonsterID, 0)
                        Msg2Player("§· tõ bá nhiÖm vô")
                        TaskNote(1077, -1)
                        --Add by luoyixuan 2009/12/30 begin
                        refreshNpcTaskState()
                        --Add by luoyixuan 2009/12/30 end
                    end
                end
            end

            --ÒÔÏÂÎª´¦Àí·ÇµÚÒ»´ÎÈÎÎñ£¬´ÓÄÃµ½ÇıÄ§·û¿ªÊ¼
        else
            if (GetTaskByte(Task_Type, 3) == 2) then
                --Èç¹ûµÚÒ»´ÎÒÑ¾­Íê³££¬ÄÇÃ´ÕûÌõÈÎÎñ½«²»»áÓë»Ø»êÌÀÓĞ¹Ø£¬¹ÊÓĞ´Ë²Ù×÷
                if (step == 1 and GetTaskByte(Task_Type, 3) == 1) then
                    Talk(1, "no", "Thêi gian kh«ng cßn nhiÒu, h·y nhanh chèng mang <c=yel>" .. questyKey[1].name .. "<c> giao cho téc tr­ëng <c=g>YÓn B¸ İch<c>!")
                    return
                end
                if (step == 2) then
                    local item = taskItem[1].Item
                    if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0) then
                        MsgBox("Sau khi anh hïng rêi khái ®©y, ta l¹i chÕ t¹o mét sè <c=yel>" .. questyKey[1].name .. "<c>, kh«ng ngê <c=r>ThiÕt Tinh ®¹i v­¬ng<c> ngöi ®­îc mïi Linh th¶o, bÌn c­íp ®i sè Linh th¶o cßn l¹i, anh hïng cã ®ång ı ®uæi theo lÊy l¹i kh«ng?", "Doctor_yesKill", "no")
                    else
                        --Ã»ÓĞÇıÄ§·û
                        Talk(1, "no", "ThÕ nµo, <c=yel>Håi Hån Than<c> mµ ta phèi chÕ cã c«ng hiÖu kh«ng?")
                    end
                elseif (step >= 3 and step <= 5) then
                    Talk(1, "no", "<c=yel>Khu Ma phï<c> lµ b¶o bèi cña <c=g>YÓn V©n<c>. Sö dông nã cã thÓ nhËn ®­îc 1 Táa Yªu TrËn ph¸p, trËn ph¸p nµy cã thÓ chÕ ngù søc m¹nh kim cang bÊt ho¹i cña <c=r>ThiÕt Tinh ®¹i v­¬ng<c>, h·y nhanh chãng ®i chÕ phôc h¾n ®i!")
                elseif (step == 6) then
                    if (HaveEventItem(questyKey[2].key) > 0) then
                        RemoveIBBuff(buffID)
                        local expe = countExp()
                        DelEventItem(questyKey[2].key)
                        AddOwnExtendExp(expe)
                        Talk(2, "no", GetName() .. " YÓn Phong huynh ®Ö, ta vÉn ch­a ®o¹t l¹i nh÷ng th¶o d­îc bŞ mÊt tõ <c=r>ThiÕt Tinh §¹i V­¬ng<c>, nh­ng ta t×m ®­îc lo¹i th¶o d­îc nµy, huynh xem xem, kh«ng biÕt cã thÓ gióp İch g× cho huynh kh«ng.", "§©y… ®©y chİnh lµ <c=yel>Ng­ H×nh Th¶o<c>! Ta cø r­ëng r»ng chóng chØ ®­îc ghi nhËn trong s¸ch y häc, kh«ng ngê c¸c h¹ l¹i cã ®­îc nã, c«ng hiÖu cña nã cßn m¹nh h¬n c¶ Håi Hån Than. Nh÷ng tu luyÖn nµy c¸c h¹ rÊt xøng ®¸ng cã ®­îc.")
                        Msg2Player("NhËn ®­îc" .. expe .. " tu luyÖn")
                        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. expe .. "<c> tu luyÖn")

                        SetTask(Task_Process, 0)                                --ËùÓĞºÍÈÎÎñÏà¹ØµÄ±äÁ¿Çå0
                        SetTaskByte(Task_Type, 1, 0)
                        SetTask(Task_Coordinate, 0)
                        --Add by luoyixuan 2009/12/30 begin
                        refreshNpcTaskState()
                        --Add by luoyixuan 2009/12/30 end

                        offlineTotimes()                                --ËøÑıÕòµÄ×ø±ê
                        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                        SetTask(Task_MonsterID, 0)
                        TaskNote(1077, -1)
                        SyncBibleState(1077, 1, 1)
                        if (GetTask(Task_Total_Times) >= 60) then
                            SyncBibleState(1078, 1, 1)
                        end

                        -- Added by liuzhiqiang at 2009-6-3 Begin---------ÒÔ¾Æ»áÓÑ
                        if (GetTaskByte(Task_flower, 1) <= 15) then
                            if (IsHaveSpaceForTreasure(1) == 1) then
                                if (IsExistItem(4, 256, 0, 1) == 0) then
                                    local num = random(1, 100)
                                    if (num <= 15) then
                                        ClearItem(4, 256, 0, 1)
                                        AddNormalItem(4, 256, 0, 1, 0, 0)
                                        SetTaskByte(Task_question, 1, 3)
                                    end
                                end
                            end
                        end
                        -- Added by liuzhiqiang at 2009-6-3 End-----------ÒÔ¾Æ»áÓÑ
                    else
                        Talk(1, "no", "C¸c h¹ vÉn ch­a t×m vÒ linh th¶o ­? Kh«ng lÏ téc ta ®· ®Õn håi diÖt vong!")
                        return
                    end
                elseif (step == 0) then
                    Talk(1, "no", "Ta ®· cho ng­¬i <c=yel>Canh hoµn hån<c>, tr«ng <c=g>YÓn B¸ İch<c> h×nh nh­ cã chuyÖn muèn t×m ng­¬i, h·y mau qua ®ã.")
                    return
                    --Modified By Guoqun for Bug fsb00033013 at 2011-01-19 Begin
                elseif (step == 7) then
                    Talk(1, "no", "Ng­¬i kh«ng dïng <c=yel>Khu Ma phï<c>, th«i vËy, lÇn sau nªn chó ı, <c=yel>Khu Ma phï<c> nµy lµ do YÓn V©n chÕ t¹o. Uy lùc v« song, ai ngê……")
                    TopMessage("ThËt tiÕc, ch­a thÓ hoµn thµnh nhiÖm vô")
                    Msg2Player("ThËt tiÕc nhiÖm vô ®· thÊt b¹i.")
                    local item = taskItem[1].Item
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
                    Msg2Player("§· tõ bá nhiÖm vô")
                    TaskNote(1077, -1)
                    --Add by luoyixuan 2009/12/30 begin
                    refreshNpcTaskState()
                    --Add by luoyixuan 2009/12/30 end
                end
            end
            --Modified By Guoqun for Bug fsb00033013 at 2011-01-19 End
        end
    else
        if (GetTaskByte(Task_Type, 3) ~= 2) then
            if (GetTask(Task_Total_Times) == 0 and GetTaskByte(Task_Type, 3) ~= 1) then
                -- µÚÒ»´Î½ÓÈÎÎñ
                --MsgBox("ÙÈ·ç£ºÓü·¨É½±¾À´Ò²Éú³¤×Å<c=yel>ÂüÍÓÂŞ»ª<c>ºÍ<c=yel>ÂüÖéÉ³»ª<c>£¬µ«×î½üÎÒÈ´Ñ°²»¼ûÁË£¬ÕâĞ©¿ÉÊÇ¾ÈÃüµÄÁéÒ©°¡£¡Ó¢ĞÛÈôÊÇÄÜ°ïÎÒ´øÀ´<c=yel>ÂüÍÓÂŞ»ª<c>ºÍ<c=yel>ÂüÖéÉ³»ª<c>¸÷<c=g>10<c>¸ö£¬ÒÔ¼°100Íò½ğÇ®£¬ÎÒµÄ×åÈË¾ÍÓĞ¾ÈÁË¡£", "Doctor_yesStart", "no")
                SetTaskByte(Task_Process, 1, 1)            --ÈÎÎñµÚÒ»²½
                SetTaskByte(Task_Process, 2, 1)            --ÈÎÎñ´ÎÊı
                SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
                SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0
                SetTaskByte(Task_Type, 3, 1)          --Á½ÖÖÂüºÍÇ®ÒÑ¾­½»¸¶
                SetTaskByte(Task_Type, 1, 1)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
                local nNum = GetTask(Task_Total_Times)
                nNum = nNum + 1
                SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1

                SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                AddEventItem(questyKey[1].key)
                Talk(1, "no", "§©y lµ do ta ®Æc chÕ <c=yel>" .. questyKey[1].name .. "<c>, nhÊt ®Şnh ph¶i tËn tay mang ®Õn cho téc tr­ëng <c=g>YÓn B¸ İch<c> t¹i trung khu th«n trÊn trªn Ngôc Ph¸p S¬n.")
                Msg2Player("§©y lµ nhiÖm vô thø 1 cña ngµy h«m nay, nhËn ®­îc 1" .. questyKey[1].name)
                TopMessage("NhËn ®­îc <c=yel>" .. questyKey[1].name)
                TaskNote(1077, 0)
                SyncBibleState(1077, 2, 1)
                --Add by luoyixuan 2009/12/30 begin
                refreshNpcTaskState()
                --Add by luoyixuan 2009/12/30 end
                offlineTotimes()
            else
                --modified by liujifang for ÏÉÄ§½çÈÎÎñbugĞŞÕı at 2012-11-15 begin
                if (GetTask(Task_Total_Times) >= 1) then
                    --modified by liujifang for ÏÉÄ§½çÈÎÎñbugĞŞÕı at 2012-11-15 end
                    if (step == 1 and GetTaskByte(Task_Type, 3) == 1) then
                        Talk(1, "no", "Thêi gian kh«ng cßn nhiÒu, h·y nhanh chèng mang <c=yel>" .. questyKey[1].name .. "<c> giao cho téc tr­ëng <c=g>YÓn B¸ İch<c>!")
                        return
                    end
                    if (step == 2 and GetTaskByte(Task_Type, 3) == 1) then
                        local item = taskItem[1].Item
                        if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0) then
                            MsgBox("Sau khi anh hïng rêi khái ®©y, ta l¹i chÕ t¹o mét sè <c=yel>" .. questyKey[1].name .. "<c>, kh«ng ngê <c=r>ThiÕt Tinh ®¹i v­¬ng<c> ngöi ®­îc mïi Linh th¶o, bÌn c­íp ®i sè Linh th¶o cßn l¹i, anh hïng cã ®ång ı ®uæi theo lÊy l¹i kh«ng?", "Doctor_yesKill", "no")
                        else
                            --Ã»ÓĞÇıÄ§·û
                            Talk(1, "no", "ThÕ nµo, <c=yel>Håi Hån Than<c> mµ ta phèi chÕ cã c«ng hiÖu kh«ng?")
                        end
                    elseif (step >= 3 and step <= 5) then
                        Talk(1, "no", "<c=yel>Khu Ma phï<c> lµ b¶o bèi cña <c=g>YÓn V©n<c>. Sö dông nã cã thÓ nhËn ®­îc 1 Táa Yªu TrËn ph¸p, trËn ph¸p nµy cã thÓ chÕ ngù søc m¹nh kim cang bÊt ho¹i cña <c=r>ThiÕt Tinh ®¹i v­¬ng<c>, h·y nhanh chãng ®i chÕ phôc h¾n ®i!")
                    elseif (step == 6) then
                        if (HaveEventItem(questyKey[2].key) > 0) then
                            RemoveIBBuff(buffID)
                            local expe = countExp()
                            DelEventItem(questyKey[2].key)
                            AddOwnExtendExp(expe)
                            Talk(2, "no", GetName() .. " YÓn Phong huynh ®Ö, ta vÉn ch­a ®o¹t l¹i nh÷ng th¶o d­îc bŞ mÊt tõ <c=r>ThiÕt Tinh §¹i V­¬ng<c>, nh­ng ta t×m ®­îc lo¹i th¶o d­îc nµy, huynh xem xem, kh«ng biÕt cã thÓ gióp İch g× cho huynh kh«ng.", "§©y… ®©y chİnh lµ <c=yel>Ng­ H×nh Th¶o<c>! Ta cø r­ëng r»ng chóng chØ ®­îc ghi nhËn trong s¸ch y häc, kh«ng ngê c¸c h¹ l¹i cã ®­îc nã, c«ng hiÖu cña nã cßn m¹nh h¬n c¶ Håi Hån Than. Nh÷ng tu luyÖn nµy c¸c h¹ rÊt xøng ®¸ng cã ®­îc.")
                            Msg2Player("NhËn ®­îc" .. expe .. " tu luyÖn")
                            TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. expe .. "<c> tu luyÖn")
                            local temp = GetTaskByte(Task_Process, 2) + 1
                            SetTaskByte(Task_Process, 1, 0)           --ÈÎÎñ²½Öè¹éÁã
                            SetTaskByte(Task_Process, 3, 0)           --É±ËÀ³Ë»Æ¸öÊı¹éÁã
                            SetTaskByte(Task_Process, 4, 0)
                            SetTaskByte(Task_Type, 1, 0)                    --ÈÎÎñÀàĞÍÇåÁã
                            SetTask(Task_Coordinate, 0)
                            SetTask(Task_MonsterID, 0)
                            SetTaskByte(Task_Type, 3, 2)                    --±ê¼ÇµÚÒ»´ÎÈÎÎñÒÑ¾­Íê³É
                            SetTaskByte(Task_Type, 2, 1)                    --ÉèÖÃ¸ÃÈÎÎñÒÑ¾­Íê³ÉµÚÒ»´Î
                            SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400)) --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                            SetTask(Task_MonsterID, 0)
                            --Add by luoyixuan 2009/12/30 begin
                            refreshNpcTaskState()
                            --Add by luoyixuan 2009/12/30 end
                            offlineTotimes()                                        --ËøÑıÕòµÄ×ø±ê
                            TaskNote(1077, -1)
                            SyncBibleState(1077, 1, 1)

                            if (GetTask(Task_Total_Times) >= 60) then
                                SyncBibleState(1078, 1, 1)
                            end

                            -- Added by liuzhiqiang at 2009-6-3 Begin---------ÒÔ¾Æ»áÓÑ
                            if (GetTaskByte(Task_flower, 1) <= 15) then
                                if (IsHaveSpaceForTreasure(1) == 1) then
                                    if (IsExistItem(4, 256, 0, 1) == 0) then
                                        local num = random(1, 100)
                                        if (num <= 15) then
                                            ClearItem(4, 256, 0, 1)
                                            AddNormalItem(4, 256, 0, 1, 0, 0)
                                            SetTaskByte(Task_question, 1, 3)
                                        end
                                    end
                                end
                            end
                            -- Added by liuzhiqiang at 2009-6-3 End-----------ÒÔ¾Æ»áÓÑ

                        else
                            Talk(1, "no", "C¸c h¹ vÉn ch­a t×m vÒ linh th¶o ­? Kh«ng lÏ téc ta ®· ®Õn håi diÖt vong!")
                            return
                        end
                    elseif (step == 7) then
                        Talk(1, "no", "Ng­¬i kh«ng dïng <c=yel>Khu Ma phï<c>, th«i vËy, lÇn sau nªn chó ı, <c=yel>Khu Ma phï<c> nµy lµ do YÓn V©n chÕ t¹o. Uy lùc v« song, ai ngê……")
                        TopMessage("ThËt tiÕc, ch­a thÓ hoµn thµnh nhiÖm vô")
                        Msg2Player("ThËt tiÕc nhiÖm vô ®· thÊt b¹i.")

                        local item = taskItem[1].Item
                        ClearItem(item[1], item[2], item[3], item[4])
                        for i = 1, 3 do
                            DelEventItem(questyKey[i].key)
                        end
                        RemoveIBBuff(buffID)
                        SetTask(Task_Coordinate, 0)
                        SetTaskByte(Task_Process, 1, 0)
                        SetTaskByte(Task_Process, 3, 0)
                        SetTaskByte(Task_Process, 4, 0)
                        SetTaskByte(Task_Type, 1, 0)                                --ËøÑıÕòµÄ×ø±ê
                        SetTaskByte(Task_Type, 3, 2)
                        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                        SetTask(Task_MonsterID, 0)
                        Msg2Player("§· tõ bá nhiÖm vô")
                        TaskNote(1077, -1)
                        --Add by luoyixuan 2009/12/30 begin
                        refreshNpcTaskState()
                        --Add by luoyixuan 2009/12/30 end
                    end
                end
            end
            --ÒÔÏÂÎª´¦Àí·ÇµÚÒ»´ÎÈÎÎñ£¬´ÓÄÃµ½ÇıÄ§·û¿ªÊ¼
        else
            if (GetTaskByte(Task_Type, 3) == 2) then
                --Èç¹ûµÚÒ»´ÎÒÑ¾­Íê³££¬ÄÇÃ´ÕûÌõÈÎÎñ½«²»»áÓë»Ø»êÌÀÓĞ¹Ø£¬¹ÊÓĞ´Ë²Ù×÷
                if (step == 2) then
                    local item = taskItem[1].Item
                    if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0) then
                        MsgBox("Sau khi anh hïng rêi khái ®©y, ta l¹i chÕ t¹o mét sè <c=yel>" .. questyKey[1].name .. "<c>, kh«ng ngê <c=r>ThiÕt Tinh ®¹i v­¬ng<c> ngöi ®­îc mïi Linh th¶o, bÌn c­íp ®i sè Linh th¶o cßn l¹i, anh hïng cã ®ång ı ®uæi theo lÊy l¹i kh«ng?", "Doctor_yesKill", "no")
                    else
                        --Ã»ÓĞÇıÄ§·û
                        Talk(1, "no", "ThÕ nµo, <c=yel>Håi Hån Than<c> mµ ta phèi chÕ cã c«ng hiÖu kh«ng?")
                    end
                elseif (step >= 3 and step <= 5) then
                    Talk(1, "no", "<c=yel>Khu Ma phï<c> lµ b¶o bèi cña <c=g>YÓn V©n<c>. Sö dông nã cã thÓ nhËn ®­îc 1 Táa Yªu TrËn ph¸p, trËn ph¸p nµy cã thÓ chÕ ngù søc m¹nh kim cang bÊt ho¹i cña <c=r>ThiÕt Tinh ®¹i v­¬ng<c>, h·y nhanh chãng ®i chÕ phôc h¾n ®i!")
                elseif (step == 6) then
                    if (HaveEventItem(questyKey[2].key) > 0) then
                        RemoveIBBuff(buffID)
                        local expe = countExp()
                        DelEventItem(questyKey[2].key)
                        AddOwnExtendExp(expe)
                        Talk(2, "no", GetName() .. " YÓn Phong huynh ®Ö, ta vÉn ch­a ®o¹t l¹i nh÷ng th¶o d­îc bŞ mÊt tõ <c=r>ThiÕt Tinh §¹i V­¬ng<c>, nh­ng ta t×m ®­îc lo¹i th¶o d­îc nµy, huynh xem xem, kh«ng biÕt cã thÓ gióp İch g× cho huynh kh«ng.", "§©y… ®©y chİnh lµ <c=yel>Ng­ H×nh Th¶o<c>! Ta cø r­ëng r»ng chóng chØ ®­îc ghi nhËn trong s¸ch y häc, kh«ng ngê c¸c h¹ l¹i cã ®­îc nã, c«ng hiÖu cña nã cßn m¹nh h¬n c¶ Håi Hån Than. Nh÷ng tu luyÖn nµy c¸c h¹ rÊt xøng ®¸ng cã ®­îc.")
                        Msg2Player("NhËn ®­îc" .. expe .. " tu luyÖn")
                        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. expe .. "<c> tu luyÖn")

                        SetTask(Task_Coordinate, 0)
                        SetTaskByte(Task_Process, 1, 0)
                        SetTaskByte(Task_Process, 3, 0)
                        SetTaskByte(Task_Process, 4, 0)
                        SetTaskByte(Task_Type, 1, 0)                        --ÈÎÎñÀàĞÍÇåÁã
                        --Add by luoyixuan 2009/12/30 begin
                        refreshNpcTaskState()
                        --Add by luoyixuan 2009/12/30 end

                        offlineTotimes()
                        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                        SetTask(Task_MonsterID, 0)
                        TaskNote(1077, -1)
                        SyncBibleState(1077, 1, 1)
                        if (GetTask(Task_Total_Times) >= 60) then
                            SyncBibleState(1078, 1, 1)
                        end

                        -- Added by liuzhiqiang at 2009-6-3 Begin---------ÒÔ¾Æ»áÓÑ
                        if (GetTaskByte(Task_flower, 1) <= 15) then
                            if (IsHaveSpaceForTreasure(1) == 1) then
                                if (IsExistItem(4, 256, 0, 1) == 0) then
                                    local num = random(1, 100)
                                    if (num <= 15) then
                                        ClearItem(4, 256, 0, 1)
                                        AddNormalItem(4, 256, 0, 1, 0, 0)
                                        SetTaskByte(Task_question, 1, 3)
                                    end
                                end
                            end
                        end
                        -- Added by liuzhiqiang at 2009-6-3 End-----------ÒÔ¾Æ»áÓÑ
                    else
                        Talk(1, "no", "C¸c h¹ vÉn ch­a t×m vÒ linh th¶o ­? Kh«ng lÏ téc ta ®· ®Õn håi diÖt vong!")
                        return
                    end
                elseif (step == 7) then
                    Talk(1, "no", "Ng­¬i kh«ng dïng <c=yel>Khu Ma phï<c>, th«i vËy, lÇn sau nªn chó ı, <c=yel>Khu Ma phï<c> nµy lµ do YÓn V©n chÕ t¹o. Uy lùc v« song, ai ngê……")
                    TopMessage("ThËt tiÕc, ch­a thÓ hoµn thµnh nhiÖm vô")
                    Msg2Player("ThËt tiÕc nhiÖm vô ®· thÊt b¹i.")
                    local item = taskItem[1].Item
                    ClearItem(item[1], item[2], item[3], item[4])
                    for i = 1, 3 do
                        DelEventItem(questyKey[i].key)
                    end
                    RemoveIBBuff(buffID)
                    SetTaskByte(Task_Process, 1, 0)
                    SetTaskByte(Task_Process, 3, 0)
                    SetTaskByte(Task_Process, 4, 0)
                    SetTaskByte(Task_Type, 1, 0)                    --ÈÎÎñÀàĞÍÇåÁã
                    SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
                    SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                    SetTask(Task_MonsterID, 0)
                    SetTaskByte(Task_Type, 3, 2)
                    Msg2Player("§· tõ bá nhiÖm vô")
                    TaskNote(1077, -1)
                    --Add by luoyixuan 2009/12/30 begin
                    refreshNpcTaskState()
                    --Add by luoyixuan 2009/12/30 end
                end
            elseif (step == 0) then
                Talk(1, "no", "Ta ®· cho ng­¬i <c=yel>Canh hoµn hån<c>, ng­¬i nªn ®i t×m<c=g>YÓn B¸ İch<c>.")
                return
            end
        end
    end
end

function Doctor_yesStart()
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

    if (nTimes == 0) then
        if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
            Talk(1, "no", "CÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c> ®Ó chÕ t¹o <c=yel>Canh hoµn hån<c>.")
            return
        end

        if (GetCash() < pm) then
            --modify by liuzhiqiang
            Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn.")
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "kh«ng gian trong hµnh trang kh«ng ®ñ, chuÈn bŞ s½n sµng råi h·y quay l¹i.")
            return
        end

        for i = 1, 10, 1 do
            DelNormalItem(3, 311, 0, 0)
            DelNormalItem(3, 312, 0, 0)
        end

        SetTaskByte(Task_Process, 1, 1)            --ÈÎÎñµÚÒ»²½
        SetTaskByte(Task_Process, 2, 1)            --ÈÎÎñ´ÎÊı
        SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
        SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0

        SetTaskByte(Task_Type, 3, 1)          --Á½ÖÖÂüºÍÇ®ÒÑ¾­½»¸¶

        local nNum = GetTask(Task_Total_Times)
        nNum = nNum + 1
        SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1

        SetTaskByte(Task_Type, 1, 1)            --½ÓÊÜÃîÊÖÉñÒ½µÄÈÎÎñ
        SetTask(Task_MonsterID, 0)                --¹ÖÎïID
        SetTask(Task_Coordinate, 0)
        AddEventItem(questyKey[1].key)
        Talk(1, "no", "§©y lµ do ta ®Æc chÕ <c=yel>" .. questyKey[1].name .. "<c>, nhÊt ®Şnh ph¶i tËn tay mang ®Õn cho téc tr­ëng <c=g>YÓn B¸ İch<c> t¹i trung khu th«n trÊn trªn Ngôc Ph¸p S¬n.")
        Msg2Player("§©y lµ nhiÖm vô thø 1 cña ngµy h«m nay, nhËn ®­îc 1" .. questyKey[1].name)
        TopMessage("NhËn ®­îc <c=yel>" .. questyKey[1].name)
        TaskNote(1077, 0)
        SyncBibleState(1077, 2, 1)
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end
        if (GetTask(Task_Total_Times) >= 60) then
            SyncBibleState(1078, 2, 1)
        end
    end
end

function Doctor_yesKill()
    CloseDialog()
    local item = taskItem[1].Item
    if (GetTaskByte(Task_Process, 1) == 2 and ((HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0))) then
        SetTaskByte(Task_Process, 1, 3)
        SetTask(Task_MonsterID, 0)
        SetTask(Task_Free_Time, 0)
        Talk(1, "no", "<c=r>ThiÕt Tinh §¹i V­¬ng<c> chİnh lµ thñ lÜnh ThiÕt Tinh trªn vïng nói nµy, th­êng ngµy sÏ kh«ng hiÖn th©n, h«m nay bŞ mïi h­¬ng cña linh th¶o hÊp dÉn ®Õn. NÕu nh­ c¸c h¹ tiªu diÖt ThiÕt Tinh nhiÒu lÇn th× h¾n nhÊt ®Şnh sÏ xuÊt hiÖn!")
        Msg2Player("Tiªu diÖt ThiÕt Tinh dÉn dô ThiÕt Tinh §¹i V­¬ng xuÊt hiÖn")
        TaskNote(1077, 2)
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end
    end
end

---yaoxin Ñ­»·ÈÎÎñ¸ÄÔì, Í³¼ÆÀëÏß´ÎÊı»ıÔÜ,ÓÃÆäÊıÖµµÄµÚ6,7,8bit¼ÇÂ¼Î´Ê¹ÓÃµÄÀëÏß»ıÀÛ´ÎÊı
function offlineTotimes()
    -- modified by yaoxin for 2010-10
    local localday = floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1-- modified by yaoxin for 2010-12

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
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

--------------------------------------------

--Á¶ÖÆÃÔÒ©ÈÎÎñ
function makeDrug()
    CloseDialog()
    if (GetTaskByte(Task_Type, 1) == 1) then
        Talk(1, "no", "§ang thùc hiÖn nhiÖm vô Miªu Thñ ThÇn Y, kh«ng thÓ nhËn nhiÖm vô.")
        return
    end

    local step = GetTaskByte(Task_Process, 1)
    if (GetTask(Task_Accept_Day) ~= floor(LocalSystemTime() / 86400)) then

        if (step == 2) then
            local item = taskItem[1].Item
            if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0) then
                MsgBox("Sau khi anh hïng rêi khái ®©y, ta l¹i chÕ t¹o mét sè <c=yel>" .. questyKey[1].name .. "<c>, kh«ng ngê <c=r>Lª Linh Thi Chó<c> ngöi ®­îc mïi Linh th¶o, bÌn c­íp ®i sè Linh th¶o cßn l¹i, anh hïng cã ®ång ı ®uæi theo lÊy l¹i kh«ng?", "Drug_yesKill", "no")
            else
                --Ã»ÓĞÇıÄ§·û
                Talk(1, "no", "ThÕ nµo, <c=yel>Håi Hån Than<c> mµ ta phèi chÕ cã c«ng hiÖu kh«ng?")
            end
        elseif (step >= 3 and step <= 5) then
            Talk(1, "no", "<c=yel>Khu Ma phï <c> chİnh lµ b¶o bèi cña huynh ®Ö ta <c=g>YÕn V©n<c>. Sö dông nã cã thÓ nhËn ®­îc 1 Táa Yªu TrËn ph¸p, trËn ph¸p nµy cã thÓ chÕ ngù søc m¹nh kim cang bÊt ho¹i cña Lª Linh Thi Phï Chó, h·y nhanh chèng ®i chÕ phôc h¾n ®i!")
        elseif (step == 6) then
            if (HaveEventItem(questyKey[3].key) > 0) then
                RemoveIBBuff(buffID)
                DelEventItem(questyKey[3].key)
                local expe = countExp()
                AddOwnExtendExp(expe)
                Talk(2, "no", GetName() .. " YÓn Phong huynh ®Ö, ta vÉn ch­a ®o¹t l¹i nh÷ng th¶o d­îc bŞ mÊt tõ <c=r>Lª Linh Thi Phï Chó<c>, nh­ng ta t×m ®­îc lo¹i th¶o d­îc nµy, huynh xem xem, kh«ng biÕt cã thÓ gióp İch g× cho huynh kh«ng.", "§©y… ®©y chİnh lµ <c=yel>Long Ng¹n Th¶o<c>! tõ c¸ huyÒn hãa thµnh rång, nã cßn quı hiÕm h¬n c¶ Ng­ H×nh Th¶o, kh«ng ngê d­îc th¶o quı hiÕm nµy l¹i cã trªn ng­êi Lª Linh Thi Phï Chó. C¸c h¹ qu¶ nhiªn lµ cøu tinh cña bé téc ta, h·y ®Ó ta gióp c¸c h¹ t¨ng cao tu luyÖn xem nh­ ®Òn ®¸p c«ng ¬n!")
                Msg2Player("NhËn ®­îc" .. expe .. " tu luyÖn")
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. expe .. "<c> tu luyÖn")
                SetTask(Task_Process, 0)                                --ËùÓĞºÍÈÎÎñÏà¹ØµÄ±äÁ¿Çå0
                SetTaskByte(Task_Type, 1, 0)
                SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
                SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
                SetTask(Task_MonsterID, 0)
                TaskNote(1078, -1)
                SyncBibleState(1078, 1, 1)
                SyncBibleState(1077, 1, 1)
                --Add by luoyixuan 2009/12/30 begin
                refreshNpcTaskState()
                --Add by luoyixuan 2009/12/30 end

                -- Added by liuzhiqiang at 2009-6-3 Begin---------ÒÔ¾Æ»áÓÑ
                if (GetTaskByte(Task_flower, 1) <= 15) then
                    if (IsHaveSpaceForTreasure(1) == 1) then
                        if (IsExistItem(4, 256, 0, 1) == 0) then
                            local num = random(1, 100)
                            if (num <= 15) then
                                ClearItem(4, 256, 0, 1)
                                AddNormalItem(4, 256, 0, 1, 0, 0)
                                SetTaskByte(Task_question, 1, 3)
                            end
                        end
                    end
                end
                -- Added by liuzhiqiang at 2009-6-3 End-----------ÒÔ¾Æ»áÓÑ
            else
                Talk(1, "no", "C¸c h¹ vÉn ch­a t×m vÒ linh th¶o ­? Kh«ng lÏ téc ta ®· ®Õn håi diÖt vong!")
                return
            end
        end

        if (step == 7) then
            Talk(1, "no", "Ng­¬i kh«ng dïng <c=yel>Khu Ma phï<c>, th«i vËy, lÇn sau nªn chó ı, <c=yel>Khu Ma phï<c> nµy lµ do YÓn V©n chÕ t¹o. Uy lùc v« song, ai ngê……")
            TopMessage("ThËt tiÕc, ch­a thÓ hoµn thµnh nhiÖm vô")
            Msg2Player("ThËt tiÕc nhiÖm vô ®· thÊt b¹i.")
            local item = taskItem[1].Item
            ClearItem(item[1], item[2], item[3], item[4])
            for i = 1, 3 do
                DelEventItem(questyKey[i].key)
            end
            RemoveIBBuff(buffID)
            SetTaskByte(Task_Process, 1, 0)
            SetTaskByte(Task_Process, 3, 0)
            SetTaskByte(Task_Process, 4, 0)
            SetTaskByte(Task_Type, 1, 0)                    --ÈÎÎñÀàĞÍÇåÁã
            SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
            SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
            SetTask(Task_MonsterID, 0)
            SetTaskByte(Task_Type, 3, 2)
            Msg2Player("§· tõ bá nhiÖm vô")
            TaskNote(1078, -1)
            --Add by luoyixuan 2009/12/30 begin
            refreshNpcTaskState()
            --Add by luoyixuan 2009/12/30 end
            return
        end
    else
        if (step == 2) then
            local item = taskItem[1].Item
            if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0) then
                MsgBox("Sau khi anh hïng rêi khái ®©y, ta l¹i chÕ t¹o mét sè <c=yel>" .. questyKey[1].name .. "<c>, kh«ng ngê <c=r>Lª Linh Thi Chó<c> ngöi ®­îc mïi Linh th¶o, bÌn c­íp ®i sè Linh th¶o cßn l¹i, anh hïng cã ®ång ı ®uæi theo lÊy l¹i kh«ng?", "Drug_yesKill", "no")
            else
                --Ã»ÓĞÇıÄ§·û
                Talk(1, "no", "ThÕ nµo, <c=yel>Håi Hån Than<c> mµ ta phèi chÕ cã c«ng hiÖu kh«ng?")
            end
            return
        end

        if (step >= 3 and step <= 5) then
            Talk(1, "no", "<c=yel>Khu Ma phï <c> chİnh lµ b¶o bèi cña huynh ®Ö ta <c=g>YÕn V©n<c>. Sö dông nã cã thÓ nhËn ®­îc 1 Táa Yªu TrËn ph¸p, trËn ph¸p nµy cã thÓ chÕ ngù søc m¹nh kim cang bÊt ho¹i cña Lª Linh Thi Phï Chó, h·y nhanh chèng ®i chÕ phôc h¾n ®i!")
            return
        end

        if (step == 6) then
            if (HaveEventItem(questyKey[3].key) > 0) then
                RemoveIBBuff(buffID)
                DelEventItem(questyKey[3].key)
                local expe = countExp()
                AddOwnExtendExp(expe)

                SetTaskByte(Task_Process, 1, 0)
                SetTaskByte(Task_Process, 3, 0)
                SetTaskByte(Task_Process, 4, 0)
                SetTaskByte(Task_Type, 1, 0)                    --ÈÎÎñÀàĞÍÇåÁã
                SetTask(Task_Coordinate, 0)
                SetTask(Task_MonsterID, 0)
                --Add by luoyixuan 2009/12/30 begin
                refreshNpcTaskState()
                --Add by luoyixuan 2009/12/30 end

                Talk(2, "no", GetName() .. " YÓn Phong huynh ®Ö, ta vÉn ch­a ®o¹t l¹i nh÷ng th¶o d­îc bŞ mÊt tõ <c=r>Lª Linh Thi Phï Chó<c>, nh­ng ta t×m ®­îc lo¹i th¶o d­îc nµy, huynh xem xem, kh«ng biÕt cã thÓ gióp İch g× cho huynh kh«ng.", "§©y… ®©y chİnh lµ <c=yel>Long Ng¹n Th¶o<c>! tõ c¸ huyÒn hãa thµnh rång, nã cßn quı hiÕm h¬n c¶ Ng­ H×nh Th¶o, kh«ng ngê d­îc th¶o quı hiÕm nµy l¹i cã trªn ng­êi Lª Linh Thi Phï Chó. C¸c h¹ qu¶ nhiªn lµ cøu tinh cña bé téc ta, h·y ®Ó ta gióp c¸c h¹ t¨ng cao tu luyÖn xem nh­ ®Òn ®¸p c«ng ¬n!")
                Msg2Player("NhËn ®­îc" .. expe .. " tu luyÖn")
                TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. expe .. "<c> tu luyÖn")
                TaskNote(1078, -1)

                -- Added by liuzhiqiang at 2009-6-3 Begin---------ÒÔ¾Æ»áÓÑ
                if (GetTaskByte(Task_flower, 1) <= 15) then
                    if (IsHaveSpaceForTreasure(1) == 1) then
                        if (IsExistItem(4, 256, 0, 1) == 0) then
                            local num = random(1, 100)
                            if (num <= 15) then
                                ClearItem(4, 256, 0, 1)
                                AddNormalItem(4, 256, 0, 1, 0, 0)
                                SetTaskByte(Task_question, 1, 3)
                            end
                        end
                    end
                end
                -- Added by liuzhiqiang at 2009-6-3 End-----------ÒÔ¾Æ»áÓÑ
            else
                Talk(1, "no", "C¸c h¹ vÉn ch­a t×m vÒ linh th¶o ­? Kh«ng lÏ téc ta ®· ®Õn håi diÖt vong!")
            end
            return
        end

        if (step == 7) then
            Talk(1, "no", "Ng­¬i kh«ng dïng <c=yel>Khu Ma phï<c>, th«i vËy, lÇn sau nªn chó ı, <c=yel>Khu Ma phï<c> nµy lµ do YÓn V©n chÕ t¹o. Uy lùc v« song, ai ngê……")
            TopMessage("ThËt tiÕc, ch­a thÓ hoµn thµnh nhiÖm vô")
            Msg2Player("ThËt tiÕc nhiÖm vô ®· thÊt b¹i.")
            local item = taskItem[1].Item
            ClearItem(item[1], item[2], item[3], item[4])
            for i = 1, 3 do
                DelEventItem(questyKey[i].key)
            end
            RemoveIBBuff(buffID)
            SetTaskByte(Task_Process, 1, 0)
            SetTaskByte(Task_Process, 3, 0)
            SetTaskByte(Task_Process, 4, 0)
            SetTaskByte(Task_Type, 1, 0)                    --ÈÎÎñÀàĞÍÇåÁã
            SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
            SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
            SetTask(Task_MonsterID, 0)
            SetTaskByte(Task_Type, 3, 2)
            Msg2Player("§· tõ bá nhiÖm vô")
            TaskNote(1078, -1)
            --Add by luoyixuan 2009/12/30 begin
            refreshNpcTaskState()
            --Add by luoyixuan 2009/12/30 end
            return
        end
    end
end

function Drug_yesStart()
    CloseDialog()
    local temp = GetTaskByte(Task_Process, 2)
    local nTimes, addtimes = todayfreetimes(temp)
    if (nTimes == 0) then
        if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
            Talk(1, "no", "Theo ph­¬ng thuèc cßn cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>.")
            return
        end
        local amberItem = taskItem[2].Item
        if (HaveNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4]) < 3) then
            Talk(1, "no", "Theo ph­¬ng thuèc cßn cÇn <c=g>3<c> <c=yel>Hæ Ph¸ch Chi T©m<c>.")
            return
        end
        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "kh«ng gian trong hµnh trang kh«ng ®ñ, chuÈn bŞ s½n sµng råi h·y quay l¹i.")
            return
        end

        if (GetCash() < 1000000) then
            Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn.")
            return
        end

        for i = 1, 10, 1 do
            --É¾µôÂüÍÓÂŞ»ªºÍÂüÍÓÉ³»ª
            DelNormalItem(3, 311, 0, 0)
            DelNormalItem(3, 312, 0, 0)
        end

        for i = 1, 3, 1 do
            --É¾µôçúçêÖ®ĞÄ
            DelNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4])
        end
        Pay(1000000)

        SetTaskByte(Task_Process, 1, 1)            --ÈÎÎñµÚÒ»²½
        SetTaskByte(Task_Process, 2, 1)            --ÈÎÎñ´ÎÊı
        SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
        SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0


        SetTaskByte(Task_Process, 1, 2)
        SetTaskByte(Task_Type, 1, 1)
        SetTaskByte(Task_Type, 2, 1)   -- ±ê¼ÇÒÑ¾­½ÓµÚÒ»¸öÈÎÎñ
        SetTask(Task_Coordinate, 0)                                --ËøÑıÕòµÄ×ø±ê
        SetTask(Task_Accept_Day, floor(LocalSystemTime() / 86400))        --ÉèÖÃ½ÓÈÎÎñµÄÈÕÆÚ
        SetTask(Task_MonsterID, 0)
        TaskNote(1077, 0)  --ÌáÊ¾°Ñ»Ø»êÌÀ¸øÙÈ²®Òæ
        SyncBibleState(1077, 1, 1)
        offlineTotimes()

        local nNum = GetTask(Task_Total_Times)
        nNum = nNum + 1
        SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1

        SetTaskByte(Task_Type, 1, 2)            --½ÓÊÜÁ¶ÖÆµ¤Ò©µÄÈÎÎñ
        SetTask(Task_MonsterID, 0)                --¹ÖÎïID
        SetTask(Task_Coordinate, 0)
        AddEventItem(questyKey[1].key)
        Talk(1, "no", "§©y lµ do ta ®Æc chÕ <c=yel>" .. questyKey[1].name .. "<c>, nhÊt ®Şnh ph¶i tËn tay mang ®Õn cho téc tr­ëng <c=g>YÓn B¸ İch<c> t¹i trung khu th«n trÊn trªn Ngôc Ph¸p S¬n.")
        Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. nTimes .. "NhËn nhiÖm vô, nhËn ®­îc 1" .. questyKey[1].name)
        TopMessage("NhËn ®­îc <c=yel>" .. questyKey[1].name)
        TaskNote(1078, 0)
        SyncBibleState(1077, 2, 1)
        SyncBibleState(1078, 2, 1)
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end

    end
end

function Drug_oddTask()
    CloseDialog()
    local step = GetTaskByte(Task_Process, 1)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local item = taskItem[4].Item

    if (step == 0) then

        if (HaveNormalItem(item[1], item[2], item[3], item[4]) == 0) and (GetCoin() < Cv) then
            Talk(1, "no", "Mçi ngµy ta chØ cã thÓ phèi chÕ 1 lÇn <c=yel>Hoµn Hån Than<c>, nÕu nh­ phèi chÕ nhiÒu lÇn th× cÇn ®Õn <c=g>1<c> ®ãa <c=yel>" .. taskItem[4].name .. " HoÆc" .. Cfs .. "TiÒn ®ång <c>")    --ĞèÒª½«¶ÔÓ¦µÄÍ­Ç®ÊıÁ¿Ò²ÏÔÊ¾
            return
        end

        if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
            Talk(1, "no", "Theo ph­¬ng thuèc cßn cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>.")
            return
        end

        local amberItem = taskItem[2].Item
        if (HaveNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4]) < 3) then
            Talk(1, "no", "Theo ph­¬ng thuèc cßn cÇn <c=g>3<c> <c=yel>Hæ Ph¸ch Chi T©m<c>.")
            return
        end

        if (GetCash() < 1000000) then
            Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn.")
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Talk(1, "no", "kh«ng gian trong hµnh trang kh«ng ®ñ, chuÈn bŞ s½n sµng råi h·y quay l¹i.")
            return
        end

        Accept_Drug_oddTask()
    end
end

function Accept_Drug_oddTask()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local temp = GetTaskByte(Task_Process, 2) + 1
    local nTimes, addtimes = todayfreetimes(temp)
    local item = taskItem[4].Item
    local itemID = FindAValidIBItem(item[1], item[2], item[3], item[4])

    if (itemID > 0) then
        CostIBItem(itemID)
    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(115)
    else
        return
    end

    for i = 1, 10, 1 do
        --É¾³ıÂüÍÓÂŞ»ªºÍÂüÖéÉ³»ª
        DelNormalItem(3, 311, 0, 0)
        DelNormalItem(3, 312, 0, 0)
    end

    local amberItem = taskItem[2].Item
    for i = 1, 3 do
        --É¾³ıçúçêÖ®ĞÄ
        DelNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4])
    end

    Pay(1000000)

    SetTaskByte(Task_Process, 1, 1)            --ÈÎÎñµÚÒ»²½
    SetTaskByte(Task_Process, 2, temp)    --ÈÎÎñ´ÎÊı
    SetTaskByte(Task_Process, 3, 1)            --±íÊ¾µ¥±¶ÈÎÎñ
    SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0

    local nNum = GetTask(Task_Total_Times)
    nNum = nNum + 1
    SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1

    SetTaskByte(Task_Type, 1, 2)            --½ÓÊÜÁ¶ÖÆµ¤Ò©µÄÈÎÎñ
    SetTask(Task_MonsterID, 0)
    SetTask(Task_Coordinate, 0)
    AddEventItem(questyKey[1].key)
    Talk(1, "no", "§©y lµ do ta ®Æc chÕ <c=yel>" .. questyKey[1].name .. "<c>, nhÊt ®Şnh ph¶i tËn tay mang ®Õn cho téc tr­ëng <c=g>YÓn B¸ İch<c> t¹i trung khu th«n trÊn trªn Ngôc Ph¸p S¬n.")
    Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. nTimes .. "NhËn nhiÖm vô, nhËn ®­îc 1" .. questyKey[1].name)
    TopMessage("NhËn ®­îc <c=yel>" .. questyKey[1].name)
    TaskNote(1078, 0)
    if (nTimes == 5) then
        SyncBibleState(1077, 3, 1)
        SyncBibleState(1078, 3, 1)
    end
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
end

function Drug_doubleTask()
    CloseDialog()
    local step = GetTaskByte(Task_Process, 1)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local item = taskItem[4].Item

    if (step == 0) then
        if (HaveNormalItem(item[1], item[2], item[3], item[4]) >= 2) or (GetCoin() >= 2 * Cv) or (HaveNormalItem(item[1], item[2], item[3], item[4]) >= 1 and GetCoin() >= Cv) then
            Accept_Drug_doubleTask()
        else
            Talk(1, "no", "Mçi ngµy ta chØ cã thÓ phèi chÕ 1 lÇn <c=yel>Hoµn Hån Than<c>, nÕu nh­ phèi chÕ nhiÒu lÇn th× cÇn ®Õn <c=g>2<c> ®ãa <c=yel>" .. taskItem[4].name .. " HoÆc" .. 2 * Cfs .. "TiÒn ®ång <c>")    --ĞèÒª½«¶ÔÓ¦µÄÍ­Ç®ÊıÁ¿Ò²ÏÔÊ¾
        end
    end
end

function Accept_Drug_doubleTask()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(115)
    local temp = GetTaskByte(Task_Process, 2) + 1
    local nTimes, addtimes = todayfreetimes(temp)
    local item = taskItem[4].Item

    if (HaveNormalItem(3, 311, 0, 0) < 10 or HaveNormalItem(3, 312, 0, 0) < 10) then
        Talk(1, "no", "Theo ph­¬ng thuèc cßn cÇn <c=yel>Man §µ La Hoa<c> vµ <c=yel>Man Ch©u Sa Hoa<c> mçi lo¹i <c=g>10<c>.")
        return
    end

    local amberItem = taskItem[2].Item
    if (HaveNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4]) < 3) then
        Talk(1, "no", "Theo ph­¬ng thuèc cßn cÇn <c=g>3<c> <c=yel>Hæ Ph¸ch Chi T©m<c>.")
        return
    end

    if (IsHaveSpaceForTreasure(1) ~= 1) then
        Talk(1, "no", "kh«ng gian trong hµnh trang kh«ng ®ñ, chuÈn bŞ s½n sµng råi h·y quay l¹i.")
        return
    end

    if (GetCash() < 1000000) then
        Talk(1, "no", "Ng­¬i kh«ng ®ñ tiÒn.")
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
        --ºó¿ÛÍ­Ç®
        CostCoinByIdx(115)
        CostCoinByIdx(115)
    else
        return
    end

    for i = 1, 10, 1 do
        --É¾³ıÂüÍÓÂŞ»ªºÍÂüÍÓÉ³»ª
        DelNormalItem(3, 311, 0, 0)
        DelNormalItem(3, 312, 0, 0)
    end

    local amberItem = taskItem[2].Item
    for i = 1, 3 do
        --É¾³ıçúçêÖ®ĞÄ
        DelNormalItem(amberItem[1], amberItem[2], amberItem[3], amberItem[4])
    end

    Pay(1000000)

    SetTaskByte(Task_Process, 1, 1)            --ÈÎÎñµÚÒ»²½
    SetTaskByte(Task_Process, 2, temp)    --ÈÎÎñ´ÎÊı
    SetTaskByte(Task_Process, 3, 2)            --±íÊ¾µ¥±¶ÈÎÎñ
    SetTaskByte(Task_Process, 4, 0)            --É±ËÀ³Ë»Æ¸öÊıÇå0

    local nNum = GetTask(Task_Total_Times)
    nNum = nNum + 1
    SetTask(Task_Total_Times, nNum)            --×ÜµÄÈÎÎñ´ÎÊı¼Ó1

    SetTaskByte(Task_Type, 1, 2)            --½ÓÊÜÁ¶ÖÆÏÉµ¤µÄÈÎÎñ
    SetTask(Task_MonsterID, 0)
    SetTask(Task_Coordinate, 0)
    AddEventItem(questyKey[1].key)
    Talk(1, "no", "§©y lµ do ta ®Æc chÕ <c=yel>" .. questyKey[1].name .. "<c>, nhÊt ®Şnh ph¶i tËn tay mang ®Õn cho téc tr­ëng <c=g>YÓn B¸ İch<c> t¹i trung khu th«n trÊn trªn Ngôc Ph¸p S¬n.")
    Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. nTimes .. "NhËn nhiÖm vô, nhËn ®­îc 1" .. questyKey[1].name)
    TopMessage("NhËn ®­îc <c=yel>" .. questyKey[1].name)
    TaskNote(1078, 0)
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
    if (nTimes == 5) then
        SyncBibleState(1077, 3, 1)
        SyncBibleState(1078, 3, 1)
    end
end

function Drug_yesKill()
    CloseDialog()
    local item = taskItem[1].Item
    if (GetTaskByte(Task_Process, 1) == 2 and ((HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) or (HaveNormalItemInQuick(item[1], item[2], item[3], item[4]) > 0))) then
        SetTaskByte(Task_Process, 1, 3)
        SetTask(Task_MonsterID, 0)
        SetTask(Task_Free_Time, 0)
        Talk(1, "no", "<c=r>Lª Linh Thi Phï Chó<c> chİnh lµ thñ lÜnh Lª Linh Thi trªn vïng nói nµy, th­êng ngµy sÏ kh«ng hiÖn th©n, h«m nay bŞ mïi h­¬ng cña linh th¶o hÊp dÉn ®Õn. NÕu nh­ c¸c h¹ tiªu diÖt Lª Linh Thi nhiÒu lÇn th× h¾n nhÊt ®Şnh sÏ xuÊt hiÖn!")
        Msg2Player("Tiªu diÖt Lª Linh Thi, dÉn dô Lª Linh Thi Phï Chó xuÊt hiÖn")
        TaskNote(1078, 2)
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end
    end
end

function cancelTask()
    CloseDialog()
    MsgBox("Téc ng­¬i ta quyÕt kh«ng miÔn c­ìng ng­êi kh¸c b«n ba cùc nhäc, tuy h«m nay téc ta gÆp n¹n diÖt vong, nh­ng vÉn kh«ng muèn cÇu trî ng­êi kh¸c. NÕu nh­ c¸c h¹ cã ı gióp ®ì, ®µnh thuËn theo ı trêi …", "yesCancel", "no")
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
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
end

function flower()
    --¸¯¶¾Ö®»¨ edit by JRT
    CloseDialog()
    local flower50 = GetTaskByte(Task_flower, 1)
    if (flower50 == 0) then
        Talk(3, "flower_help", GetName() .. "Lµm phiÒn tiªn sinh, xin hái tiªn sinh ®©y lµ n¬i nµo?", "N¬i ®©y ®­îc gäi lµ Ngôc Ph¸p S¬n, thiªn ®×nh gi¸n ¸p nh÷ng ng­êi ph¶n gi¸o t¹i n¬i nµy, khôc khôc…, trong ®ã cã nhiÒu tªn hung ¸c cùc ®Ønh, khôc khôc khôc …, ta khuyªn c¸c h¹ còng nªn dõng b­íc t¹i ®©y th«i.", GetName() .. " khİ s¾c tiªn sinh xem ra kh«ng ®­îc tèt l¾m, nh­ lµ bŞ ®éc khİ x©m nhËp, kh«ng biÕt t¹i h¹ cã thÓ gióp ®­îc g× kh«ng?")
    elseif (flower50 >= 1) and (flower50 < 6) then
        if (flower50 == 5) and (HaveEventItem(255) >= 1) then
            if (HaveIBBuff(690) == 1) then
                DelEventItem(255)
                ClearItem(6, 1, 522, 1)
                RemoveIBBuff(690)
                SetTaskByte(Task_flower, 1, 6)
                --Add by luoyixuan 2009/12/30 begin
                refreshNpcTaskState()
                --Add by luoyixuan 2009/12/30 end
                AddOwnExtendExp(2000000)
                for i = 0, 4 do
                    AddNormalItemPile(1, 20, 1, 1, 0, 0)
                    AddNormalItemPile(1, 23, 1, 1, 0, 0)
                end
                Talk(3, "flower_help1", GetName() .. " YÓn Phong tiªn sinh, ta mang thuèc gi¶i ®Õn nµy!", "ah, ®a t¹! ¢n ®øc cña anh hïng, t¹i h¹ nhí m·i kh«ng quªn.", GetName() .. "Tiªn sinh qu¸ lêi.")
            else
                Talk(1, "no", "¸i dµ, ®¸ng tiÕc, hiÖu lùc cña thuèc gi¶i ®· hÕt, anh hïng h·y ®Õn suèi nguån ®iÒu chÕ l¹i, kh«i lùc hiÖu lùc cña thuèc gi¶i. Ta trao c¸c h¹ 1 <c=g>Träc LiÔu<c>, khôc khôc …., nÕu nh­ sö dông hÕt cã thÓ vÒ t×m ta nhËn l¹i.")
                AddNormalItem(6, 1, 522, 1, 0, 0)
                SetTaskByte(Task_flower, 4, 3)
                Msg2Player("NhËn ®­îc 1 Träc LiÔu.")
                Msg2Player("§Õn suèi ngån kh«i phôc hiÖu lùc thuèc gi¶i.")
                TaskNote(104, 3)
                SetTaskByte(Task_flower, 1, 4)
                --Add by luoyixuan 2009/12/30 begin
                refreshNpcTaskState()
                --Add by luoyixuan 2009/12/30 end
            end
        else
            if (HaveNormalItem(6, 1, 522, 1) < 1) then
                ClearItem(6, 1, 522, 1)
                if (IsHaveSpaceForTreasure(1) == 0) then
                    Talk(1, "no", "kh«ng gian hµnh trang c¸c h¹ kh«ng ®ñ.")
                    Msg2Player("Kh«ng gian hµnh trang kh«ng ®ñ, kh«ng thÓ nhËn Träc LiÔu!")
                else
                    Talk(1, "no", "§©y lµ <c=g>Träc LiÔu<c>, khôc khôc …., nÕu nh­ sö dông hÕt cã thÓ vÒ t×m ta nhËn l¹i.")
                    AddNormalItem(6, 1, 522, 1, 0, 0)
                    SetTaskByte(Task_flower, 4, 3)
                    Msg2Player("NhËn ®­îc 1 Träc LiÔu.")
                    --Add by luoyixuan 2009/12/30 begin
                    refreshNpcTaskState()
                    --Add by luoyixuan 2009/12/30 end
                end
            else
                Talk(1, "no", "TÊt c¶ nhê cËy vµo c¸c h¹, lu«n nhí r»ng hiÖu lùc cña thuèc gi¶i duy tr× trong thêi gian rÊt ng¾n, cÇn ph¶i sö dông <c=g>Träc LiÔu<c> míi cã thÓ mang thuèc gi¶i trë vÒ thuËn lîi.")

            end
        end
    end
end

function flower_help()
    CloseDialog()
    MsgBox("¸i dµ, kh«ng giÊu g× ng­¬i, ta chİnh lµ ®¹i phu cña vïng nói nµy, ta v× ra ngoµi t×m d­îc th¶o ®iÒu trŞ bÖnh dŞch trong téc, kh«ng ngê c¸c th¶o d­îc ®ã ®· phï hãa, ta kh«ng cÈn thËn nªn ®· tróng ®éc hoa, tuy kh«ng mÊt m¹ng, nh­ng khã hoµn thµnh nhiÖm vô mµ téc tr­ëng ®· giao. nÕu nh­ c¸c h¹ cã thÓ gióp ta t×m thuèc gi¶i, t¹i h¹ v« cïng c¶m kİch!", "yes_flower", "no")
end

function flower_help1()
    CloseDialog()
    Talk(2, "no", "Thùc ra t¹i h¹ cßn 1 viÖc muèn nhê, gÇn ®©y ta lu«n b¾t gÆp 1 ng­êi bİ Èn xuÊt hiÖn trong th«n, c¸c h¹ cã thÓ gióp ta ®iÒu tra lai lŞch vÒ h¾n kh«ng?", GetName() .. "Tiªn sinh yªn tam, t¹i h¹ nhÊt ®Şnh ®iÒu tra cÈn thËn.")
    Msg2Player("§Õn l©n cËn bé l¹c Di Ph­¬ng ®iÒu tra th©n phËn ng­êi bİ Èn.")
    if (GetJusticEvilCredit() < 0) then
        TaskNote(104, 4)
    else
        TaskNote(104, 5)
    end
end

function yes_flower()
    CloseDialog()
    SetTaskByte(Task_flower, 1, 1)
    SetSubTask(104, 1, 1)
    TaskNote(104, 0)
    --Add by luoyixuan 2009/12/30 begin
    refreshNpcTaskState()
    --Add by luoyixuan 2009/12/30 end
    Talk(3, "yes_flower1", GetName() .. "T¹i h¹ nhÊt ®Şnh gióp tiªn sinh, nh­ng lµm thÕ nµo ®Ó cã ®­îc thuèc gi¶i, xin tiªn sinh chØ dÉn.", "NÕu muèn gi¶i ®éc nµy, cÇn ph¶i thu thËp <c=g>§éc Lan Th¶o<c> t¹i vïng phİa B¾c vµ <c=g>Long ThiÖp Lan<c> t¹i vïng phİa Nam cïng víi ngån n­íc suèi cña bé l¹c ®Òu ph«i chÕ thµnh thuèc gi¶i.", "ThÕ nh­ng, thuèc gi¶i nµy cã hiÖu lùc trong thêi gian rÊt ng¾n, ®©y lµ <c=g>Träc LiÔu<c>, vËt nµy cã thÓ hót khái ®éc khİ cña Ngôc Ph¸p S¬n, duy tr× thêi gian hiÖu lùc cña thuèc gi¶i. Khôc … khôc…….")
end

function yes_flower1()
    CloseDialog()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Nh­ng hµnh trang cña c¸c h¹ kh«ng ®ñ, ta kh«ng thÓ trao  c¸c h¹ <c=g>Träc LiÔu<c>.")
    else
        Talk(1, "no", "§©y lµ <c=g>Träc LiÔu<c>, khôc khôc …., nÕu nh­ sö dông hÕt cã thÓ vÒ t×m ta nhËn l¹i.")
        AddNormalItem(6, 1, 522, 1, 0, 0)
        SetTaskByte(Task_flower, 4, 3)
        Msg2Player("NhËn ®­îc 1 Träc LiÔu.")
        Msg2Player("Thu thËp 2 lo¹i ®éc th¶o, ®iÒu chÕ thµnh thèc gi¶i, gi¶i ®éc gióp YÕn Phong.")
        --Add by luoyixuan 2009/12/30 begin
        refreshNpcTaskState()
        --Add by luoyixuan 2009/12/30 end
    end
end

function no()
    CloseDialog()
end
