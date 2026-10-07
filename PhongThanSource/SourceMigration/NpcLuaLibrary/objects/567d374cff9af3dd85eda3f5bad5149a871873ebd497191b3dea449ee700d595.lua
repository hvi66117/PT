Task_hengcai = 1214;

Task_SXD_KaiQi = 1146

Task_xianmo_renwu = 1297
Task_xianmo_npc = 1298
Task_xianmo_npcIndex = 1299
Task_xianmo_npcID = 1300
Task_faery = 1301

Task_Count = 1665

Forbidden_Buff = 1242
Task_CarID = 1667
Task_Carriagenpcidx = 1666

npc_name = {
    [47] = "HuyÔn Tinh",
    [49] = "Xa BØ Phu Nh©n",
    [50] = "Lôc Ng« §¹i ThÇn"
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local tRenWu = GetByte(GetTask(Task_SXD_KaiQi), 1)
    local tRenWuBuff = HaveIBBuff(404)

    if (npcchr >= 0) and (npcchr <= 7) and GetNpcTemplateID(npcindex) ~= 2099 then
        local i = GetLevel() - 95
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (npcchr < 0 or npcchr > 7) then
        jsyj_call()
    end

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(858) > 0) then
                liesha_city(w)
            end

            local tTeamRenWu = GetByte(GetTask(Task_SXD_KaiQi), 1)
            local tTeamRenWuBuff = HaveIBBuff(404)

            if (tTeamRenWuBuff > 0) and ((tTeamRenWu == 1) or (tTeamRenWu == 2)) then
                SXD_KaiQi_kill(w)
            end


        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(858) > 0) then
            liesha_city(w)
        end

        if (tRenWuBuff > 0) and (tRenWu == 1) then
            SXD_KaiQi_kill(w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 49)
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (HaveIBBuff(493) > 0) then
        local xianmo_m = GetByte(GetTask(Task_xianmo_renwu), 3)
        if (xianmo_m == 50) or (xianmo_m == 51) then
            Frenwu110(mapgid, px, py)
        end
    end

    if (mapgid == 51 and GetTaskByte(Task_Count, 1) == 17 and IsMantlePrentice(PlayerIndex) > 0 and GetNpcID(GetTask(Task_Carriagenpcidx)) == GetTask(Task_CarID) and GetTask(Task_CarID) ~= 0 and GetTaskByte(Task_Count, 1) == 17) then
        if (HaveIBBuff(Forbidden_Buff) == 0) then
            AddIBBuff(Forbidden_Buff)
        end
    end

    if (npcchr >= 0) and (npcchr <= 7) and GetNpcTemplateID(npcindex) == 2099 then
        DelNpc(npcindex)
    end ;

end

