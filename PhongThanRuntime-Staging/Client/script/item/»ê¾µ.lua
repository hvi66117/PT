back_cele = 1379

back_numbers = 1381

function main()
    local name = { "Sãi", "Ma Phong thó s¬n hån", "Tiªn Phong thó s¬n hån" }
    local status = GetTaskByte(back_cele, 1)
    local obj = GetTaskByte(back_numbers, 3)
    local str
    if (obj == 0) or (obj > 3) then
        local i = math.random(5)
        if (i == 4) or (i == 5) then
            i = 3
        end
        SetTaskByte(back_numbers, 3, i)
        str = name[i]
    else
        str = name[obj]
    end
    if (status == 2) then
        AddIBBuff(641)
        TopMessage("§· vµo ¶o ¶nh C¶nh, h·y mau ®i thu phôc <c=r>" .. str)
        Msg2Player("¶o ¶nh C¶nh ®· më, c¸c hån ph¸ch cã thÓ ®ang ë trªn ng­êi " .. str .. "!")
        ClearItem(6, 1, 481, 0)
        ClearItem(6, 1, 482, 0)

        local zhenying = GetJusticEvilCredit()
        if (zhenying > 0) then
            TaskNote(1040, 3, str)
        elseif (zhenying < 0) then
            TaskNote(1041, 3, str)
        end
    end
end
