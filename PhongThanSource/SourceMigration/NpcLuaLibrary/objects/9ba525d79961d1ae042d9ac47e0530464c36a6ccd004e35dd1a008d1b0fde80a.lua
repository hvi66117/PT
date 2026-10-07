Task_PrepareMaterial = 1049;
function main()
    if (GetTask(Task_PrepareMaterial) == 9) then
        local nNum = HaveEventItemCount(199)

        if (GetNpcName(DialogNpcIdx) == (GetName() .. "_QuÕ")) then

            DelNpc(DialogNpcIdx)
            if (nNum >= 2) then
                TopMessage(13244)
                Msg2Player("B¹n ®· thu thËp ®ñ H¹t quÕ.")
            else
                AddEventItem(199)
                TopMessage(13245)
                Msg2Player("B¹n nhËn ®­îc 1 H¹t quÕ.")
            end

        end

    else
        TopMessage(13246)
    end

end
