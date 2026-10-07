Task_newer13 = 1416

function main()
    CloseDialog()
    if (GetPlayerType() ~= 0) then
        ClearItem(6, 1, 495, 0)
        return 0
    end

    local state13 = GetTaskByte(Task_newer13, 1)
    if (state13 == 3) then
        local w, x, y = GetWorldPos()
        x = math.floor(x / 8)
        y = math.floor(y / 16)
        if (((x - 209) ^ 2 + (y - 179) ^ 2) >= 3) then
            Talk(1, "no", "B¹n c¸ch Tiªu Th¸p qu¸ xa!")
            return 0
        else
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 0)
            nInterrupt = SetBit(nInterrupt, 4, 0)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            nInterrupt = SetBit(nInterrupt, 9, 1)
            BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\ÃºÓÍ.lua", nInterrupt)

        end
    else

        ClearItem(6, 1, 495, 0)
        Msg2Player("DÇu ho¶ ®· hÕt")
    end


end;

function no()
    CloseDialog()
end;
