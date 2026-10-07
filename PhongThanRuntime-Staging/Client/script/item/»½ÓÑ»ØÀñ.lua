require(" Æ÷‹ƒÍªÓ∂Ø.luax")

function main(itemID)
    no()
    if (HaveNormalItem(6, 1, 1569, 1) <= 0) then
        if (HaveNormalItem(6, 1, 1569, 0) > 0) then
            DelNormalItem(6, 1, 1569, 0)
            AddNormalItemBind(6, 1, 1569, 1, 0, 0, 1)
        else
            WriteLog("[ThÀp Chu Ni™n][ªΩ”—ªÿ¿Ò][Th t bπi]")
            return
        end
    end

    if (GetLevel() < 90) then
        Talk(1, "no", "ThÀt xin lÁi, ƒ˙µƒµ»º∂≤ª◊„ c p 90, «ÎΩ´∏√ªÿ¿ÒÀÕ∏¯∆‰À˚ c p 90 “‘…œµƒÕÊº“∞…!")
        return 0
    end

    if (TENYEAR.Pub_IsTENYEAR(5) < 1) then
        DelNormalItem(6, 1, 1569, 1)
        InfoBox("ªÓ∂ØΩ· ¯, ªΩ”—ªÿ¿Ò∞¸“—æ≠◊˜∑œ¡À!")
        WriteLog("[ThÀp Chu Ni™n][ªΩ”—ªÿ¿Ò][ ’ªÿ]")
        return 0
    end

    if (GetTaskBit(2186, 3) == 1) then
        Talk(1, "no", "ThÀt xin lÁi, √ø∏ˆΩ«…´◊Ó∂‡ƒ‹ø™∆Ù1¥ŒªΩ”—ªÿ¿Ò, «ÎΩ´∏√ªÿ¿ÒÀÕ∏¯∆‰À˚ c p 90 “‘…œµƒÕÊº“∞…!")
        return 0
    elseif (GetTaskBit(2186, 2) == 1) then
        Talk(1, "no", "ThÀt xin lÁi, ƒ„ «ªÿπÈ’ﬂ, ’‚∏ˆªΩ”—ªÿ¿Ò÷ªƒ‹∏¯ªÓ‘æÕÊº“, «ÎΩ´∏√ªÿ¿ÒÀÕ∏¯’ŸªΩƒ„ªÿπÈ∑‚…Ò ¿ΩÁµƒ–÷µ‹ ÷÷–∞…!")
        return 0
    end

    if (DelNormalItem(6, 1, 1569, 1) <= 0) then
        InfoBox("ThÀt xin lÁi, ¿Ò∞¸Œﬁ∑®¥Úø™!")
        WriteLog("[ThÀp Chu Ni™n][ªΩ”—ªÿ¿Ò][Th t bπi]")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThÀt xin lÁi, hµnh trang kh´ng ÆÒ 2 ´ trËng, vui lﬂng sæp x’p lπi.")
        return
    end

    SetTaskBit(2186, 3, 1)
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 1316, 6, 0, 0, 0, 1)
    Msg2Player("MÎ ªΩ”—ªÿ¿Ò nhÀn Æ≠Óc 1 c∏i Vi Quang Qu∏i PhÔ vµ “ª’≈ThŒ Kim DÀt.")
    InfoBox("MÎ ªΩ”—ªÿ¿Ò, ƒ„ nhÀn Æ≠Óc 1 c∏i Vi Quang Qu∏i PhÔ vµ “ª’≈ThŒ Kim DÀt!")
    WriteLog("[ThÀp Chu Ni™n][ªΩ”—ªÿ¿Ò]")
end;

function no()
    CloseDialog()
end

