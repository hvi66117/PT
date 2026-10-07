Task_DuJie_Value = 1326

Global_Lamp_LightCount = 167
Npc_Const_Distance = 1000

function main(itemid)
    local taskstep = GetByte(GetTask(Task_DuJie_Value), 1)
    local tasknum = GetByte(GetTask(Task_DuJie_Value), 3)
    if ((taskstep ~= 1 or tasknum ~= 7)) then
        Talk(1, "no", "(®¹o cô) kh«ng thÓ sö dông")
        return
    end

    if (HaveIBBuff(524) == 0) then
        Talk(1, "no", "Thiªn KiÕp cã h¹n ®Þnh thêi gian! B¹n kh«ng trong tr¹ng th¸i Thiªn KiÕp, kh«ng thÓ h« ho¸n Thiªn KiÕp n¹n")
        return
    end

    local credit = GetJusticEvilCredit()
    local name = GetName()
    local nNpcIdx
    local w, x, y = GetWorldPos()
    if (w == 73) then
        local bresult = nil
        if (credit > 0) then
            bresult = isincycle(2011, 3336)
        else
            bresult = isincycle(1941, 3246)
        end

        if (bresult == 0) then
            Talk(1, "no", "Thiªn KiÕp, cÇn ph¶i trong ph¹m vi cã thÓ quan s¸t ®­îc VËt tæ! B¹n ®· ®i qu¸ xa råi!")
            return
        end

        if (credit > 0) then
            nNpcIdx = AddNpc(823, 30, SubWorld, x * 32, y * 32)

            AddGlobalCountNews("<c=g>" .. name .. "<c> ®Õn <c=r>BÊt Chu Thiªn Quan<c>-VËt tæ [Tiªn KiÕp] tiÕp nhËn kh¶o nghiÖm Thiªn KiÕp.", 3);
        else
            nNpcIdx = AddNpc(830, 30, SubWorld, x * 32, y * 32)

            AddGlobalCountNews("<c=g>" .. name .. "<c> ®Õn <c=r>BÊt Chu Thiªn Quan<c>-VËt tæ [Ma KiÕp] tiÕp nhËn kh¶o nghiÖm Thiªn KiÕp.", 3);
        end
        SetNpcName(nNpcIdx, "<c=g>" .. name .. "<c> XuÊt KhiÕu Nguyªn ThÇn")

        SetNpcTimer(nNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1200)
        SetNpcTask(nNpcIdx, 1, GetPlayerID())
        DelNormalItem(itemid)
        DelNormalItem(6, 1, 442, 1)
        Msg2Player("XuÊt KhiÕu Nguyªn ThÇn cña b¹n ®· xuÊt hiÖn!")
        if (credit > 0) then
            TaskNote(1027, 2, 7)
        else
            TaskNote(1027, 3, 7)
        end

    else
        Msg2Player("N¬i ®©y kh«ng thÓ triÖu gäi XuÊt KhiÕu Nguyªn ThÇn!")
    end
end

function isincycle(cyclex, cycley)
    local w, x, y = GetWorldPos()
    local dis = math.floor(math.sqrt(((cyclex - x) * 32) ^ 2 + ((cycley - y) * 32) ^ 2))
    if (dis > Npc_Const_Distance) then
        return 0
    end
    return 1
end

function no()
    CloseDialog()
end
