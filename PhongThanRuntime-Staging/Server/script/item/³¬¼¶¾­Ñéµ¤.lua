function main()
    if (HaveNormalItem(6, 1, 1355, 1) <= 0) then
        return
    end

    local nLevel = GetLevel()
    if (GetLevel() >= 200 and GetJusticEvilCredit() ~= 0) then
        MsgBox("Hi�n t�i �� �� c�p, s� d�ng 1 Kinh Nghi�m ��n, nh�n <c=g>2<c> gi� tr�ng th�i Thi�n Gi�ng Th�n T�i, ��ng � s� d�ng kh�ng?", "SureGetBuff", "no")
    else
        if (DelNormalItem(6, 1, 1355, 1) > 0) then
            local nExp = math.floor((1700.51 * nLevel * nLevel + 1829.65 * nLevel - 66382) * 5)
            -- The original formula was restricted to level 40+.  Keep it for
            -- existing levels, but never pass a negative amount for level 1-39.
            if (nExp < 1) then
                nExp = 1000000
            end
            AddOwnExp(nExp)
            Msg2Player("S� d�ng Kinh Nghi�m ��n nh�n ���c " .. nExp .. " �i�m kinh nghi�m.")
            WriteLog("S� d�ng Kinh Nghi�m ��n nh�n ���c " .. nExp .. " �i�m kinh nghi�m.")
        end
    end
end

function SureGetBuff()
    no()
    if (HaveNormalItem(6, 1, 1355, 1) <= 0) then
        return
    end

    if (DelNormalItem(6, 1, 1355, 1) > 0) then
        AddIBBuff(228, 7200)
        Msg2Player("S� d�ng Kinh Nghi�m ��n nh�n ���c 2 gi� tr�ng th�i Thi�n Gi�ng Th�n T�i.")
        WriteLog("S� d�ng Kinh Nghi�m ��n nh�n ���c 2 gi� tr�ng th�i Thi�n Gi�ng Th�n T�i.")
    end
end

function no()
    CloseDialog()
end
