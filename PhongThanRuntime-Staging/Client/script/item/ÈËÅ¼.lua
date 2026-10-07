TASK_CRLH = 1513
TASK_CRLH_SHOUJI = 1514
TASK_CRLH_NPCIDX = 1516
TASK_CRLH_NPCID = 1517

TASK_CRLH_NPCTM1 = 1203
TASK_CRLH_NPCTM2 = 1204
TASK_CRLH_NPCTM3 = 1205

function main()


    if (GetTaskByte(TASK_CRLH, 1) == 1 and GetTaskByte(TASK_CRLH, 2) == 4) then

        UseProperty()
    end
end

function UseProperty()


    local mapid, x, y = GetWorldPos()

    if (mapid ~= 32) then
        Msg2Player("Ph¶i sö dông trong Ngäc TuyÒn B¨ng Xuyªn.")
        return

    end

    local TargetNpcIdx = GetPlayerTarget()

    local npcTemplateID = GetNpcTemplateID(TargetNpcIdx)

    if ((npcTemplateID == TASK_CRLH_NPCTM1) or (npcTemplateID == TASK_CRLH_NPCTM2) or (npcTemplateID == TASK_CRLH_NPCTM3)) then

        local scale = GetNpcLife(TargetNpcIdx) / GetNpcLifeMax(TargetNpcIdx)

        if (scale <= 0.25) then

            if (npcTemplateID == TASK_CRLH_NPCTM1) then
                if (GetTaskByte(TASK_CRLH_SHOUJI, 1) == 1) then
                    Msg2Player("Lo¹i qu¸i nµy ®· thu thËp hoµn tÊt.")
                    return
                end

            elseif (npcTemplateID == TASK_CRLH_NPCTM2) then
                if (GetTaskByte(TASK_CRLH_SHOUJI, 2) == 1) then
                    Msg2Player("Lo¹i qu¸i nµy ®· thu thËp hoµn tÊt.")
                    return
                end

            elseif (npcTemplateID == TASK_CRLH_NPCTM3) then
                if (GetTaskByte(TASK_CRLH_SHOUJI, 3) == 1) then
                    Msg2Player("Lo¹i qu¸i nµy ®· thu thËp hoµn tÊt.")
                    return
                end

            end

            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)
            nInterrupt = SetBit(nInterrupt, 2, 1)
            nInterrupt = SetBit(nInterrupt, 3, 0)
            nInterrupt = SetBit(nInterrupt, 4, 0)
            nInterrupt = SetBit(nInterrupt, 5, 1)
            nInterrupt = SetBit(nInterrupt, 6, 0)
            nInterrupt = SetBit(nInterrupt, 8, 0)
            nInterrupt = SetBit(nInterrupt, 9, 1)
            nInterrupt = SetBit(nInterrupt, 10, 0)

            SetTask(TASK_CRLH_NPCIDX, TargetNpcIdx)
            SetTask(TASK_CRLH_NPCID, GetNpcID(TargetNpcIdx))

            BeginMotion(npcTemplateID, 0, 5, "\\script\\motion\\ÊÕ¼¯»ê.lua", nInterrupt)

        else
            Msg2Player("CÇn Hång HuyÕt míi cã thÓ thu thËp.")

        end

    else
        Msg2Player("ChØ cã thÓ thu thËp Hån.")

    end
end
