Task_fragment = 1519

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (HaveIBBuff(756) == 0) then
        Msg2Player("Bπn kh´ng sˆ dÙng CuËc, kh´ng th” Æµo vÀt nµy!")
        return
    end

    local mapid, x, y = GetWorldPos()
    local mapid1, npcx, npcy = GetNpcWorldPos(DialogNpcIdx)
    local distance = math.floor(((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32)
    if (distance > 300) then
        Msg2Player("Bπn c∏ch To∏i phi’n qu∏ xa, kh´ng th” Æµo.")
        return
    end

    SetTask(Task_fragment, DialogNpcIdx)

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 1)

    if (GetNpcTask(DialogNpcIdx, 1) == 1) then
        BeginMotion(Task_fragment, 0, 3, "\\script\\motion\\ ∞»°ÀÈ∆¨.lua", nInterrupt)
    elseif (GetNpcTask(DialogNpcIdx, 1) == 2) then
        BeginMotion(Task_fragment, 0, 6, "\\script\\motion\\ ∞»°ÀÈ∆¨.lua", nInterrupt)
    elseif (GetNpcTask(DialogNpcIdx, 1) == 3 or GetNpcTask(DialogNpcIdx, 1) == 4) then
        BeginMotion(Task_fragment, 0, 10, "\\script\\motion\\ ∞»°ÀÈ∆¨.lua", nInterrupt)
    end
end
