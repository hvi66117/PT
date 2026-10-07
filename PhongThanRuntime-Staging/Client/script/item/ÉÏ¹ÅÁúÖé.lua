Task_xianmo_wdjx = 1542

Task_info_xian = 1097
Task_info_mo = 1098

function main()
    local DragonNpcs = {
        [1] = { ID = 1242, name = "Gß Thæ Long" },
        [2] = { ID = 1243, name = "Gß Háa Long" },
        [3] = { ID = 1244, name = "Gß B¨ng Long" },
        [4] = { ID = 1245, name = "Gß L«i Long" },
    }
    local npcindex = GetPlayerTarget()
    local npcTemplateID = GetNpcTemplateID(npcindex)
    for i = 1, 4 do
        if (npcTemplateID == DragonNpcs[i].ID) then
            DrangonIndex = i
        end
    end
    if ((npcTemplateID < 1242) or (npcTemplateID > 1245)) then
        Msg2Player("Th­îng Cæ Long Ch©u chØ cã thÓ sö dông víi Long §«n!")
    else
        if (GetNpcTask(npcindex, 1) == GetCamp()) then
            Msg2Player(DragonNpcs[DrangonIndex].name .. "Ch­a thÓ t¹o ra uy hiÕp cho ng­¬i, kh«ng cÇn nhËn sù cho phÐp")
            return
        end
        if (HaveNormalItem(6, 1, 577, 1) >= 1) then
            DelNormalItem(6, 1, 577, 1)
        else
            DelNormalItemInQuick(6, 1, 577, 1)
        end
        Msg2Player("§· truyÒn søc m¹nh Th­îng Cæ Long Ch©u vµo " .. DragonNpcs[DrangonIndex].name .. ", cã thÓ nhËn ®­îc sù cho phÐp cña" .. DragonNpcs[DrangonIndex].name .. " hay kh«ng lµ do ý trêi.")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c> ®ang sö dông Th­îng Cæ Long Ch©u biÕn ®æi trËn doanh <c=g>" .. DragonNpcs[DrangonIndex].name .. "<c>.")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)
        SetPlayerTarget(DialogNpcIdx)
        BeginMotion(Task_xianmo_wdjx, 1, 3, "\\script\\motion\\Ê¹ÓÃÉÏ¹ÅÁúÖé.lua", nInterrupt)
    end
end

function no()
    CloseDialog()
end
