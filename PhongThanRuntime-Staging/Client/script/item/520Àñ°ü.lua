require("recharge_event.luax")
require("common.luax")
ItemName = "ÉñÃØ¶Ò»»ÀñºĞ"

Task_520 = 2103
function main(itemID)
    local times = GetTaskByte(Task_520, 3) + 1
    local nlimit = GetGlobalStoreValueWord(81, 2)
    if (times > nlimit) then
        Talk(1, "no", "±¾´Î»î¶¯¶Ò»»µÄÉÏÏŞÎª: <c=g>" .. nlimit .. "<c>,ÄúÒÑ¾­´ïµ½¶Ò»»ÉÏÏŞ, ÇëÏÂ´Î»î¶¯ÔÙ¶Ò»»°É.")
        return
    end

    local itemnum = CalJiangJunLingNum(times)
    local str = "§©y lµ ÄúµÚ<c=g>" .. times .. "<c>´Î¿ªÆô" .. ItemName .. ", cÇn tiªu hao T­íng Qu©n LÖnh: <c=r>" .. itemnum .. "<c> c¸i\nÈ·¶¨¿ªÆôÀñ°ü sao?"
    MsgBox(str, "Open520_yes", "no")
end
function Open520_yes()
    no()
    local times = GetTaskByte(Task_520, 3) + 1
    local itemnum = CalJiangJunLingNum(times)
    if (HaveNormalItem(3, 100, 0, 0) < itemnum) then
        InfoBox("ThËt xin lçi, T­íng Qu©n LÖnh²»×ã" .. itemnum .. " c¸i, ²»ÄÜ¿ªÆôÀñ°ü.")
        return
    end
    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng ®ñ 3¸ñ, h·y s¾p xÕp l¹i råi ®Õn ®æi.")
        return
    end
    for i = 1, itemnum do
        DelNormalItem(3, 100, 0, 0)
    end
    GiveItem()
end

function GiveItem()

    local times = GetTaskByte(Task_520, 3) + 1
    SetTaskByte(Task_520, 3, times)

    for i = 1, 10 do
        AddNormalItemBind(6, 1, 1446, 1, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)

    Msg2Player("Ngµi më " .. ItemName .. ", nhËn ®­îc ºìÃµ¹å*10, Vi Quang Qu¸i Phï.")
    Talk(1, "no", "Ngµi më " .. ItemName .. ", nhËn ®­îc ºìÃµ¹å*10, Vi Quang Qu¸i Phï.")
    WriteLog("[ÉñÃØ¶Ò»»ÀñºĞ][¿ªÆôºó»ñµÃºìÃµ¹å*10, Vi Quang Qu¸i Phï.]")

end

function CalJiangJunLingNum(times)
    if (times == 1) then
        return 5
    elseif (times >= 2 and times <= 9) then
        return 8
    else
        return 16
    end
end

function no()
    CloseDialog()
end
