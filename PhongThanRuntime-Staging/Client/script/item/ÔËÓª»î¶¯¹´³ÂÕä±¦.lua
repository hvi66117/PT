ItemTableConst = {
    [1] = { name = "¡È∆¯¡“—Ê»€Ω◊∞", ID = { 8, 1730, 2, 0 }, count = 1 },
    [2] = { name = "Vi Quang Qu∏i PhÔ (ch≠a mµi)", ID = { 3, 374, 0, 0 }, count = 1 },
    [3] = { name = "TÛi Danh Ng‰c", ID = { 8, 1669, 2, 1 }, count = 1 },
    [4] = { name = "Di Quang k›nh", ID = { 8, 509, 2, 0 }, count = 1 },
    [5] = { name = "T≠Ìng Qu©n L÷nh", ID = { 3, 100, 0, 0 }, count = 5 },
}
NeedBageCount = 5
BoxName = "π¥≥¬’‰±¶"
boxID = { 6, 1, 1536, 1 }

function no()
    CloseDialog()
end

function main(nItemId)
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(NeedBageCount + 1) == 0) then
        InfoBox("TÛi kh´ng ÆÒ ´ trËng" .. NeedBageCount .. "h∑y sæp x’p lπi tÛi.")
        return
    end

    if (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    local str = ""
    local temp = 1

    for i = 1, table.getn(ItemTableConst) do
        for j = 1, ItemTableConst[i].count do
            AddNormalItemPile(ItemTableConst[i].ID[1], ItemTableConst[i].ID[2], ItemTableConst[i].ID[3], ItemTableConst[i].ID[4], 0, 0)
        end
        if (i == table.getn(ItemTableConst)) then
            str = str .. ItemTableConst[i].name .. "*" .. ItemTableConst[i].count .. "."
        else
            str = str .. ItemTableConst[i].name .. "*" .. ItemTableConst[i].count .. ","
        end
    end

    BrocateMessage(temp, str)
    WriteLog("[ª˜…±π¥≥¬ÀÕ’‰±¶ªÓ∂Ø][¥Úø™" .. BoxName .. "]")

end
function BrocateMessage(nMessageType, str)
    if (nMessageType >= 1) then
        Msg2Player("MÎ " .. BoxName .. " nhÀn Æ≠Óc " .. str)
    end
    if (nMessageType >= 2) then
        AddGlobalNews("<c=g>" .. GetName() .. "<c> mÎ «ß–¡ÕÚø‡µ√µΩµƒ" .. BoxName .. " nhÀn Æ≠Óc " .. str .. "πßœ≤!")
    end
    if (nMessageType >= 3) then

    end
end
