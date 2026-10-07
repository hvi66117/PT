TASK_day = 305
TASK_map = 306
TASK_Time = 307
TASK_Npcindex = 336

function OnDeath(npcidx)
    local w, x, y = GetWorldPos()
    local mapid, posx, posy = GetNpcWorldPos(npcidx)
    local nLevel = 200
    local nTongName = ""
    local key = 0
    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (w == GetTaskByte(TASK_map, 1)) and (npcidx == GetTask(TASK_Npcindex)) then
                SetTaskByte(TASK_map, 3, 1)
                Msg2Player("Chóc mõng b¹n vµ ®ång ®éi ®· b¾t ®­îc kÎ gi¶ danh! Mau quay vÒ l·nh ®Şa nhËn th­ëng!")
                SetTask(TASK_Npcindex, 0)
                TaskNote(31, 4)
                nLevel = GetLevel()
                nTongName = GetTongName()
                key = 1
                i = membercount
            end
        end
        PlayerIndex = oldPlayer
    elseif (w == GetTaskByte(TASK_map, 1)) and (npcidx == GetTask(TASK_Npcindex)) then
        SetTaskByte(TASK_map, 3, 1)
        Msg2Player("Chóc mõng b¹n b¾t ®­îc kÎ gi¶ danh! Mau quay vÒ l·nh ®Şa nhËn th­ëng!")
        SetTask(TASK_Npcindex, 0)
        TaskNote(31, 5)
        key = 1
    end ;

    if (GetTeam() ~= 0 and key == 1) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (GetLevel() >= (nLevel + 10) and nTongName ~= "" and nTongName == GetTongName()) then
                local nMapId, nPosX, nPosY = GetWorldPos()
                if (nMapId == mapid and math.abs((nPosX - posx) * (nPosX - posx) + (nPosY - posy) * (nPosY - posy)) <= 800) then
                    local nTaskDay = GetTaskByte(1990, 2)
                    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
                    if (nTaskDay ~= nToday) then
                        SetTaskByte(1990, 1, 0)
                        SetTaskByte(1990, 2, nToday)
                    end
                    local nTimes = GetTaskByte(1990, 1)
                    if (nTimes < 20) then
                        SetTaskByte(1990, 1, nTimes + 1)
                        AddNormalItemBind(6, 1, 1197, 1, 0, 0, 1)
                        Msg2Player("ÄúºÃĞÄµØ°ïÖú±¾¹ú³ÉÔ±Íê³ÉÁË°Ğ³¡ÊÔÁ¶! nhËn ®­îc ÈÊÒåÊ¯ËéÆ¬!")
                        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\">ºÃĞÄµØ°ïÖú±¾¹ú³ÉÔ±Íê³ÉÁË°Ğ³¡ÊÔÁ¶! nhËn ®­îc ÈÊÒåÊ¯ËéÆ¬!</bc>")

                    else
                        Msg2Player("ÄúºÃĞÄµØ°ïÖú±¾¹ú³ÉÔ±Íê³ÉÁË°Ğ³¡ÊÔÁ¶!Äú½ñÌìÒÑ¾­ nhËn ®­îc 20 c¸i ÈÊÒåÊ¯ËéÆ¬, ÎŞ·¨¼ÌĞø»ñµÃÈÊÒåÊ¯ËéÆ¬ÁË.")
                        Msg2TongMember("<bc=r><RoleName=\"" .. GetName() .. "\">ºÃĞÄµØ°ïÖú±¾¹ú³ÉÔ±Íê³ÉÁË°Ğ³¡ÊÔÁ¶!</bc>")
                    end
                end
            end
        end
        PlayerIndex = oldPlayer
    end

    if (key == 0) and (GetCityName() ~= "") then
        local NpcName = GetNpcName(npcidx)
        AddIBBuff(367)
        if (NpcName ~= "") or (NpcName ~= nil) then
            local playername = GetName()
            Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\"> DiÖt trõ kÎ m¹o danh <bc=wh>" .. NpcName .. "</bc><bc=r>, nhËn ®­îc Th¸nh Háa LÖnh </bc>")
        end
    end
    DelNpc(npcidx)
end;
