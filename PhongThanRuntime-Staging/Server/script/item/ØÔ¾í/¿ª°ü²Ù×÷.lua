require("common.luax")
Unpack_TABLE = COMMON.Unpack_TABLE

function PTTrace(s)
    local h = openfile("admin_bridge\\openpack_trace.log", "a")
    if h then write(h, date("%H:%M:%S") .. " " .. s .. "\n") closefile(h) end
end

function no()
    CloseDialog()
end

-- Phong Than local fix 2026-09-28: the server calls item main() with the item
-- index as the only argument, and GetItemPartByID() returns 0 for these packs
-- (the pack id 1571..1593 is the MagicScript DetailType). DelItemByID and
-- IsItemBind are not registered. The pack type is therefore resolved from the
-- packs present in the bag (GetItemCount) and consumed by type with DelItem.
PT_PACK_FIRST = 1571
PT_PACK_LAST = 1593

function PT_PackName(idx)
    return Unpack_TABLE[idx].nums .. " " .. Unpack_TABLE[idx].name
end

function PT_Confirm(d)
    local idx = d - 1570
    if (idx <= 0 or idx > getn(Unpack_TABLE)) then return end
    SetTask(140, d)
    SetTask(141, idx)
    PTTrace("confirm pack=" .. d .. " idx=" .. idx)
    MsgBox("Ban muon <c=g>mo goi nay<c>? Se nhan duoc <c=y>" .. PT_PackName(idx) .. "<c>!\nHay chu y cho trong trong hanh trang.", "Unpackyes", "no")
end

function main(nItemIndex)
    CloseDialog()
    local d = GetItemPartByID(nItemIndex)
    if (d >= PT_PACK_FIRST and d <= PT_PACK_LAST) then
        PT_Confirm(d)
        return
    end
    local found = {}
    local n = 0
    local k = PT_PACK_FIRST
    while k <= PT_PACK_LAST do
        if (k - 1570 <= getn(Unpack_TABLE)) and (GetItemCount(6, k) > 0) then
            n = n + 1
            found[n] = k
        end
        k = k + 1
    end
    PTTrace("main item=" .. tostring(nItemIndex) .. " part=" .. tostring(d) .. " packs=" .. n)
    if n == 0 then
        Msg2Player("Khong tim thay goi nguyen lieu trong hanh trang.")
        return
    end
    if n == 1 then
        PT_Confirm(found[1])
        return
    end
    local opts = {}
    local i = 1
    while i <= n and i <= 7 do
        opts[i] = PT_PackName(found[i] - 1570) .. "/PTPick" .. found[i]
        i = i + 1
    end
    opts[i] = "Khong mo/no"
    Say("Chon goi muon mo:", i, opts)
end

k = PT_PACK_FIRST
while k <= PT_PACK_LAST do
    local pd = k
    setglobal("PTPick" .. k, function() PT_Confirm(%pd) end)
    k = k + 1
end

function Unpackyes()
    CloseDialog()
    local d = GetTask(140)
    local idx = GetTask(141)
    PTTrace("yes pack=" .. d .. " idx=" .. idx .. " space=" .. tostring(IsHaveSpaceForTreasure(2)))
    if (d < PT_PACK_FIRST or d > PT_PACK_LAST or idx ~= d - 1570) then
        Talk(1, "no", "Mo goi that bai, vui long thu lai!")
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Hanh trang khong du cho trong, hay don hanh trang roi mo lai.")
        return
    end
    if (GetItemCount(6, d) < 1) then
        Talk(1, "no", "Khong con goi nay trong hanh trang.")
        return
    end
    SetTask(140, 0)
    SetTask(141, 0)
    local nDel = DelItem(1, 6, d)
    PTTrace("yes deleted=" .. tostring(nDel))
    if ((nDel or 0) < 1) then
        Talk(1, "no", "Mo goi that bai, vui long thu lai!")
        return
    end
    local nNums = Unpack_TABLE[idx].nums
    local id = Unpack_TABLE[idx].malterItem
    for i = 1, nNums do
        AddNormalItemPile(id[1], id[2], id[3], id[4], 0, 0)
    end
    Msg2Player("Mo goi nhan duoc " .. PT_PackName(idx))
    WriteLog("[unpack]" .. Unpack_TABLE[idx].name .. " x" .. nNums)
end