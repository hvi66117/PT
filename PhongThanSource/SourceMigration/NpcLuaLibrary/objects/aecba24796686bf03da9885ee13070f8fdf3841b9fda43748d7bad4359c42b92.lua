function OnDeath()
    GetBuff()
end;

function GetBuff()
    local rate = math.random(1, 10)
    if (rate <= 3) then
        AddIBBuff(337)

    elseif (rate <= 6) then
        AddIBBuff(402)

    elseif (rate <= 9) then
        AddIBBuff(403)

    end
end
