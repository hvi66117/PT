--ÃÎÈÆ×°.lua
--author: mayining
--date:2009/2/16

function main(itemID)
    local w, x, y = GetWorldPos()
    local t = GetIBItemGenTime(itemID)
    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (w == 71) then
            Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
        else
            if (GetSex() == 1) then
                Y1, M1, D1 = Time2LocalYMD(t + 5184000) --60ÈÕ
                Y2, M2, D2 = GetYMD()
                local morphtype = GetMorphType()
                if (morphtype == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
                    Msg2Player("Kh«ng thÓ sö dông ë tr¹ng th¸i nµy.")
                elseif (morphtype == 457) then
                    MsgBox("Th¸i V©n Trang nµy dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn cëi bé y phôc nµy ®Ó trë l¹i t­íng m¹o tr­íc kia?", "yes1", "no")
                else
                    if (floor((SystemTime() - t) / 86400) >= 60) then
                        CostIBItem(itemID)
                        Talk(1, "no", 13299)
                    else
                        MsgBox("Th¸i V©n Trang nµy dïng ®Õn" .. Y1 .. "N¨m" .. M1 .. "Th¸ng" .. D1 .. ".\n B¹n muèn mÆc bé y phôc nµy ®Ó thay ®æi t­íng m¹o?", "yes2", "no")
                    end
                end
            else
                Talk(1, "no", 13325)
            end
        end
    end
    SetExeState(0)
end

function yes1()
    PolyMorph(-1, 0, 0, 0, 0)
    CloseDialog()
end

function yes2()
    local i = FindAValidIBItem(8, 526, 2, 0)
    local j = FindAValidIBItem(8, 1377, 2, 0)
    if (i ~= 0) or (j ~= 0) then
        PolyMorph(457, 1, 0, -1, 43200, 1, 0, 48)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end

function no()
    CloseDialog()
end