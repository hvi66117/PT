--description: ³ãÑÀ
--author: gongpeng
--date: 2009/03/25

Task_id = 1358;
-- 1Byte:status : 0:Î´ÁìÈ¡ÈÎÎñ; 1-4:Íê³É0-3Ìì; 5:Íê³ÉµÚÒ»²½;
--        6-11:É±ËÀ³ãÑÀ0-5Ö»; 12:ÈÎÎñÍê³É;
-- 2Byte:ÁÔÉ± ÏàÓ¦ÕóÓªÖĞ·çÊŞÉ½çõµÄ´ÎÊı
Idx_danfang = 1360; -- µ¤·¿µÄidx
ID_danfang = 1361; -- µ¤·¿µÄid
Idx_chiya = 1362; -- ³ãÑÀµÄidx
ID_chiya = 1363; -- ³ãÑÀµÄid

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
            ScrollMessage("§· diÖt trõ <c=g>Sİ Nha<c>")
            SetTaskByte(Task_id, 1, status + 1)
            TaskNote(1036, 7, (status - 5))
        elseif (GetTask(ID_danfang) ~= GetNpcID(idx_df)) then
            TopMessage("<c=g>Thiªn Hµnh ThuËn NghŞch<c> - nhiÖm vô thÊt b¹i")
            SetTaskByte(Task_id, 1, 6)
            TaskNote(1036, 8)
        elseif (GetTask(ID_chiya) ~= GetNpcID(idx_chy)) then
            ScrollMessage("VÉn ch­a ®¸nh b¹i <c=g>Sİ Nha<c>")    --Õâ¸öËÆºõÃ»ÓĞ±ØÒª ÔÙ²â
        end

        SetTask(Idx_chiya, 0)
        if (status == 10) then
            Msg2Player("§· ®Èy lïi Sİ Nha, luyÖn thµnh Hoµng Lé ®¬n, ®Õn ®èi tho¹i víi §¬n Phßng.")
            TaskNote(1036, 10)
        end
    end
    DelNpc(npcidx)
end
