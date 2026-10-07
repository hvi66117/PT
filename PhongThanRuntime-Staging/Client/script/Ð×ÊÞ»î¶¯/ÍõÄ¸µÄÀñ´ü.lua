require("common_beast.luax")

award1 = CommonBeast.TaskAward1
award2 = CommonBeast.TaskAward2
award3 = CommonBeast.TaskAward3
award4 = CommonBeast.TaskAward4
packet_list = CommonBeast.packet_list
task_info = CommonBeast.task_info
illegal_time = CommonBeast.illegal_time

function main(level, time, npcIndex, itemId)


    local nParticular = GetItemPartByID(itemId)
    if (nParticular < 1703 or nParticular > 1706) then
        WriteLog("[Ho¹t ®éng Hung Thó]itemIdÒì³£" .. itemId .. "/nParticular:" .. nParticular)
        return
    end
    SetTask(140, itemId)

    local tasks = {
        [1] = { "¸¶·Ñ¿ªÆô", "CostOpen"; show = 1 },
        [2] = { "ÆÕÍ¨¿ªÆô", "NormalOpen"; show = 1 }
    }

    SayTask("Äú½«´ò¿ªÍõÄ¸µÄÀñ´ü, ÔÚ·âÓ¡¿¨, Kinh NghiÖm §¬nµÈ½±ÀøÖĞËæ»ú»ñµÃÒ»Ñù, Äú¿ÉÒÔÑ¡Ôñ¸¶·Ñ0.88 Th«ng B¶o½«ÎªÄúÌŞ³ı·âÓ¡¿¨ÒÔÍâ½±Àø, Äú½«°Ù·Ö°Ù»ñµÃÒ»ÕÅ·âÓ¡¿¨.", tasks)
end

function CostOpen()

    no()
    local log = ""
    local select_index = packet_list[GetItemPartByID(GetTask(140))]
    if (select_index < 1) then
        return
    end

    local _, cv, _ = GetCostCoinInfoByIdx(298)
    if (GetCoin() < cv) then
        Talk(1, "no", "Th«ng b¶o kh«ng ®ñ!")
        return
    end

    MsgBox("¿ªÆôÍõÄ¸Àñ´üĞèÒª»¨·Ñ<c=g>0.88<c> Th«ng B¶o. ÄãÏÖÔÚÒª¶Ò»» sao?", "Yes", "main")
end

function Yes()

    no()
    local itemId = GetTask(140)
    local select_index = packet_list[GetItemPartByID(itemId)]

    local item_name = GetItemName(itemId)

    if (CostCoinByIdx(298) <= 0) then
        Talk(1, "Th«ng b¶o kh«ng ®ñ!")
        return
    end

    if (DelItemByID(itemId) < 0) then
        return
    end

    local time_illegal = GetTask(illegal_time)
    local illegal_flag, times_ = CommonBeast.GetIllagelInfo(GetGameServerName(), GetName())
    if (time_illegal < times_) then
        SetTask(illegal_time, time_illegal + 1)
    end

    local award_info = {}
    if (select_index == 1) then
        award_info = award1
    elseif (select_index == 2) then
        award_info = award2
    elseif (select_index == 3) then
        award_info = award3
    elseif (select_index == 4) then
        award_info = award4
    end

    local new_award = {}
    for i = 1, getn(award_info) do
        if (award_info[i].iscost == 1) then
            table.insert(new_award, award_info[i])
        end
    end

    local index = math.random(1, getn(new_award))

    local num = new_award[index].num
    for i = 1, num do
        AddNormalItemBind(new_award[index].id[1], new_award[index].id[2], new_award[index].id[3], new_award[index].id[4], 0, 0, 1)
    end

    local award_name = GetNormalItemName(new_award[index].id[1], new_award[index].id[2], new_award[index].id[3], new_award[index].id[4])
    Msg2Player("Chóc mõng ngµi më " .. item_name .. ", nhËn ®­îc " .. award_name)
    WriteLog("[Ho¹t ®éng Hung Thó][¿ªÆôÀñ´ü][¸¶·Ñ¿ªÆô]" .. item_name .. ",»ñµÃ½±Àø" .. award_name)
end

function NormalOpen()

    no()
    local itemId = GetTask(140)

    local select_index = packet_list[GetItemPartByID(itemId)]
    if (select_index < 1) then
        return
    end

    local item_name = GetItemName(itemId)

    local award_info = {}
    if (select_index == 1) then
        award_info = award1
    elseif (select_index == 2) then
        award_info = award2
    elseif (select_index == 3) then
        award_info = award3
    elseif (select_index == 4) then
        award_info = award4
    end

    local award_name = ""
    local random_index = CommonBeast.GetRandIndex(award_info)

    local time_illegal = GetTask(illegal_time)
    local illegal_flag, times_ = CommonBeast.GetIllagelInfo(GetGameServerName(), GetName())
    if (time_illegal < times_) then
        SetTask(illegal_time, time_illegal + 1)
    end

    if (random_index == getn(award_info)) then
        if (DelItemByID(itemId) < 0) then
            return
        end

        EarnBind(award_info[random_index].num)

        award_name = award_name .. award_info[random_index].num .. "B¹c khãa"
    else
        local num = award_info[random_index].num
        if (IsHaveSpaceForTreasure(num + 1) <= 0) then
            InfoBox("Tói kh«ng ®ñ « trèng" .. num .. "¸ñ, ÇëÕûÀíºóÔÙ¿ªÆôÍõÄ¸µÄÀñ´ü.")
            return
        end

        if (DelItemByID(itemId) < 0) then
            return
        end

        local illegal_flag, times_ = CommonBeast.GetIllagelInfo(GetGameServerName(), GetName())
        if (illegal_flag == 1 and illegal_flag ~= 0) then
            if (time_illegal < times_) then
                local sec_rand = math.random(1, 100)
                if (sec_rand > 17) then

                    local len = getn(award_info)
                    EarnBind(award_info[len].num)

                    award_name = award_name .. award_info[len].num .. "B¹c khãa"

                    Msg2Player("Chóc mõng ngµi më " .. item_name .. ", nhËn ®­îc " .. award_name)
                    WriteLog("[Ho¹t ®éng Hung Thó][¿ªÆôÀñ´ü][ÆÕÍ¨¿ªÆô]" .. item_name .. ",»ñµÃ½±Àø" .. award_name)
                    return
                end
            end
        end

        for i = 1, num do
            AddNormalItemBind(award_info[random_index].id[1], award_info[random_index].id[2], award_info[random_index].id[3], award_info[random_index].id[4], 0, 0, 1)
        end

        award_name = GetNormalItemName(award_info[random_index].id[1], award_info[random_index].id[2], award_info[random_index].id[3], award_info[random_index].id[4])
    end

    Msg2Player("Chóc mõng ngµi më " .. item_name .. ", nhËn ®­îc " .. award_name)
    WriteLog("[Ho¹t ®éng Hung Thó][¿ªÆôÀñ´ü][ÆÕÍ¨¿ªÆô]" .. item_name .. ",»ñµÃ½±Àø" .. award_name)
end

function no()

    CloseDialog()
end
