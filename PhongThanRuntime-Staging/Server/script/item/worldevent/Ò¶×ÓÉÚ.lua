snake_npcIndex = 1401
snake_npcID = 1402

function main()
    if (HaveIBBuff(513) == 0) then
        Talk(1, "no", "Linh Xµ khÝ ®· tiªu trõ, xin h·y tiÕp tôc ®Õn Linh Xµ thô triÖu gäi Linh Xµ")
        return
    end

    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (UTask_Knight == 134) or (UTask_Wizard == 134) or (UTask_Druid == 134) then
        local npcid = GetTask(snake_npcID)
        local npcidx = GetTask(snake_npcIndex)
        if (npcid ~= math.mod(GetNpcID(npcidx), 2 ^ 31)) then
            Msg2Player("Linh Xµ khÝ ®· tiªu trõ, xin h·y tiÕp tôc ®Õn Linh Xµ thô triÖu gäi Linh Xµ")
            return 0
        end

        local sm, sx, sy = GetNpcWorldPos(npcidx)
        local mapid, x, y = GetWorldPos()
        if (sm ~= mapid) then
            Msg2Player("DiÖp Tö Tiªu lµ b¶o vËt cña Tiªn Ma giíi, chØ cã thÓ sö dông ë <c=g>BÊt Chu Thiªn quan<c>!")
            return 0
        end

        if ((x - sx) ^ 2 + (y - sy) ^ 2 > 150 ^ 2) then
            Msg2Player("Cù ly so víi Linh Xµ, DiÖp Tö Tiªu kh«ng thÓ triÖu gäi Linh Xµ!")
            return 0
        end

        if (x - sx == 0) and (y - sy == 0) then
            x = sx + math.random(1, 4)
            y = sy + math.random(1, 4)
        end

        local seamDistance = math.floor(math.sqrt((x - sx) ^ 2 + (y - sy) ^ 2))
        local seamX = 5 * ((x - sx) / seamDistance)
        local seamY = 5 * ((y - sy) / seamDistance)
        NpcRun(npcidx, sx + seamX, sy + seamY)

        local r = (1959 - sx) ^ 2 + (3312 - sy) ^ 2
        if (r <= 400) then
            local sl = AddNpc(806, 1, SubWorld, sx * 32, sy * 32)
            SetNpcTimer(sl, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 5)
            SetNpcName(sl, ("<c=g>" .. GetName() .. "<c> gäi ra Linh Xµ"))
            SetNpcScript(sl, "\\script\\item\\worldevent\\ÁéÉß.lua")
            SetNpcTask(sl, 1, math.mod(GetUUID(s), 2 ^ 31))
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 135)
                TaskNote(86, 5)
            elseif (pt == 1) then
                SetTask(1, 135)
                TaskNote(87, 5)
            else
                SetTask(2, 135)
                TaskNote(88, 5)
            end ;
            Msg2Player("Linh Xµ ®· lé ra b¶n tÝnh hung tµn, ph¶i chÝnh phôc ®­îc nã míi nhËn ®­îc V¶y r¾n!")
            TopMessage("Chinh phôc thµnh c«ng Linh Xµ, nhËn ®­îc V¶y r¾n!")
            RemoveIBBuff(513)
            AddIBBuff(513, 300)
            DelNpc(npcidx)
        end
    end
end

function no()
    CloseDialog()
end
