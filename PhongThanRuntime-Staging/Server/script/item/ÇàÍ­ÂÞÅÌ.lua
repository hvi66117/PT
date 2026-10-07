gMineTask = 1654

Task_snjuli = 1655
gMineNote = 1509

function main()


    local instanceType = GetCurrentInstanceType(PlayerIndex)
    if (instanceType ~= 4) then
        Talk(1, "no", "<c=r>Ng¹i qu¸! La Bµn nµy chØ cã thÓ sö dông trong phã b¶n Hµn B¨ng TrËn.<c>")
        return
    end

    local lightname = {
        [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }
    local mapid, x1, y1 = GetWorldPos()
    local px = 189 * 8
    local py = 196 * 16
    local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))

    local light = 1;
    if (distance <= 25) then
        light = 4;
    elseif (distance <= 400) then
        light = 3;
    elseif (distance <= 2500) then
        light = 2;
    end ;
    local msg = "La Bµn ph¸t ra" .. lightname[light]
    local lastdist = GetTask(Task_snjuli)

    if ((light == 4) and (lastdist >= 0)) then
        msg = msg .. ", manh mèi h×nh nh­ ®ang ë ngay gÇn chç b¹n, h·y chó ý t×m kü nhÐ!"
        MsgBox(msg, "xizuowb", "no")
    else
        if (lastdist == -1) then
            msg = msg .. ", manh mèi h×nh nh­ ë ngay trong khu vùc nµy!"
        elseif (lastdist < distance) then
            msg = msg .. ", h×nh nh­ b¹n ®· ®i <color=red>ra xa<color> manh mèi!"
        else
            msg = msg .. ", h×nh nh­ b¹n ®ang <color=red>®Õn gÇn<color> manh mèi!"
        end
        Talk(1, "no", msg)
    end ;
    SetTask(Task_snjuli, distance)
end

function xizuowb()
    if ((HaveNormalItemInQuick(6, 1, 788, 0) >= 1) or (HaveNormalItem(6, 1, 788, 0) >= 1)) then
        if (HaveNormalItem(6, 1, 788, 0) >= 1) then
            DelNormalItem(6, 1, 788, 0)
        elseif (HaveNormalItemInQuick(6, 1, 788, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 788, 0)
        end ;
        Msg2Player("Manh mèi ®· xuÊt hiÖn!")
        Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>Cuèc chim<c>.")

        SetTaskByte(gMineTask, 1, 6)
        AddNormalItem(3, 1082, 0, 0, 0, 0)
    else
        Talk(1, "no", "B¹n kh«ng cã <c=g>La Bµn §ång<c>.")
    end
end

function no()
    CloseDialog()
end;
