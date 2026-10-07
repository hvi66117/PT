Task_GetBaojian = 1646
SiliBaojian = { name = "T­ LÔ B¶o Gi¸m", Item = { 6, 1, 868, 0, 0, 0 } }
Yucilibao = { name = "Tói Vua ban", Item = { 6, 1, 724, 0, 0, 0 } }
TusuJiu = {
    [1] = { name = "§å T« Töu (L©m Tiªn)", Item = { 6, 1, 865, 0, 0, 0 } },
    [2] = { name = "§å T« Töu (Thanh Long)", Item = { 8, 1351, 0, 0, 0, 0 } },
    [3] = { name = "§å T« Töu (B¹ch Hæ)", Item = { 8, 1350, 0, 0, 0, 0 } },
    [4] = { name = "§å T« Töu (HuyÒn Vò)", Item = { 8, 1352, 0, 0, 0, 0 } },
    [5] = { name = "§å T« Töu (Chu T­íc)", Item = { 8, 1349, 0, 0, 0, 0 } },

    [6] = { name = "§å T« Töu (sinh lùc)", Item = { 6, 1, 867, 0, 0, 0 } },
    [7] = { name = "§å T« Töu (NhËt NguyÖt)", Item = { 6, 1, 866, 0, 0, 0 } },
    [8] = { name = "§å T« Töu (Hoµn MÖnh)", Item = { 8, 1353, 3, 0, 0, 0 } },
    [9] = { name = "§å T« Töu (Hoµn ThÇn)", Item = { 8, 1354, 4, 0, 0, 0 } },
    [10] = { name = "Ph¸o hoa", Item = { 6, 1, 785, 0, 0, 0 } },
}

function main()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Msg2Player("Hµnh trang kh«ng ®ñ chç!")
        return
    end
    local item = 0
    local item2 = 0
    item = Yucilibao.Item
    DelNormalItem(item[1], item[2], item[3], item[4])
    local i = math.random(1, 100)
    local nLevel = GetLevel()
    if (nLevel >= 30 and nLevel < 60) then
        if (i <= 40) then
            item = TusuJiu[10]
        elseif (i <= 60) then
            item = TusuJiu[1]
        elseif (i <= 70) then
            item = TusuJiu[2]
        elseif (i <= 80) then
            item = TusuJiu[3]
        elseif (i <= 90) then
            item = TusuJiu[4]
        else
            item = TusuJiu[5]
        end
    elseif (nLevel >= 60) then
        if (i <= 10 and GetTask(Task_GetBaojian) == 0) then
            item = SiliBaojian.Item
            AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], 1)
            SetTask(Task_GetBaojian, 1)
            Msg2Player("Chóc mõng b¹n nhËn ®­îc T­ LÔ B¶o Gi¸m")
            WriteLog(GetName() .. " nhËn ®­îc mét T­ LÔ B¶o Gi¸m (Tói Vua ban)")
            return
        else
            if (i <= 40) then
                item = TusuJiu[1]
                item2 = TusuJiu[10]
            elseif (i <= 55) then
                item = TusuJiu[6]
            elseif (i <= 70) then
                item = TusuJiu[7]
            elseif (i <= 85) then
                item = TusuJiu[8]
            else
                item = TusuJiu[9]
            end
        end
    end
    local idItem = item.Item
    AddNormalItemBind(idItem[1], idItem[2], idItem[3], idItem[4], idItem[5], idItem[6], 1)
    Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. item.name)
    WriteLog(GetName() .. " nhËn ®­îc " .. item.name .. "(Tói Vua ban)")
    if (item2 ~= 0) then
        idItem = item2.Item
        AddNormalItemBind(idItem[1], idItem[2], idItem[3], idItem[4], idItem[5], idItem[6], 1)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. item2.name)
        WriteLog(GetName() .. " nhËn ®­îc " .. item2.name .. "(Tói Vua ban)")
    end
end

function no()
    CloseDialog()
end