function jsyj_call()
    local js_w, js_x, js_y = GetWorldPos()
    local TASK_JIANGSHAN = 1426
    local TASK_JIANGSHAN_PAGE5_STATUS = 1438
    if (GetTaskByte(TASK_JIANGSHAN, 1) == 2 and GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4) == 4) then
        local nRandom = math.random(1, 100)
        if (nRandom <= 2) then
            local nNpcID = AddNpc(2099, 95, SubWorld, js_x * 32, js_y * 32, 1)
            if (nNpcID > 0) then

                SetNpcTimer(nNpcID, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
            end
        end
    end
end

function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 858
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 49 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    elseif (type2 == 49 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    end
end

function no()
    CloseDialog()
end;

function GetKillNum()
    local nKillNum1 = GetByte(GetTask(Task_SXD_KaiQi), 2)
    local nKillNum2 = GetByte(GetTask(Task_SXD_KaiQi), 3)

    if (nKillNum1 >= 254 and nKillNum2 ~= 0) then
        nKillNum1 = nKillNum2 + nKillNum1
    end

    return nKillNum1
end

function SetKillNum(nKillNum)
    if (nKillNum > 254) then
        SetTask(Task_SXD_KaiQi, SetByte(SetByte(GetTask(Task_SXD_KaiQi), 2, 254), 3, nKillNum - 254))
    else
        SetTask(Task_SXD_KaiQi, SetByte(GetTask(Task_SXD_KaiQi), 2, nKillNum))
    end
end

function SXD_KaiQi_kill(WorldID)
    if (GetLevel() < 92) or (HaveIBBuff(404) == 0) then
        return 0
    end

    local tRenWu = GetByte(GetTask(Task_SXD_KaiQi), 1)
    if (tRenWu == 1) then
        local wSB, xSB, ySB = GetWorldPos()
        if (wSB == WorldID) then
            local tKillNUM = GetKillNum()
            if (tKillNUM < 499) then
                local shenyu = 500 - tKillNUM - 1
                SetKillNum(tKillNUM + 1)
                ScrollMessage("B¹n cßn ph¶i tiªu diÖt  " .. shenyu .. "Xa BØ Phu Nh©n!")
                TaskNote(57, 1, tKillNUM + 1)
            else
                SetKillNum(tKillNUM + 1)
                SetTask(Task_SXD_KaiQi, SetByte(GetTask(Task_SXD_KaiQi), 1, 2))
                ScrollMessage("B¹n ®· tiªu diÖt ®ñ sè Xa BØ Phu Nh©n!")
                Msg2Player("B¹n ®· tiªu diÖt ®ñ sè Xa BØ Phu Nh©n!")
                TaskNote(57, 2)
            end
        end
    end
end

function Frenwu40(px, py, templateID)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = math.random(1, 3)
        local dd1 = GetTask(970)
        local dd2 = GetTask(971)
        local d1 = GetTask(964)
        local d2 = GetTask(965)

        if (dd2 < 3) and (templateID == d2) then
            if (p ~= 3) then
                SetTask(971, dd2 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån cña Xa BØ Phu Nh©n")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Xa BØ Phu Nh©n ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Xa BØ Phu Nh©n", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Xa BØ Phu Nh©n ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån cña Xa BØ Phu Nh©n")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Xa BØ Phu Nh©n ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Xa BØ Phu Nh©n", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Xa BØ Phu Nh©n ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
            end
        end

        if (GetTask(971) >= 3) and (GetTask(970) >= 3) then
            Msg2Player("Siªu ®é thµnh c«ng! B¹n h·y quay vÒ Phong ThÇn ®µi gÆp ¢n Hång nhËn th­ëng!")
            TaskNote(48, 2)
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
end

function Frenwu42()

    local rand_buff = math.random(1, 1000)
    local today_buff = math.floor(LocalSystemTime() / 86400)
    if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
        AddIBBuff(369)
        TopMessage(11647)
        SetTask(991, today_buff)
    end
end

function Frenwu110(nm, nx, ny)
    local nums = GetTaskByte(Task_xianmo_npc, 1) + 1
    if (nums > 50) then
        RemoveIBBuff(493)
        return 0
    end

    local px1, py1 = GetTaskWord(Task_faery, 1), GetTaskWord(Task_faery, 2)
    local rv = (nx - px1) ^ 2 + (ny - py1) ^ 2
    if (rv > 400) then
        Msg2Player("C¸c Ma vËt bÞ diÖt ®Òu kh«ng n»m trong ph¹m vi Chó trËn, kh«ng thÓ tô tËp hån ph¸ch")
        return 0
    end

    local growth = nums * GetTaskByte(Task_xianmo_npc, 3) + GetTaskByte(Task_xianmo_npc, 2)
    local ty = GetTaskByte(Task_xianmo_renwu, 4)
    if (math.random(1, 1000) <= growth) then
        local newNpcName = GetName()
        local npcIdx = 0
        local Newindex = 0
        if (ty == 3) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 756)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=water>" .. newNpcName .. "_Tiªn hån<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                TaskNote(90, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        elseif (ty == 4) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 782)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=yel>" .. newNpcName .. "_Ma ph¸ch<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                TaskNote(91, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        else
            return 0
        end
        SetNpcScript(npcIdx, "\\script\\item\\worldevent\\ÏÉ»êÄ§ÆÇ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\ÏÉ»êÄ§ÆÇ.lua", 300)
        SetNpcName(npcIdx, newNpcName)
        SetTask(Task_xianmo_npcIndex, npcIdx)
        SetTask(Task_xianmo_npcID, math.mod(GetNpcID(npcIdx), 2 ^ 31))
        SetCamp(ty)
        SetNpcCurCamp(npcIdx, ty)

        SetTaskByte(Task_xianmo_renwu, 4, (ty + 2))
        RemoveIBBuff(493)
        AddIBBuff(494)
        SetTaskByte(Task_xianmo_npc, 1, 51)
    else
        SetTaskByte(Task_xianmo_npc, 1, nums)
        growth = math.floor(growth / 10)
        if (math.mod(growth, 10) == 0) then
            Msg2Player("Chó trËn ch­a tô hîp ®ñ c¸c hån ph¸ch, h·y tranh thñ thêi gian!")
        end
        TaskNote(87 + ty, 1)
    end
end
