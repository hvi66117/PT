--ìåÄ§ËÀÍö.lua
--author: GaoJingwei
--date:2009/2/5

task_renwu = 1309        --1byte£ºÊÇ·ñ½ÓÈÎÎñ£¬0±íÊ¾ÒÑ½Ó£¬1±íÊ¾Ã»½Ó£»2byte£ºÒÑ½ÓÈÎÎñµÄ´ÎÊı;
--3byte:Ê£ÓàµÄ¹ÖÎï¸öÊı£»4byte:ÊÇ·ñÍê³ÉÈÎÎñ
totleNumber = 1311        --Íæ¼ÒÀÛ¼Æ½ÓÈÎÎñµÄ´ÎÊı
killTimes = 1325        --1byte:É±ËÀÊôÓÚ×Ô¼º¹ÖµÄ´ÎÊı;2byte:ÊÇ·ñÁìÈ¡¹ıÓñÊ¯

function OnDeath(monsterNpcIdx)
    local killerIdx = PlayerIndex                            --É±ËÀ¹ÖµÄÍæ¼ÒµÄidx
    local killerID = GetPlayerID()                             --É±ËÀ¹ÖµÄÍæ¼ÒµÄID 
    local playerID = GetNpcTask(monsterNpcIdx, 0)             --ÊÍ·Å¹ÖµÄÍæ¼ÒµÄID
    local playerCredit = GetNpcTask(monsterNpcIdx, 1)         --ÊÍ·Å¹ÖµÄÍæ¼ÒµÄÉùÍû
    local TargetNpcIdx = GetNpcTask(monsterNpcIdx, 2)         --ËşµÄidx

    local number = GetNpcTask(TargetNpcIdx, 5)               --Ê£Óà¹ÖµÄÊıÁ¿
    local killerCredit                                       --É±ËÀ¹ÖµÄÍæ¼ÒÊÇÏÉ»¹ÊÇÄ§£¬1±íÊ¾ÏÉ£¬0±íÊ¾Ä§

    if (GetJusticEvilCredit() > 0) then
        killerCredit = 1
    else
        killerCredit = 0
    end

    local id, x, y = GetNpcWorldPos(monsterNpcIdx)
    if (GetNpcTask(TargetNpcIdx, 6) + 180 >= SystemTime()) then
        --ÈôÔÚ3·ÖÄÚ
        if (killerID == playerID) then
            --É±ËÀÊôÓÚ×Ô¼ºµÄ¹Ö 
            PlayerIndex = SearchPlayerById(playerID)

            number = number - 1
            SetNpcTask(TargetNpcIdx, 5, number)
            local refreshTimes = GetTaskByte(killTimes, 1)            --ÊÍ·ÅËşµÄÍæ¼ÒÉ±ËÀÊôÓÚ×Ô¼º¹ÖµÄÅú´Î
            refreshTimes = refreshTimes + 1
            SetTaskByte(killTimes, 1, refreshTimes)

            --Msg2Player("»¹Ê£Óà"..number.."Ö»ìåÄ§Ã»ÓĞ³¬¶È")

            local isDropStone = GetTaskByte(killTimes, 2)            --Íæ¼ÒÊÇ·ñÁì¹ıÓñÊ¯
            if (refreshTimes <= 10 and isDropStone == 0 and number < 3) then
                MonsterDrop(monsterNpcIdx, TargetNpcIdx)            --¹ÖÎïµôÂä
            end
            --------Add by gaojingwei at 2009/05/11 start ---------------
            if (GetNpcTask(TargetNpcIdx, 1) >= 15 and GetNpcTask(TargetNpcIdx, 1) <= 18) then
                if (number == 0) and (GetNpcTask(TargetNpcIdx, 9) == 0) then
                    local id1, x1, y1 = GetNpcWorldPos(TargetNpcIdx)
                    local id2, x2, y2 = GetWorldPos()

                    if (id1 == id2) then
                        --Èç¹û¼¤»îËüµÄÍæ¼ÒÔÚµ±Ç°µØÍ¼
                        SetNpcTask(TargetNpcIdx, 0, 0)                      --Ëş±äÎªÎ´¼¤»î×´Ì¬
                        DelNpcTimer(TargetNpcIdx)                          --È¡Ïû¶¨Ê±

                        SetTaskByte(task_renwu, 3, 0)
                        SetTaskByte(task_renwu, 4, 1)
                        RemoveIBBuff(515)
                        TaskNote(1026, 4)
                        Msg2Player("§· siªu ®é thµnh c«ng tÊt c¶ Phi Thè Ma, vÒ gÆp N÷ Oa n­¬ng n­¬ng nhËn th­ëng")
                    end
                end
            end
            --------Add by gaojingwei at 2009/05/11 end------------------
            PlayerIndex = killerIdx
        elseif (killerCredit == playerCredit) then
            --Í¬ÕóÓªÉ±ËÀ²»ÊôÓÚ×Ô¼ºµÄ¹Ö
            local temp = random(1, 100)
            if (temp <= 20) then
                number = number - 1
                SetNpcTask(TargetNpcIdx, 5, number)
                --------Add by gaojingwei at 2009/05/15 start ---------------

                if (GetNpcTask(TargetNpcIdx, 1) >= 15 and GetNpcTask(TargetNpcIdx, 1) <= 18) then
                    if (number == 0) then
                        local id1, x1, y1 = GetNpcWorldPos(TargetNpcIdx)
                        local id2, x2, y2 = GetWorldPos()
                        local pld = SearchPlayerById(playerID)

                        if (id1 == id2) and (pld > 0) and (GetNpcTask(TargetNpcIdx, 9) == 0) then
                            --Èç¹û¼¤»îËüµÄÍæ¼ÒÔÚµ±Ç°µØÍ¼
                            PlayerIndex = pld
                            SetNpcTask(TargetNpcIdx, 0, 0)                      --Ëş±äÎªÎ´¼¤»î×´Ì¬
                            DelNpcTimer(TargetNpcIdx)                          --È¡Ïû¶¨Ê±

                            SetTaskByte(task_renwu, 3, 0)
                            SetTaskByte(task_renwu, 4, 1)
                            RemoveIBBuff(515)
                            TaskNote(1026, 4)
                            Msg2Player("§· siªu ®é thµnh c«ng tÊt c¶ Phi Thè Ma, vÒ gÆp N÷ Oa n­¬ng n­¬ng nhËn th­ëng")
                        end
                    end
                end
                PlayerIndex = killerIdx
                --------Add by gaojingwei at 2009/05/15 end------------------
            else

                local pld = SearchPlayerById(playerID)
                if (pld > 0) then
                    --ÈôÍæ¼Ò²»ÔÚÏßÔò·µ»Ø£¬²»ÔÙË¢¹Ö

                    PlayerIndex = pld

                    number = number - 1
                    local k = AddNpc(810, 15, SubWorldID2Idx(id), x * 32, y * 32)            --?Ôö¼ÓÒ»Ö»¹Ö 
                    SetNpcScript(k, "\\script\\npcdeath\\ìåÄ§ËÀÍö.lua")            --?°ó¶¨½Å±¾
                    SetNpcName(k, GetName() .. "Phi Thè Ma")

                    local lifetime = 180 - (SystemTime() - GetNpcTask(TargetNpcIdx, 6))
                    if (lifetime <= 0) then
                        lifetime = 1
                    end
                    SetNpcTimer(k, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lifetime)

                    --Éè¶¨ËûµÄÖ÷ÈË
                    SetNpcTask(k, 0, playerID)
                    SetNpcTask(k, 1, playerCredit)
                    SetNpcTask(k, 2, TargetNpcIdx)

                    number = number + 1
                    SetNpcTask(TargetNpcIdx, 5, number)
                    PlayerIndex = killerIdx

                end

            end
        elseif (killerCredit ~= playerCredit) then
            --²»Í¬ÕóÓªÉ±ËÀ¹Ö
            number = number - 1
            for i = 1, 2, 1 do
                if (number >= 30) then
                    break
                end

                local pld = SearchPlayerById(playerID)
                if (pld > 0) then
                    --ÈôÍæ¼Ò²»ÔÚÏßÔò·µ»Ø£¬²»ÔÙË¢¹Ö

                    PlayerIndex = pld

                    local k = AddNpc(810, 15, SubWorldID2Idx(id), x * 32, y * 32)            --?Ôö¼ÓÒ»Ö»¹Ö 
                    SetNpcScript(k, "\\script\\npcdeath\\ìåÄ§ËÀÍö.lua")                --?°ó¶¨½Å±¾
                    SetNpcName(k, GetName() .. "Phi Thè Ma")

                    local lifetime = 180 - (SystemTime() - GetNpcTask(TargetNpcIdx, 6))
                    if (lifetime <= 0) then
                        lifetime = 1
                    end
                    SetNpcTimer(k, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lifetime)

                    --Éè¶¨ËûµÄÖ÷ÈË
                    SetNpcTask(k, 0, playerID)
                    SetNpcTask(k, 1, playerCredit)
                    SetNpcTask(k, 2, TargetNpcIdx)
                    number = number + 1

                end

            end
            PlayerIndex = killerIdx
            SetNpcTask(TargetNpcIdx, 5, number)
        end
    end
    DelNpc(monsterNpcIdx)
