Task_id = 1358;

Idx_danfang = 1360;
ID_danfang = 1361;
Idx_chiya = 1362;
ID_chiya = 1363;

function OnDeath(npcidx)
    local status = GetTaskByte(Task_id, 1)

    if ((status >= 6) and (status <= 10)) then

        local playerID = GetNpcTask(npcidx, 0)
        if (playerID ~= GetPlayerID()) then
            DelNpc(npcidx)
            return
        end

        local idx_df = GetTask(Idx_danfang)
        local idx_chy = GetTask(Idx_chiya)

        if ((GetTask(ID_danfang) == GetNpcID(idx_df)) and (GetTask(ID_chiya) == GetNpcID(idx_chy))) then
            ScrollMessage("§· diÖt trõ <c=g>SÝ Nha<c>")
            SetTaskByte(Task_id, 1, status + 1)
            TaskNote(1036, 7, (status - 5))
        elseif (GetTask(ID_danfang) ~= GetNpcID(idx_df)) then
            TopMessage("<c=g>Thiªn Hµnh ThuËn NghÞch<c> - nhiÖm vô thÊt b¹i")
            SetTaskByte(Task_id, 1, 6)
            TaskNote(1036, 8)
        elseif (GetTask(ID_chiya) ~= GetNpcID(idx_chy)) then
            ScrollMessage("VÉn ch­a ®¸nh b¹i <c=g>SÝ Nha<c>")
        end

        SetTask(Idx_chiya, 0)
        if (status == 10) then
            Msg2Player("§· ®Èy lïi SÝ Nha, luyÖn thµnh Hoµng Lé ®¬n, ®Õn ®èi tho¹i víi §¬n Phßng.")
            TaskNote(1036, 10)
        end
    end
    DelNpc(npcidx)
end
