function main()
    if (HaveNormalItem(6, 1, 327, 0) <= 0) then
        return
    end
    local nProb = math.random(1, 1000)
    if (nProb <= 50) then
        AddNormalItem(3, 41, 0, 0, 0, 0)
        AddNormalItem(3, 41, 0, 0, 0, 0)
        TopMessage("Anh hïng nhËn 2 <c=g>Lam B¶o Th¹ch<c>")
        Msg2Player("Anh hïng nhËn 2 Lam B¶o Th¹ch. ")
        WriteLog(GetName() .. "NhËn 2 Lam B¶o Th¹ch. ")
    elseif (nProb <= 80) then
        AddNormalItem(3, 100, 0, 0, 0, 0)
        AddNormalItem(3, 100, 0, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 2 <c=g>T­íng Qu©n LÖnh<c>")
        Msg2Player("B¹n nhËn ®­îc 2 T­íng Qu©n LÖnh.")
        WriteLog(GetName() .. " nhËn ®­îc 2 T­íng Qu©n LÖnh.")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Nhê Kim Lang Phæ, nhËn ®­îc 2 <c=g>T­íng Qu©n LÖnh<c>! T×nh kÕt nghÜa huynh ®Ö sÏ ®­îc Trêi phï hé", 3)
    elseif (nProb <= 100) then
        Earn(5000000)
        TopMessage("Anh hïng nhËn <c=g>500 v¹n <c>")
        Msg2Player("Anh hïng nhËn 500 v¹n. ")
        WriteLog(GetName() .. "NhËn 500 v¹n. ")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Th«ng qua Kim Lan Phæ, nhËn <c=g>500 v¹n<c>! KÕt nghÜa huynh ®Ö ®­îc trêi cao phï hé!", 3)
    elseif (nProb <= 500) then
        AddNormalItem(8, 29, 4, 0, 0, 0)
        TopMessage("Anh hïng nhËn 1 <c=g>Ch©n KhÝ (nhá)<c>")
        Msg2Player("Anh hïng nhËn 1 Ch©n KhÝ (nhá). ")
        WriteLog(GetName() .. "NhËn 1 Ch©n KhÝ (nhá). ")
    elseif (nProb <= 900) then
        AddNormalItem(8, 28, 3, 0, 0, 0)
        TopMessage("Anh hïng nhËn 1 <c=g>Thanh Lé (tiÓu)<c>")
        Msg2Player("Anh hïng nhËn 1 Thanh Lé (tiÓu). ")
        WriteLog(GetName() .. "NhËn 1 Thanh Lé (tiÓu). ")
    elseif (nProb <= 935) then
        AddNormalItem(3, 1150, 0, 0, 0, 0)
        TopMessage("Anh hïng nhËn 1 <c=g>Tö Thuû Tinh<c>")
        Msg2Player("Anh hïng nhËn 1 Tö Thuû Tinh. ")
        WriteLog(GetName() .. "NhËn 1 Tö Thuû Tinh. ")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Th«ng qua Kim Lan Phæ, nhËn 1 <c=g>Tö Thuû Tinh<c>, KÕt nghÜa huynh ®Ö ®­îc trêi cao phï hé!", 3)
    elseif (nProb <= 970) then
        AddNormalItem(3, 89, 0, 0, 0, 0)
        TopMessage("Anh hïng nhËn 1 <c=g>Thñy Tinh Hoµng<c>")
        Msg2Player("Anh hïng nhËn 1 Thñy Tinh Hoµng. ")
        WriteLog(GetName() .. "NhËn 1 Thñy Tinh Hoµng. ")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Th«ng qua Kim Lan Phæ, nhËn <c=g>Thñy Tinh Hoµng<c>, KÕt nghÜa huynh ®Ö ®­îc trêi cao phï hé!", 3)
    elseif (nProb <= 998) then
        local nItemList = {
            { name = "XÝch Viªm L­¬ng Ngäc", id = { 3, 255, 0, 0 }, },
            { name = "Thanh Minh L­¬ng Ngäc", id = { 3, 262, 0, 0 }, },
            { name = "Tö Hµ L­¬ng Ngäc", id = { 3, 269, 0, 0 }, },
        }
        local nRand = math.random(1, 3)
        local nItem = nItemList[nRand].id
        AddNormalItemBind(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0, 1)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. nItemList[nRand].name .. "<c>")
        Msg2Player("B¹n nhËn ®­îc " .. nItemList[nRand].name .. " .")
        WriteLog(GetName() .. " nhËn ®­îc " .. nItemList[nRand].name .. " .")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Th«ng qua Kim Lan Phæ, nhËn 1 <c=g>" .. nItemList[nRand].name .. "<c>, KÕt nghÜa huynh ®Ö ®­îc trêi cao phï hé!", 3)
    else
        local nItemList = {
            { name = "XÝch Viªm Danh Ngäc", id = { 3, 256, 0, 0 }, },
            { name = "Thanh Minh Danh Ngäc", id = { 3, 263, 0, 0 }, },
            { name = "Tö Hµ Danh Ngäc", id = { 3, 270, 0, 0 }, },
        }
        local nRand = math.random(1, 3)
        local nItem = nItemList[nRand].id
        AddNormalItemBind(nItem[1], nItem[2], nItem[3], nItem[4], 0, 0, 1)
        TopMessage("B¹n nhËn ®­îc <c=g>" .. nItemList[nRand].name .. "<c>")
        Msg2Player("B¹n nhËn ®­îc " .. nItemList[nRand].name .. " .")
        WriteLog(GetName() .. " nhËn ®­îc " .. nItemList[nRand].name .. " .")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Th«ng qua Kim Lan Phæ, nhËn 1 <c=g>" .. nItemList[nRand].name .. "<c>, KÕt nghÜa huynh ®Ö ®­îc trêi cao phï hé!", 3)
    end
    DelNormalItem(6, 1, 327, 0)
end

function no()
    CloseDialog()
end
