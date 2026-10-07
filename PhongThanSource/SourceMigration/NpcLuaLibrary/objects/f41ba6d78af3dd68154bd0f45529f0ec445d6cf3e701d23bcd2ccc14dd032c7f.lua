--Descript:´«Áî¹Ù.lua
--Author:jiaruoting
--Date:09/10/26

instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒýµ¼ÈÎÎñ 7=½Ó¹ý¹Ø 8=¹ýÌì¾ø 9=¹ýµØÁÒ 10=¹ý·çºð 11=Íê³É¹ý¹Ø
--2byte:0=Î´½Ó 1=½Ó 2=É±µØÁÒBOSS 3=½ÓÏÞÊ±É±·çºð 4=Íê³É 
function OnDeath(npcindex)
    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcindex, 1)
    if (GetTeam() == 0) then
        if (GetTaskByte(instence_Task, 2) == 1) then
            local m, x, y = GetNpcWorldPos(npcindex)
            local secnpcidx = AddNpc(1520, 1, SubWorld, x * 32, y * 32)
            SetNpcScript(secnpcidx, "\\script\\instance\\ÖÜ¾ü½«Áì.lua")
            SetInstanceTempValue(25, secnpcidx);
            SetInstanceTempValue(26, GetNpcID(secnpcidx))
            Msg2Player("D­êng nh­ ®· b¾t ®­îc 1 Binh sÜ Qu©n Chu, mau qua ®ã xem thö!")
        end
    else
        local oldPlayer = PlayerIndex
        local oldPlayer = PlayerIndex
        local AddNum = 0
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(instence_Task, 2) == 1) then
                if (AddNum == 0) then
                    local m, x, y = GetNpcWorldPos(npcindex)
                    local secnpcidx = AddNpc(1520, 1, SubWorld, x * 32, y * 32)
                    SetNpcScript(secnpcidx, "\\script\\instance\\ÖÜ¾ü½«Áì.lua")
                    SetInstanceTempValue(25, secnpcidx);
                    SetInstanceTempValue(26, GetNpcID(secnpcidx))
                    Msg2Player("D­êng nh­ ®· b¾t ®­îc 1 Binh sÜ Qu©n Chu, mau qua ®ã xem thö!")
                    AddNum = AddNum + 1
                end
            end
        end
        PlayerIndex = oldPlayer
    end

    DelNpc(npcidx)
    InstanceIndex = oldInstance
end