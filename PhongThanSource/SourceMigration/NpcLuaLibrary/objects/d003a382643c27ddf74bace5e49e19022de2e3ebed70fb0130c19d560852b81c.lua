--hongliang 红砂阵 10/10/29


--------------------------------------
--副本临时变量
--1 ~ 4: TABLE_Npc中Npc的Idx
--5 ~ 8: TABLE_Npc中Npc的ID

TASK_Instance_HSZ = 601 --1st byte: 引导任务步骤 0-未接;1-已接;2-已和道人对话;3-已答应武王;4-已杀死boss;5-已完成任务;

NPCTVID_InstanceIdx = 0;
NPCTVID_InstanceId = 1;

INSTANCE_TYPE_HSZ = 10

BUFF_InstanceTime = 1344
Timer_Check = 68
Timer_End = 69
--------------------------------------


TABLE_Npc = {
    --id 等级 x坐标 y坐标 死亡路径 是否ai ai路径 显示名字
    --红砂阵魂
    [1] = { id = 1842, lvl = 130, x = 1765, y = 3108, npcscript = "\\script\\instance\\death\\红砂阵魂右.lua", isai = 0, aisrcipt = "", npcname = "H錸g Sa Tr薾 H錸" },
    [2] = { id = 1842, lvl = 130, x = 1537, y = 3334, npcscript = "\\script\\instance\\death\\红砂阵魂左.lua", isai = 0, aisrcipt = "", npcname = "H錸g Sa Tr薾 H錸" },
    --红砂阵门
    [3] = { id = 1868, lvl = 1, x = 1826, y = 3163, npcscript = "\\script\\instance\\红砂阵门.lua", isai = 0, aisrcipt = "", npcname = "H錸g Sa Tr薾 M玭" },
    [4] = { id = 1868, lvl = 1, x = 1593, y = 3391, npcscript = "\\script\\instance\\红砂阵门.lua", isai = 0, aisrcipt = "", npcname = "H錸g Sa Tr薾 M玭" },
}


-- 副本初始化，进行副本的初始设置，如摆Boss，置常量等，在创建副本后自动调用
function OnInitialize()

    --初始化，副本未启动时
    for i = 1, 64 do
        SetInstanceSaveValue(i, 0);
        SetInstanceTempValue(i, 0);
    end

    --加NPC
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(InstanceID)
    local NpcIdx = {};
    local NpcID = {};
    local temp = -1
    local nNum = getn(TABLE_Npc)
    local LeftTime = 60 * 60 * 2
    --AddGlobalNews("初始化,nSubWorldIdx="..nSubWorldIdx)
    for i = 1, nNum do
        temp = TABLE_Npc[i]
        NpcIdx[i] = AddNpc(temp.id, temp.lvl, nSubWorldIdx, temp.x * 32, temp.y * 32)

        if (NpcIdx[i] > 0) then
            SetNpcScript(NpcIdx[i], temp.npcscript)
            --				SetNpcTimer(NpcIdx[i], "\\script\\ontimer\\删掉自己.lua", LeftTime) --Error: 不能绑timer 洪亮 10/11/23
            SetNpcName(NpcIdx[i], temp.npcname)
            if (temp.isai > 0) then
                SetAIScript(NpcIdx[i], temp.aisrcipt)
            end

            if (i <= 2) then
                SetNpcName(NpcIdx[i], "<c=yel>H錸g Sa Tr薾 H錸<c>")
            end

            --记录NPC的idx和id
            NpcID[i] = GetNpcID(NpcIdx[i]);
            SetInstanceTempValue(i, NpcIdx[i]);
            SetInstanceTempValue(i + nNum, NpcID[i]);
            --NPC记录副本的id和idx
            SetNpcTask(NpcIdx[i], NPCTVID_InstanceId, InstanceID);
            SetNpcTask(NpcIdx[i], NPCTVID_InstanceIdx, InstanceIndex);
        end
    end


    --加3个隐藏NPC
    for i = 1, 5 do
        local npcidx = AddNpc(1852, 1, nSubWorldIdx, (1600 + random(1, 5)) * 32, (3290 + random(1, 5)) * 32)  --隐藏NPC，需要加在阻挡里
        if (npcidx > 0) then
            --				SetNpcTimer(npcidx, "\\script\\ontimer\\删掉自己.lua", LeftTime+30) --Error: 不能绑timer 洪亮 10/11/23
            SetInstanceTempValue(20 + i, npcidx);
        end
    end

    --	        --两个首领彼此记录idx和id
    --	        SetNpcTask(NpcIdx[3], 2, NpcIdx[4]);
    --	        SetNpcTask(NpcIdx[3], 3, NpcID[4]);
    --	        SetNpcTask(NpcIdx[4], 2, NpcIdx[3]);
    --	        SetNpcTask(NpcIdx[4], 3, NpcID[3]);

