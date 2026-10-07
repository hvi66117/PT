--description:ontimer
--author: huyuzhang
--date:2009/7/29

TASK_CRLH = 1513
TASK_CRLH_GROW = 1514
TASK_CRLH_LOCATION = 1515
TASK_CRLH_ROUSHEN_IDX = 1516
TASK_CRLH_G_COUNT = 241
TASK_NOTEID = 1091

function main()

    local pid = GetNpcTask(DialogNpcIdx, 1)
    local pidx = GetNpcTask(DialogNpcIdx, 3)

    if (GetPlayerID() == pid) then
        if (GetTaskByte(TASK_CRLH, 1) == 3 and GetTaskByte(TASK_CRLH, 2) == 3) then
            if (IsHaveSpaceForTreasure(1) == 0) then
                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, s¾p xÕp råi h·y quay l¹i.")
                return

            else
                Talk(1, "no", "TuyÖt DiÖp:§a t¹ ng­¬i gióp ta chÊm døt ®au khæ.")
                AddNormalItem(3, 467, 0, 0, 0, 0)            --»ñµÃÈý»êÆßÆÇ
                TaskNote(TASK_NOTEID, 10)
                TopMessage("NhËn ®­îc 3 hån 7 ph¸ch.")
                SetTaskByte(TASK_CRLH, 2, 4)

            end
        end
    end

end

function no()
    CloseDialog()
end;