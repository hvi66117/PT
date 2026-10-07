TeamChk = 1175
LuckyNum = 1176
BossMark = 1177

function OnDeath(c)
    if (GetTeam() ~= 0) then
        local number = GetTeamSize()
        local oldPlayer = PlayerIndex
        for i = 1, number do
            PlayerIndex = GetTeamMember(i)
            local numbermark = GetTask(TeamChk) / number
            local mapId, posX, posY = GetWorldPos();
            if (mapId ~= 14) then
                PlayerIndex = oldPlayer
                DelNpc(c)
                return
            end
            if (numbermark ~= GetNpcID(c)) then
                PlayerIndex = oldPlayer
                DelNpc(c)
                return
            end
        end
        PlayerIndex = oldPlayer
        jiangli(c)
    end
    DelNpc(c)
end

function jiangli(npcIdx)
    local oldPlayer = PlayerIndex
    local number = GetTeamSize()
    if (number == 0) then
        return
    end
    local obj = PlayerIndex
    local mark = math.random(1, 10000)
    for i = 1, number do
        PlayerIndex = GetTeamMember(i)
        if (GetNpcID(npcIdx) == GetTask(BossMark)) then
            local lucky = GetTask(LuckyNum)
            local luckstrike = 0
            if (lucky <= 10) then
                luckstrike = lucky
            elseif (lucky <= 20) then
                luckstrike = (lucky - 10) * 2 + 10
            elseif (lucky <= 30) then
                luckstrike = (lucky - 20) * 5 + 30
            elseif (lucky <= 40) then
                luckstrike = (lucky - 30) * 10 + 80
            else
                luckstrike = (lucky - 40) * 20 + 180
            end
            if (luckstrike > 1000) then
                luckstrike = 1000
            end
            if (mark <= luckstrike) then
                local i = math.random(3, 5)
                if (math.random(1, 1000) <= 500) then
                    ThrowItem(npcIdx, -1, 0, 2, i, 7, 0, 0)
                    WriteLog("R¬i ra Lôc Trang Gi¸p cÊp 80")
                else
                    ThrowItem(npcIdx, -1, 0, 9, i, 7, 0, 0)
                    WriteLog("R¬i Lôc Phi Phong cÊp 80")
                end
                SetTask(LuckyNum, 0)
                AddGlobalCountNews("Anh hïng thiÕu niªn <c=g>" .. GetName() .. "<c> hµng phôc Niªn Thó tù m×nh gäi ra, nhËn ®­îc 1 <c=r>trang bÞ lôc cÊp 80<c>!", 3)
            end
        end
    end
    PlayerIndex = oldPlayer
    local mark1 = math.random(1, 1000)
    if (mark1 <= 50) then
        ThrowItem(npcIdx, -1, 8, 424, 2, 0, 0, 0)
    else
        ThrowItem(npcIdx, -1, 8, 235, 2, 0, 0, 0)
    end
    local mark2 = math.random(1, 1000)
    if (mark2 <= 50) then
        ThrowItem(npcIdx, -1, 6, 0, 345, 1, 0, 0)
    elseif (mark2 <= 500) then
        ThrowItem(npcIdx, -1, 6, 0, 184, 1, 0, 0)
    else
        ThrowItem(npcIdx, -1, 6, 0, 20, 1, 0, 0)
    end
end
