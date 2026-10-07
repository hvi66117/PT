function main(l, t)
    local w, x, y = GetWorldPos()
    local f = GetCompeteFlag()
    if (f == 1 or CanPolyMorph() == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (w == 71) then
            Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
        else
            local Y1, M1, D1 = Time2LocalYMD(t + 604800)
            local Y2, M2, D2 = GetYMD()
            if (GetSex() == 0) then
                local morphtype = GetMorphType()
                if (morphtype == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                    Msg2Player("Kh«ng thÓ sö dông ë tr¹ng th¸i nµy.")
                elseif (morphtype == 788) then
                    MsgBox("Hoa sinh nhËt nµy h¹n dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?", "yes1", "no")
                else
                    if (math.floor((SystemTime() - t) / 86400) >= 7) then
                        Talk(1, "no", 13359)
                    else
                        MsgBox("Hoa sinh nhËt nµy h¹n dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?", "yes2m", "no")
                    end
                end
            else
                local morphtype = GetMorphType()
                if (morphtype == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                    Msg2Player("Kh«ng thÓ sö dông ë tr¹ng th¸i nµy.")
                elseif (morphtype == 789) then
                    MsgBox("Hoa sinh nhËt nµy h¹n dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?", "yes1", "no")
                else
                    if (math.floor((SystemTime() - t) / 86400) >= 7) then
                        Talk(1, "no", 13359)
                    else
                        MsgBox("Hoa sinh nhËt nµy h¹n dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?", "yes2w", "no")
                    end
                end
            end
        end
    end
end

function yes1()
    PolyMorph(-1, 0, 0, 0, 0)
    CloseDialog()
end

function yes2m()
    PolyMorph(788, 1, 0, -1, 43200)
    CloseDialog()
end

function yes2w()
    PolyMorph(789, 1, 0, -1, 43200)
    CloseDialog()
end

function no()
    CloseDialog()
end
