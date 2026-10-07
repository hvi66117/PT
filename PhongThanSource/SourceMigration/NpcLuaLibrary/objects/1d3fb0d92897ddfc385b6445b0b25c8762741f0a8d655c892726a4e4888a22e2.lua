------------------------------------------------
--description: °Ð³¡£º£¨3¼¶³ÇÊÐ½¨Öþ£©boss
--author: yaoxin
--date: 2007-09-11
--304×÷·Ï£¬
TASK_day = 305 --Ê±¼ä´Á
TASK_map = 306 --1½Ó¹ÖËùÔÚµØÍ¼, ¼°2½Ó¹Ö·½Î», 3Íê³ÉµÄ±êÖ¾
TASK_Time = 307 --½ñÌì½Ó¹ýÈÎÎñµÄ´ÎÊý 
TASK_Npcindex = 336-- ´æ·Å¶ÔÓ¦×Ô¼ºµÄnpcÐòºÅ
------------------------------------------------------------

function OnDeath(npcidx)
    local w, x, y = GetWorldPos()
    local key = 0
    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (w == GetTaskByte(TASK_map, 1)) and (npcidx == GetTask(TASK_Npcindex)) then
                SetTaskByte(TASK_map, 3, 1)
                Msg2Player("Chóc mõng b¹n vµ ®ång ®éi ®· b¾t ®­îc kÎ gi¶ danh! Mau quay vÒ l·nh ®Þa nhËn th­ëng!")
                SetTask(TASK_Npcindex, 0)
                TaskNote(31, 4)
                key = 1
                i = membercount
            end
        end
        PlayerIndex = oldPlayer
    elseif (w == GetTaskByte(TASK_map, 1)) and (npcidx == GetTask(TASK_Npcindex)) then
        SetTaskByte(TASK_map, 3, 1)
        Msg2Player("Chóc mõng b¹n b¾t ®­îc kÎ gi¶ danh! Mau quay vÒ l·nh ®Þa nhËn th­ëng!")
        SetTask(TASK_Npcindex, 0)
        TaskNote(31, 5)
        key = 1
    end ;

    if (key == 0) and (GetCityName() ~= "") then
        local NpcName = GetNpcName(npcidx)
        AddIBBuff(367)--ÐþÌú,Ê¥»ðÁî
        if (NpcName ~= "") or (NpcName ~= nil) then
            local playername = GetName()
            Msg2TongMember("<bc=r><RoleName=\"" .. playername .. "\">DiÖt trõ kÎ m¹o danh<bc=wh>" .. NpcName .. "</bc><bc=r>, nhËn ®­îc Th¸nh Háa LÖnh </bc>")
        end
    end
    DelNpc(npcidx)
end;