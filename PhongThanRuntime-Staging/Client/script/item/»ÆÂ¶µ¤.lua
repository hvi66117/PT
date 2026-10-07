Task_id = 1358;

Idx_danfang = 1360;
ID_danfang = 1361;
Idx_chiya = 1362;
ID_chiya = 1363;

function main()
    local idx_chy = GetTask(Idx_chiya)
    if ((idx_chy ~= 0) and (GetTask(ID_chiya) == GetNpcID(idx_chy))) then
        ScrollMessage("Ph¶i tiªu diÖt <c=g>Si Nha<c>")
        return
    end

    local status = GetTaskByte(Task_id, 1)

    if ((status >= 6) and (status <= 10)) then
        local idx_df = GetTask(Idx_danfang)
        local Mapid, x1, y1 = GetNpcWorldPos(idx_df)
        local w2, x2, y2 = GetWorldPos()

        if (((x1 - x2) ^ 2 + (y1 - y2) ^ 2) > 400) then
            ScrollMessage("C¸ch VÞ TÕ L­ qu¸ xa")
            return
        end

        PlayerSit()
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 0)
        nInterrupt = SetBit(nInterrupt, 4, 0)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 8, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        BeginMotion(Task_id, 1, 30, "\\script\\motion\\´ò×ø½ø¶ÈÌõ.lua", nInterrupt)
    elseif (status == 11) then
        Msg2Player("§· ®Èy lïi SÝ Nha, luyÖn thµnh Hoµng Lé ®¬n, ®Õn ®èi tho¹i víi §¬n Phßng.")
    end
end
