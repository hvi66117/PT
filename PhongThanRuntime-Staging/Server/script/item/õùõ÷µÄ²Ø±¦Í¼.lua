Task_ibyq = 1613
Task_yq = 1614

Task_szxh = 1615

Task_szbzxy = 1616
Task_szbzdis = 1617
Family_szxh = 21

TaskNote_szxh = 1503

function main()
    local lightname = {
        [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }
    local mapid, x1, y1 = GetWorldPos()
    if (mapid ~= 92) then
        Talk(1, "no", "Tµng b¶o ®å hiÓn thÞ B¶o tµng ®ang ë <c=r>Khe nøt ViÔn Cæ<c>!")
        return
    end

    local px = GetTaskWord(Task_szbzxy, 1)
    local py = GetTaskWord(Task_szbzxy, 2)
    local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))

    local light = 1;
    if (distance <= 25) then
        light = 4;
    elseif (distance <= 400) then
        light = 3;
    elseif (distance <= 2500) then
        light = 2;
    end ;
    local msg = "Tµng b¶o ®å Tú H­u ph¸t ra " .. lightname[light]

    local lastdist = GetTask(Task_szbzdis)
    if (light == 4) and (lastdist >= 0) then
        msg = msg .. ", B¶o tµng Tú H­u h×nh nh­ ®ang ë gÇn ®©y, b¹n h·y chó ý t×m kü nhÐ!"
        MsgBox(msg, "pixiuwb", "no")
    else
        if (lastdist == -1) then
            msg = msg .. ", B¶o tµng Tú H­u h×nh nh­ ë ngay trong khu vùc nµy!"
        elseif (lastdist < distance) then
            msg = msg .. ", H×nh nh­ b¹n ®· ®i <color=red>ra xa<color> B¶o tµng Tú H­u."
        else
            msg = msg .. ", H×nh nh­ b¹n ®ang <color=red>®Õn gÇn<color> B¶o tµng Tú H­u."
        end
        Talk(1, "no", msg)
    end ;
    SetTask(Task_szbzdis, distance)
end

function pixiuwb()

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Hµnh trang cña b¹n ®· ®Çy, kh«ng thÓ ®µo B¶o tµng.")
        return
    end

    local possibility = math.random(1, 100)

    if (possibility <= 25) then
        AddNormalItem(3, 934, 0, 0, 0, 0, 0)
    elseif (possibility <= 40) then
        AddNormalItem(3, 935, 0, 0, 0, 0, 0)
    elseif (possibility <= 50) then
        AddNormalItem(3, 936, 0, 0, 0, 0, 0)
    elseif (possibility <= 63) then
        AddNormalItem(3, 919, 0, 0, 0, 0, 0)
    elseif (possibility <= 76) then
        AddNormalItem(3, 920, 0, 0, 0, 0, 0)
    elseif (possibility <= 84) then
        AddNormalItem(3, 921, 0, 0, 0, 0, 0)
    elseif (possibility <= 91) then
        AddNormalItem(3, 922, 0, 0, 0, 0, 0)
    elseif (possibility <= 96) then
        AddNormalItem(3, 923, 0, 0, 0, 0, 0)
    else
        AddNormalItem(3, 924, 0, 0, 0, 0, 0)
    end

    if (HaveNormalItem(6, 1, 758, 0) >= 1) then
        DelNormalItem(6, 1, 758, 0)
    else
        DelNormalItemInQuick(6, 1, 758, 0)
    end
    Msg2Player("B¹n ®· ®µo ®­îc B¶o tµng Tú H­u!")
    Talk(1, "no", "B¹n nhËn ®­îc B¶o tµng Tú H­u!")
end

function no()
    CloseDialog()
end;
