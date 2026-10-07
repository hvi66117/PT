--hongliang 2009-12-28 烹饪宗师


--------------------烹饪宗师---------------------------
NPCTASK_TABLE_SuDaJi_SoldierIdx = {
    [1] = 11,
    [2] = 12,
    [3] = 13,
    [4] = 14,
    [5] = 15,
    [6] = 16,
}

SOLDIER_TEMPLATE_ID = 1726;
--------------------烹饪宗师---------------------------


function OnTimer(SuDaJiIdx)

    --删除6个伤兵
    local SoldierIdx = 0;
    for i = 1, 6 do

        SoldierIdx = GetNpcTask(SuDaJiIdx, NPCTASK_TABLE_SuDaJi_SoldierIdx[i]);

        if (GetNpcTemplateID(SoldierIdx) == SOLDIER_TEMPLATE_ID) then

            DelNpc(SoldierIdx);
            --NpcSay(SuDaJiIdx,"删除伤兵"..SoldierIdx);

            --DebugPrint("玩家下线，删除所有伤兵");

        else
            --NpcSay(SuDaJiIdx,"错误: 伤兵idx记录错误"..SoldierIdx);
        end

    end

    --停止计时
    DelNpcTimer(SuDaJiIdx);
end


