function main()
    local playerType = GetPlayerType()
    if (playerType ~= 2) then
        Talk(1, "no", "ChØ cã DÞ Nh©n míi cã thÓ biÕn th©n cho Thó triÖu gäi!")
        return
    end

    local creatureSkill, creatureType = GetCreatureInfo()
    if (creatureType < 0) then
        Talk(1, "no", "B¹n ch­a gäi Thó triÖu gäi ra, kh«ng thÓ biÕn th©n cho nã!")
        return
    elseif (creatureType == 411) then
        Talk(1, "no", "Thó triÖu gäi cña b¹n ®· biÕn thµnh <c=g>Phi Thiªn Tru<c> råi, kh«ng thÓ biÕn n÷a!")
        return
    end

    if (HaveNormalItem(6, 1, 401, 1) > 0) then
        SetCreatureType(creatureSkill, 411)
        Msg2Player("Thó triÖu gäi cña b¹n ®· biÕn thµnh Phi Thiªn Tru")
        DelNormalItem(6, 1, 401, 1)
    end
end;

function no()
    CloseDialog()
end
