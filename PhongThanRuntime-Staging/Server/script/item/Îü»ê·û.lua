Task_XiHun = 1180
Task_XiHun_x = 1183
Task_XiHun_y = 1184
Task_XiHun_begin = 1185

function no()
    CloseDialog()
end;

function main()
    if (GetTask(Task_XiHun_begin) > 0) then
        Talk(1, "no", "HÊp Hån TrËn kh«ng thÓ thi triÓn liªn tôc, h·y <c=r>hoµn thµnh hoÆc hñy nhiÖm vô<c> råi tiÕp tôc l¹i!")
        return 0
    end

    local npcname = {
        [1] = "¶i Nh©n",
        [2] = "Quang Quû",
        [3] = "L·o §ång",
        [4] = "S¬n Tiªu",
        [5] = "V« Danh Thó",
        [6] = "Th¹ch Di",
    }
    local mapname = {
        [0] = "ChØ ®Þnh",
        [1] = "§«ng Doanh",
        [2] = "Ph­¬ng Tr­îng",
    }

    local mapid, px, py = GetWorldPos()
    local mapSetid = GetByte(GetTask(Task_XiHun), 3)

    if (mapid == mapSetid + 54) then
        local r = math.random(2, 5)
        SetTask(Task_XiHun_x, px)
        SetTask(Task_XiHun_y, py)
        SetTask(Task_XiHun_begin, SystemTime())
        Msg2Player("B¹n t¹i" .. mapname[mapSetid] .. " lËp 1 HÊp Hån TrËn")
        TopMessage("B¹n t¹i <c=g>" .. mapname[mapSetid] .. "<c> lËp 1 HÊp Hån TrËn")
        DelNormalItem(6, 1, 344, 0)
        DelNormalItemInQuick(6, 1, 344, 0)
        if (r == 2) then
            r = 1
        end
        AddNpc(671 + r, 1, SubWorld, px * 32, py * 32)
        AddIBBuff(426 + r)
    else
        Talk(1, "no", "H·y thi triÓn HÊp Hån TrËn t¹i<c=g>" .. mapname[mapSetid] .. "<c> trªn khu vùc.")
    end
end;
