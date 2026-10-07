require("common_beast.luax")

card_id = CommonBeast.card_id
seal_card_type_number = CommonBeast.seal_card_type_number
card_boss = CommonBeast.card_boss
boss_map = CommonBeast.boss_map
task_number = CommonBeast.task_number
boss_name = CommonBeast.boss_name

gTemplateID = 2407

function main(level, time, npcIndex, itemId)

    local Y, M, D = GetYMD()
    if (GetTaskByte(task_number, 4) ~= D) then
        SetTask(task_number, 0)
        SetTaskByte(task_number, 4, D)
    end

    if (GetTaskByte(task_number, 1) > 0) then
        Talk(1, "no", "Ã¿ÌìÖ»ÄÜÕÙ»½Ò»´Î×¨Êôboss, ÇëÓÂÊ¿Ã÷ÌìÔÙÀ´!")
        return
    end

    local particular = GetItemPartByID(itemId)

    for i = 1, getn(card_id) do
        if (particular == card_id[i][3]) then
            local mapid, x, y = GetWorldPos()
            if (mapid == boss_map) then


                if (DelItemByID(itemId) <= 0) then
                    return
                end

                SetTaskByte(task_number, 1, 1)

                local award_name = AddCallAward(card_boss[i].hardType)
                if (award_name == nil) then
                    return
                end

                local npc_index = AddNpc(card_boss[i].hardType, card_boss[i].level, SubWorldID2Idx(mapid), x * 32, y * 32)
                SetNpcTimer(npc_index, "\\script\\ontimer\\×¨ÊôbossÉ¾µô×Ô¼º.lua", card_boss[i].time)

                local disappear = card_boss[i].time / 60
                Msg2Player("ÄúÒÑ¾­ÕÙ»½ÁË×¨Êôboss,×¨Êôboss½«ÓÚ" .. disappear .. "·ÖÖÓÖ®ºóÏûÊ§,ÇëÓÂÊ¿×¥½ôÊ±¼ä½«Æä½µ·ş£.¡!")
                WriteLog("[Ho¹t ®éng Hung Thó][bossÏà¹Ø][ÕÙ»½]ÔÚ[" .. x .. "," .. y .. "]´¦ÕÙ»½ÁËboss(" .. card_boss[i].hardType .. "),µÈ¼¶" .. card_boss[i].level .. ", nhËn ®­îc " .. award_name)

                local posX = math.floor(x / 8)
                local posY = math.floor(y / 16)
                Msg2CurMapAnnounce("Anh hïng " .. GetName() .. "ÔÚÓÎ»ê¹Ø(" .. posX .. "," .. posY .. ")ÕÙ³ö¶ÓÎé×¨Êôboss: " .. boss_name[i] .. ",¿ì¼ÓÈëËûµÄ¶ÓÎé°ïÖúËû¹²Í¬½µ·ş!")

                local nNpcIdx = SearchNearNpcByTemplateId(PlayerIndexToNpcIndex(PlayerIndex), gTemplateID + i)
                SetNpcBelonger(nNpcIdx)

                break
            end
        end
    end
end

function AddCallAward(template_id)

    local award_list = {}
    for _, value in ipairs(card_boss) do
        if (value.hardType == template_id) then
            award_list = value.award_call
            break
        end
    end

    local result = CommonBeast.AddAward(award_list)
    if (result ~= nil) then
        Msg2Player("¹§Ï²Äú³É¹¦ÕÙ»½Ğ×ÊŞ,»ñµÃ½±Àø" .. result)
    end

    return result
end

function no(...)

    CloseDialog()
end
