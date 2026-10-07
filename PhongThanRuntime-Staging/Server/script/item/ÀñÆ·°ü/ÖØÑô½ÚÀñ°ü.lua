Task_cy_jiangli = 1582

function main()

    DelNormalItem(6, 1, 860, 1)

    local cy_libao = 0
    local randindex = math.random(1, 1000)
    if (randindex <= 100) then
        if (GetTaskByte(Task_cy_jiangli, 4) == 0) then
            AddNormalItem(6, 1, 738, 1, 0, 0, 0)
            cy_libao = 1
            SetTaskByte(Task_cy_jiangli, 4, 1)
        else
            AddNormalItem(6, 1, 728, 1, 0, 0, 0)
        end
    elseif (randindex <= 235) then
        AddNormalItem(6, 1, 728, 1, 0, 0, 0)
    elseif (randindex <= 370) then
        AddNormalItem(6, 1, 727, 1, 0, 0, 0)
    elseif (randindex <= 460) then
        AddNormalItem(6, 1, 734, 1, 0, 0, 0)
    elseif (randindex <= 595) then
        AddNormalItem(6, 1, 733, 1, 0, 0, 0)
    elseif (randindex <= 685) then
        AddNormalItem(6, 1, 725, 1, 0, 0, 0)
    elseif (randindex <= 775) then
        AddNormalItem(6, 1, 731, 1, 0, 0, 0)
    elseif (randindex <= 865) then
        AddNormalItem(6, 1, 730, 1, 0, 0, 0)
    elseif (randindex <= 910) then
        AddNormalItem(8, 1054, 3, 1, 0, 0)
    else
        AddNormalItem(8, 1055, 4, 1, 0, 0)
    end

    if (cy_libao == 0) then
        TopMessage("B¹n nhËn ®­îc 1 B¸nh Trïng D­¬ng")
    else
        TopMessage("B¹n nhËn ®­îc 1 Thï Du H­¬ng Nang")
        AddGlobalNews("<color=green>" .. GetName() .. "<color> më Tói Quµ Trïng D­¬ng nhËn ®­îc <color=green>Thï Du H­¬ng Nang<color>.")
        WriteLog(GetName() .. " nhËn ®­îc 1 Thï Du H­¬ng Nang")
    end
end
