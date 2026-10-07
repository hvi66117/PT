Flower_TreeID = 1818    --»¨Ãç

Item = {
    [1] = { ID = { 3, 1120, 0 }, isBind = 1 }, --ÀÍ¶¯¹âÈÙ½±ÕÂ
    [2] = { ID = { 3, 1118, 0 }, isBind = 1 }, --ÎåÒ»ÆøÇò
    [3] = { ID = { 3, 1119, 0 }, isBind = 1 }, --¿ìÀÖÆøÇò
    [4] = { ID = { 3, 1121, 0 }, isBind = 1 }, --ÌìÌÃÄñ
    [5] = { ID = { 3, 1122, 0 }, isBind = 1 }, --À¶É«Ñý¼§
    [6] = { ID = { 6, 1, 827 }, isBind = 0 }, --ÉñÃØÖÖ×Ó
    [7] = { ID = { 6, 1, 828 }, isBind = 1 }, --åÐÒ£»¨·Ê
    [8] = { ID = { 6, 1, 829 }, isBind = 1 }, --ÔÓ²Ý
    [9] = { ID = { 6, 1, 830 }, isBind = 1 }, --Çà³æ
    [10] = { ID = { 6, 1, 831 }, isBind = 1 }, --ÌìÌÃÀñºÐ
    [11] = { ID = { 6, 1, 832 }, isBind = 1 }, --É±³æ¼Á
    [12] = { ID = { 6, 1, 833 }, isBind = 1 }, --³ý²Ý¼Á
}

function main(nLevel, nTime, nTNpcIdx, itemID)
    local mapid, x, y = GetWorldPos()

    if mapid == 21 then
        local npcidx = AddNpc(Flower_TreeID, 1, SubWorld, x * 32, y * 32)
        if npcidx > 0 then
            DelItemByID(itemID)
            SetNpcTask(npcidx, 0, GetPlayerID())
            SetNpcName(npcidx, GetName() .. "!")
            SetNpcScript(npcidx, "\\script\\»î¶¯½Å±¾\\ÎåÒ»»¨.lua")
            --local nCurTime   = LocalSystemTime()/86400
            --local nLeftTime  = (floor(nCurTime) + 1) *86400 - LocalSystemTime()
            SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 30)    --»¨µÄ´æÔÚÊ±¼äÎª30·ÖÖÓ
            InfoBox("Thêi gian tån t¹i cña chåi hoa nµy chØ cã 30 phót, h·y mau chãng ®i ch¨m sãc nã!")
        else
            InfoBox("N¬i ®©y hoa cá qu¸ nhiÒu, ch­a trång thµnh c«ng! L¸t n÷a h·y thö l¹i!")
        end
    else
        InfoBox("Trång hoa cÇn ®Õn TriÒu Ca, n¬i ®ã thñy thæ rÊt thÝch hîp ®Ó chåi hoa nµy ph¸t triÓn!")
    end

end
