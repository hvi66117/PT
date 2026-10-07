require("common.luax")
Unpack_TABLE = COMMON.Unpack_TABLE

function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)
    CloseDialog()
    local nParticular = GetItemPartByID(itemID)
    if (nParticular < 1571) then
        return
    elseif (nParticular > 1593) then
        return
    end

    local idx = nParticular - 1570
    if (idx <= 0 or idx > getn(Unpack_TABLE)) then
        return
    end
    SetTask(140, itemID)
    SetTask(141, idx)

    local str = Unpack_TABLE[idx].nums .. "." .. Unpack_TABLE[idx].name
    MsgBox("你现在要<c=g>解开此包<c> sao?将获得<c=y>" .. str .. "<c>!\n请注意你的背包空间.", "Unpackyes", "no")
end

function Unpackyes()
    CloseDialog()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "您的背包空间不足, 清理背包后再解开礼包.")
        return
    end

    local itemID = GetTask(140)
    local nParticular = GetItemPartByID(itemID)
    if (nParticular < 1571) then
        Talk(1, "no", "非常抱歉, 解包失败, 请重试!")
        return
    elseif (nParticular > 1593) then
        Talk(1, "no", "非常抱歉, 解包失败, 请重试!")
        return
    end

    local idx = nParticular - 1570
    if (GetTask(141) ~= idx) then
        Talk(1, "no", "非常抱歉, 解包失败, 请重试!")
        return
    end
    SetTask(140, 0)
    SetTask(141, 0)
    local isBind = 0
    if (IsItemBind(itemID) > 0) then
        isBind = 1
    end

    if (DelItemByID(itemID) < 1) then
        Talk(1, "no", "非常抱歉, 解包失败, 请重试!")
        return
    end

    local nNums = Unpack_TABLE[idx].nums
    local id = Unpack_TABLE[idx].malterItem
    for i = 1, nNums do
        if (isBind == 1) then
            AddNormalItemBind(id[1], id[2], id[3], id[4], 0, 0, 1)
        else
            AddNormalItemPile(id[1], id[2], id[3], id[4], 0, 0)
        end
    end

    Msg2Player("你解开此包 nh薾 頲 " .. nNums .. "." .. Unpack_TABLE[idx].name)
    ScrollMessage("<c=y>" .. Unpack_TABLE[idx].name .. "<c>包解包成功")
    WriteLog("[解包]" .. Unpack_TABLE[idx].name .. "[绑定]" .. isBind)
end
