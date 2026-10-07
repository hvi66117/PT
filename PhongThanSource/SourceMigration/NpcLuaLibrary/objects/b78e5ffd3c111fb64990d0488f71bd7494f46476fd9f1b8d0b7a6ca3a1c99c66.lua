require("common_beast.luax")

seal_start_template_id = 2407
card_boss = CommonBeast.card_boss
task_number = CommonBeast.task_number
boss_name = CommonBeast.boss_name

function OnDeath(npcindex)

    local template_id = GetNpcTemplateID(npcindex)

    local npc_belonger = GetNpcBelonger(npcindex)

    local team_id = GetTeam()
    local old_playerindex = PlayerIndex
    local log = "击杀" .. boss_name[template_id - 2407]

    local award_list = {}
    for _, value in ipairs(card_boss) do
        if (value.hardType == template_id) then
            award_list = value.award_kill
            break
        end
    end

    local Y, M, D = GetYMD()
    if (team_id > 0) then
        local log = "击杀队伍的队员有"
        local size = GetTeamSize()
        if (size > 0) then
            for i = 1, size do
                PlayerIndex = GetTeamMember(i)
                log = log .. GetName() .. ","
                if (GetTaskByte(CommonBeast.task_number, 4) ~= D) then
                    SetTask(CommonBeast.task_number, 0)
                    SetTaskByte(CommonBeast.task_number, 4, D)
                end

                local task_num = GetTaskByte(task_number, 2)
                if (task_num < 2) then
                    SetTaskByte(task_number, 2, task_num + 1)

                    local award_name = CommonBeast.AddAward(award_list)
                    if (award_name == nil) then
                        WriteLog("[Ho箃 ng Hung Th骫[boss相关][击杀]K輈h s竧 Boss奖励异常")
                        return
                    end

                    Msg2Player("成功消灭凶兽, nh薾 頲 " .. award_name)
                    local tmp = task_num + 1
                    WriteLog("[Ho箃 ng Hung Th骫[boss相关][击杀]K輈h s竧 Boss(" .. boss_name[template_id - 2407] .. ",队伍id为" .. team_id .. ",当天第" .. tmp .. "次击杀,获得奖励" .. award_name)
                end
            end
            WriteLog("[Ho箃 ng Hung Th骫[boss相关][击杀]" .. log)
        end

        PlayerIndex = old_playerindex
    else
        if (GetTaskByte(CommonBeast.task_number, 4) ~= D) then
            SetTask(CommonBeast.task_number, 0)
            SetTaskByte(CommonBeast.task_number, 4, D)
        end

        local task_num = GetTaskByte(task_number, 2)
        if (task_num >= 2) then
            return
        end

        SetTaskByte(task_number, 2, task_num + 1)
        local award_name = CommonBeast.AddAward(award_list)
        if (award_name == nil) then
            return
        end

        Msg2Player("成功消灭凶兽, nh薾 頲 " .. award_name)
        local tmp = task_num + 1
        WriteLog("[Ho箃 ng Hung Th骫[boss相关][击杀]K輈h s竧 Boss(" .. boss_name[template_id - 2407] .. ",队伍id为" .. team_id .. ",当天第" .. tmp .. "次击杀,获得奖励" .. award_name)
    end
end

