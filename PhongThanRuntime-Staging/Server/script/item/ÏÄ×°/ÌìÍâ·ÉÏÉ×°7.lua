function main(l, t)
    local w, x, y = GetWorldPos()
    local f = GetCompeteFlag()
    if (f == 1 or CanPolyMorph() == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (w == 71) then
            Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
        else
            local tbl_NewDress = { 1932, 1933 }
            local nSex = GetSex() + 1
            if (nSex <= 0 or nSex > 2) then
                return
            end
            Y1, M1, D1 = Time2LocalYMD(t + 86400 * 7)
            Y2, M2, D2 = GetYMD()
            local morphtype = GetMorphType()
            if (morphtype == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                Msg2Player("Kh«ng thÓ sö dông ë tr¹ng th¸i nµy.")
            elseif (morphtype == tbl_NewDress[nSex]) then
                MsgBox("Bé trang bÞ Thiªn Ngo¹i Phi Tiªn Trang h¹n sö dông ®Õn ngµy " .. D1 .. " th¸ng " .. M1 .. " n¨m " .. Y1 .. ".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?", "yes1", "no")
            else
                if (math.floor((SystemTime() - t) / 86400) >= 7) then
                    Talk(1, "no", "Bé trang bÞ Thiªn Ngo¹i Phi Tiªn Trang ®· hÕt h¹n.")
                else
                    MsgBox("Bé trang bÞ Thiªn Ngo¹i Phi Tiªn Trang h¹n sö dông ®Õn ngµy " .. D1 .. " th¸ng " .. M1 .. " n¨m " .. Y1 .. ".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?", "yes2", "no")
                end
            end
        end
    end
end

function yes1()
    PolyMorph(-1, 0, 0, 0, 0)
    CloseDialog()
end

function yes2()
    local tbl_NewDress = { 1932, 1933 }
    local nSex = GetSex() + 1
    if (nSex <= 0 or nSex > 2) then
        return
    end
    PolyMorph(tbl_NewDress[nSex], 1, 0, -1, 43200)
    CloseDialog()
end

function no()
    CloseDialog()
end
