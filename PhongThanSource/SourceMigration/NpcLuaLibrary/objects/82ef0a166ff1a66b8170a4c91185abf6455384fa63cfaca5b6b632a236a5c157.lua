NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local mob_lvl = GetNpcLevel(npcindex)

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (mob_lvl >= 15) then
                if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                    AddNormalItem(6, 1, 358, 1, 0, 0)
                    TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                    Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <c>Viªn Bån")
                end ;
            end ;
        end ;
    end ;
end

function no()
    CloseDialog()
end;
