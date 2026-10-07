--description: ËéÆ¬
--author: liuzhiqiang
--date: 2009/07/29

Task_fragment = 1519 --¼ÇÂ¼ËéÆ¬Ë÷Òı

--AS GaoJingwei 090803
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 090803

function main()
    if (HaveIBBuff(756) == 0) then
        Msg2Player("B¹n kh«ng sö dông Cuèc, kh«ng thÓ ®µo vËt nµy!")
        return
    end

    local mapid, x, y = GetWorldPos()  --Íæ¼Òµ±Ç°µÄÎ»ÖÃ
    local mapid1, npcx, npcy = GetNpcWorldPos(DialogNpcIdx) --»ñÈ¡npcµÄÎ»ÖÃ
    local distance = floor(((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32) --Íæ¼ÒÓëËéÆ¬µÄ¾àÀë
    if (distance > 300) then
        Msg2Player("B¹n c¸ch To¸i phiÕn qu¸ xa, kh«ng thÓ ®µo.")
        return
    end

    SetTask(Task_fragment, DialogNpcIdx)

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
    nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
    nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
    nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
    nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
    nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
    nInterrupt = SetBit(nInterrupt, 9, 1)    --½ÇÉ«ËÀÍö
    nInterrupt = SetBit(nInterrupt, 10, 1)    --¹ÖÎïÄ¿±ê¶ªÊ§

    if (GetNpcTask(DialogNpcIdx, 1) == 1) then
        BeginMotion(Task_fragment, 0, 3, "\\script\\motion\\Ê°È¡ËéÆ¬.lua", nInterrupt)
    elseif (GetNpcTask(DialogNpcIdx, 1) == 2) then
        BeginMotion(Task_fragment, 0, 6, "\\script\\motion\\Ê°È¡ËéÆ¬.lua", nInterrupt)
    elseif (GetNpcTask(DialogNpcIdx, 1) == 3 or GetNpcTask(DialogNpcIdx, 1) == 4) then
        BeginMotion(Task_fragment, 0, 10, "\\script\\motion\\Ê°È¡ËéÆ¬.lua", nInterrupt)
    end
end
