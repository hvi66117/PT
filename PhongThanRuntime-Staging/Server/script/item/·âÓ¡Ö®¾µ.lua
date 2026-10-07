Task_Outoftree = 1478

ID_SoulofDevil = 1113
ID_PK_Xiaolei = 1108

global_PKXiaolei_Flag = 215
global_PKXiaolei_index = 217

function main(l, t, npcindex)
    local Outoftree_step = GetTaskByte(Task_Outoftree, 1)
    if (Outoftree_step >= 10) then
        Talk(1, "no", "Do b¹n ®· hoµn thµnh TiÕt Ngo¹i Sinh Chi, nªn Cæ KÝnh bÞ tiªu t¸n søc m¹nh, vì vôn thµnh tro bôi r¬i v·i kh¾p trÇn gian...")
        ClearItem(6, 1, 524, 0)
        return
    end

    if GetPlayerExtLevel() < 59 then
        Talk(1, "no", "Cæ kÝnh tiÒm chøa søc m¹nh cña c¸c lùc thÇn th­îng cæ")
        return
    end

    if Outoftree_step <= 1 then
        Talk(1, "no", "Cæ kÝnh tiÒm chøa søc m¹nh cña c¸c lùc thÇn th­îng cæ")
        return
    end

    if (Outoftree_step == 2) then
        Talk(2, "outtree", "Mét ©m thanh phiªu diªu: Anh hïng ®õng lÊy lµm l¹, ®ã lµ Ngò ¢m Täa.§inh Huy...", GetName() .. "Th× ta lµ vËy, nh­ng TiÕu L«i qu¶ lµ lîi h¹i, e r»ng ta còng kh«ng ph¶i ®èi thñ cña h¾n.")
        return
    end

    local TypeofSoul = GetNpcTask(npcindex, 1)
    local m, x, y = GetWorldPos()

    if (Outoftree_step == 3) then
        if (HaveIBBuff(699) == 0) then
            Msg2Player("Ngò ¢m Täa.§inh Huy ch­a hé thÓ, h·y sö dông Phong Ên KÝnh lÇn n÷a ®Ó «ng ta hé thÓ.")
            SetTaskByte(Task_Outoftree, 1, 2)
            TaskNote(108, 16)
        else

            if (GetFightState() == 0) then
                Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
                return
            end

            if (m ~= 75) then
                Msg2Player("Phong Ên KÝnh chØ cã thÓ  b¾t lÊy hån ma thó cña qu¸i ë Ngôc Ph¸p s¬n.")
                return
            end

            if (npcindex == 0) then
                Msg2Player("ChØ chuét ph¶i vµo ng­êi hån Ma thó míi cã thÓ x¸c ®Þnh môc tiªu")
                return
            end

            if (GetNpcTemplateID(npcindex) ~= ID_SoulofDevil) then
                Msg2Player("Phong Ên KÝnh chØ cã thÓ dïng ®Ó b¾t hån ph¸ch cña 3 lo¹i qu¸i ë Ngôc Ph¸p s¬n.")
                return
            end

            local Mapid, x_soul, y_soul = GetNpcWorldPos(npcindex)
            local distance = ((x_soul - x) ^ 2 + (y_soul - y) ^ 2) ^ 0.5 * 32
            distance = math.floor(distance)
            if distance > 350 then
                Msg2Player("B¹n c¸ch qu¸ xa môc tiªu.")
                return
            end

            if (TypeofSoul == 1) then

                if (GetTaskByte(Task_Outoftree, 2) == 1) then
                    ScrollMessage(" Kh«ng thÓ phong Ên")
                    Msg2Player("B¹n ®· phong Ên hån Thõa Hoµng, kh«ng thÓ phong Ên lÇn n÷a.")
                    return
                else
                    AddProcessBar(npcindex)
                end
            elseif (TypeofSoul == 2) then

                if (GetTaskByte(Task_Outoftree, 3) == 1) then
                    ScrollMessage(" Kh«ng thÓ phong Ên")
                    Msg2Player("B¹n ®· phong Ên hån Lª Linh Thi, kh«ng thÓ phong Ên lÇn n÷a.")
                    return
                else
                    AddProcessBar(npcindex)
                end
            elseif (TypeofSoul == 3) then

                if (GetTaskByte(Task_Outoftree, 4) == 1) then
                    ScrollMessage(" Kh«ng thÓ phong Ên")
                    Msg2Player("B¹n ®· phong Ên hån S¬n HÇu, kh«ng thÓ phong Ên lÇn n÷a.")
                    return
                else
                    AddProcessBar(npcindex)
                end
            end
        end
        return
    end

    if (Outoftree_step == 4) then

        SetTaskByte(Task_Outoftree, 1, 5)
        SetSubTask(108, -1, 1)
        local addexp = AddOwnExtendExp(3150000)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc " .. addexp .. "Sau khi b¹n ®Õn cÊp 60 h·y t×m TiÕu L«i.")
        Talk(2, "no", "Anh hïng hµnh sù nhanh chãng, qu¶ lµ bËc kú tµi. Giê ta dïng c«ng lùc ngµn n¨m truyÒn cho anh hïng, ®Ó gióp anh hïng chÕ ngù TiÕu L«i.", "KÝnh nµy rÊt m¹nh, ta cÇn thêi gian, míi cã thÓ chuyÓn søc m¹nh cña nã, ®Õn khi anh hïng ®Õn cÊp 60, cã thÓ cïng ta th¶o luËn c¸ch chÕ ngù TiÕu L«i.")
        TaskNote(108, 10)
        return
    end

    if (Outoftree_step == 5) then
        if (GetPlayerExtLevel() < 60) then

            Msg2Player("Sau khi b¹n tíi cÊp 60 h·y ®Õn t×m TiÕu L«i.")
            TaskNote(108, 10)
            InfoBox("Anh hïng ®õng qu¸ gÊp, ta cßn cÇn 1 kho¶ng thêi gian míi cã thÓ chuyÓn søc m¹nh cña KÝnh nµy, anh hïng h·y an t©m chê ®îi.")
        else
            Talk(3, "no", "Anh hïng ®· ®îi l©u, ta ®· chuyÓn søc m¹nh cña KÝnh, m­în søc m¹nh cña KÝnh nµy, anh hïng cã thÓ phong Ên TiÕu L«i vµo trong!", GetName() .. "Tèt qu¸, nh­ng sö dông KÝnh nµy nh­ thÕ nµo?", "Lóc nµy anh hïng ®õng bËn t©m, chØ cÇn anh hïng t×m ®Õn TiÕu L«i, ta sÏ ph¸t ®éng KÝnh nµy, phong Ên h¾n vµo trong!")
            TaskNote(108, 19)
        end
        return
    end

    if (Outoftree_step == 6) then
        local key = GetTaskWord(1481, 2)
        local nowtime = math.mod(SystemTime(), 2 ^ 16)
        if (key + 60 >= nowtime) then
            Talk(1, "no", "TiÕu L«i  ®ang m­u ®å tho¸t khái KÝnh, mau ®i th­¬ng l­îng víi Ngò ¢m Täa.§inh Huy.")
            TaskNote(108, 11)
        else
            Talk(1, "no", "TiÕu Lé ®· tho¸t khái KÝnh, dïng Phong Ên KÝnh khèng chÕ h¾n thªm lÇn n÷a.")
            TaskNote(108, 19)
        end
        return
    end

    if (Outoftree_step == 7) then

        if (GetPlayerExtLevel() < 60) then
            Talk(1, "no", "Cæ kÝnh tiÒm chøa søc m¹nh cña c¸c lùc thÇn th­îng cæ")
            return
        else


            if (GetGlobalValue(global_PKXiaolei_Flag) == 1) then
                Talk(1, "no", "Ph¸p trËn lóc nµy ®· ph¸t huy c«ng hiÖu, <c=g>Phong Ên KÝnh<c> kh«ng thÓ sö dông.")
                return
            end

            if m ~= 75 then
                Talk(1, "no", "ChØ trong Tø §inh Ph­îc Linh TrËn míi tiªu trõ ®­îc søc m¹nh cña TiÕu L«i")
                return
            end

            local distance = ((x - (248 * 8)) ^ 2 + (y - (238 * 16)) ^ 2) ^ 0.5 * 32
            distance = math.floor(distance)
            if distance > 700 then
                Talk(1, "no", "ChØ trong Tø §inh Ph­îc Linh TrËn míi tiªu trõ ®­îc søc m¹nh cña TiÕu L«i")
                ScrollMessage("H« ho¸n thÊt b¹i")
                return
            end

            if (GetIBBuffCount() >= 32) then
                Talk(1, "no", "Tr¹ng th¸i qu¸ nhiÒu, l¸t n÷a h½ng tíi")
                return
            end

            local PKXiaoleiIndex = AddNpc(ID_PK_Xiaolei, 60, SubWorld, 248 * 8 * 32 + 3, 238 * 16 * 32 + 3)
            SetGlobalValue(global_PKXiaolei_Flag, 1)

            SetTaskByte(Task_Outoftree, 1, 8)

            SetNpcScript(PKXiaoleiIndex, "\\script\\¹ÖÎï\\Ð¥À×Õ½¶·.lua")
            SetNpcTimer(PKXiaoleiIndex, "\\script\\ontimer\\Ð¥À×Õ½¶·É¾µô×Ô¼º.lua", 10 * 60)
            SetNpcOwer(PKXiaoleiIndex, PlayerIndex)
            SetNpcTask(PKXiaoleiIndex, 1, GetPlayerID())
            local NewXiaoleiName = GetName() .. "H« ho¸n TiÕu L«i"
            SetNpcName(PKXiaoleiIndex, NewXiaoleiName)

            SetGlobalValue(global_PKXiaolei_index, PKXiaoleiIndex)

            local teamSize = GetTeamSize()
            local OldPlayIndex = PlayerIndex
            local teamSize = GetTeamSize()
            if (teamSize == 0) then
                AddIBBuff(700)
            else
                for i = 1, teamSize do
                    PlayerIndex = GetTeamMember(i)
                    if (GetTaskByte(Task_Outoftree, 1) == 7) then
                        TaskNote(108, 13)
                    end
                    if (GetTaskByte(Task_Outoftree, 1) == 8) then
                        TaskNote(108, 14)
                    end

                    if (GetIBBuffCount() < 32) then
                        AddIBBuff(700)
                    else
                        Msg2Player("Tr¹ng th¸i qu¸ nhiÒu, l¸t n÷a h½ng tíi")
                    end
                end
            end
            PlayerIndex = OldPlayIndex

            NpcSay(PKXiaoleiIndex, "C¸c ng­¬i d¸m ®èi xö víi ta nh­u vËy, th»ng ngèc §inh Huy, ®Ó ta diÖt mÊy ®øa nhãc nµy sÏ t×m ng­¬i tÝnh sæ.")
        end
        return 0
    end

    if (Outoftree_step == 8) then
        local PKXiaoleiIndex = GetGlobalValue(global_PKXiaolei_index)
        local bindPlayerID = GetNpcTask(PKXiaoleiIndex, 1)
        if (GetPlayerID() ~= bindPlayerID) then
            ScrollMessage("TiÕu L«i ®· biÕn mÊt, nhiÖm vô thÊt b¹i")
            Msg2Player("B©y giê søc cña b¹n ®· tiªu hao qu¸ nhiÒu, cÇn tÞnh d­ìng míi cã thÓ triÖu gäi tiÕp ®­îc.")
        else
            ScrollMessage("Mau ®i chinh phôc TiÕu L«i")
        end
        return 0
    end

    if (Outoftree_step == 9) then

        local MitanName = "MËt th¸m Ma giíi"
        if GetJusticEvilCredit() > 0 then
            MitanName = "MËt th¸m Tiªn giíi"
        end
        InfoBox("TiÕu L«i ®· bÞ phong Ên, ®i t×m" .. MitanName .. " b¸o c¸o sù viÖc!")
        TaskNote(108, 15, MitanName)
    end
