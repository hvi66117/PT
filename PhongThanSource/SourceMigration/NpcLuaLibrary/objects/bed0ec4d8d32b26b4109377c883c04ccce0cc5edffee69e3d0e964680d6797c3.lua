function OnDeath(npcidx)
    AddGlobalCountNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<c>1 chiªu lÊy <color=blue> Thñ cÊp BOSS Hoµng Kim---NhŞ Lang ThÇn<c>.", 20)

    DelNpc(npcidx)
end;
