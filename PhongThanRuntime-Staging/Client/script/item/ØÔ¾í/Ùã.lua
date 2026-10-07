gua8_renwu = 1340
gua8_task = 1341

function main()
    if (GetPlayerExtLevel() < 15) then
        Talk(1, "no", "Tèn:Ng¹i qu¸! §iÓm tu luyÖn cña ng­¬i ch­a ®ñ 15, ch­a thÓ më Qu¸i quyÓn nµy!")
        return 0
    end

    MsgBox("Tèn:L­ìng nghi sinh Tø t­îng, Tø t­îng sinh B¸t qu¸i. Tèn lµ giã, c¨n cø theo quÎ t­îng nµy, cÇn ph¶i ®i vÒ h­íng T©y nam ®Ó gi¶i quÎ!", "AcceptTask", "no")
end

function AcceptTask()
    CloseDialog()
    local nTaskStatus = GetTaskByte(gua8_renwu, 3)
    if (nTaskStatus == 2 or nTaskStatus == 3) then
        TopMessage("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        Msg2Player("B¹n ®ang trong qu¸ tr×nh gi¶i quÎ, kh«ng thÓ tiÕp tôc më quÎ")
        return
    end

    if (HaveNormalItem(6, 1, 459, 0) > 0) then
        DelNormalItem(6, 1, 459, 0)
        set_8gua()
    elseif (HaveNormalItem(6, 1, 451, 0) > 0) then
        DelNormalItem(6, 1, 451, 0)
        set_8gua()
    end
end

function set_8gua()
    SetTaskByte(gua8_renwu, 3, 2)
    SetTaskByte(gua8_renwu, 4, 5)
    SetTask(gua8_task, 0)
    TaskNote(97, 6)
    TopMessage("§i t×m Ng­êi h¸i thuèc")
    Msg2Player("§i t×m Ng­êi h¸i thuèc")
    Talk(1, "no", "Tèn:<c=g>Ng­êi h¸i thuèc<c> ë BÊt Chu Thiªn quan cã thÓ gióp ng­¬i gi¶i quÎ nµy!")
end

function no()
    CloseDialog()
end
