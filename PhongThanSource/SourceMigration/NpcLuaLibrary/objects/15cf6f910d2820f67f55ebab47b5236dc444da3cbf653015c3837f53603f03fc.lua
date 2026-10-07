function OnDeath(npcidx)
    do_sershu()
    if (math.random(1000) <= 50) then
        SetPK(GetPK() - 3)
        Msg2Player("Ch©n khÝ cña b¹n ®· yÕu ®i")
    end
end;

function do_sershu()
    if (GetTask(586) > 1) then
        local count = GetTask(586) - 1;
        Msg2Player("B¹n cßn ph¶i tiªu diÖt " .. count .. "Phi Thè.")
        SetTask(586, count)
    elseif (GetTask(586) == 1) then
        Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô cña Ma LÔ Thä")
        SetTask(586, 0)

    end ;
end;
