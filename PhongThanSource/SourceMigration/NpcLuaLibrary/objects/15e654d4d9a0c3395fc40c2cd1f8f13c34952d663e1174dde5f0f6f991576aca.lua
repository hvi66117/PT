Task_star = 1417

function GetPlayerTaskState()
    return 0, 0
end

function main()

    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 2) then
        if (GetNpcTask(DialogNpcIdx, 1) == GetPlayerID()) then

            if (HaveIBBuff(768) == 1) then
                Msg2Player("Sau khi trång H¹t H¶i T©m Th¶o, cÇn ®îi mét lóc sau míi cã thÓ thu ho¹ch!")
                return
            end

            local rand = math.random(1, 100)
            if (rand > 40) then
                Msg2Player("H¸i thÊt b¹i, t×m Vâ Quy lÊy h¹t H¶i T©m Th¶o råi trång l¹i.")
                TopMessage("<c=g>Thu thËp thÊt b¹i<c>")
                SetTaskByte(Task_star, 3, 0)
                DelNpc(DialogNpcIdx)
                return
            end

            if (IsHaveSpaceForTreasure(1) ~= 1) then
                TopMessage("<c=g>Thu thËp thÊt b¹i<c>")
                Msg2Player("Tói ®· ®Çy, kh«ng thÓ lÊy Thñy T©m, t×m Vâ Quy lÊy h¹t H¶i T©m Th¶o råi trång l¹i.")
                SetTaskByte(Task_star, 3, 0)
                DelNpc(DialogNpcIdx)
                return
            end

            Msg2Player("Thu thËp thµnh c«ng Thñy T©m, mau quay vÒ thØnh gi¸o Tinh Quan c¸ch sö dông Ph¸p b¶o nµy.")
            TopMessage("H¸i thµnh c«ng <c=g>Thñy T©m<c>")
            AddNormalItem(6, 1, 513, 0, 0, 0)
            SetTaskByte(Task_star, 3, 3)
            SetTaskByte(Task_star, 1, 9)
            TaskNote(1060, 1)

            DelNpc(DialogNpcIdx)
        end
    end
end
