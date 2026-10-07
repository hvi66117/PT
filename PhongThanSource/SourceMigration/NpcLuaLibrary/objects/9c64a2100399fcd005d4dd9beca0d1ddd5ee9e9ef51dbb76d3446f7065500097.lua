--description:ÎåÍ¨Éñ--Î÷À¥ÂØ
--author: yaoxin
--date: 2007/8/6

function OnDeath(c)
    local npcWSIdx = GetTask(1056)
    if (npcWSIdx == c) then

        SetTask(1056, 0)
        local oldplayIdx = PlayerIndex
        local MIdx = GetPlayerIndexByName(GetMateName())
        if (MIdx > 0) then
            PlayerIndex = MIdx
            SetTask(1056, 0)
            PlayerIndex = oldplayIdx
        end

        local str = ""

        for i = 1, 6 do
            ThrowItem(c, PlayerIndex, 1, 6, 0, 0, 1)
        end
        --TopMessage(11688)
        str = ", rít 6 S« c« la"
        local w = random(1, 10)
        if (w <= 9) then
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = str .. "Víi 1 Hoa Hång"
        else
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            ThrowItem(c, PlayerIndex, 6, 0, 345, 1, 0, 1)
            str = str .. "Víi 2 Hoa Hång"
        end

        Msg2Team("Ngò Th«ng ThÇn ë T©y C«n L«n bÞ gi¸ng phôc" .. str)
    end
    DelNpc(c)
end;
