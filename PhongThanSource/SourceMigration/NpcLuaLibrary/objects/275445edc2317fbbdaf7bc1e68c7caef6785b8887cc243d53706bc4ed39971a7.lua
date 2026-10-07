Task_baichuan = 1364
Global_luohou = 180

Tower_Camp = {
    { desc = "Canh Th­¬ng" },
    { desc = "Quú Vò" },
}

function OnDeath(npcidx)
    local killSuccess = 0
    killSuccess = processKillNpc(npcidx)
    SetGlobalValue(Global_luohou, 0)
    if (killSuccess == 0) then
        aborteKillNpc(npcidx)
    end

    DelNpc(npcidx)
end;

function processKillNpc(npcidx)
    local gdCamp = 1
    local credit = GetJusticEvilCredit()

    if (credit < 0) then
        gdCamp = 2
    end

    if (GetPlayerExtLevel() >= 47 and GetTaskByte(Task_baichuan, 1) == 4 and GetNpcTask(npcidx, 1) == GetPlayerID()) then
        SetTaskByte(Task_baichuan, 1, 5)
        TaskNote(1037, 6, Tower_Camp[gdCamp].desc)
        Msg2Player("La HÇu ®· bÞ tiªu diÖt, cã thÓ ®i phôc mÖnh råi.")
        TopMessage("§· ®¸nh b¹i <c=g>La HÇu<c>")
        return 1
    end
    return 0
end

function aborteKillNpc(npcidx)
    local bindPlayerID = GetNpcTask(npcidx, 1)
    local playerIdx = SearchPlayerById(bindPlayerID)
    if (playerIdx > 0) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = playerIdx
        Msg2Player("Ch­a tËn tay diÖt trõ La HÇu, h¾n cã thÓ håi sinh, h·y ®i t×m Thiªn Nh¹c Tr­ëng L·o.")
        TopMessage("NhiÖm vô B¸ch Xuyªn Huy Tô thÊt b¹i")

        local gdCamp = 1
        local credit = GetJusticEvilCredit()
        if (credit < 0) then
            gdCamp = 2
        end

        TaskNote(1037, 7, Tower_Camp[gdCamp].desc)
        PlayerIndex = playerIndexCache
    end
end
