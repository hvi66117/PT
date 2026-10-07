itemname = "LÔ bao S¸ch Ch­ HÇu"
Itemid = { 6, 1, 1438, 1 }

function main(itemID)
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end
    local nTask = {
        "M¶nh s¸ch Ch­ HÇu/suipian",
        "S¸ch Ch­ HÇu (Tµn trang)/canye",
    }
    Say("H·y chän ®¹o cô ngµi muèn nhËn: ", table.getn(nTask), nTask)
end

function suipian()
    no()
    local n = DelNormalItem(Itemid[1], Itemid[2], Itemid[3], Itemid[4])
    local Str = ""
    if (n > 0) then
        AddNormalItem(8, 193, 0, 0, 0, 0)
        Msg2Player("Ngµi sö dông LÔ bao S¸ch Ch­ HÇu, nhËn ®­îc 1 c¸i M¶nh s¸ch Ch­ HÇu, xin nhËn lÊy!")
        Str = "[Thµnh c«ng]"
    else
        Talk(1, "no", "Më lÔ bao thÊt b¹i")
        Str = "[ThÊt b¹i]"
    end
    WriteLog("[LÔ bao S¸ch Ch­ HÇu][Chän m¶nh] " .. Str)
end
function canye()
    no()
    local n = DelNormalItem(Itemid[1], Itemid[2], Itemid[3], Itemid[4])
    local Str = ""
    if (n > 0) then
        AddNormalItem(8, 1422, 0, 0, 0, 0)
        Msg2Player("Ngµi sö dông LÔ bao S¸ch Ch­ HÇu, nhËn ®­îc 1 c¸i S¸ch Ch­ HÇu (Tµn trang), xin nhËn lÊy!")
        Str = "[Thµnh c«ng]"
    else
        Talk(1, "no", "Më lÔ bao thÊt b¹i")
        Str = "[ThÊt b¹i]"
    end
    WriteLog("[LÔ bao S¸ch Ch­ HÇu][Chän Tµn trang]" .. Str)
end
function no()
    CloseDialog()
end
