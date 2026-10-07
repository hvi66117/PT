Double_Optimization = 1697
function OnDeath(c)
    if (PlayerIndex > 0) then
        local circle1 = GetByte(GetTask(1013), 3)

        local npcTGIdx = GetTask(1017)
        if (npcTGIdx == c) then
            if (circle1 == 7) then
                local logstr = "[NhËn ®­îc]»ê"
                local r = math.random(1, 100)
                if (r <= 12) then
                    AddNormalItemPile(3, 134, 0, 0, 0, 0)
                    TopMessage(13294)
                    Msg2Player("§¸nh b¹i Thiªn C­¬ng Tinh, nhËn ®­îc 1 Ph¸ch.")
                    logstr = logstr .. "+ÆÇ"
                end
                SetTask(1013, SetByte(GetTask(1013), 3, 0))
                Msg2Player("§¸nh b¹i Thiªn C­¬ng Tinh, nhËn ®­îc 1 Hån.")
                TaskNote(53, 8)
                AddNormalItemPile(3, 133, 0, 0, 0, 0)

                local weekDay = GetWeekDay()
                if (GetTaskByte(Double_Optimization, 3) < 8) then
                    if (GetTaskByte(Double_Optimization, 3)) > 0 then
                        AddNormalItemPile(3, 133, 0, 0, 0, 0)
                        Msg2Player("B¹n ®· nhËn phÇn th­ëng nh©n ®«i, bÊt ngê nhËn ®­îc 1 Hån")
                        ScrollMessage("B¹n ®· nhËn phÇn th­ëng nh©n ®«i, bÊt ngê nhËn ®­îc 1 Hån")
                        logstr = logstr .. "+Ë«±¶¾­ÑéÖÜ-»ê"
                    end
                    if (weekDay == 1) then

                        Msg2Player("H«m nay lµ chñ ®Ò Thiªn Cang Chi Hån, chóc mõng nhËn thªm 1 hån")
                        logstr = logstr .. "+Ö÷ÌâÈÕ"
                        local nDoubel = 1
                        local nDoubleBuff = 1480

                        if (HaveIBBuff(1523) > 0) then
                            nDoubel = nDoubel + 1
                            CostIBBuff(1523, 1)
                            Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                            logstr = logstr .. "+Ö÷Ìâ·û"
                        end

                        local bHaveBuff = HaveIBBuff(nDoubleBuff)
                        local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                        if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                            nDoubel = nDoubel + nBuffLevel
                            Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                            logstr = logstr .. "+Ö÷Ìâ×´Ì¬"
                        end
                        for i = 1, nDoubel do
                            AddNormalItemPile(3, 133, 0, 0, 0, 0)
                        end
                        logstr = logstr .. "-»ê" .. nDoubel

                    end

                elseif (GetTaskByte(Double_Optimization, 3) >= 8) then
                    local nTemp = GetTaskByte(Double_Optimization, 3)
                    nTemp = SetBit(nTemp, 6, 0)
                    SetTaskByte(Double_Optimization, 3, nTemp)
                end

                SetTaskWord(1014, 1, 0)
                SetTask(1014, 0)
                SetTask(1017, 0)
                TopMessage(13295)
                WriteLog("[Ììî¸Ö®»ê][Ììî¸ÐÇ]" .. logstr)
            end
        else
            local h, m, s = GetHMS()
            local w, x, y = GetNpcWorldPos(c)
            WriteLog("[Ììî¸Ö®»ê][Ììî¸ÐÇ±»ÇÀ]Ê±¼ä: " .. h .. "/" .. m .. "/µØÍ¼ºÅ" .. w)
        end
    end
    DelNpc(c)
end;
