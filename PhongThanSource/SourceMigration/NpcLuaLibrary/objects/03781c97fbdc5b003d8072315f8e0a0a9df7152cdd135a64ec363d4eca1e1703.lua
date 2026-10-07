--description:npc
--author: mayining
--date:2009/1/13

JECT_TASK_STATE = 1291 -- byte1:type byte2:state byte3:ib byte4:Monster
JECT_TASK_FLAG_IDX = 1292
JECT_TASK_FLAG_ID = 1293
JECT_TYPE = 2
MIN_LEVEL = 20
MAX_LEVEL = 30
FLAG_NPC_ID = 803
FLAG_ITEM_DET = 329
FLAG_NAME = "_Ma ChiÕn Kú"
SET_CAMP = 4
REFRESH_DIS = 150

-- Added by Zhaoqingsong at 2009-4-29 begin
JECT_TASK_ACC_LEVEL = 1415
-- Added by Zhaoqingsong at 2009-4-29 end

g_NpcName = {
    "Gß Hång Nª (Ma)",
    "Gß Viªm Sa (Ma)",
    "Gß XÝch Thæ (Ma)",
    "Gß Hång Nª (Tiªn)",
    "Gß Viªm Sa (Tiªn)",
    "Gß XÝch Thæ (Tiªn)",
}

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()

    local nType = GetTaskByte(JECT_TASK_STATE, 1)
    local nState = GetTaskByte(JECT_TASK_STATE, 2)

    if (nType ~= JECT_TYPE) then
        Msg2Player("NÕu muèn c¾m cê d­¬ng ai thÞ uy ma chóng, cÇn ®Õn tr­íc trËn tiÒn cña Ma giíi t×m n¬i thÝch hîp")
        return
    end

    if (nState ~= 2) or ((HaveNormalItem(3, FLAG_ITEM_DET, 0, 0) <= 0)) then
        Msg2Player("Trong hµnh trang cña b¹n kh«ng cã Ma giíi ChiÕn kú, kh«ng thÓ c¾m cê")
        return
    end

    -- Modify by Zhaoqingsong at 2009-4-29 begin
    -- local nLevel = GetPlayerExtLevel()
    local nLevel = GetTaskByte(JECT_TASK_ACC_LEVEL, 1)
    if (nLevel == 0) then
        nLevel = GetPlayerExtLevel()
    end
    -- Modify by Zhaoqingsong at 2009-4-29 end

    if ((nLevel <= MIN_LEVEL) or (nLevel > MAX_LEVEL)) and ((nLevel <= 40)) then
        Msg2Player("N¬i ®©y kh«ng thÝch hîp c¾m cê, xin t×m n¬i kh¸ch thÝch hîp")
        return
    end

    if (GetNpcTask(DialogNpcIdx, 0) > 0) then
        Msg2Player("N¬i ®©y ®· cã chiÕn kú, nÕu muèn c¾m n÷a th× ph¶i nhæ bá cê cò ®i!")
        return
    end

    MsgBox("C¾m cê ë ®©y sÏ khiÕn cho Tiªn chóng chÊn ®éng, B¹n x¸c ®Þnh muèn c¾m Ma giíi ChiÕn kú ë ®©y?", "setFlag", "no")

    SetTask(142, GetNpcID(DialogNpcIdx))
end

