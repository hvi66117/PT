TASK_DAY = 1589
TASK_TIMES = 1590

function main()
    if (HaveNormalItem(6, 1, 717, 0) == 0) then
        return
    end
    if (GetLevel() < 30) then
        Msg2Player("Ch­a ®ñ cÊp 30, kh«ng thÓ nhËn d­îc lùc")
        TopMessage("Ch­a ®ñ cÊp, kh«ng thÓ sö dông")
        return
    end
    local thisday = math.floor(LocalSystemTime() / 86400)
    if (thisday > GetTask(TASK_DAY)) then
        SetTask(TASK_DAY, thisday)
        DelNormalItem(6, 1, 717, 0)
        SetTaskByte(TASK_TIMES, 3, 1)
        SetTaskByte(TASK_TIMES, 2, 0)
        SetTaskByte(TASK_TIMES, 1, 0)
        AddVigour(50)
        Msg2Player("Sö dông thµnh c«ng Ng­ng ThÇn §¬n, t¨ng 50 ®iÓm Tinh Lùc")
        TopMessage("T¨ng 50 ®iÓm Tinh Lùc")
        WriteLog(GetName() .. "Sö dông Ng­ng ThÇn §¬n.")
    else
        local times = GetTaskByte(TASK_TIMES, 3)
        if (times < 5) then

            DelNormalItem(6, 1, 717, 0)
            times = times + 1
            SetTaskByte(TASK_TIMES, 3, times)
            AddVigour(50)
            Msg2Player("Sö dông thµnh c«ng Ng­ng ThÇn §¬n, t¨ng 50 ®iÓm Tinh Lùc")
            TopMessage("T¨ng 50 ®iÓm Tinh Lùc")
            WriteLog(GetName() .. "Sö dông Ng­ng ThÇn §¬n.")
        else
            Msg2Player("H«m nay ®· sö dông 5 <c=g>Ng­ng ThÇn §¬n<c>, kh«ng thÓ tiÕp nhËn thªm d­îc lùc")
            TopMessage("Sè lÇn sö dông h«m nay ®· ®¹t møc tèi ®a")
        end


    end

end;