end

function MonsterDrop(monsterNpcIdx, TargetNpcIdx)
    --¹ÖÎïµôÂä
    local playerID = GetNpcTask(TargetNpcIdx, 4)                                --¼¤»îËşµÄÍæ¼ÒµÄidx
    local pld = SearchPlayerById(playerID)
    if (pld > 0) then
        --ÈôÍæ¼Ò²»ÔÚÏßÔò·µ»Ø£¬²»ÔÙË¢¹Ö
        PlayerIndex = pld
    else
        return
    end

    local t = random(1, 150)
    if (t == 1) then
        local r = random(1, 20)
        if (r >= 1 and r <= 14) then
            --µÃµ½2¼¶ÓñÊ¯
            local s = random(0, 2)
            s = 254 + s * 7
            ThrowItem(monsterNpcIdx, PlayerIndex, 3, s, 0, 0, 0, 0)
        elseif (r >= 15 and r <= 19) then
            --µÃµ½3¼¶ÓñÊ¯
            local s = random(0, 2)
            s = 255 + s * 7
            ThrowItem(monsterNpcIdx, PlayerIndex, 3, s, 0, 0, 0, 0)
        else
            --µÃµ½4¼¶ÓñÊ¯
            local s = random(0, 2)
            s = 256 + s * 7
            ThrowItem(monsterNpcIdx, PlayerIndex, 3, s, 0, 0, 0, 0)
        end
        SetTaskByte(killTimes, 2, 1)                            --±íÊ¾ÒÑ¾­µôÂä¹ıÓñÊ¯
        Msg2Player("r¬i ra 1 B¶o Th¹ch ch­a mµi s¸ng")
        --	ScrollMessage("µôÂäÒ»Î´¿ª¹âÓñÊ¯")
    end
end
