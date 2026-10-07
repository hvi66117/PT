Task_star = 1417

Task_prepare = 1537

Task_anotherID = 1538
Task_item = 1539
Task_stage = 1540

function main(l, t, npcindex)
    local H, M, S = GetHMS()
    if (H >= 23) then
        Talk(1, "no", "Trêi tèi råi, h·y nghØ ng¬i ®i, ®Õn ngµy mai sÏ tiÕp tôc göi chóc phóc.")
        Msg2Player("§· hÕt thêi gian ho¹t ®éng, ngµy mai h·y tiÕp tôc nhĞ!")
        return
    end
    onlinetime = GetOnlineTime()
    lasttime = GetTask(Task_item)
    if ((math.abs(onlinetime - lasttime) < 3000) and (GetTaskByte(Task_prepare, 2)) ~= 0) then
        Msg2Player("B¹n võa göi mét lêi chóc phóc, cÇn chê 50 phót n÷a míi cã thÓ göi tiÕp.")
        return
    end
    local npcindex = GetPlayerTarget()
    if (npcindex <= 0) then
        Msg2Player("H·y chän ®óng ng­êi ch¬i ®Ó sö dông.")
        return
    end
    local npcTemplateID = GetNpcTemplateID(npcindex)
    if (npcTemplateID < 0) then
        local AnotherIndex = NpcIdx2PIdx(npcindex)
        local mapid, x, y = GetWorldPos()
        local OldIndex = PlayerIndex
        PlayerIndex = AnotherIndex
        local othermapid, otherx, othery = GetWorldPos()
        local PlayerType = GetPlayerType()
        local PlayerLevel = GetLevel()
        local AnotherID = GetPlayerID()

        PlayerIndex = OldIndex
        SetTask(Task_anotherID, AnotherID)

        local distance = math.floor(((otherx - x) ^ 2 + (othery - y) ^ 2) ^ 0.5 * 32)
        if (distance > 400) then
            Msg2Player("B¹n c¸ch ng­êi ch¬i kh¸c qu¸ xa, [ThiÖp mêi kû niÖm] kh«ng thÓ ph¸t huy t¸c dông!")
            return
        end

        if (PlayerLevel < 50) then
            Talk(1, "no", "H·y sö dông víi ng­êi ch¬i ®¹t ®¼ng cÊp 50 trë lªn.")
            return
        end

        if (PlayerType == 0) then
            if ((GetTaskBit(Task_prepare, 1) == 1)) then
                Talk(1, "no", "B¹n ®· göi chóc phóc ®Õn 1 Gi¸p SÜ, h·y sö dông víi ng­êi ch¬i thuéc hÖ ph¸i kh¸c.")
                return
            end
        elseif (PlayerType == 1) then
            if (GetTaskBit(Task_prepare, 2) == 1) then
                Talk(1, "no", "B¹n ®· göi chóc phóc ®Õn 1 §¹o SÜ, h·y sö dông víi ng­êi ch¬i thuéc hÖ ph¸i kh¸c.")
                return
            end
        elseif (PlayerType == 2) then
            if (GetTaskBit(Task_prepare, 3) == 1) then
                Talk(1, "no", "B¹n ®· göi chóc phóc ®Õn 1 DŞ Nh©n, h·y sö dông víi ng­êi ch¬i thuéc hÖ ph¸i kh¸c.")
                return
            end
        else
            Talk(1, "no", "ChØ cã thÓ sö dông víi ng­êi ch¬i.")
        end

        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 1)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        BeginMotion(Task_prepare, 0, 5, "\\script\\motion\\·¢ËÍÑûÇë.lua", nInterrupt)
        if (HaveIBBuff(783) > 0) then
            RemoveIBBuff(783)
        end
    else
        Msg2Player("ChØ cã thÓ sö dông víi ng­êi ch¬i.")
        return
    end


end;

function no()
    CloseDialog()
end;
