GiftPackageName = "·âÉñ°ÔÖ÷ÌØÈ¨¿¨"
GiftPackageID = { 6, 1, 1184, 1 }
NeedBagCount = 11
ExpBuffID = 0
ExpBuffTime = 0

ItemTable = {
    [1] = { name = "ÇïÒâÕýÅ¨×°(30 ngµy )", ID = { 6, 1, 1016, 1 }, count = 1 },
    [2] = { name = "Thanh Lé", ID = { 8, 162, 3, 0 }, count = 1 },
    [3] = { name = "Ch©n KhÝ", ID = { 8, 163, 4, 0 }, count = 1 },
    [4] = { name = "S¸ch Ch­ HÇu (M¶nh)", ID = { 8, 193, 5, 0 }, count = 5 },
}
CustonTable = {
}
RidingTable = {
    [1] = { name = "Tr¸c M·", ID = { 0, 10, 24, 1 } },
    [2] = { name = "Tr¸c T­íc", ID = { 0, 10, 25, 1 } },
    [3] = { name = "Tr¸c ®iÖp", ID = { 0, 10, 26, 1 } },
}
WeaponTable = {
    [1] = { name = "Tr¹m Kim Phñ(B¶n ®Æc biÖt)", ID = { 0, 0, 92, 1 } },
    [2] = { name = "Th¸i Cùc KiÕm(B¶n ®Æc biÖt)", ID = { 0, 0, 92, 2 } },
    [3] = { name = "DiÖt ThÇn ViÖt(B¶n ®Æc biÖt)", ID = { 0, 0, 92, 3 } },
}

ArmHeadTable = {
    [1] = { name = "Cù §Êu Kh«i", ID = { 0, 7, 9, 2 } },
    [2] = { name = "V©n Trung Qu¸n", ID = { 0, 7, 10, 2 } },
    [3] = { name = "KhuyÓn V¨n Trô", ID = { 0, 7, 11, 2 } },
}
function main()
    if (HaveNormalItem(GiftPackageID[1], GiftPackageID[2], GiftPackageID[3], GiftPackageID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(NeedBagCount + 1) == 0) then
        InfoBox("Tói kh«ng ®ñ « trèng" .. NeedBagCount .. "h·y s¾p xÕp l¹i tói.")
        return
    end

    if (ExpBuffID > 0) then
        if (GetIBBuffCount() >= 32 and HaveIBBuff(ExpBuffID) <= 0) then
            InfoBox("BUFF trong tói qu¸ nhiÒu, h·y s¾p xÕp tói tr­íc. ")
            return
        end
    end

    local zhty = GetPlayerType() + 1
    if (zhty < 1 or zhty > 3) then
        return
    end

    DelNormalItem(GiftPackageID[1], GiftPackageID[2], GiftPackageID[3], GiftPackageID[4])
    local str = ""

    if (ExpBuffID > 0) then
        AddIBBuff(ExpBuffID, ExpBuffTime)
        str = str .. "3 ngµy Ë«±¶µô±¦ÂÊ, "
    end

    for i = 1, table.getn(ItemTable) do
        for j = 1, ItemTable[i].count do
            AddNormalItemBind(ItemTable[i].ID[1], ItemTable[i].ID[2], ItemTable[i].ID[3], ItemTable[i].ID[4], 0, 0, 1)
        end
        str = str .. ItemTable[i].count .. "." .. ItemTable[i].name .. ","
    end

    if (table.getn(CustonTable) == 2) then
        if (GetSex() == 0) then
            AddNormalItemBind(CustonTable[1].ID[1], CustonTable[1].ID[2], CustonTable[1].ID[3], CustonTable[1].ID[4], 0, 0, 1)
            str = str .. CustonTable[1].name .. ","
        else
            AddNormalItemBind(CustonTable[2].ID[1], CustonTable[2].ID[2], CustonTable[2].ID[3], CustonTable[2].ID[4], 0, 0, 1)
            str = str .. CustonTable[2].name .. ","
        end
    end

    if (table.getn(ArmHeadTable) == 3) then
        AddNormalItem4(ArmHeadTable[zhty].ID[1], ArmHeadTable[zhty].ID[2], ArmHeadTable[zhty].ID[3], ArmHeadTable[zhty].ID[4], 0, 0, 0, 0, 0)
        str = str .. ArmHeadTable[zhty].name .. ","
    end

    if (table.getn(RidingTable) == 3) then
        AddNormalItem4(RidingTable[zhty].ID[1], RidingTable[zhty].ID[2], RidingTable[zhty].ID[3], RidingTable[zhty].ID[4], 0, 0, 0, 0, 0)
        str = str .. RidingTable[zhty].name
    end

    if (table.getn(WeaponTable) == 3) then
        AddNormalItem(WeaponTable[zhty].ID[1], WeaponTable[zhty].ID[2], WeaponTable[zhty].ID[3], WeaponTable[zhty].ID[4], 0, 0)
        str = str .. " vµ " .. WeaponTable[zhty].name .. "."
    end

    Msg2Player("Më " .. GiftPackageName .. " nhËn ®­îc " .. str)
    ScrollMessage("Më <c=green>" .. GiftPackageName .. "<c>")
    WriteLog("Më " .. GiftPackageName)
end

function no()
    CloseDialog()
end
