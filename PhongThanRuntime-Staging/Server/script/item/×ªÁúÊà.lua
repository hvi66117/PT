Task_lucy = 1267
item = {
    [1] = { "ChuyÓn Long Xu: 1", 15, 0, 6, 1, 397 },
    [2] = { "Th¹ch D­¬ng Gi¸c: 1", 50, 0, 3, 238, 0 },
    [3] = { "Th¹ch Bµi: 1", 26, 0, 3, 239, 0 },
    [4] = { "§å phæ Ph¸ Qu©n: 1 quyÓn", 9, 2 },
}

function main()
    CloseDialog()
    if (HaveNormalItem(3, 240, 0, 0) > 0) and (HaveNormalItem(6, 1, 397, 0) > 0) then
        DelNormalItem(3, 240, 0, 0)
        DelNormalItem(6, 1, 397, 0)
        openbox()
    elseif (HaveNormalItem(3, 240, 0, 0) > 0) and (HaveNormalItem(6, 1, 392, 0) > 0) then
        DelNormalItem(3, 240, 0, 0)
        DelNormalItem(6, 1, 392, 0)
        openbox()
    else
        Talk(1, "no", GetName() .. ": CÇn cã <c=g>Thiªn C¬ §ång<c> míi cã thÓ sö dông.")
    end
end;

function no()
    CloseDialog()
end

function fLucyVal(ntime)
    local val = 100 - math.floor(ntime / 10) * 10
    if (val <= 0) then
        return 1
    end
    return math.random(1, val)
end

function openbox()
    local val_green = GetByte(GetTask(Task_lucy), 2) + 1
    local lucy = fLucyVal(val_green)

    local nItemNum = GetTaskByte(Task_lucy, 4) + 1

    if (lucy <= 1) then
        local r1 = math.random(5, 7)
        local t1 = GetPlayerType() + 6
        AddNormalItem(0, r1, t1, 10, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Lôc trang cÊp 100")
        TopMessage("B¹n nhËn ®­îc <c=g>Lôc trang cÊp 100<c>")
        SetTaskByte(Task_lucy, 2, 0)
        WriteLog("ChuyÓn Long Xu-Lôc trang cÊp 100")
        return 0

    elseif (nItemNum == 12) then
        local r2 = math.random(1, 5)
        local t2 = GetPlayerType() + 275 + r2 * 3
        SetTaskByte(Task_lucy, 4, 0)
        AddNormalItem(6, 1, t2, 0, 0, 0)
        Msg2Player("Anh hïng nhËn QuyÓn §å Phæ Ph¸ Qu©n")
        TopMessage("Anh hïng nhËn <c=g>QuyÓn §å Phæ Ph¸ Qu©n<c>")
        WriteLog("QuyÓn §å Phæ Ph¸ Qu©n")
        return 0

    else
        SetTaskByte(Task_lucy, 2, val_green)

        SetTaskByte(Task_lucy, 4, nItemNum)

        local r = math.random(1, 100)
        local temp = 0
        local updata = table.getn(item)
        for i = 1, updata do
            temp = temp + item[i][2]
            if (r <= temp) then
                local data = item[i]
                local a = data[3]
                if (a == 0) then
                    AddNormalItem(data[4], data[5], data[6], 0, 0, 0)
                elseif (a == 2) then
                    local r2 = math.random(1, 5)
                    local t2 = GetPlayerType() + 275 + r2 * 3
                    AddNormalItem(6, 1, t2, 0, 0, 0)

                    SetTaskByte(Task_lucy, 4, 0)

                end
                Msg2Player("B¹n nhËn ®­îc " .. data[1])
                TopMessage("B¹n nhËn ®­îc <c=g>" .. data[1])

                return 0
            end
        end
    end
end
