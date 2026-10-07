TASK_ID_FAQUIR = 1238
TASK_ID_FAQUIR_BS = 1239
TASK_INFO_ID_FAQUIR = 1016
BUFF_ID_FAQUIR = 463
MONSTER_NPCID = 690
MONSTER_LIFE_TIME = 1800

require("common.luax")
IsSpecialMorph = COMMON.IsSpecialMorph

function main()
    if (IsSpecialMorph() == true) then
        Msg2Player("Tr¹ng th¸i nµy kh«ng thÓ sö dông BiÕn Th©n Phï.")
        return
    end
    local taskStatus = GetByte(GetTask(TASK_ID_FAQUIR), 1)
    if (GetFreeNpcCount() < 160) then
        Talk(1, "no", 14365)
        return
    elseif (taskStatus == 1) then
        local guardIndex = GetTGuardIndexByPlayerName(GetName())
        local mapid, x, y = GetWorldPos()
        if (guardIndex > 0) then
            Talk(1, "no", 14366)
            return
        elseif (mapid ~= 44 and mapid ~= 45) then
            Talk(1, "no", GetName() .. ": Th­¬ng Thang nãi ¸o nµy chØ cã t¸c dông trong thêi gian nhÊt ®Þnh. Hay lµ cø ®Õn <c=r>tÇng 3 hoÆc 4 BÝch Du Cung<c> råi tÝnh vËy!")
            return
        end
        local boxIndex = NewSiegeWeapon(mapid, 32 * x, 32 * y, MONSTER_NPCID)
        local boxNpcIndex = GetSiegeWeaponNpcIndex(boxIndex)
        if (boxNpcIndex > 0) then
            DelNormalItem(6, 1, 365, 1)
            local playerName = GetName()
            SetNpcScript(boxNpcIndex, "\\script\\¹ÖÎï\\ÎÞ¼äÐÐÕß±äÉí¹Ö.lua")
            SendCarriage(boxIndex, playerName, 1, MONSTER_LIFE_TIME)
            SetGuardLevel(boxNpcIndex, 1)
            local npcName = GetNpcName(boxNpcIndex)
            SetNpcName(boxNpcIndex, "<c=g>" .. npcName .. "<c>")

            TaskNote(TASK_INFO_ID_FAQUIR, 1, 100)
            AddIBBuff(BUFF_ID_FAQUIR)

            local npcID = GetNpcID(boxNpcIndex)
            SetTask(TASK_ID_FAQUIR_BS, npcID)

            Talk(1, "no", GetName() .. ": Tr­íc mÆt xuÊt hiÖn mét bé Vò La ThÇn Y, nhÊp vµo sÏ mÆc lªn ng­êi!")
        else
            Talk(1, "no", GetName() .. ":…Sao l¹i thÊt b¹i!? Thö l¹i lÇn n÷a xem!")
            return 0
        end
        Msg2Player("Tr­íc mÆt xuÊt hiÖn mét bé Vò La ThÇn Y")
        TopMessage(14367)
    else
        Talk(1, "no", GetName() .. ": Thø nµy h×nh nh­ kh«ng ph¶i dïng lóc nµy")
    end
end

function no()
    CloseDialog()
end
