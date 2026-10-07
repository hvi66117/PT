function main()
    local WorldType = GetWorldType()
    if (WorldType == 1) then
        local playercamp = GetCamp()
        if (playercamp ~= 0) and (playercamp ~= 7) then
            Msg2Player("Trong phe ph¸i nµy kh«ng thÓ sö dông Ngù Phong phï.")
            AddNormalItemPile(6, 1, 435, 1, 0, 0)
            return
        elseif (IsPlayerInsideWeapon(PlayerIndex) > 0) then
            Msg2Player("Trong tr¹ng th¸i nµy kh«ng thÓ sö dông Ngù Phong phï.")
            AddNormalItemPile(6, 1, 435, 1, 0, 0)
        else
            GotoExtRevivePos()
        end
    else
        Msg2Player("Ngù Phong phï chØ cã thÓ sö dông trong Tiªn Ma giíi!")
        AddNormalItemPile(6, 1, 435, 1, 0, 0)
    end
end;
