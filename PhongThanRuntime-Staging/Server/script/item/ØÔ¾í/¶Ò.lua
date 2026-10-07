gua8_renwu = 1340
gua8_task = 1341

function main()
    if (GetPlayerExtLevel() < 15) then
        Talk(1, "no", "§oµi:Ng¹i qu¸! §iÓm tu luyÖn cña ng­¬i ch­a ®ñ 15, ch­a thÓ më ®­îc qu¸i quyÓn nµy")
        return 0
    end

    MsgBox("§oµi:L­ìng nghi sinh Tø t­îng, Tø t­îng sinh B¸t qu¸i. §oµi lµ ®Çm, c¨n cø theo quÎ nµy, ph¶i ®i vÒ h­íng §«ng nam ®Ó gi¶i quÎ!", "AcceptTask", "no")
end

function AcceptTask()
    CloseDialog()
    local nTaskStatus = GetTaskByte(gua8_renwu, 3)
    if (nTaskStatus == 2 or nTaskStatus == 3) then
        TopMessage("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        Msg2Player("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        return
    end

    if (HaveNormalItem(6, 1, 456, 0) > 0) then
        DelNormalItem(6, 1, 456, 0)
        set_8gua()
    elseif (HaveNormalItem(6, 1, 448, 0) > 0) then
        DelNormalItem(6, 1, 448, 0)
        set_8gua()
    end
end

function set_8gua()
    SetTaskByte(gua8_renwu, 3, 2)
    SetTaskByte(gua8_renwu, 4, 2)
    SetTask(gua8_task, 5)
    TaskNote(97, 3, 0)
    TopMessage("B¹n ph¶i thu thËp ®ñ <c=g>5 hån ph¸ch Tr¹nh Nanh<c>")
    Msg2Player("B¹n ph¶i thu thËp ®ñ <c=g>5 hån ph¸ch Tr¹nh Nanh<c>")
    Talk(1, "no", "§oµi:Muèn gi¶i quÎ nµy cÇn cã <c=g>5 hån ph¸ch Tr¹nh Nanh<c>. CÇn ph¶i lÊy ®­îc <c=g>HÊp hån chó<c> trªn m×nh Phi Thè míi cã thÓ thu ®­îc hån ph¸ch Tr¹nh Nanh")
end

function no()
    CloseDialog()
end
