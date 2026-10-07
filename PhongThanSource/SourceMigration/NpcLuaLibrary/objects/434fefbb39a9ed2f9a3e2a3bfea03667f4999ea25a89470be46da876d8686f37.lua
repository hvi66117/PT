BoxName = "ThÎ gi¶m gi¸ 20% VIP"
boxID = { 6, 1, 1117, 1 }
TableItem = {
    { name = "§Æc QuyÒn HuyÒn Vò", id = 192, VipLevel = 1 },
    { name = "§Æc QuyÒn Chu T­íc", id = 193, VipLevel = 2 },
    { name = "§Æc QuyÒn B¹ch Hæ", id = 194, VipLevel = 3 },
}
function no()
    CloseDialog()
end
function main(nItemId)
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local opra = {
        "§Æc QuyÒn HuyÒn Vò/SelectItem",
        "§Æc QuyÒn Chu T­íc/SelectItem",
        "§Æc QuyÒn B¹ch Hæ/SelectItem",
    }
    Say("H·y chän lo¹i h×nh VIP ngµi muèn mua, sau khi mua ngµi sÏ nhËn 1 th¸ng ®Æc quyÒn VIP t­¬ng øng.", table.getn(opra), opra)
end
function SelectItem(nIndex)
    no()
    nIndex = nIndex + 1
    if (nIndex < 1 or nIndex > 3) then
        return
    end
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local nVipLevel = GetPlayerVipLevel()
    if (nVipLevel > TableItem[nIndex].VipLevel) then
        Talk(1, "no", "ThËt xin lçi, cÊp VIP hiÖn t¹i cña ngµi cao h¬n lo¹i VIP ®· chän, xin h·y chän l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(TableItem[nIndex].id)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, mua <c=y>" .. TableItem[nIndex].name .. "<c> cÇn <c=y>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end
    SetTask(140, nIndex)
    MsgBox("Ngµi sÏ tiªu phÝ <c=y>" .. Cfs .. " Th«ng B¶o<c>mua <c=y>" .. TableItem[nIndex].name .. "<c>ÌØÈ¨, x¸c nhËn muèn mua.", "SelectItemSure", "no")
end
function SelectItemSure()
    no()
    local nIndex = GetTask(140)
    if (nIndex < 1 or nIndex > 3) then
        return
    end
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local nVipLevel = GetPlayerVipLevel()
    if (nVipLevel > TableItem[nIndex].VipLevel) then
        Talk(1, "no", "ThËt xin lçi, cÊp VIP hiÖn t¹i cña ngµi cao h¬n lo¹i VIP ®· chän, xin h·y chän l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(TableItem[nIndex].id)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, mua <c=y>" .. TableItem[nIndex].name .. "<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end
    if (CostCoinByIdx(TableItem[nIndex].id) ~= 0) then
        DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4])
        SetPlayerVipLevel(TableItem[nIndex].VipLevel, 30 * 86400)
        AddIBBuff(233, (86400 * 30))
        AddIBBuff(442, (86400 * 30))
        Msg2Player("Chóc mõng ngµi mua " .. TableItem[nIndex].name .. " thµnh c«ng")
        WriteLog("[Sö dông][" .. BoxName .. "][ mua " .. TableItem[nIndex].name .. "]")
    end
end
