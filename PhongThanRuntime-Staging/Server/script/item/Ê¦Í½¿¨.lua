task_juanzhoujing = 1115;
task_jingInfo = 1121;

Task_wuya = 1231

function main()
    if (GetLevel() > 50) then
        Talk(1, "no", 14319)
        return
    end
    if (HaveMaster() == 1) then
        Talk(1, "no", GetName() .. ": b¹n ®· cã s­ phô, t¹m thêi kh«ng thÓ nhËn nhiÖm vô nµy!")
        return
    end

    if (GetTask(Task_wuya) == 0) then
        MsgBox(14320, "AcceptTask", "no")
    else
        Talk(1, "no", GetName() .. ": HiÖn t¹i vÉn ch­a nªn dïng, ®îi ®Õn lóc thÝch hîp ®·!..")
    end
end

function AcceptTask()
    SetTask(Task_wuya, 1)
    DelNormalItem(6, 1, 360, 1)
    TaskNote(80, 0)
    AddGlobalCountNews("ThiÕu niªn <c=yel>" .. GetName() .. "<c> S¬ NhËp Giang Hå, ®ang muèn tÇm s­ häc nghÖ", 3)
    Talk(1, "no", 14321)
end

function no()
    CloseDialog()
end
