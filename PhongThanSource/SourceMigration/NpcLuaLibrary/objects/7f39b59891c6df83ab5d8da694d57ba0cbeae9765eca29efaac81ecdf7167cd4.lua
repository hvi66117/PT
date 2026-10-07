Task_SXD_FZhang = 1149

Task_SXD_RenWu = 1147

Task_FangZ_Credit = 1150

Task_FangZ_Darge = 1151

function OnDeath(npcindex)

    local membercount = GetTeamSize()
    local tRenWu = GetByte(GetTask(Task_SXD_FZhang), 1)
    SetTask(Task_FangZ_Darge, 0)
    if (membercount == 0) then
        if (tRenWu == 2) then
            TopMessage("B¹n nhËn ®­îc 1 r©u Giao Long")
            Msg2Player("B¹n nhËn ®­îc 1 r©u Giao Long!")
            SetTask(Task_SXD_FZhang, SetByte(GetTask(Task_SXD_FZhang), 1, 3))
            AddNormalItem(3, 180, 0, 0, 0, 0)
            TaskNote(58, 2)
        end
    else
        local tOldIndex = PlayerIndex
        for i = 1, membercount do
            local w, x, y = GetWorldPos()
            PlayerIndex = GetTeamMember(i)
            local tMemRenWu = GetByte(GetTask(Task_SXD_FZhang), 1)
            if (tMemRenWu == 2 and w == 55) then
                TopMessage("B¹n nhËn ®­îc 1 r©u Giao Long")
                Msg2Player("B¹n nhËn ®­îc 1 r©u Giao Long!")
                SetTask(Task_SXD_FZhang, SetByte(GetTask(Task_SXD_FZhang), 1, 3))
                AddNormalItem(3, 180, 0, 0, 0, 0)
                TaskNote(58, 2)
            else
                Talk(1, "no", "¸m Giao Long thuéc tæ ®éi ng­¬i ®· bÞ giÕt, xin thµnh viªn ch­a kÝch ho¹t rêi ®éi ®Ó kÝch ho¹t l¹i!")
            end
        end
        PlayerIndex = tOldIndex
    end
    DelNpc(npcindex)
end;

function no()
    CloseDialog()
end

