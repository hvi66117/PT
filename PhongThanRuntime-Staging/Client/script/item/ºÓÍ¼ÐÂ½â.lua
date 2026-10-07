Task_hetu = 1387

Hetu_position1 = {
    { name = "1" },
    { name = "3" },
    { name = "7" },
    { name = "9" },
}

Hetu_position2 = {
    { name = "2" },
    { name = "4" },
    { name = "6" },
    { name = "8" },
}

function main()

    if (GetTaskByte(Task_hetu, 1) == 1) then
        if (GetTaskByte(Task_hetu, 2) == 1) then
            TaskNote(1043, 1, 0, "1")
        else
            TaskNote(1043, 1, 0, "2")
        end
    end

    Talk(3, "renwu", "QuyÓn 1: Hµ §å vèn lµ thÇn thó Long M· th­îng cæ hiÕn cho Phôc Hy, ch©n th©n hãa thµnh ¶o ¶nh, cã thÓ lµm tinh thÇn bÞ mª hoÆc. Muèn gi¶i trõ, chØ cã thÓ theo <c=g>thø tù<c> ®¸nh dÊu trªn (Hµ §å) thu phôc c=g>Long M·<c> trong Linh th¹ch trÊn phong  t¹i 4 h­íng.", "QuyÓn 2:Trªn (Hµ §å) tæng céng cã 8 con sè, dïng sè chän ra, ph¶i theo sù gîi ý ph­¬ng h­íng con sè t×m ®­îc Linh th¹ch cña BÊt Chu Thiªn Quan, phãng thÝch Long M· vµ thu phôc toµn bé 8 Long M· míi cã thÓ xãa bá ¶o gi¸c.", "QuyÓn 3:TriÖu gäi vµ thu phôc Long M· , ®Òu ph¶i lµm <c=g>®ång bé<c> míi ®­îc, do 2 ng­êi ®i h­íng kh¸c nhau, sau khi ë 1 phÝa triÖu gäi hoÆc thu phôc, phÝa kia còng ph¶i trong  <c=g>thêi gian qui ®Þnh<c> triÖu gäi vµ thu phôc.")

end

function renwu()
    CloseDialog()

    local hetu_state = GetTaskByte(Task_hetu, 1)

    if (hetu_state >= 1 and hetu_state <= 4) then

        local pos1 = Hetu_position1[hetu_state].name
        local pos2 = Hetu_position2[hetu_state].name

        if (GetTaskByte(Task_hetu, 2) == 1) then
            Talk(1, "no", "QuyÓn 4: B©y giê cÇn ®i ®Õn <c=g>" .. pos1 .. "<c> tÊt c¶ ph­¬ng h­íng, sau khi cïng ®ång ®éi thu phôc ®ång bé, tù ®éng sÏ cã gîi ý b­íc tiÕp theo.")
        else
            Talk(1, "no", "QuyÓn 4: B©y giê cÇn ®i ®Õn <c=g>" .. pos2 .. "<c> tÊt c¶ ph­¬ng h­íng, sau khi cïng ®ång ®éi thu phôc ®ång bé, tù ®éng sÏ cã gîi ý b­íc tiÕp theo.")
        end
    else
        Talk(1, "no", "QuyÓn 4: Chóc mõng b¹n!<c=g>Long M·<c> ®· bÞ thu phôc hoµn toµn, ®· xãa bá ®­îc ¶nh ¶o!")
    end
end

function no()
    CloseDialog()
end
