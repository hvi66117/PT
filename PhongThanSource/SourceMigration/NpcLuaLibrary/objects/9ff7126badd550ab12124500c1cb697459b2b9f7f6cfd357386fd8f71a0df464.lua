NPCTASK_TABLE_SuDaJi_SoldierIdx = {
    [1] = 11,
    [2] = 12,
    [3] = 13,
    [4] = 14,
    [5] = 15,
    [6] = 16,
}

SOLDIER_TEMPLATE_ID = 1726;

function OnTimer(SuDaJiIdx)


    local SoldierIdx = 0;
    for i = 1, 6 do

        SoldierIdx = GetNpcTask(SuDaJiIdx, NPCTASK_TABLE_SuDaJi_SoldierIdx[i]);

        if (GetNpcTemplateID(SoldierIdx) == SOLDIER_TEMPLATE_ID) then

            DelNpc(SoldierIdx);


        else

        end

    end

    DelNpcTimer(SuDaJiIdx);
end


