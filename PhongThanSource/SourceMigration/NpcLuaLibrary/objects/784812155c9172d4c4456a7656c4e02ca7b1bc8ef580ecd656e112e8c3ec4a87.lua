--description: ¶úÊó
--author: likun 
--date:2007/11/16 

function OnDeath(nNpcIndex)
    GetBuff()
end;

function GetBuff()
    local rate = random(1, 10)
    if (rate <= 3) then
        AddIBBuff(337)

    elseif (rate <= 6) then
        AddIBBuff(402)

    elseif (rate <= 9) then
        AddIBBuff(403)

    end
end