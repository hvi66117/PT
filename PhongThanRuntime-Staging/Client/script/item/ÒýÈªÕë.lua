Task_GoAstray = 1541
WanZhaoShou_ID = 228
WanZhaoShou_Index = 253

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 },
    [1] = { task = 1, note = 87 },
    [2] = { task = 2, note = 88 },
}

function main()

    local taskGoAstray = GetTaskByte(Task_GoAstray, 1)
    if (taskGoAstray == 1) then
        local oldnpcidx = GetGlobalValue(WanZhaoShou_Index)
        if (oldnpcidx ~= 0) then
            local oldnpcid = GetGlobalValue(WanZhaoShou_ID)
            if (GetNpcID(oldnpcidx) == oldnpcid) then
                Msg2Player("V¹n Tr¶o Thó ®· xuÊt hiÖn! Anh hïng h·y nhanh tay diÖt trõ!")
                Talk(1, "no", "V¹n Tr¶o Thó ®· xuÊt hiÖn! Anh hïng h·y nhanh tay diÖt trõ!")
                return
            end
        end

        if (HaveIBBuff(786) == 0) then
            Talk(1, "no", "CÇn ph¶i cã m¸u cña Ninh Miªu vµ Sãi, míi cã thÓ dÉn dô ®­îc môc tiªu!")
            return
        end

        if (CheckArea() == 0) then
            Talk(1, "no", "Ph¶i ®Õn gÇn TuyÒn Nh·n sö dông, cù ly qu¸ xa!")
            return
        end

        if (HaveIBBuff(786) > 0) then

            local idx, x, y = GetWorldPos()
            local newnpcidx = AddNpc(1230, 75, SubWorldID2Idx(idx), x * 32, y * 32 + 20)

            SetAIScript(newnpcidx, "\\script\\ai\\Íò×¦ÊÞboss.lua")
            SetNpcScript(newnpcidx, "\\script\\npcdeath\\ÏÉÄ§\\Íò×¦ÊÞ.lua")
            SetNpcTimer(newnpcidx, "\\script\\ontimer\\Íò×¦ÊÞÉ¾µô×Ô¼º.lua", 1500)
            WriteLog("TriÖu håi ra 1 V¹n Tr¶o Thó")

            local newnpcid = GetNpcID(newnpcidx)
            SetGlobalValue(WanZhaoShou_Index, newnpcidx)
            SetGlobalValue(WanZhaoShou_ID, newnpcid)

            if (GetTeam() ~= 0) then
                local oldPlayer = PlayerIndex
                local membercount = GetTeamSize()

                for i = 1, membercount do
                    PlayerIndex = GetTeamMember(i)

                    local mapid, x, y = GetWorldPos()
                    if (mapid == 76) then
                        ClearBuff()
                    end
                end
                PlayerIndex = oldPlayer
            else
                ClearBuff()
            end

        end

    elseif (taskGoAstray == 2) then
        Talk(1, "no", "Anh hïng ®· thu phôc thµnh c«ng V¹n Tr¶o Thó, mau vÒ phôc mÖnh!")
    else
        Talk(1, "no", "B¹n ch­a tiÕp nhËn nhiÖm vô!")
    end

end

function ClearBuff()
    RemoveIBBuff(784)
    RemoveIBBuff(785)
    RemoveIBBuff(786)
end

function no()
    CloseDialog()
end

function CheckArea()
    local idx, x, y = GetWorldPos()
    local nDis = math.sqrt((x - 1960) ^ 2 + (y - 3331) ^ 2)
    if (nDis <= 40) then
        return 1
    else
        return 0
    end
end
