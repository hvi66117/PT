---ÔÂ¹ğ×Ó
Task_PrepareMaterial = 1049;
function main()
    if (GetTask(Task_PrepareMaterial) == 9) then
        local nNum = HaveEventItemCount(199)
        --		if( nNum < 10)then
        if (GetNpcName(DialogNpcIdx) == (GetName() .. "_QuÕ")) then
            AddEventItem(199)
            DelNpc(DialogNpcIdx)
            nNum = nNum + 1
            if (nNum >= 10) then
                TopMessage(13244)
                Msg2Player("B¹n ®· thu thËp ®ñ H¹t quÕ.")
            else
                TopMessage(13245)
                Msg2Player("B¹n nhËn ®­îc 1 H¹t quÕ.")
            end
        end
        --		end
    else
        TopMessage(13246)
    end

end