end

function AddProcessBar(npcindex)
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 0)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 7, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 0)
    SetPlayerTarget(npcindex)
    BeginMotion(npcindex, 0, 3, "\\script\\motion\\²¶×½Ä§ÎïÖ®»êÏìÓ¦.lua", nInterrupt)
end

function outtree()
    Talk(3, "futi", "Ng­êi nµy qu¶ lµ ®å ®Ö tai häa, ta cã 1 c¸ch, võa cã thÓ b¾t ®­îc nã, anh hïng võa lÊy l¹i ®­îc vËt ®· mÊt.", GetName() .. " C¸ch g×, cã thÓ nãi ra xem nµo.", "KÝnh nµy lµ b¸u vËt th­îng cæ, nÕu ta hé t¸ vµo th©n thÓ anh hïng, cã thÓ m­în søc m¹nh kÝnh nµy hót hån Ma thó ë Ngôc Ph¸p s¬n, ®ång thêi xoay chuyÓn søc lùc, phong Ên ®­îc TiÕu L«i!")
end

function futi()
    MsgBox(GetName() .. " Ph¸p lùc ®· ph¸t huy, ph¶i tËn lùc míi thµnh c«ng", "futi_ok", "no")
end

function futi_ok()
    CloseDialog()

    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "Tr¹ng th¸i qu¸ nhiÒu, l¸t n÷a h½ng tíi")
        return
    end
    SetTaskByte(Task_Outoftree, 1, 3)
    AddIBBuff(699)
    SetTaskByte(Task_Outoftree, 2, 0)
    SetTaskByte(Task_Outoftree, 3, 0)
    SetTaskByte(Task_Outoftree, 4, 0)

    Msg2Player("H·y thö dïng Phong Ên KÝnh b¾t hån Ma thó cña 3 lo¹i qu¸i ë Ngôc Ph¸p s¬n.")
    TaskNote(108, 2)
    return
end

function no()
    CloseDialog()
end
