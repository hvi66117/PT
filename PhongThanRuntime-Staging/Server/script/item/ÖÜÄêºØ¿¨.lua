require(" Æ÷‹ƒÍªÓ∂Ø.luax")

function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (HaveNormalItem(6, 1, 1570, 1) <= 0) then
        local temp = HaveNormalItem(6, 1, 1570, 0)
        if (temp > 0) then
            for i = 1, temp do
                DelNormalItem(6, 1, 1570, 0)
                AddNormalItemBind(6, 1, 1570, 1, 0, 0, 1)
            end
        else
            return
        end
    end

    local y, m, d = GetYMD()
    if not (y == 2017 and m == 6 and (d >= 13 and d <= 25)) then
        ClearItem(6, 1, 1570, 1)
        ClearItem(6, 1, 1570, 0)
        InfoBox("ªÓ∂ØΩ· ¯, [÷‹ƒÍ∫ÿø®]“—æ≠◊˜∑œ¡À!")
        WriteLog("[ThÀp Chu Ni™n][÷‹ƒÍ∫ÿø®][ ’ªÿ]")
        return 0
    end

    local tasks = {
        { "Kinh Nghi÷m ß¨n-Si™u c p", "shop1"; show = 1 },
        { "Th«n T≠Ìng DÙ L÷nh", "shop2"; show = 1 },

        { "÷‹ƒÍ∫ÿø®ΩÈ…‹", "shuoming"; show = 1 },
    }
    SayTask("‘⁄ªÓ∂Ø∆⁄º‰, Ω¯––÷∏∂®»ŒŒÒ, Ω´ªÒµ√µ¿æﬂ[÷‹ƒÍ∫ÿø®], √øÃÏªÒ»°…œœﬁŒ™ 10 c∏i .\n◊¢: [÷‹ƒÍ∫ÿø®]ø…“‘∂“ªª“‘œ¬Ω±¿¯, Ω±¿¯ŒÔ∆∑Ω‘Œ™∞Û∂®µƒ, 6‘¬25»’∫Û÷‹ƒÍ∫ÿø®Ω´µΩ∆⁄œ˚ ß.\nMÍi l˘a ch‰n:", tasks)
end

function shuoming()
    Talk(1, "main", "‘⁄6‘¬13»’~6‘¬22»’∆⁄º‰, √øHoµn thµnh nhi÷m vÙ “‘œ¬“ª¥Œ∂ºΩ´ªÒµ√µ¿æﬂ[÷‹ƒÍ∫ÿø®], √øÃÏªÒ»°…œœﬁŒ™ 10 c∏i .\nÕÍ≥…“ª¥ŒÕÚœ…’Û: 1 c∏i \nÕÍ≥…“ª¥ŒVÀn L≠¨ng: 1 c∏i \nÕÍ≥…“ª¥ŒLi÷p M∑ Th≠Îng Kim:  2 c∏i \nΩµ∑˛ÕÚœ…’ÛÕ®ÃÏΩÃ÷˜:  10 c∏i")
end

function shop1()
    MsgBox("Kinh Nghi÷m ß¨n-Si™u c p:  10 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 1 c∏i Kinh Nghi÷m ß¨n-Si™u c p(Kho∏), ƒ„œ÷‘⁄“™∂“ªª sao?", "Yes_shop1", "main")
end

function Yes_shop1()
    no()
    if (HaveNormalItem(6, 1, 1570, 1) < 10) then
        Talk(1, "no", "ThÀt xin lÁi, ƒ˙µƒ[÷‹ƒÍ∫ÿø®]≤ª◊„,  10 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 1 c∏i Kinh Nghi÷m ß¨n-Si™u c p!")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lÁi, tÛi kh´ng ÆÒ, h∑y sæp x’p tÛi.")
        return
    end

    for i = 1, 10 do
        DelNormalItem(6, 1, 1570, 1)
    end
    AddNormalItemBind(6, 1, 1355, 1, 0, 0, 1)
    Talk(1, "no", "ƒ„ π”√ 10 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 1 c∏i Kinh Nghi÷m ß¨n-Si™u c p")
    Msg2Player("ƒ„≥…π¶ π”√ 10 c∏i ÷‹ƒÍ∫ÿø®∂“ªª 1 c∏i Kinh Nghi÷m ß¨n-Si™u c p")
    WriteLog("[ThÀp Chu Ni™n][÷‹ƒÍ∫ÿø®]Kinh Nghi÷m ß¨n-Si™u c p")
end

function shop2()
    MsgBox("Th«n T≠Ìng DÙ L÷nh:  10 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 10 c∏i Th«n T≠Ìng DÙ L÷nh(Kho∏), ƒ„œ÷‘⁄“™∂“ªª sao?", "Yes_shop2", "main")
end

function Yes_shop2()
    no()
    if (HaveNormalItem(6, 1, 1570, 1) < 10) then
        Talk(1, "no", "ThÀt xin lÁi, ƒ˙µƒ[÷‹ƒÍ∫ÿø®]≤ª◊„,  10 c∏i ÷‹ƒÍ∫ÿø®∂“ªª 10 c∏i Th«n T≠Ìng DÙ L÷nh!")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lÁi, tÛi kh´ng ÆÒ, h∑y sæp x’p tÛi.")
        return
    end

    for i = 1, 10 do
        DelNormalItem(6, 1, 1570, 1)
        AddNormalItemBind(3, 1637, 0, 0, 0, 0, 1)
    end
    Talk(1, "no", "ƒ„ π”√ 10 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 10 c∏i Th«n T≠Ìng DÙ L÷nh")
    Msg2Player("ƒ„≥…π¶ π”√ 10 c∏i ÷‹ƒÍ∫ÿø®∂“ªª 10 c∏i Th«n T≠Ìng DÙ L÷nh")
    WriteLog("[ThÀp Chu Ni™n][÷‹ƒÍ∫ÿø®]Th«n T≠Ìng DÙ L÷nh")
end

function shop3()
    MsgBox("∏ﬂº∂◊∞±∏æ´ªÍ:  40 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 1 c∏i ∏ﬂº∂◊∞±∏æ´ªÍ(Kho∏), ƒ„œ÷‘⁄“™∂“ªª sao?", "Yes_shop3", "main")
end

function Yes_shop3()
    no()
    if (HaveNormalItem(6, 1, 1570, 1) < 40) then
        Talk(1, "no", "ThÀt xin lÁi, ƒ˙µƒ[÷‹ƒÍ∫ÿø®]≤ª◊„,  40 c∏i ÷‹ƒÍ∫ÿø®∂“ªª 1 c∏i ∏ﬂº∂◊∞±∏æ´ªÍ!")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lÁi, tÛi kh´ng ÆÒ, h∑y sæp x’p tÛi.")
        return
    end

    for i = 1, 40 do
        DelNormalItem(6, 1, 1570, 1)
    end
    AddNormalItemBind(8, 1951, 2, 0, 0, 0, 1)
    Talk(1, "no", "ƒ„ π”√ 40 c∏i [÷‹ƒÍ∫ÿø®]∂“ªª 1 c∏i ∏ﬂº∂◊∞±∏æ´ªÍ")
    Msg2Player("ƒ„≥…π¶ π”√ 40 c∏i ÷‹ƒÍ∫ÿø®∂“ªª 1 c∏i ∏ﬂº∂◊∞±∏æ´ªÍ")
    WriteLog("[ThÀp Chu Ni™n][÷‹ƒÍ∫ÿø®]∏ﬂº∂◊∞±∏æ´ªÍ")
end
