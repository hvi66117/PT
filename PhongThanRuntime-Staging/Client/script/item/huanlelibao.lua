function main()
    MsgBox("Tr­íc khi më LÔ bao, xin dän hµnh trang ph¶i cßn Ýt nhÊt 2 « trèng!", "OpenBox", "no")
end

function no()
    CloseDialog()
end

function OpenBox()
    CloseDialog()
    lingfu = {
        [1] = "Hång S¸t Phï",
        [2] = "B¨ng Kiªu Trïng Phï",
        [3] = "HuyÔn Tinh Phï",
        [4] = "Háa Tµ Phï",
        [5] = "L©n Yªu Phï",
        [6] = "Cù Th¹ch Phï",
        [7] = "Th¸i Tö phï",
        [8] = "Nham Thó Phï",
        [9] = "Tö Nha phï",
        [10] = "¶i Nh©n Phï",
        [11] = "§¹i §iªu Phï",
        [12] = "Bµn Cæ Phï",
        [13] = "Long Nh©n phï",
        [14] = "TÞnh Phong Phï",
        [15] = "Th¶o Tiªn Phï",
        [16] = "B¨ng Linh Phï",
        [17] = "Hæ Nh©n Phï",
        [18] = "Quû §¨ng Phï"
    }
    if (HaveNormalItem(6, 1, 417, 0) > 0) then
        local str = "Chóc mõng b¹n nhËn ®­îc ngo¹i trang Niªn thó"
        local lingfuOne
        local linfuTwo

        AddNormalItem(6, 1, 418, 0, 0, 0)

        for i = 1, 2 do
            local k = math.random(1, 18)
            if (i == 1) then
                lingfuOne = k
            else
                lingfuTwo = k
            end

            if (k == 1) then
                AddNormalItem(8, 96, 2, 0, 0, 0)
            elseif (k == 2) then
                AddNormalItem(8, 110, 2, 0, 0, 0)
            elseif (k == 3) then
                AddNormalItem(8, 93, 2, 0, 0, 0)
            elseif (k == 4) then
                AddNormalItem(8, 90, 2, 0, 0, 0)
            elseif (k == 5) then
                AddNormalItem(8, 78, 2, 0, 0, 0)
            elseif (k == 6) then
                AddNormalItem(8, 83, 2, 0, 0, 0)
            elseif (k == 7) then
                AddNormalItem(8, 224, 2, 0, 0, 0)
            elseif (k == 8) then
                AddNormalItem(8, 58, 2, 0, 0, 0)
            elseif (k == 9) then
                AddNormalItem(8, 225, 2, 0, 0, 0)
            elseif (k == 10) then
                AddNormalItem(8, 54, 2, 0, 0, 0)
            elseif (k == 11) then
                AddNormalItem(8, 105, 2, 0, 0, 0)
            elseif (k == 12) then
                AddNormalItem(8, 75, 2, 0, 0, 0)
            elseif (k == 13) then
                AddNormalItem(8, 52, 2, 0, 0, 0)
            elseif (k == 14) then
                AddNormalItem(8, 108, 2, 0, 0, 0)
            elseif (k == 15) then
                AddNormalItem(8, 107, 2, 0, 0, 0)
            elseif (k == 16) then
                AddNormalItem(8, 109, 2, 0, 0, 0)
            elseif (k == 17) then
                AddNormalItem(8, 113, 2, 0, 0, 0)
            elseif (k == 18) then
                AddNormalItem(8, 99, 2, 0, 0, 0)
            end
        end
        str = str .. " vµ 2 biÕn th©n phï"
        DelNormalItem(6, 1, 417, 0)
        TopMessage(str)
        Msg2Player(str)
    else
        WriteLog("Hñy tói vui vÎ!")
    end
end
