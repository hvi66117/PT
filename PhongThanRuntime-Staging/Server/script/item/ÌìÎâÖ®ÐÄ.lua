TASK_lateral = 1200

function main()
    if (GetBit(GetTask(TASK_lateral), 18) == 0) then
        SetTaskBit(TASK_lateral, 18, 1)
        Msg2Player("§¹i phu ë T©y Kú ®ang cÇn nã")
        MsgBox("Mang Thiªn Ng« T©m [®á] ®Õn cho <c=g>®¹i phu ë T©y Kú<c>!", "say1")
    elseif (GetBit(GetTask(TASK_lateral), 19) == 1) then
        if (GetBit(GetTask(TASK_lateral), 21) == 1) then
            TaskNote(706, -1)
        end
        DelNormalItem(6, 1, 347, 0)
        Talk(1, "no", "Thø nµy ®· h­, kh«ng thÓ sö dông!")
    else
        Talk(1, "no", "Sau cÊp 34 nhí mang ®Õn T©y Ky gÆp §¹i Phu, «ng ta sÏ cÇn nã!")
    end
end

function say1()
    Talk(1, "no", "§¹i phu ë T©y Kú sÏ nãi cho b¹n biÕt lîi Ých cña nã.")
end

function no()
    CloseDialog()
end
