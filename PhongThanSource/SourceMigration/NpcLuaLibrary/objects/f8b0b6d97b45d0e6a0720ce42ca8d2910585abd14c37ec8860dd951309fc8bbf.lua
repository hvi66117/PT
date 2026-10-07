--description: ÄêÊÞ
--author: lilingxu
--date:2007/2/1


function OnDeath(npcidx)
    SetGlobalValue(929, 0)
    DelNpc(npcidx)

    AddGlobalCountNews(11652, 20)
    Msg2Player("§· hµng phôc ®­îc Niªn Thó! Chóc b¹n n¨m míi vui vÎ!")
    TopMessage(11653)
    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    if (GetTeam() ~= 0) then
        -- ¦³¶¤¥î(¥]¬A¥u¦³¦Û¤v¤@­Ó¤Hªº)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- ¹M¾ú¶¤¤¤¶¤­û
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            city_shouji(w)
        end
        PlayerIndex = oldPlayer
    else
        -- µL¶¤¥î
        city_shouji(w)
    end ;
end

function city_shouji(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        AddNormalItem(8, 235, 2, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Niªn Thó phï")
    end
end
