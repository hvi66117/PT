function main(l, t)
    local w, x, y = GetWorldPos()
    local f = GetCompeteFlag()
    if (f == 1 or CanPolyMorph() == 1) then
        Msg2Player("Trong tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông V« ¶nh Bµn Cæ Trang!")
    else
        if (w == 71) then
            Msg2Player("Khu vùc nµy kh«ng thÓ sö dông V« ¶nh Bµn Cæ Trang")
        else
            Y1, M1, D1 = Time2LocalYMD(t + 2592000)
            Y2, M2, D2 = GetYMD()
            local morphtype = GetMorphType()
            if (morphtype == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                Msg2Player("Trong tr¹ng th¸i nµy kh«ng thÓ sö dông V« ¶nh Bµn Cæ Trang!")
            elseif (morphtype == 82) then
                MsgBox("Bé V« ¶nh Bµn Cæ Trang nµy sö dông ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?", "yes1", "no")
            else
                if (math.floor((SystemTime() - t) / 86400) >= 30) then
                    Talk(1, "no", "Bé V« ¶nh Bµn Cæ Trang nµy ®· qu¸ h¹n!")
                else
                    MsgBox("Bé V« ¶nh Bµn Cæ Trang nµy sö dông ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?", "yes2", "no")
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
    PolyMorph(82, 1, 0, -1, 43200, 1, 1)
    CloseDialog()
end

function no()
    CloseDialog()
end
