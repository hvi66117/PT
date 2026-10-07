--π˘»∫£ª2009-12-30£ª“¬≤ßœ‡¥´£¨ ÈªÍ…æ≥˝

Task_Partner = 1657
Task_YiboProcess = 1658 -- 1Byte:1—∞’“ ¶æ≠…œœ¬∆™ 2’“µΩ ¶æ≠…œœ¬∆™ 3“—∞— ÈΩª∏¯¡Àª∆ÃÏªØ 4Ω”µΩ¡‘…± ÈªÍ»ŒŒÒ 5 ÈªÍ“—æ≠ Õ∑≈ 6¡‘…±≥…π¶ 7»ŒŒÒÕÍ≥… 8»ŒŒÒ ß∞‹
-- 2Byte: ¶æ≠¿‡–Õ/∞Á—›Ω«…´ 1…œ∆™( ¶) 2œ¬∆™(ÕΩ)
Hunt_Buff = 1243       -- ¥Àbuff¥Ê‘⁄ ±º‰Õ¨π÷ŒÔ¥Ê‘⁄ ±º‰œ‡Õ¨ ,buffœ˚ ß“‘∫Û£¨‘Ú»ŒŒÒ ß∞‹
Debuff_ID = 1244

YiboItem = {
    [6] = { name = "D©y KhÊn Ti™n", Item = { 6, 1, 792, 0, 0, 0 } },
}

function OnTimer(npcidx)
    local PlayerIndex1 = SearchPlayerById(GetNpcTask(npcidx, 1))
    local PlayerIndex2 = SearchPlayerById(GetNpcTask(npcidx, 2))

    if (PlayerIndex1 > 0) then
        PlayerIndex = PlayerIndex1
        Msg2Player("Th≠ HÂn bi’n m t, nhi÷m vÙ th t bπi, xin Æi g∆p Hoµng Thi™n H„a hÒy nhi÷m vÙ!")
        Task_Fail()
    end

    if (PlayerIndex2 > 0) then
        PlayerIndex = PlayerIndex2
        Msg2Player("Th≠ HÂn bi’n m t, nhi÷m vÙ th t bπi, xin Æi g∆p Hoµng Thi™n H„a hÒy nhi÷m vÙ!")
        Task_Fail()
    end

    DelNpc(npcidx)
end

function Task_Fail()
    SetTaskByte(Task_YiboProcess, 1, 8)
    TaskNote(1515, 4)
    RemoveIBBuff(Debuff_ID)
    RemoveIBBuff(Hunt_Buff)

    local item = YiboItem[6].Item
    ClearItem(item[1], item[2], item[3], item[4])
end
