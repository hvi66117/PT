function main(l, t)

    local w, x, y = GetWorldPos()
    local f = GetCompeteFlag()

    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (w == 71) then
            Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
        else

            local Y1, M1, D1 = Time2LocalYMD(t + 604800)
            local Y2, M2, D2 = GetYMD()
            local morphtype = GetMorphType()

            if (morphtype == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                Msg2Player("Kh«ng thÓ sö dông ë tr¹ng th¸i nµy.")
            elseif (morphtype == 357) then
                MsgBox("Th¸i V©n Trang nµy dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?", "yes1", "no")
            else
                MsgBox("Th¸i V©n Trang nµy dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?", "yes2", "no")
            end
        end
    end

end

function yes1()

    CloseDialog()
    PolyMorph(-1, 0, 0, 0, 0)

end

function yes2()

    CloseDialog()
    PolyMorph(357, 1, 0, -1, 43200, 1)

end

function no()
    CloseDialog()
end
