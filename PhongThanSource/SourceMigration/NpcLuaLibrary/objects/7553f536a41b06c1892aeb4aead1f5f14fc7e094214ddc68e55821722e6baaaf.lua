Task_id = 1358;

Time_id = 1359;
Buff_danfang = 626;
Idx_danfang = 1360;
ID_danfang = 1361;

function GetPlayerTaskState()
    return 0, 0
end

function main()
    local tasks = {
        { "Thiªn Hµnh ThuËn NghŞch", "tianxing"; show = 0 },
    }
    local status = GetTaskByte(Task_id, 1)

    if (status < 12) then
        tasks[1].show = 1
    end

    SayTask("(trong lß hõng hùc löa)", tasks)

    SetTask(140, DialogNpcIdx)

end

function tianxing()
    CloseDialog()

    DialogNpcIdx = GetTask(140)
    local playerID = GetNpcTask(DialogNpcIdx, 0)

    if (playerID ~= GetPlayerID()) then
        Talk(1, "no", "Ng­¬i kh«ng ph¶i lµ ng­êi ®· triÖu gäi ta.")
        return
    end

    local status = GetTaskByte(Task_id, 1)

    if ((status >= 1) and (status <= 3)) then

        local thistime = GetTask(Time_id)
        local thisday = math.floor(LocalSystemTime() / 86400)
        if (thisday <= thistime) then
            Talk(1, "no", "Háa HÇu h«m nay ®· ®ñ, sau khi qua <c=g>Giê Tı<c> ®ªm nay h·y ®Õn.")
            TaskNote(1036, 3)
            return
        end

        if (GetTaskByte(Task_id, 2) < 40) then
            Talk(1, "no", "Muèn luyÖn thÇn ®¬n, cÇn cã ®ñ vËt liÖu, linh khİ <c=g>Phong thó s¬n hån<c> trªn BÊt Chu S¬n lµ vËt liÖu tèt nhÊt, nÕu trong <c=g>30 phót<c> tiªu diÖt <c=g>40<c> Phong thó s¬n hån bªn ®èi ®Şch, linh khİ S¬n hån sÏ hÊp thô vµo ng­¬i, th× sÏ ®ñ vËt liÖu cho ngµy h«m nay!")
            TaskNote(1036, 1, GetTaskByte(Task_id, 2))
        else
            renwu1()
        end

    elseif ((status >= 6) and (status <= 10)) then
        Talk(1, "no", "Ph­¬ng ph¸p luyÖn <c=g>Hoµng Lé ®¬n<c> rÊt ®¬n gi¶n, trong tr¹ng th¸i <c=g>täa thiÒn<c> (Ên\"v\"Phİm) sö dông Hoµng Lé ®¬n lµ ®­îc, luyÖn ®¬n gåm 5 l­ît, mçi l­ît còng sÏ cã <c=g>Sİ Nha<c> ®Õn tËp kİch, tiªu diÖt chóng cã thÓ tiÕp tôc luyÖn ®¬n.")
        TaskNote(1036, 7, status - 6)
        if (status == 10) then
            TaskNote(1036, 10)
        end

    elseif (status == 11) then

        local idx2 = GetTask(Idx_danfang)

        if ((idx2 ~= 0) and (GetTask(ID_danfang) == GetNpcID(idx2))) then
            SetTaskByte(Task_id, 1, 12)
            SetTask(Idx_danfang, 0)
            SetTask(ID_danfang, 0)

            local addexp = AddOwnExtendExp(3500000)
            TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
            Msg2Player("Hoµn thµnh nhiÖm vô Thiªn Hµnh ThuËn NghŞch h«m nay, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")
            ClearItem(6, 1, 471, 1)
            ClearItem(6, 1, 472, 1)
            Talk(1, "no", "Sİ Nha ®· bŞ tiªu diÖt, luyÖn ®¬n còng ®· hoµn tÊt, viªn ®¬n d­îc nµy cã thÓ t¨ng cao tu hµnh cña ng­¬i.")
            SetSubTask(1036, -1, 1)
            TaskNote(1036, -1)
        end

    elseif (status == 12) then
        return
    else

        Talk(1, "no", "T«i lµ ®¬n phßng")

    end

end

function renwu1()
    CloseDialog()

    local playerID = GetNpcTask(GetTask(140), 0)

    if (playerID ~= GetPlayerID()) then
        Talk(1, "no", "Ng­¬i kh«ng ph¶i lµ ng­êi ®· triÖu gäi ta.")
        return
    end

    if (GetTaskByte(Task_id, 2) > 40) then
        TaskNote(1036, 1, 40)
    else
        TaskNote(1036, 1, GetTaskByte(Task_id, 2))
    end

    local thisday = math.floor(LocalSystemTime() / 86400)

    local status = GetTaskByte(Task_id, 1)
    if (GetTaskByte(Task_id, 2) >= 40) then
        SetTaskByte(Task_id, 2, 0)
        local addexp = 0
        if ((status == 1) or (status == 2)) then
            local addexp = AddOwnExtendExp(1500000)
            TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
            Msg2Player("Hoµn thµnh nhiÖm vô Thiªn Hµnh ThuËn NghŞch h«m nay, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")
            Talk(1, "no", "Linh khİ trªn ng­êi ng­¬i qu¶ nhiªn lµ d­îc liÖu tèt, háa hÇu h«m nay ®· chuÈn bŞ ®ñ, qua giê <c=g>Tİ<c> tèi nay, míi cã thÓ luyÖn 1 lß ®¬n, h«m kh¸c ng­¬i h·y ®Õn.")
            TaskNote(1036, 3)
            SetTaskByte(Task_id, 3, 0)
            RemoveIBBuff(Buff_danfang)
            DelNpc(DialogNpcIdx)
            SetTask(Idx_danfang, 0)
            SetTask(ID_danfang, 0)
        elseif (status == 3) then
            local addexp = AddOwnExtendExp(2500000)
            TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
            Msg2Player("Hoµn thµnh nhiÖm vô Thiªn Hµnh ThuËn NghŞch h«m nay, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")
            Talk(1, "no", "§¬n ®· luyÖn thµnh, tu hµnh t¨ng cao, mang <c=g>VŞ TÕ L­<c> quay vÒ hái <c=g>S¬n ThÇn Hång B¸c<c> b­íc tiÕp theo sÏ lµm nh­ thÕ nµo.")
            TaskNote(1036, 4)
            SetTaskByte(Task_id, 3, 0)
            RemoveIBBuff(Buff_danfang)
            DelNpc(DialogNpcIdx)
            SetTask(Idx_danfang, 0)
            SetTask(ID_danfang, 0)
        end

        SetTask(Time_id, thisday)
        SetTaskByte(Task_id, 1, status + 1)
    end
end

function no()
    CloseDialog()
end
