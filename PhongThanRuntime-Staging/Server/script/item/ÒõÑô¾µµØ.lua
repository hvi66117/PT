TASK_CRLH = 1513
TASK_CRLH_CALLTIME = 1515
TASK_CRLH_SHOUJI = 1514

TASK_CRLH_X_MIN = 1823
TASK_CRLH_X_MAX = 1845
TASK_CRLH_Y_MIN = 2956
TASK_CRLH_Y_MAX = 2980

TASK_CRLH_X_MIN2 = 1793
TASK_CRLH_X_MAX2 = 1823
TASK_CRLH_Y_MIN2 = 2894
TASK_CRLH_Y_MAX2 = 2930

TASK_CRLH_X_MIN3 = 1846
TASK_CRLH_X_MAX3 = 1869
TASK_CRLH_Y_MIN3 = 3039
TASK_CRLH_Y_MAX3 = 3064

function main()

    if (GetTaskByte(TASK_CRLH, 1) == 1 and GetTaskByte(TASK_CRLH, 2) == 4) then
        doMission()

    end

end

function doMission()
    local mapid, x, y = GetWorldPos()

    if (mapid ~= 32) then
        Msg2Player("Ph¶i sö dông ë Ngäc TuyÒn B¨ng Xuyªn!")
        return

    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 8, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 0)

    if ((x >= TASK_CRLH_X_MIN and x <= TASK_CRLH_X_MAX and y >= TASK_CRLH_Y_MIN and y <= TASK_CRLH_Y_MAX) or
            (x >= TASK_CRLH_X_MIN2 and x <= TASK_CRLH_X_MAX2 and y >= TASK_CRLH_Y_MIN2 and y <= TASK_CRLH_Y_MAX2) or
            (x >= TASK_CRLH_X_MIN3 and x <= TASK_CRLH_X_MAX3 and y >= TASK_CRLH_Y_MIN3 and y <= TASK_CRLH_Y_MAX3)

    ) then
        if (GetTaskByte(TASK_CRLH_SHOUJI, 2) == 0) then
            if (SystemTime() - GetTask(TASK_CRLH_CALLTIME) >= 180) then
                doMotion(nInterrupt)

            else
                Msg2Player("HiÖn giê ch­a thÓ triÖu håi!")

            end

        else
            Msg2Player("Hån ph¸ch nµy ®· thu thËp ®ñ!")

        end
    else
        Msg2Player("Ph¶i ®Õn gÇn L«i §iÖn Th¸p míi cã thÓ sö dông!")

    end
end

function doMotion(nInterrupt)
    BeginMotion(2, 0, 5, "\\script\\motion\\ÒýÀ×.lua", nInterrupt)

end
