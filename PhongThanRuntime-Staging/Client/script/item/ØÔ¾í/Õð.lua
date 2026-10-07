gua8_renwu = 1340
gua8_task = 1341

function main()
    if (GetPlayerExtLevel() < 15) then
        Talk(1, "no", "Ng¹i qu¸! §iÓm tu luyÖn cña ng­¬i ch­a ®ñ 15, ch­a thÓ më Qu¸i quyÓn nµy!")
        return 0
    end

    MsgBox("L­ìng nghi sinh Tø t­îng, Tø t­îng sinh B¸t qu¸i. ChÊn lµ sÊm sÐt. C¨n cø theo quÎ t­îng nµy, cÇn ph¶i ®i vÒ h­íng §«ng B¾c ®Ó gi¶i quÎ!", "AcceptTask", "no")
end

function AcceptTask()
    CloseDialog()
    local nTaskStatus = GetTaskByte(gua8_renwu, 3)
    if (nTaskStatus == 2 or nTaskStatus == 3) then
        TopMessage("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        Msg2Player("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        return
    end

    if (HaveNormalItem(6, 1, 458, 0) > 0) then
        DelNormalItem(6, 1, 458, 0)
        set_8gua()
    elseif (HaveNormalItem(6, 1, 450, 0) > 0) then
        DelNormalItem(6, 1, 450, 0)
        set_8gua()
    end
end

function set_8gua()
    SetTaskByte(gua8_renwu, 3, 2)
    SetTaskByte(gua8_renwu, 4, 4)
    SetTask(gua8_task, 10)
    TaskNote(97, 5, 0)
    TopMessage("B¹n cÇn ph¶i h¸i ®ñ <c=g>10 M¹n §µ la hoa<c>")
    Msg2Player("B¹n cÇn ph¶i h¸i ®ñ <c=g>10 M¹n §µ la hoa<c>")
    Talk(1, "no", "Muèn më quÎ nµy cÇn ph¶i h¸i ®ñ <c=g>10 M¹n §µ la hoa<c>, ph¶i h¸i M¹n §µ la hoa (Tiªn) ch­a në míi ®­îc!")
end

function no()
    CloseDialog()
end
