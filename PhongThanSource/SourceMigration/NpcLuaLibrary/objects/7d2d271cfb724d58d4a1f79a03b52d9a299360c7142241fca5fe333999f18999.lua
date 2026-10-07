Task_FangZ_Credit = 1150
Task_DongY_Credit = 1148

function OnGetDYGlory()
    local tDongYCredit = GetTask(Task_DongY_Credit)
    return tDongYCredit
end

function OnWasteDYGlory(nWaste)
    local tDongYCredit = GetTask(Task_DongY_Credit)
    if (tDongYCredit < nWaste) then
        return 0
    end

    SetTask(Task_DongY_Credit, tDongYCredit - nWaste)

    return 1
end

function OnGetFZGlory()
    local tFangZCredit = GetTask(Task_FangZ_Credit)
    return tFangZCredit
end

function OnWasteFZGlory(nWaste)
    local tFangZCredit = GetTask(Task_FangZ_Credit)
    if (tFangZCredit < nWaste) then
        return 0
    end

    SetTask(Task_FangZ_Credit, tFangZCredit - nWaste)

    return 1
end
