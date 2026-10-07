task_deer = 1467

task_deer_npc = 1468
global_boss_index = 208
global_boss_id = 209

function OnDeath(npcidx)
    local npcid = GetNpcID(npcidx)
    if (npcid == GetTask(task_deer_npc)) then
        if (GetTeam() ~= 0) then
            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                if (npcid == GetTask(task_deer_npc)) and (GetTaskByte(task_deer, 2) == 1) then
                    SetTaskByte(task_deer, 2, 2)
                    TaskNote(103, 1)
                    RemoveIBBuff(686)
                    AddIBBuff(686, 10 * 60)
                end
            end
            PlayerIndex = oldPlayer
            Msg2Team("Thiªn YÕt hãa ph©n th©n thµnh 3, hiÖn ®ang xuÊt hiÖn t¹i phÝa T©y, phÝa B¾c vµ phÝa Nam, h·y nhanh chèng t×m vµ tiªu diÖt h¾n, ng­¬i chØ cã thêi gian 10 phót ®Ó t×m chóng.")
        elseif (GetTaskByte(task_deer, 2) == 1) then
            SetTaskByte(task_deer, 2, 2)
            TaskNote(103, 1)
            RemoveIBBuff(686)
            AddIBBuff(686, 10 * 60)
            Msg2Team("Thiªn YÕt hãa ph©n th©n thµnh 3, hiÖn ®ang xuÊt hiÖn t¹i phÝa T©y, phÝa B¾c vµ phÝa Nam, h·y nhanh chèng t×m vµ tiªu diÖt h¾n, ng­¬i chØ cã thêi gian 10 phót ®Ó t×m chóng.")
        end
        local item_pos = {
            { 1783, 3235 },
            { 1627, 3476 },
            { 1842, 3831 },
        }
        local Newindex = 0
        for i = 1, 3 do
            Newindex = AddNpc(1064, 55, SubWorld, item_pos[i][1] * 32, item_pos[i][2] * 32)
            if (Newindex > 0) then
                SetNpcScript(Newindex, "\\script\\¹ÖÎï\\Ð«»¢npc.lua")
                SetNpcTimer(Newindex, "\\script\\ontimer\\ÌìÐ«.lua", 60 * 10)
                SetNpcName(Newindex, "<c=g>YÕt Hæ<c>")
            else
                WriteLog("Gia t¨ng YÕt Hæ npc thÊt b¹i:" .. i)
            end
        end
        SetWorldEventValue(3, 19, 2)
        WriteLog(GetName() .. "§¸nh b¹i Thiªn H¹t 1")
    else
        SetGlobalValue(global_boss_index, 0)
        SetGlobalValue(global_boss_id, 0)
        SetWorldEventValue(3, 15, 0)
        WriteLog(GetName() .. "§¸nh b¹i Thiªn H¹t 1, thÊt b¹i")
    end

    DelNpc(npcidx)
end;
