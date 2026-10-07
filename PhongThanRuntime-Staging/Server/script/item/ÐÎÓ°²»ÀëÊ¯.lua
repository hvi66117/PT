function main(sel)
    if (IsSameMap() == 1) then
        local beihai = GetBit(GetTask(1055), 9)
        local xikunlun = GetBit(GetTask(1055), 10)
        local julu = GetBit(GetTask(1055), 11)
        local juelongling = GetBit(GetTask(1055), 12)
        local chentangguan = GetBit(GetTask(1055), 13)

        local w, x, y = GetWorldPos()
        if (beihai == 0) and (w == 6) then
            if (GetTask(1056) == 0) then
                wutongshen(9, x, y)
            else
                MsgBox("Ngò Th«ng ThÇn ë c¸c n¬i kh¸c <c=g>vÉn ch­a bŞ khuÊt phôc<c>. NÕu b¹n khiªu chiÕn ngay t¹i ®©y, cã thÓ Ngò Th«ng ThÇn ch­a bŞ khuÊt phôc sÏ bŞ <c=r>th¶ ®i<c>mÊt. B¹n x¸c ®Şnh tiÕp tôc khiªu chiÕn Ngò Th«ng ThÇn ngay t¹i ®©y chø?", "yes", "no")
            end
        elseif (xikunlun == 0) and (w == 9) then
            if (GetTask(1056) == 0) then
                wutongshen(10, x, y)
            else
                MsgBox("Ngò Th«ng ThÇn ë c¸c n¬i kh¸c <c=g>vÉn ch­a bŞ khuÊt phôc<c>. NÕu b¹n khiªu chiÕn ngay t¹i ®©y, cã thÓ Ngò Th«ng ThÇn ch­a bŞ khuÊt phôc sÏ bŞ <c=r>th¶ ®i<c>mÊt. B¹n x¸c ®Şnh tiÕp tôc khiªu chiÕn Ngò Th«ng ThÇn ngay t¹i ®©y chø?", "yes", "no")
            end
        elseif (julu == 0) and (w == 13) then
            if (GetTask(1056) == 0) then
                wutongshen(11, x, y)
            else
                MsgBox("Ngò Th«ng ThÇn ë c¸c n¬i kh¸c <c=g>vÉn ch­a bŞ khuÊt phôc<c>. NÕu b¹n khiªu chiÕn ngay t¹i ®©y, cã thÓ Ngò Th«ng ThÇn ch­a bŞ khuÊt phôc sÏ bŞ <c=r>th¶ ®i<c>mÊt. B¹n x¸c ®Şnh tiÕp tôc khiªu chiÕn Ngò Th«ng ThÇn ngay t¹i ®©y chø?", "yes", "no")
            end
        elseif (juelongling == 0) and (w == 19) then
            if (IsCanKill() < 2) then
                MsgBox(13152, "yes", "no")
            elseif (GetTask(1056) ~= 0) then
                MsgBox("Ngò Th«ng ThÇn ë c¸c n¬i kh¸c <c=g>vÉn ch­a bŞ khuÊt phôc<c>. NÕu b¹n khiªu chiÕn ngay t¹i ®©y, cã thÓ Ngò Th«ng ThÇn ch­a bŞ khuÊt phôc sÏ bŞ <c=r>th¶ ®i<c>mÊt. B¹n x¸c ®Şnh tiÕp tôc khiªu chiÕn Ngò Th«ng ThÇn ngay t¹i ®©y chø?", "yes", "no")
            else
                wutongshen(12, x, y)
            end
        elseif (chentangguan == 0) and (w == 65) then
            if (IsCanKill() < 2) then
                MsgBox(13152, "yes", "no")
            elseif (GetTask(1056) ~= 0) then
                MsgBox("Ngò Th«ng ThÇn ë c¸c n¬i kh¸c <c=g>vÉn ch­a bŞ khuÊt phôc<c>. NÕu b¹n khiªu chiÕn ngay t¹i ®©y, cã thÓ Ngò Th«ng ThÇn ch­a bŞ khuÊt phôc sÏ bŞ <c=r>th¶ ®i<c>mÊt. B¹n x¸c ®Şnh tiÕp tôc khiªu chiÕn Ngò Th«ng ThÇn ngay t¹i ®©y chø?", "yes", "no")
            else
                wutongshen(13, x, y)
            end
        else
            Talk(1, "no", 13153)
        end
    else
        Talk(1, "no", 13154)
    end ;
end;

function yes()
    local w, x, y = GetWorldPos()

    if (w == 6) or (w == 9) or (w == 13) or (w == 19) or (w == 65) then
        local mapToIdx = { [6] = 9, [9] = 10, [13] = 11, [19] = 12, [65] = 13 }
        wutongshen(mapToIdx[w], x, y)
    end
end

function wutongshen(mapid, mx, my)
    local a = { [9] = 582, [10] = 583, [11] = 586, [12] = 585, [13] = 584 }
    local npcWTIdx = AddNpc(a[mapid], 60, SubWorld, mx * 32, my * 32)
    if (npcWTIdx > 0) then
        local mark = CostIBItem(FindAValidIBItem(8, 357, 2, 0))
        if (mark == 1) then
            CloseDialog()
            local oldPlayer = PlayerIndex
            for i = 1, 2 do
                PlayerIndex = GetTeamMember(i)
                SetTask(1056, npcWTIdx)
                SetTask(1055, SetBit(GetTask(1055), mapid, 1))
            end
            PlayerIndex = oldPlayer
        else
            Talk(1, "no", 13155)
        end
    else
        Talk(1, "no", 13156)
    end
end

function no()
    CloseDialog()
end;

function IsCanKill()
    local oldPlayer = PlayerIndex
    local i, j
    j = 0
    for i = 1, 2 do
        PlayerIndex = GetTeamMember(i)
        if (GetLevel() >= 80) then
            j = j + 1
        end
    end
    PlayerIndex = oldPlayer
    return j
end

function IsSameMap()
    local mark = 0
    if (GetTeamSize() == 2) then
        if (IsMarried() == 1) and (GetTask(801) == GetMateNameID()) and (GetMateTask(801) == GetNameID()) then
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;

            local oldPlayer = PlayerIndex
            local w1, x1, y1, w, x, y
            w, x, y = GetWorldPos()

            PlayerIndex = n
            w1, x1, y1 = GetWorldPos()
            if (w1 == w) then
                mark = 1
            end
            PlayerIndex = oldPlayer
        end
    end
    return mark
end
