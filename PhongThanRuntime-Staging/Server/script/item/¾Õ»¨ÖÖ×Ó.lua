Task_chongyang = 1581

Task_cy_jiangli = 1582

Task_cy_zhuyuxn = 1583

function main()
    local progress = GetTaskByte(Task_chongyang, 1)
    local membercount = 1
    local oldindex = PlayerIndex
    if (progress == 1) then
        if (GetTeam() ~= 0) then
            membercount = GetTeamSize()
            if (IsCaptain() == 0) then
                Talk(1, "no", "ChØ cã ®éi tr­ëng míi cã thÓ trång h¹t")
                return
            end
        end

        local w1, x1, y1 = GetWorldPos()
        if (w1 == 21) then

            if (membercount > 3) then
                Talk(1, "no", "Nh©n sè trong ®éi tèi ®a chØ lµ 3 ng­êi!")
                return
            end

            if (GetTeam() ~= 0) then

                for i = 1, membercount, 1 do
                    local newindex = GetTeamMember(i)
                    if (PlayerIndex ~= newindex) then
                        PlayerIndex = newindex

                        if (GetTaskByte(Task_chongyang, 1) == 1) then
                            Talk(1, "no", "B¹n ®ang tham gia ho¹t ®éng, vui lßng hoµn thµnh hoÆc hñy bá tham gia, sau ®ã tæ ®éi míi cã thÓ tham gia ho¹t ®éng l¹i tõ ®Çu.")
                            PlayerIndex = oldindex
                            Talk(1, "no", "Trong ®éi cã thµnh viªn ®ang tham gia ho¹t ®éng.")
                            return
                        end

                        if (GetLevel() < 30) then
                            Talk(1, "no", "B¹n ch­a ®¹t cÊp 30, kh«ng thÓ tham gia ho¹t ®éng.")
                            PlayerIndex = oldindex
                            Talk(1, "no", "Trong nhãm cña b¹n cã thµnh viªn ch­a ®¹t cÊp 30")
                            return
                        end

                        local onlinetime = GetOnlineTime(1)
                        if (onlinetime < 60 * 60) then
                            Talk(1, "no", "Thêi gian online ch­a ®ñ 1 tiÕng, kh«ng thÓ tham gia ho¹t ®éng")
                            PlayerIndex = oldindex
                            Talk(1, "no", "Trong ®éi cã thµnh viªn online ch­a ®ñ 1 giê!")
                            return
                        end

                        local wdy, xdy, ydy = GetWorldPos()
                        if (wdy ~= 21) then
                            Talk(1, "no", "HiÖn t¹i b¹n kh«ng ë TriÒu Ca, kh«ng thÓ tham gia ho¹t ®éng")
                            PlayerIndex = oldindex
                            Talk(1, "no", "Trong ®éi cã thµnh viªn kh«ng ë TriÒu Ca.")
                            return
                        end

                        if (GetTaskByte(Task_chongyang, 2) >= 10) then
                            Talk(1, "no", "B¹n ®· dïng hÕt sè lÇn tham gia ho¹t ®éng trong h«m nay, kh«ng thÓ tiÕp tôc tham gia.")
                            PlayerIndex = oldindex
                            Talk(1, "no", "Trong ®éi cã thµnh viªn ®· thùc hiÖn ®ñ sè lÇn ho¹t ®éng trong ngµy!")
                            return
                        end
                    end
                end
            end

            PlayerIndex = oldindex

            local npcidx = AddNpc(1471, 1, SubWorldID2Idx(21), x1 * 32, y1 * 32)
            SetNpcName(npcidx, GetName() .. "_Tr©u Cóc")
            SetNpcScript(npcidx, "\\script\\»î¶¯½Å±¾\\³û¾Õ.lua")
            SetNpcTimer(npcidx, "\\script\\ontimer\\³û¾Õ.lua", 30)

            local curName = GetName()

            local PID = GetPlayerID()
            local num = 3
            SetNpcTask(npcidx, 1, membercount)
            SetNpcTask(npcidx, 2, 1)
            SetNpcTask(npcidx, 3, PID)
            SetNpcTask(npcidx, 6, 0)
            SetNpcTask(npcidx, 19, 1)
            SetNpcTask(npcidx, 20, LocalSystemTime())
            local localday = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
            SetNpcTask(npcidx, 21, localday)
            SetNpcTask(npcidx, 22, GetTaskByte(Task_chongyang, 2))

            if (GetTeam() ~= 0) then
                for i = 1, membercount, 1 do
                    local newindex = GetTeamMember(i)
                    if (PlayerIndex ~= newindex) then
                        PlayerIndex = newindex
                        local anotherID = GetPlayerID()
                        local tasknums = GetTaskByte(Task_chongyang, 2) + 1
                        num = num + 1
                        SetNpcTask(npcidx, num, anotherID)
                        SetTaskByte(Task_chongyang, 1, 1)
                        SetTaskByte(Task_chongyang, 2, tasknums)
                        AddIBBuff(1046)

                        if (HaveIBBuff(1338) > 0) then
                            RemoveIBBuff(1338)
                        end
                        AddIBBuff(1338, 30)
                        TaskNote(1621, 1, curName)
                        InfoBox("§ång ®éi cña b¹n <c=g>" .. curName .. "<c> ®ang tr¶ lêi, vui lßng ®îi.")

                        if (num == 4) then
                            SetNpcTask(npcidx, 23, GetTaskByte(Task_chongyang, 2))
                        else
                            SetNpcTask(npcidx, 24, GetTaskByte(Task_chongyang, 2))
                        end
                        PlayerIndex = oldindex
                    end
                end
            end
            AddIBBuff(1046)

            if (HaveIBBuff(1338) > 0) then
                RemoveIBBuff(1338)
            end
            AddIBBuff(1338, 30)
            TaskNote(1621, 1, "B¹n")

            DelNormalItem(6, 1, 723, 1)
            Msg2Team("Tr©u Cóc ®· trång! Xin l­u ý c¸c c©u hái cña hÖ thèng ®Ó tr¶ lêi ®óng!")
            Msg2Player("§· ®Õn l­ît b¹n tr¶ lêi c©u hái ®Çu tiªn! Xin nhÊp vµo Tr©u Cóc, néi trong 30 gi©y ph¶i tr¶ lêi c©u hái.")
        else
            Talk(1, "no", "H¹t Hoa Cóc chØ cã thÓ trång trong néi thµnh TriÒu Ca.")
        end
    else
        Talk(1, "no", "ChØ cã h¹t Hoa Cóc nhËn trong ho¹t ®éng tiÕt Trïng D­¬ng míi cã thÓ sö dông.")
    end

end

function no()
    CloseDialog()
end
