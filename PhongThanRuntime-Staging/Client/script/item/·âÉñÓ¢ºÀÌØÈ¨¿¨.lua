GiftPackageName = "∑‚…Ò”¢∫¿Ãÿ»®ø®"
GiftPackageID = { 6, 1, 1182, 1 }
NeedBagCount = 2
ExpBuffID = 0
ExpBuffTime = 0

ItemTable = {
    [1] = { name = "«Ô“‚’˝≈®◊∞(7 ngµy)", ID = { 6, 1, 1014, 1 }, count = 1 },
}
CustonTable = {
}
RidingTable = {
}
WeaponTable = {
    [1] = { name = "Trπm Kim PhÒ(B∂n Æ∆c bi÷t)", ID = { 0, 0, 92, 1 } },
    [2] = { name = "Th∏i C˘c Ki’m(B∂n Æ∆c bi÷t)", ID = { 0, 0, 92, 2 } },
    [3] = { name = "Di÷t Th«n Vi÷t(B∂n Æ∆c bi÷t)", ID = { 0, 0, 92, 3 } },
}
function main()
    if (HaveNormalItem(GiftPackageID[1], GiftPackageID[2], GiftPackageID[3], GiftPackageID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(NeedBagCount + 1) == 0) then
        InfoBox("TÛi kh´ng ÆÒ ´ trËng" .. NeedBagCount .. "h∑y sæp x’p lπi tÛi.")
        return
    end

    if (ExpBuffID > 0) then
        if (GetIBBuffCount() >= 32 and HaveIBBuff(ExpBuffID) <= 0) then
            InfoBox("BUFF trong tÛi qu∏ nhi“u, h∑y sæp x’p tÛi tr≠Ìc. ")
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
        str = str .. "3 ngµy À´±∂µÙ±¶¬ , "
    end

    for i = 1, table.getn(ItemTable) do
        for j = 1, ItemTable[i].count do
            AddNormalItemBind(ItemTable[i].ID[1], ItemTable[i].ID[2], ItemTable[i].ID[3], ItemTable[i].ID[4], 0, 0, 1)
        end
        str = str .. ItemTable[i].count .. "." .. ItemTable[i].name
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

    if (table.getn(RidingTable) == 3) then
        AddNormalItem4(RidingTable[zhty].ID[1], RidingTable[zhty].ID[2], RidingTable[zhty].ID[3], RidingTable[zhty].ID[4], 0, 0, 0, 0, 0)
        str = str .. RidingTable[zhty].name .. ","
    end

    if (table.getn(WeaponTable) == 3) then
        AddNormalItem(WeaponTable[zhty].ID[1], WeaponTable[zhty].ID[2], WeaponTable[zhty].ID[3], WeaponTable[zhty].ID[4], 0, 0)
        str = str .. " vµ " .. WeaponTable[zhty].name .. "."
    end

    Msg2Player("MÎ " .. GiftPackageName .. " nhÀn Æ≠Óc " .. str)
    ScrollMessage("MÎ <c=green>" .. GiftPackageName .. "<c>")
    WriteLog("MÎ " .. GiftPackageName)
end

function no()
    CloseDialog()
end
