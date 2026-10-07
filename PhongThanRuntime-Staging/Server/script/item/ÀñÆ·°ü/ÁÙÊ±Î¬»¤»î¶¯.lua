item = {
    [1] = { "Thanh Lé (Nh­ ý)", 19, 0, 8, 381, 3 },
    [2] = { "Ch©n KhÝ (Nh­ ý)", 19, 0, 8, 382, 4 },
    [3] = { "T¸ Thanh Lé (Nh­ ý)", 30, 0, 8, 383, 3 },
    [4] = { "Thñy Ch©n KhÝ (Nh­ ý)", 30, 0, 8, 384, 4 },
    [5] = { "5 Linh B¶o", 2, 1, 500 },
}

function main()
    local rand1 = math.random(1, 100)
    local temp = 0
    local updata = table.getn(item)
    for i = 1, updata do
        temp = temp + item[i][2]
        if (rand1 <= temp) then
            local data = item[i]
            local a = data[3]
            if (a == 0) then
                AddNormalItem(data[4], data[5], data[6], 0, 0, 0)
            elseif (a == 1) then
                AddBindCoin(data[4])
            end
            Msg2Player("B¹n nhËn ®­îc " .. data[1])
            TopMessage("B¹n nhËn ®­îc <c=g>" .. data[1])
            WriteLog("B¶o vÖ ho¹t ®éng" .. data[1])
            if (HaveNormalItem(6, 1, 766, 0) > 0) then
                DelNormalItem(6, 1, 766, 0)
            else
                DelNormalItemInQuick(6, 1, 766, 0)
            end
            return 0
        end
    end
end

function no()
    CloseDialog()
end