function setFlag()

    CloseDialog()

    if (GetNpcID(DialogNpcIdx) ~= GetTask(142)) then
        Msg2Player("§Êt ë ®©y qu¸ cøng, xin t×m n¬i kh¸c c¾m cê!")
        return
    end

    local nType = GetTaskByte(JECT_TASK_STATE, 1)
    local nState = GetTaskByte(JECT_TASK_STATE, 2)

    if (nType ~= JECT_TYPE) then
        Msg2Player("NÕu muèn c¾m cê d­¬ng ai thÞ uy ma chóng, cÇn ®Õn tr­íc trËn tiÒn cña Ma giíi t×m n¬i thÝch hîp")
        return
    end

    -- Modify by Zhaoqingsong at 2009-4-29 begin
    -- local nLevel = GetPlayerExtLevel()
    local nLevel = GetTaskByte(JECT_TASK_ACC_LEVEL, 1)
    if (nLevel == 0) then
        nLevel = GetPlayerExtLevel()
    end
    -- Modify by Zhaoqingsong at 2009-4-29 end

    --	if (( nLevel <= MIN_LEVEL ) or ( nLevel > MAX_LEVEL )) and (( nLevel <= 40 ) or ( nLevel > 50 )) then
    --		Msg2Player( "´Ë´¦²¢·Ç±¾´ÎÊúÆìÑïÍþÖ®µØ£¬ÇëÒÀÕÕÄ§½ç¼Æ»®ÐÐÊÂ£¬ÒÔÃâ¶¸ÉúÊÂ¶Ë" )
    --		return
    --	end

    if (nState ~= 2) or ((HaveNormalItem(3, FLAG_ITEM_DET, 0, 0) <= 0)) then
        Msg2Player("Trong hµnh trang cña b¹n kh«ng cã Ma giíi ChiÕn kú, kh«ng thÓ c¾m cê")
        return
    end

    if (GetNpcTask(DialogNpcIdx, 0) > 0) then
        Msg2Player("N¬i ®©y ®· cã chiÕn kú, nÕu muèn c¾m n÷a th× ph¶i nhæ bá cê cò ®i!")
        return
    end

    local nSubWorldId
    local nWorldX
    local nWorldY
    nSubWorldId, nWorldX, nWorldY = GetNpcWorldPos(DialogNpcIdx)

    local npc_index = AddNpc(FLAG_NPC_ID, 1, SubWorld, nWorldX * 32, nWorldY * 32 + 32)

    if (npc_index > 0) then

        NewNpcName = "<c=y>" .. GetName() .. FLAG_NAME
        SetNpcName(npc_index, NewNpcName)
        SetNpcScript(npc_index, "\\script\\npcdeath\\Õ½ÆìÄ§.lua")
        SetNpcTimer(npc_index, "\\script\\ontimer\\Õ½ÆìÄ§.lua", 10)

        DelNormalItem(3, FLAG_ITEM_DET, 0, 0)

        SetNpcTask(npc_index, 0, GetPlayerID())
        SetNpcTask(npc_index, 1, DialogNpcIdx)
        SetNpcTask(npc_index, 2, 6)
        SetNpcTask(npc_index, 3, 0)
        SetNpcTask(DialogNpcIdx, 0, npc_index)

        SetNpcName(DialogNpcIdx, "")

        SetNpcCamp(npc_index, SET_CAMP)
        SetCamp(SET_CAMP)

        AddIBBuff(512)

        SetTaskByte(JECT_TASK_STATE, 2, 3)
        SetTask(JECT_TASK_FLAG_IDX, npc_index)
        SetTask(JECT_TASK_FLAG_ID, GetNpcID(npc_index))

        TaskNote(1022, 3)
        Msg2Player("B¹n ®· c¾m thµnh c«ng Ma giíi ChiÕn kú, cßn ph¶i cÈn thËn coi chõng Tiªn giíi ph¶n kÝch")

        if (GetPlayerExtLevel() > 30) then
            SetNpcTask(npc_index, 9, 1)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> c¾m Ma giíi ChiÕn kú t¹i" .. g_NpcName[6] .. ". Tiªn giíi Thñ vÖ ®· ph¶n kÝch d÷ déi")
        else
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> c¾m Ma giíi ChiÕn kú t¹i" .. g_NpcName[6] .. ". Mang vÒ vinh dù cho Ma giíi!")
        end

        for i = 1, 3 do
            refresh_Monster(npc_index, 30)
        end

        return
    end

    Msg2Player("ThÊt b¹i bÊt ngê")
end

function refresh_Monster(npcindex, nTime)

    if (GetNpcTask(npcindex, 9) ~= 1) then
        return
    end

    local nSubWorldId
    local nWorldX
    local nWorldY
    nSubWorldId, nWorldX, nWorldY = GetNpcWorldPos(npcindex)
    nWorldX = nWorldX * 32
    nWorldY = nWorldY * 32
    nWorldX = random(nWorldX - REFRESH_DIS, nWorldX + REFRESH_DIS)
    nWorldY = random(nWorldY - REFRESH_DIS, nWorldY + REFRESH_DIS)

    local OldSubWorld = SubWorld
    SubWorld = SubWorldID2Idx(nSubWorldId)

    local nNpcType = GetNpcTask(npcindex, 2)
    if (nNpcType == 1) then
        --ºéÄà

        local npc_index = AddNpc(894, 35, SubWorld, nWorldX, nWorldY)
        SetNpcTimer(npc_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nTime)
        SetNpcTarget(npc_index, npcindex)
        SetNpcName(npc_index, "Ma giíi Thñ vÖ")

    elseif (nNpcType == 4) then

        local npc_index = AddNpc(891, 35, SubWorld, nWorldX, nWorldY)
        SetNpcTimer(npc_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nTime)
        SetNpcTarget(npc_index, npcindex)
        SetNpcName(npc_index, "Tiªn giíi Thñ vÖ")

    elseif (nNpcType == 2) then
        --Ñ×É³

        local npc_index = AddNpc(895, 40, SubWorld, nWorldX, nWorldY)
        SetNpcTimer(npc_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nTime)
        SetNpcTarget(npc_index, npcindex)
        SetNpcName(npc_index, "Ma giíi Thñ vÖ")

    elseif (nNpcType == 5) then

        local npc_index = AddNpc(892, 40, SubWorld, nWorldX, nWorldY)
        SetNpcTimer(npc_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nTime)
        SetNpcTarget(npc_index, npcindex)
        SetNpcName(npc_index, "Tiªn giíi Thñ vÖ")

    elseif (nNpcType == 3) then
        --³àÍÁ

        local npc_index = AddNpc(896, 45, SubWorld, nWorldX, nWorldY)
        SetNpcTimer(npc_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nTime)
        SetNpcTarget(npc_index, npcindex)
        SetNpcName(npc_index, "Ma giíi Thñ vÖ")

    elseif (nNpcType == 6) then

        local npc_index = AddNpc(893, 45, SubWorld, nWorldX, nWorldY)
        SetNpcTimer(npc_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", nTime)
        SetNpcTarget(npc_index, npcindex)
        SetNpcName(npc_index, "Tiªn giíi Thñ vÖ")

    end

    SubWorld = OldSubWorld

end

function no()
    CloseDialog()
end