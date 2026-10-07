--description:ÎÞ¼äÐÐÕß±äÉí¹Ö½Å±¾
--author: zhaoqingsong
--date: 2008-7-29

-- ÎÞ¼äÐÐÕßÈÎÎñID
-- 1 Byte ÈÎÎñ×´Ì¬, 0,Î´½ÓÊÜ¹ýÈÎÎñ£»1£¬½ÓÊÜÈÎÎñ£»2£¬Íê³ÉÈÎÎñ
-- 2 Byte É±¹ÖÊýÁ¿
TASK_ID_FAQUIR = 1238
TASK_ID_FAQUIR_BS = 1239        -- ±äÉí¹Ö±äÁ¿
TASK_INFO_ID_FAQUIR = 1016
BUFF_ID_FAQUIR = 463

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local isInWeapon = IsPlayerInsideWeapon(PlayerIndex)
    local taskStatus = GetByte(GetTask(TASK_ID_FAQUIR), 1)
    local killCount = GetByte(GetTask(TASK_ID_FAQUIR), 2)
    if (isInWeapon > 0 and killCount < 100) then
        return
    end
    local playerName = GetName()
    local guardIndex = GetTGuardIndexByPlayerName(playerName)
    if (guardIndex == 0) then
        Talk(1, "no", GetName() .. ": Sao l¹i mÆc ®å cña ng­êi kh¸c thÕ...")
        return
    end

    local npcID = GetNpcID(DialogNpcIdx)
    if (npcID ~= GetTask(TASK_ID_FAQUIR_BS)) then
        return
    end

    if (isInWeapon == 0 and GetTask(TASK_ID_FAQUIR_BS) == npcID) then
        MsgBox(14483, "enter", "no")
    elseif (isInWeapon > 0) then
        MsgBox(14484, "out", "no")
    else
        Talk(1, "no", GetName() .. "Sao l¹i mÆc ®å cña ng­êi kh¸c thÕ…")
    end
end

function enter()
    CloseDialog()
    local npcID = GetNpcID(DialogNpcIdx)
    if (npcID == GetTask(TASK_ID_FAQUIR_BS)) then
        PlayerInOrOut(1, DialogNpcIdx)
        local skill, type = GetCreatureInfo()
        if (type >= 0) then
            SetCreatureType(skill, type)
        end
    end
end

function out()
    CloseDialog()
    local npcid = GetNpcID(DialogNpcIdx)
    local carriageIndex = GetSiegeWeaponIndexByNpcIndex(DialogNpcIdx)
    if (npcid == GetTask(TASK_ID_FAQUIR_BS)) then
        PlayerInOrOut(0, DialogNpcIdx)
        RemoveIBBuff(BUFF_ID_FAQUIR)
        DeleteSiegeWeapon(carriageIndex)
    end
end

function OnDeath(carriageNpcIndex)
    local carriageIndex = GetSiegeWeaponIndexByNpcIndex(carriageNpcIndex)
    local guardIndex = GetTGuardIndexByCarriageIndex(carriageIndex)

    if (guardIndex == 0) then
        DeleteSiegeWeapon(carriageIndex)
        return 0
    end

    local _, _, _, playerName = GetTGuardInfo(guardIndex)
    local relationPlayerIndex = GetPlayerIndexByName(playerName)

    if (relationPlayerIndex > 0) then
        local oldPlayerIndex = PlayerIndex
        PlayerIndex = relationPlayerIndex
        taskStatus = GetByte(GetTask(TASK_ID_FAQUIR), 1)
        local killCount = GetByte(GetTask(TASK_ID_FAQUIR), 2)
        if (taskStatus == 1 and killCount < 100) then
            RemoveIBBuff(BUFF_ID_FAQUIR)
            TaskNote(TASK_INFO_ID_FAQUIR, 3)
            Msg2Player("Vò La ThÇn Y cña b¹n ®· bÞ háng råi, mau vÒ gÆp Th­¬ng Thang, nÕu kh«ng qu¸i ph¸t hiÖn ra th× uæng c«ng tu luyÖn…")
        end
        PlayerIndex = oldPlayerIndex
    end
    DeleteSiegeWeapon(carriageIndex) -- ³ÌÐò°ÑÍæ¼ÒµÄÕóÓªÉèÖÃ»ØÀ´
end

function no()
    CloseDialog()
end
