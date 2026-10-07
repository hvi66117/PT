--description: ÌìĞ«
--author: yaoxin
--date:2009/5/30

task_deer = 1467 -- 1½ÓÈÎÎñÊ±¼ä,2 Íê³É×´Ì¬(1½Ó,2É±ËÀÌìĞ«,ÌìĞ«·ÖÉí,3É±ËÀ·ÖÉí,ÌìĞ«¸´»î,4É±ËÀ¸´»îÌìĞ«,¸´Ãü,5Áì½±Íê³É, 6ÁìÉùÍûÍê³É)
--µÚ¶ş½×¶Î, 3byte ½ÓÈÎÎñÊ±¼ä, 4Íê³É×´Ì¬(1½Ó,2¸½Éí¶ÁÌõ,3ÕÙboss,4¸´Ãü,5Íê³É)
task_deer_npc = 1468 --µÚ1½×¶Î´ænpcµÄid,×÷Îª±êÖ¾,µÚ¶ş½×¶ÎÕÙ³öÊ±ÎªnpcµÄid,×÷ÎªÊ¶±ğ
global_boss_index = 208 -- ÌìĞ«µÄidx
global_boss_id = 209 -- ÌìĞ«µÄid

function OnDeath(npcidx)
    local npcid = GetNpcID(npcidx)
    if (npcid == GetTask(task_deer_npc)) then
        if (GetTeam() ~= 0) then
            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            -- ±éÀú¶ÓÖĞ¶ÓÔ±
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
            Msg2Team("Thiªn YÕt hãa ph©n th©n thµnh 3, hiÖn ®ang xuÊt hiÖn t¹i phİa T©y, phİa B¾c vµ phİa Nam, h·y nhanh chèng t×m vµ tiªu diÖt h¾n, ng­¬i chØ cã thêi gian 10 phót ®Ó t×m chóng.")
        elseif (GetTaskByte(task_deer, 2) == 1) then
            SetTaskByte(task_deer, 2, 2)
            TaskNote(103, 1)
            RemoveIBBuff(686)
            AddIBBuff(686, 10 * 60)
            Msg2Team("Thiªn YÕt hãa ph©n th©n thµnh 3, hiÖn ®ang xuÊt hiÖn t¹i phİa T©y, phİa B¾c vµ phİa Nam, h·y nhanh chèng t×m vµ tiªu diÖt h¾n, ng­¬i chØ cã thêi gian 10 phót ®Ó t×m chóng.")
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
                SetNpcScript(Newindex, "\\script\\¹ÖÎï\\Ğ«»¢npc.lua")
                SetNpcTimer(Newindex, "\\script\\ontimer\\ÌìĞ«.lua", 60 * 10)
                SetNpcName(Newindex, "<c=g>YÕt Hæ<c>")
            else
                WriteLog("Gia t¨ng YÕt Hæ npc thÊt b¹i:" .. i)
            end
        end
        SetWorldEventValue(3, 19, 2)--ÊÀ½çÊÂ¼şÉèÖÃ,1½Ó,2·ÖÉí,3·ÖÉíËÀ1,4·ÖÉíËÀ2,5·ÖÉíËÀ3,¸´»î,6Íê³É
        WriteLog(GetName() .. "§¸nh b¹i Thiªn H¹t 1")
    else
        SetGlobalValue(global_boss_index, 0)
        SetGlobalValue(global_boss_id, 0)
        SetWorldEventValue(3, 15, 0)
        WriteLog(GetName() .. "§¸nh b¹i Thiªn H¹t 1, thÊt b¹i")
    end

    DelNpc(npcidx)
end;