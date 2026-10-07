function main()
    local w, x, y = GetWorldPos()
    if (GetFightState() == 1) and (w == 64) then
        local i = math.random(530, 533)
        local ChageNum = AddNpc(i, 1, SubWorld, x * 32, y * 32)
        SetNpcScript(ChageNum, "\\script\\怪物\\鬼月活动战魂.lua")
        TopMessage(13123)
        SetTask(824, ChageNum)
    else
        AddNormalItem(6, 1, 178, 1, 0, 0, 0)
        TopMessage(13124)
    end
end;