end

-- 副本释放，可进行副本初始化相反的处理，如清常量等，在释放副本前自动调用
function OnRelease()

    local nNum = getn(TABLE_Npc)
    local NpcIdx = -1

    for i = 1, nNum do
        NpcIdx = GetInstanceTempValue(i)

        if (NpcIdx > 0 and GetNpcID(NpcIdx) ~= 0 and GetNpcID(NpcIdx) == GetInstanceTempValue(i + nNum)) then
            DelNpc(NpcIdx);
        end
    end

    --删除刷出的小怪
    local Rightnpc = GetInstanceTempValue(21)
    local Leftnpc = GetInstanceTempValue(22)
    local tempIdx = 0
    local tempID = 0

    for i = 1, GetNpcTask(Leftnpc, 0), 2 do
        --左侧走廊
        if (Leftnpc > 0 and GetNpcTemplateID(Leftnpc) == 1852) then
            tempIdx = GetNpcTask(Leftnpc, i)
            tempID = GetNpcTask(Leftnpc, i + 1)
            if (tempIdx > 0 and GetNpcID(tempIdx) == tempID) then
                DelNpc(tempIdx)
            end
        end
    end

    for i = 1, GetNpcTask(Rightnpc, 0), 2 do
        --右侧走廊
        if (Rightnpc > 0 and GetNpcTemplateID(Rightnpc) == 1852) then
            tempIdx = GetNpcTask(Rightnpc, i)
            tempID = GetNpcTask(Rightnpc, i + 1)
            if (tempIdx > 0 and GetNpcID(tempIdx) == tempID) then
                DelNpc(tempIdx)
            end
        end
    end

    --删除鸣沙仙
    tempIdx = GetInstanceTempValue(34)
    if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1847) then
        DelNpc(tempIdx)
    end

    --删除中间阻挡门
    tempIdx = GetInstanceTempValue(35)
    if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1868) then
        DelNpc(tempIdx)
    end

    --删除隐藏NPC
    for i = 1, 7 do
        tempIdx = GetInstanceTempValue(20 + i)
        if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1852) then
            DelNpc(tempIdx)
        end
    end

    --删除武王对话
    tempIdx = GetInstanceTempValue(36)
    if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1862) then
        DelNpc(tempIdx)
    end

    --删除雕像对话
    for i = 1, 3 do
        tempIdx = GetInstanceTempValue(36 + i)
        if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == (1852 + i)) then
            DelNpc(tempIdx)
        end
    end

    --删除武王战斗
    tempIdx = GetInstanceTempValue(41)
    if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1861) then
        DelNpc(tempIdx)
    end

    --删除传送门
    for i = 1, 3 do
        tempIdx = GetInstanceTempValue(41 + i)
        if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == (1867 + i)) then
            DelNpc(tempIdx)
        end
    end

    --删除沙龙
    tempIdx = GetInstanceTempValue(45)
    if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1849) then
        DelNpc(tempIdx)
    end

    --删除张天君
    tempIdx = GetInstanceTempValue(46)
    if (tempIdx > 0 and GetNpcTemplateID(tempIdx) == 1851) then
        DelNpc(tempIdx)
    end

    ----------------删红砂阵灵--------------------
    for i = 23, 25 do
        local hideIdx = GetInstanceTempValue(i)
        local hideNum = GetNpcTask(hideIdx, 0)

        for i = 1, hideNum do
            local bossNpcIdx = GetNpcTask(hideIdx, i)

            if (bossNpcIdx > 0 and GetNpcTemplateID(bossNpcIdx) == 1846) then
                DelNpc(bossNpcIdx)
            end
        end
    end
    ----------------删红砂阵灵--------------------

    ----------------删阻挡------------------------
    for i = 47, 48 do
        local doorIdx = GetInstanceTempValue(i)
        if (doorIdx > 0 and GetNpcTemplateID(doorIdx) == 1869) then
            DelNpc(doorIdx)
        end
    end

    for i = 49, 50 do
        local doorIdx = GetInstanceTempValue(i)
        if (doorIdx > 0 and GetNpcTemplateID(doorIdx) == 1866) then
            DelNpc(doorIdx)
        end
    end
    ----------------删阻挡------------------------

end