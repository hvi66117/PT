-- Blaze game server startup script
-- Created in 2006-07-19
-- by zhujialiang

function OnDeath(npcidx)
    local a = GetName()

    AddGlobalCountNews("<c=green>" .. a .. "<c> mét kiÕm h¹ thñ ®Çu lÜnh <c=r>Kho¸c Quû<c> nhËn ®­îc <c=g>tranh b¸t qu¸i<c>.", 20)
    AddNormalItem(3, 87, 0, 0, 0, 1)
    DelNpc(npcidx)
end;