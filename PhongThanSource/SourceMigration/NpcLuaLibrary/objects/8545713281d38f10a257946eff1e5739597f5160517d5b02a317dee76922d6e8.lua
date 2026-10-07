--description:∑¸ÙÀ∫Û»À À¿ÕˆΩ≈±æ
--author: zhaoqingsong
--date: 2009-6-22

-- 1Byte£∫0Œ¥Ω”°¢1µ√µΩ–ﬁ–– ¶÷∏“˝°¢2¥Úø™¥´ÀÕ√≈°¢3¥´ÀÕµΩΩ™◊”—¿¥¶
--        4ªÒµ√Ω™◊”—¿µ¿æﬂ∫”Õº¬Â È°¢5”§¡È±‰…Ì ß–ß°¢6ª÷∏¥±æ…Ì°¢7º§ªÓ¡À∑®÷˘°¢8’˜∑˛∑¸ÙÀ°¢10ÕÍ≥…
Task_YinGuoLunHui = 1489
Task_LunHui_Time = 1490

Conf_LH_Npc_Trap = 1146
Conf_LH_Npc_Soul = 468
Conf_LH_Npc_Penstock = 1144
Conf_LH_Npc_FXDialog = 1142
Conf_LH_Npc_FXFight = 1143

Conf_LH_Npc_Self = {
    [0] = { [0] = 1147, [1] = 1148 }, --º◊ ø
    [1] = { [0] = 1149, [1] = 1150 }, --µ¿ ø
    [2] = { [0] = 1151, [1] = 1152 }, --“Ï»À
}

Conf_LH_Buff_A = 717    -- ¥´ÀÕ
Conf_LH_Buff_B = 718    -- ±‰…Ì
Conf_LH_Buff_C = 719    -- ∑¸ÙÀ∂‘ª∞
Conf_LH_Buff_D = 720    -- ∑¸ÙÀ’Ω∂∑
Conf_LH_Buff_E = 721    -- ∑®÷˘

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --º◊ ø
    [1] = { task = 1, note = 87 }, --µ¿ ø
    [2] = { task = 2, note = 88 }, --“Ï»À
}

Task_HelpScore = 1491
SCORE_LIMIT = 100 --√ø÷‹ªÒµ√ª˝∑÷…œœﬁ

function OnDeath(npcidx)
    local teamSize = GetTeamSize()
    local bindPlayerID = GetNpcTask(npcidx, 1)
    if (teamSize == 0) then
        local playerID = GetPlayerID()
        if (playerID == bindPlayerID and HaveIBBuff(Conf_LH_Buff_D) > 0) then
            SetTaskByte(Task_YinGuoLunHui, 1, 8)
            TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 45)
            RemoveIBBuff(Conf_LH_Buff_D)
            TopMessage("ß∑ chinh phÙc t™n Ti Ti÷n h©u nh©n PhÙc Hy.")
            Msg2Player("ß∑ chinh phÙc t™n Ti Ti÷n h©u nh©n PhÙc Hy, c„ th” Æ’n t◊m Tu Hµnh S≠ b∏i bi÷t!")
        end
    else
        local playerIndexCache = PlayerIndex
        local isValid = 0

        local addScore = 0  --Add by liuzhiqiang at 2009/7/3
        local array = {}
        local help_num = 1

        for i = 1, teamSize do
            PlayerIndex = GetTeamMember(i)
            local playerID = GetPlayerID()
            if (playerID == bindPlayerID and HaveIBBuff(Conf_LH_Buff_D) > 0) then
                isValid = 1
                break
            end
        end
        if (isValid == 1) then
            for i = 1, teamSize do
                PlayerIndex = GetTeamMember(i)
                if (HaveIBBuff(Conf_LH_Buff_D) > 0) then
                    SetTaskByte(Task_YinGuoLunHui, 1, 8)
                    TaskNote(MainTask_GD_Conf[GetPlayerType()].note, 45)
                    RemoveIBBuff(Conf_LH_Buff_D)
                    TopMessage("ß∑ chinh phÙc t™n Ti Ti÷n h©u nh©n PhÙc Hy.")
                    Msg2Player("ß∑ chinh phÙc t™n Ti Ti÷n h©u nh©n PhÙc Hy, c„ th” Æ’n t◊m Tu Hµnh S≠ b∏i bi÷t!")

                    addScore = addScore + 4
                    array[help_num] = GetName()
                    help_num = help_num + 1
                end
            end
        end
        PlayerIndex = playerIndexCache

        -----------------Add by liuzhiqiang at 2009/7/2 start------------------∞Ô÷˙ª˝∑÷
        local scoreLimit = GetTaskByte(Task_HelpScore, 3)
        if (addScore > 0) then
            if (GetTask(3) >= 165 or GetTask(1) >= 165 or GetTask(2) >= 165) then
                if (scoreLimit < SCORE_LIMIT) then
                    scoreLimit = scoreLimit + addScore
                    if (scoreLimit > SCORE_LIMIT) then
                        addScore = SCORE_LIMIT - GetTaskByte(Task_HelpScore, 3)
                    end
                    SetTaskByte(Task_HelpScore, 3, scoreLimit)
                    AddHelpScore(addScore)
                    local str = ""
                    for i = 1, help_num - 1 do
                        str = str .. "<c=g><RoleName=\"" .. array[i] .. "\"><c> "
                    end
                    AddEvent("%s Æ∑ Æ∏nh bπi <c=g>HÀu Nh©n PhÙc Hy<c>, giÛp" .. str .. " khi™u chi’n nhi÷m vÙ chÒ tuy’n c p 65, nhÀn Æ≠Óc ßi”m nh©n ngh‹a" .. addScore .. "ßi”m kinh nghi÷m.", 1)  --∂‘∫√”—∑¢≥ˆœ˚œ¢
                    Msg2Player("ChÛc mıng! Bπn nhÀn Æ≠Óc" .. addScore .. " Æi”m Nh©n Ngh‹a!")
                    WriteLog(GetName() .. "NhÀn Æ≠Óc" .. addScore .. " Æi”m Nh©n Ngh‹a.")
                else
                    Msg2Player("Ngπi qu∏! MÁi ng≠Íi mÁi tu«n chÿ c„ th” nhÀn Æ≠Óc " .. SCORE_LIMIT .. " Æi”m Nh©n Ngh‹a, tu«n nµy bπn Æ∑ nhÀn tËi Æa rÂi.")
                end
            end
        end
        -----------------Add by liuzhiqiang at 2009/7/2 end  ------------------∞Ô÷˙ª˝∑÷
    end
    DelNpc(npcidx)
end
