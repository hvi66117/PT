--’‹¬ﬁ”„.lua
--author:gaojingwei
--date:2009/04/16

-----------≥ıœ÷∂Àƒﬂ »˝”„÷Æ¬“-----------------
Task_Variety_Process = 1389        --1byte: 0√ª¡Ï»ŒŒÒ£¨1¡Ï¡À»ŒŒÒ 2‘⁄–«πŸ¥¶¡Ï»°¡ÀΩ±¿¯ 3¡Ï»°¡ÀÃΩ÷™…≥ªÍµƒ»ŒŒÒ 4≥…π¶”Îµ•¥ø…≥ªÍ∂‘ª∞ 5‘⁄ª∆ÃÏªØ¥¶¡Ï»°¡ÀΩ±¿¯
--6¡Ï»°¡À…±»˝”„µƒ»ŒŒÒ  7”Î“Ω…˙∂‘ª∞ 8”Î¥ÛÕ∑”„∂‘ª∞ 9”Î’€¬ﬁ”„∂‘ª∞ 10”Îæﬁπ«…‡”„∂‘ª∞ 11‘⁄ª∆ÃÏªØ¥¶Ω±¿¯
--12º˚ÕÍ◊£»⁄£¨13…±ÕÍ15∏ˆª¿Î–°—˝£¨14µ√µΩΩı≤Ø£¨15◊£»⁄‘ƒ∂¡º«“‰∫Û£¨16¡Ï»°ª∆ÃÏªØΩ±¿¯    -----ª¿Îæ´∆«
--2byte: 1Ω”µΩπ˝≥ıº˚∂ÀƒﬂµƒÕ®÷™ 2Ω”µΩπ˝»˝”„÷Æ¬“µƒÕ®÷™ 3Ω”µΩπ˝ª¿Îæ´∆«µƒÕ®÷™ 4 Ω”µΩπ˝±≥∫Û÷˜ƒ±µƒÕ®÷™
--3byte£∫±æ¥Œ…±À¿ª¿Î–°—˝µƒ ˝ƒø
--4Byte:±æ¥Œ…±À¿æ˙»Àµƒ ˝ƒø
Task_Time_Stemp = 1390        --º«¬º…±µ•¥ø…≥ªÍ£¨∫Õ»˝∏ˆ”„µƒ ±º‰
Task_NpcID = 1391            --º«¬ºµ•¥ø…≥ªÍ∫Õ»˝∏ˆ”„µƒ ±º‰
puteGhost = 956                --µ•¥ø…≥ªÍµƒtemplateID
bigHeadFish = 952            --¥ÛÕ∑”„µƒµƒtemplateID
foldFish = 952                --’€¬·”„µƒtemplateID
greatTongueFish = 952        --æﬁπ«…‡”„µƒtemplateID

