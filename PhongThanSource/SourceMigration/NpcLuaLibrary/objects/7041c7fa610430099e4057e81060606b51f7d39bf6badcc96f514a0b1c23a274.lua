--description: ÓÄ¼Å(¼ÀÔ¨¹È)
--author: liujifang
--date: 2013-03-12

gItemGen = 8
gItemDetail = 1453
gItemPart = 2

Task_ItemNum = 1853  --1byte:Á¬ÐøÎ´³öÖÐ¸ß¼¶µµ½±ÀøµÄ´ÎÊý£»3byte:»ñµÃ´ó½±µÄ´ÎÊý£»4byte:Á¬ÐøÎ´»ñµÃ´ó½±µÄ´ÎÊý
Task_KillNum = 1854  --ÁÔÉ±npcµÄ´ÎÊý

function OnDeath(nNpcIdx)
    if (PlayerIndex <= 0) then
        --·ÇÈË´òËÀ
        return
    end

    local nKillNum = GetTask(Task_KillNum) + 1
    local logStr = ""
    SetTask(Task_KillNum, nKillNum)

    CancelNpcBelonger(nNpcIdx)
    NpcPolyMorph(nNpcIdx, -1)
    NpcRemoveIBBuff(nNpcIdx, 1459)

    ThrowItem(nNpcIdx, PlayerIndex, 6, 1, 954, 1, 0, 0, 1)  --ÓÄ¼ÅÒÅÎï
    --¶îÍâ½±Àø
    AddIBBuff(1455)
    if (HaveIBBuff(1455) >= 1 and GetIBBuffTimes(1455) >= 10) then
        AddNormalItemBind(6, 1, 942, 1, 0, 0, 1)
        Msg2Player("NhËn thªm 1 Linh Hån TÕ PhÈm.")
        ScrollMessage("NhËn thªm 1 Linh Hån TÕ PhÈm.")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c> Siªu ®é U TÞch trong TÕ Uyªn Cèc, nhËn ®­îc 1 Linh Hån TÕ PhÈm.")
        logStr = logStr .. "Linh Hån TÕ PhÈm"
        for i = 1, 10 do
            RemoveIBBuff(1455)
        end
    end
    WriteLog("TÕ Uyªn Cèc: giÕt" .. nKillNum .. ".")
end;

function RndProbabilityTable(t)
    if type(t) == "table" then
        local count = getn(t)
        local sum = 0
        local rnd = random(1, 10000)
        for i = 1, count do
            local probability = t[i][1]
            sum = sum + probability
            if rnd <= sum then
                return i
            end
        end
        return 0
    else
        return nil
    end
end