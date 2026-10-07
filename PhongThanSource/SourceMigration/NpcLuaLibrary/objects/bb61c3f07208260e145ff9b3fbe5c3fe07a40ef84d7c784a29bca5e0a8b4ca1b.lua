--description:ontimer
--author: huyuzhang
--date:2009/7/29

TASK_CRLH = 1513
TASK_CRLH_GROW = 1514
TASK_CRLH_LOCATION = 1515
TASK_CRLH_ROUSHEN_IDX = 1516
TASK_CRLH_NPCID = 1517
TASK_CRLH_G_COUNT = 241
TASK_CRLH_G_TOTAL = 242
TASK_NOTEID = 1091

function OnDeath(npcindex)
    --local	num = GetGlobalValue(TASK_CRLH_G_COUNT)
    --local	t_npcidx = GetTask(TASK_CRLH_ROUSHEN_IDX)
    --local	t_npcid = GetTask(TASK_CRLH_NPCID)

    local t_npcidx = GetNpcTask(npcindex, 2)
    local t_npcid = GetNpcTask(npcindex, 3)

    if (GetNpcID(t_npcidx) ~= t_npcid) then
        return

    end


    --Ö´ĞĞµ½ÕâËµÃ÷¾øìÇNPC»¹»î×Å
    local num = GetNpcTask(t_npcidx, 8)
    num = num + 1
    --Msg2Player("ÒÑ¾­ÏûÃğÁË"..num)
    SetNpcTask(t_npcidx, 8, num)

    local pid = GetNpcTask(npcindex, 1)

    if (GetPlayerID() == pid) then
        local killnum = GetTaskByte(TASK_CRLH_GROW, 3)

        killnum = killnum + 1

        if (killnum >= 7) then

            if (t_npcid == GetNpcID(t_npcidx)) then
                SetTaskByte(TASK_CRLH, 2, 3)
                DelNpc(GetTask(TASK_CRLH_ROUSHEN_IDX))

                local loca_x = GetTaskWord(TASK_CRLH_LOCATION, 1)
                local loca_y = GetTaskWord(TASK_CRLH_LOCATION, 2)

                local newnpcidx = AddNpc(1210, 85, SubWorld, loca_x * 32, loca_y * 32)    --Ìí¼Ó¸øµÀ¾ßµÄ
                SetNpcScript(newnpcidx, "\\script\\¹ÖÎï\\¾øìÇÈı»êÆßÆÇ.lua")
                SetTask(TASK_CRLH_ROUSHEN_IDX, newnpcidx)            --ÓÃÓÚÏÂ´ÎÉ¾µô	
                SetTask(TASK_CRLH_NPCID, GetNpcID(newnpcidx))        --¼ÇÂ¼NPCID ¼ì²éÊÇ·ñ´æÔÚ
                SetNpcTask(newnpcidx, 1, GetPlayerID())                --¼ÇÂ¼Íæ¼Ò¹éÊô
                SetNpcTask(newnpcidx, 2, 0)                            --µ÷ÓÃ¼ÆÊı
                SetNpcTask(newnpcidx, 3, PlayerIndex)                --¼ÇÂ¼Íæ¼ÒIDX
                SetNpcTask(newnpcidx, 10, GetNpcID(newnpcidx))
                SetNpcTimer(newnpcidx, "\\script\\ontimer\\¾øìÇÏûÊ§.lua", 180)
                TaskNote(TASK_NOTEID, 9)

                Msg2Player("§· thu thËp ®ñ hån ph¸ch.")
                TopMessage("Hån TuyÖt DiÖp xuÊt hiÖn")
                SetTaskByte(TASK_CRLH_GROW, 3, killnum)

            else
                --¸ÅÂÊºÜĞ¡
                Msg2Player("TuyÖt DiÖp ®· tö vong, nhiÖm vô thÊt b¹i.")

            end

        else
            SetTaskByte(TASK_CRLH_GROW, 3, killnum)
            Msg2Player("§· thµnh c«ng thu thËp " .. killnum .. " ph¸ch.")

            --if( t_npcid == GetNpcID(t_npcidx) ) then	

            --if( GetNpcTask(t_npcidx, 5) == 10 )	then			--ËµÃ÷¹ÖÒÑ¾­¶¼Ë¢ÍêÁË

            --local	remain = GetNpcTask(t_npcidx, 4)

            --if( ( 7 - killnum ) > remain ) then 
            --Msg2Player("ÈÎÎñÊ§°Ü,ÏûÃğ¹ÖÎïµÄÊıÁ¿²»×ã¡£")
            --SetTaskByte(TASK_CRLH, 2, 10)
            --TaskNote(TASK_NOTEID, 11)

            --end

            --end
            --end
        end

    end

    if (num == 10) then
        local pid = GetNpcTask(t_npcidx, 1)
        local pidx = GetNpcTask(t_npcidx, 3)

        local tmp_pidx = PlayerIndex
        PlayerIndex = pidx

        if (GetPlayerID() == pid) then
            if (GetTaskByte(TASK_CRLH_GROW, 3) < 7) then
                Msg2Player("NhiÖm vô thÊt b¹i, ch­a tiªu diÖt ®ñ sè qu¸i vËt!")
                SetTaskByte(TASK_CRLH, 2, 10)
                TaskNote(TASK_NOTEID, 11)
                DelNpc(t_npcidx)

            end

        end

        PlayerIndex = tmp_pidx

    end

    DelNpc(npcindex)
end