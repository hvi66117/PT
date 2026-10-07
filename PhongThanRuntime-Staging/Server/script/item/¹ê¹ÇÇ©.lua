TASK_lateral = 1200

function main()
    if (GetLevel() >= 31) then
        if (GetBit(GetTask(TASK_lateral), 2) == 0) then
            SetTaskBit(TASK_lateral, 2, 1)
            TaskNote(700, 1)
            Msg2Player("§i t×m øng Tiªm Th­¬ng ë TriÒu Ca")
            MsgBox("<c=g>øng Tiªm Th­¬ng<c> ë TriÒu Ca gÇn ®©y thu thËp nhiÒu lo¹i th¨m, ng­¬i ®Õn ®­a «ng ta xem cã Ých kh«ng?", "say1")
        else
            Talk(1, "no", "<c=g>øng Tiªm Th­¬ng<c> ë TriÒu Ca gÇn ®©y thu thËp nhiÒu lo¹i th¨m.")
        end
    else
        Talk(1, "no", "Th¨m nµy cÇn ®¹t <c=r>cÊp 31<c> míi dïng ®­îc!")
    end
end
function say1()
    Talk(1, "no", "Quy Cèt Thiªm: Cã thÓ t×m <c=g>øng Tiªm Th­¬ng<c> t¹i <c=r>T©y B¾c<c> cña TriÒu Ca Y Sinh.")
end;
function no()
    CloseDialog()
end