Coordinate = --»˝∏ˆ”„µƒ◊¯±Í
{
    [1] = { desc = "[203,202]", link = "ß´ng H∂i ThÒy V˘c [37,203,202]" },
    [2] = { desc = "[216,199]", link = "ß´ng H∂i ThÒy V˘c [37,216,199]" },
    [3] = { desc = "[219,192]", link = "ß´ng H∂i ThÒy V˘c [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045
-----------≥ıœ÷∂Àƒﬂ »˝”„÷Æ¬“-----------------
function OnDeath(npcindex)
    -- Added by Zhaoqingsong at 2009-5-6 Begin
    processJiangshan(npcindex)
    -- Added by Zhaoqingsong at 2009-5-6 End
    local flag = 0
    if (GetTeam() == 0 and GetTaskByte(Task_Variety_Process, 1) == 8) then
        flag = 1
    elseif (GetTeam() ~= 0) then
        local oldPlayerIndex = PlayerIndex
        local memberNum = GetTeamSize()
        for i = 1, memberNum do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_Variety_Process, 1) == 8) then
                flag = 1
                break
            end
        end
        PlayerIndex = oldPlayerIndex
    end

    if (flag == 1) then
        if (GetTask(Task_Time_Stemp) + 60 >= SystemTime()) then
            --æ‡¿Î…œ¥Œ Õ∑≈npc’€¬·”„µƒ ±º‰≤ªπª1∑÷÷”
            return
        end

        local id, x, y = GetNpcWorldPos(npcindex)

        local fishIndex = AddNpc(foldFish, 1, SubWorldID2Idx(id), x * 32, y * 32)                    --‘ˆº”“ª÷ªπ÷
        SetNpcScript(fishIndex, "\\script\\¡˙Ã◊\\’‹¬ﬁ”„.lua")
        SetNpcName(fishIndex, "<c=g>Tri’t La Ng≠<c>")
        SetNpcTimer(fishIndex, "\\script\\ontimer\\…æµÙ◊‘º∫.lua", 60)                            --3∑÷÷”∫Û◊‘∂Øœ˚ ß
        local fishID = GetNpcID(fishIndex)

        if (GetTeam() == 0) then
            SetTask(Task_NpcID, fishID)
            SetTask(Task_Time_Stemp, SystemTime())
            TopMessage("Xu t hi÷n 1 Tri’t La Ng≠ lπ")
            Msg2Player("Tri’t La Ng≠ xu t hi÷n, mau tÌi h·i manh mËi.")
            return
        end

        ----±È¿˙∂”ŒÈƒ⁄µƒÕÊº“£¨∂‘”⁄”–œ‡Õ¨»ŒŒÒµƒÕÊº“£¨∞—ghostID∫Õ…±π÷ ±º‰º«¬ºµΩ»ŒŒÒ±‰¡ø÷–
        if (GetTeam() ~= 0) then
            local oldPlayerIndex = PlayerIndex
            local memberNum = GetTeamSize()
            for i = 1, memberNum do
                PlayerIndex = GetTeamMember(i)
                SetTask(Task_Time_Stemp, SystemTime())
                if (GetTaskByte(Task_Variety_Process, 1) == 8) then
                    SetTask(Task_NpcID, fishID)
                    TopMessage("Xu t hi÷n 1 Tri’t La Ng≠ lπ")
                    Msg2Player("Tri’t La Ng≠ xu t hi÷n, mau tÌi h·i manh mËi.")
                end
                PlayerIndex = oldPlayerIndex
            end
        end
    end
end

-- Added by Zhaoqingsong at 2009-5-6 Begin  Ω≠…Ω“¿æ… 5-15 …œœﬂ

-- 1Byte 0Œ¥Ω¯––æÌ“ª£ª1 æÌ“ªÕÍ≥…£ª2 æÌ∂˛ÕÍ≥…£ª3 æÌ»˝ÕÍ≥…
-- 2Byte 0Œ¥ø™ º£ª1 ª√œÛ1ÕÍ≥…£ª2 ª√œÛ2ÕÍ≥…£ª...“¿¥Œ¿‡Õ∆
TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

CONST_JS_FISH = {
    { name = "ßπi ß«u Ng≠", ratio = 50 },
    { name = "Tri’t La Ng≠", ratio = 80 },
    { name = "C˘ CËt Thi÷t Ng≠", ratio = 100 },
}

function processJiangshan(npcindex)
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµÿÕºº∞◊¯±Í
    local teamSize = GetTeamSize()
    if (teamSize == 0) then
        processJiangshanForOne(npcindex)
    else
        local playerIndexCache = PlayerIndex
        for i = 1, teamSize do
            PlayerIndex = GetTeamMember(i)
            local mapid2, x2, y2 = GetWorldPos()
            if (mapid2 == mapgid) then
                processJiangshanForOne(npcindex)
            end
        end
        PlayerIndex = playerIndexCache
    end
end

function processJiangshanForOne(npcindex)
    if (GetLevel() < 35) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page2Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 3)
    if (mainStatus > 0 or oneStep ~= 3 or page2Step ~= 3) then
        return 0
    end
    local twoStepStatus = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3)
    local twoStepOption = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 4)
    if (twoStepStatus ~= 1 or twoStepOption ~= 1) then
        return 0
    end
    local twoStepOption2 = GetTaskByte(TASK_JIANGSHAN_ONE_DATE, 3)
    if (twoStepOption2 ~= 2) then
        return 0
    end

    SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3, 2)
    SetTaskByte(TASK_JIANGSHAN_ONE_DATE, 3, 0)
    TaskNote(Task_Info_JIANGSHAN_TWO, 7)
    FinishNpcCollection(6)
    TopMessage("Thi’t Ng≠ v≠¨ng c©u k’t ng≠Íi ngoµi hπi ta")
    Msg2Player("GiÛp Thi’t Ng≠ v≠¨ng di÷t trı Tri’t La Ng≠ thµnh c´ng, ch¯ng th˘c Thi’t Ng≠ v≠¨ng ch›nh lµ nÈi ¯ng n®m x≠a cÒa D≠ Kh∏nh, v“ phÙc m÷nh D≠ Kh∏nh.")
end

-- Added by Zhaoqingsong at 2009-5-6 End
