gua8_renwu = 1340
gua8_task = 1341

function main()
    if (GetPlayerExtLevel() < 15) then
        Talk(1, "no", "CÊn: Ng¹i qu¸! §iÓm tu luyÖn cña ng­¬i ch­a ®ñ 15, ch­a thÓ më Qu¸i quyÓn nµy!")
        return 0
    end

    MsgBox("CÊn: L­ìng nghi sinh Tø t­îng, Tø t­îng sinh B¸t qu¸i. CÊn lµ nói, c¨n cø theo quÎ t­îng nµy, ng­¬i ph¶i ®i vÒ h­íng T©y b¾c ®Ó gi¶i quÎ!", "AcceptTask", "no")
end

function AcceptTask()
    CloseDialog()
    local nTaskStatus = GetTaskByte(gua8_renwu, 3)
    if (nTaskStatus == 2 or nTaskStatus == 3) then
        TopMessage("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        Msg2Player("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        return
    end

    if (HaveNormalItem(6, 1, 461, 0) > 0) then
        DelNormalItem(6, 1, 461, 0)
        set_8gua()
    elseif (HaveNormalItem(6, 1, 453, 0) > 0) then
        DelNormalItem(6, 1, 453, 0)
        set_8gua()
    end
end

function set_8gua()
    SetTaskByte(gua8_renwu, 3, 2)
    SetTaskByte(gua8_renwu, 4, 7)
    SetTask(gua8_task, 0)
    TaskNote(97, 8)
    TopMessage("B¹n ph¶i tiªu trõ Ma Kh©m Nguyªn (S¬n)")
    Msg2Player("B¹n ph¶i tiªu trõ Ma Kh©m Nguyªn (S¬n)")
    Talk(1, "no", "CÊn: Më quÎ nµy cÇn tiªu diÖt <c=g>Ma Kh©m Nguyªn (S¬n)<c>, b¹n ph¶i tiªu diÖt Ma Kh©m Nguyªn míi cã thÓ dô Ma Kh©m Nguyªn (S¬n) xuÊt hiÖn.")
end

function no()
    CloseDialog()
end
