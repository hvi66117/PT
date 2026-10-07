TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_PAGE5_STATUS = 1438
TASK_INFO_JIANGSHAN_PAGE5 = 1058

function no()
    CloseDialog()
end
function main(l, t, TargetNpcIndex)
    if (GetTaskByte(TASK_JIANGSHAN, 1) == 3) then
        MsgBox("Giang S¬n Y Cùu. Nga Mao Bót nµy ®· kh«ng cßn h÷u dông n÷a, b¹n muèn vøt bá nã kh«ng?", "del", "no")
        return 0
    end
    if (TargetNpcIndex == 0) then
        return
    end

    if (GetTaskByte(TASK_JIANGSHAN, 1) == 2) then
        UseProperty(GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4), TargetNpcIndex)
    end
end

function del()
    CloseDialog()
    ClearItem(6, 1, 503, 0)
end
function UseProperty(missionid, npcindex)


    if (IsPlayer(npcindex) == 1) then
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 8, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 0)

    local npcTemplateID = GetNpcTemplateID(npcindex)
    local type = GetHardNpcAttrib(npcindex)
    local duration = 3
    local mapid, x, y = GetWorldPos()

    if (mapid < 47 or mapid > 51) then
        return
    end

    if (type == 7) then
        type = 6
    end

    if (missionid == 2) then


        local scale = GetNpcLife(npcindex) / GetNpcLifeMax(npcindex)

        if ((scale <= 0.5) and (type ~= -1) and (npcTemplateID == 45 or npcTemplateID == 2097)) then
            SetPlayerTarget(npcindex)
            BeginMotion(TASK_JIANGSHAN, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)
        else
            Msg2Player("ChØ thu thËp T­¬ng LiÔu ThÇn lam m¸u vµng")
        end

    elseif (missionid == 3) then


        local scale = GetNpcLife(npcindex) / GetNpcLifeMax(npcindex)

        if ((scale <= 0.5) and (type ~= -1) and (npcTemplateID == 46 or npcTemplateID == 2098)) then
            local saved = GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3)

            if (type == 7) then
                type = 6
            end

            if (saved == 255) then

                SetPlayerTarget(npcindex)
                BeginMotion(type + 1, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)


            elseif (saved ~= type) then
                SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 1, 1)
                SetPlayerTarget(npcindex)
                BeginMotion(type + 1, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)

            else
                Msg2Player("B¹n ®· thu thËp ký øc cïng lo¹i")
            end

        else
            Msg2Player("ChØ thu thËp HuyÔn Tinh Xanh m¸u vµng")
        end


    elseif (missionid == 4) then


        local scale = GetNpcLife(npcindex) / GetNpcLifeMax(npcindex)

        if ((scale <= 0.5) and (type ~= -1) and (npcTemplateID == 48 or npcTemplateID == 2099)) then

            local saved = GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3)
            if (saved == 255) then

                SetPlayerTarget(npcindex)
                BeginMotion(type + 1, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)

            elseif (saved ~= type and saved < 10) then

                SetPlayerTarget(npcindex)
                BeginMotion(type + 1, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)

            elseif (saved >= 10) then
                local s1 = math.floor(saved / 10)
                local s2 = saved - s1 * 10

                if (s1 ~= type and s2 ~= type) then
                    SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 1, 1)
                    SetPlayerTarget(npcindex)
                    BeginMotion(type + 1, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)
                else
                    Msg2Player("B¹n ®· thu thËp ký øc cïng lo¹i")
                end
            else
                Msg2Player("B¹n ®· thu thËp ký øc cïng lo¹i")
            end

        else
            Msg2Player("ChØ thu thËp Xa BØ Phu Nh©n Xanh m¸u vµng")
        end


    elseif (missionid == 5) then


        local m, x, y = GetWorldPos()
        local nm, npcx, npcy = GetNpcWorldPos(npcindex)
        local distance = ((x - npcx) ^ 2 + (y - npcy) ^ 2) ^ 0.5 * 32

        if (distance <= 320 and (npcTemplateID == 49 or npcTemplateID == 2100) and (type ~= -1)) then
            nInterrupt = SetBit(nInterrupt, 4, 1)
            SetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 3, 1)
            SetPlayerTarget(npcindex)
            BeginMotion(TASK_JIANGSHAN, 1, duration, "\\script\\motion\\ÊÕ¼¯¼ÇÒä.lua", nInterrupt)
        elseif ((npcTemplateID == 49 or npcTemplateID == 2100) and (type ~= -1)) then
            ScrollMessage("Lôc Ng« §¹i ThÇn xanh b¶n tÝnh ®a nghi, b¹n ph¶i tiÕn gÇn h¬n n÷a")
        end

    end
end
