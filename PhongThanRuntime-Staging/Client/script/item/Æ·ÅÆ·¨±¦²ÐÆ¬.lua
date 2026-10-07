function no()
    CloseDialog()
end

function main()
    MsgBox("Œ“æπ ’ºØµΩ¡À’‚√¥∂‡Ph∏p b∂o Truy“n Thuy’t≤–∆¨, ÷ª“™¥’πª 1000 c∏i æÕø…“‘≥¢ ‘∞—À¸√«∫œ≥…≤ª∞Û∂®µƒ<c=y>L‘ bao Ph∏p B∂o Truy“n Thuy’t<c>¡À.œ÷‘⁄æÕ∂Ø ÷∫œ≥… sao?", "Yes_Item", "no")
end

function Yes_Item()
    CloseDialog()
    local num = { [0] = 0, [1] = 0 }
    local nNum = 0
    for i = 0, 1 do
        num[i] = HaveNormalItem(6, 1, 1564, i)
        nNum = nNum + num[i]
    end

    if (nNum < 1000) then
        Talk(1, "no", "ThÀt xin lÁi, ngµi ch≠a ÆÒ Ph∏p b∂o Truy“n Thuy’t≤–∆¨≤ª◊„<c=r>1000<c> c∏i.")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Xin lÁi, tÛi Æ«y, h∑y sæp x’p rÂi gh–p. ")
        return
    end

    nNum = 0
    for i = 1, 0, -1 do
        if (num[i] > 0) then
            for j = 1, num[i] do
                if (DelNormalItem(6, 1, 1564, i) > 0) then
                    nNum = nNum + 1

                    if (nNum >= 1000) then
                        AddNormalItem(6, 1, 1310, 0, 0, 0)
                        Msg2Player("Ngµi nhÀn Æ≠Óc “ªL‘ bao Ph∏p B∂o Truy“n Thuy’t")
                        Talk(1, "no", "Bπn dÔng " .. nNum .. " c∏iPh∏p b∂o Truy“n Thuy’t≤–∆¨∂“ªª¡À 1 c∏i L‘ bao Ph∏p B∂o Truy“n Thuy’t")
                        WriteLog("[L‘ bao Ph∏p B∂o Truy“n Thuy’t∫œ≥…]ø€≥˝" .. nNum .. "µ⁄ÀƒŒª0: " .. num[0] .. " vµ 1: " .. num[1])
                        return 0
                    end
                end
            end
        end
    end
end
