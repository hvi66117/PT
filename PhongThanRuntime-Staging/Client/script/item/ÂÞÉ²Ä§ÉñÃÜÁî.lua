MapList = {
    [1] = { mapid = 16, mapname = "Tam S¬n", },
    [2] = { mapid = 14, mapname = "§ång Quan", },
    [3] = { mapid = 65, mapname = "TrÇn §­êng", },
}

function main()

    local m, x, y = GetWorldPos()
    local flag = 0
    for i = 1, table.getn(MapList) do
        if (MapList[i].mapid == m) then
            flag = 1
            break
        end
    end
    if (flag == 0 or GetFightState() == 0) then
        Talk(1, "no", "Ö»ÄÜÔÚ" .. MapList[1].mapname .. "," .. MapList[2].mapname .. "," .. MapList[3].mapname .. "µÈµØÍ¼ÕÙ»½ÂŞÉ²Ä§Éñ.")
        return
    end

    MsgBox("ÂŞÉ²Ä§ÉñĞ×ÏÕÎŞ±È, Äú×îºÃ¶àÕÒ¼¸¸ö»ï°éÒ»ÆğÓëÖ®Õ½¶·, ÄúÈ·ÈÏÒªÔÚÕâÀïÕÙ»½³öÂŞÉ²Ä§Éñ sao?", "YesNow", "no")

end
function YesNow()
    local m, x, y = GetWorldPos()
    local flag = 0
    for i = 1, table.getn(MapList) do
        if (MapList[i].mapid == m) then
            flag = 1
            break
        end
    end
    if (flag == 0 or GetFightState() == 0) then
        Talk(1, "no", "Ö»ÄÜÔÚ" .. MapList[1].mapname .. "," .. MapList[2].mapname .. "," .. MapList[3].mapname .. "µÈµØÍ¼ÕÙ»½ÂŞÉ²Ä§Éñ.")
        return
    end
    if (DelNormalItem(6, 1, 1439, 0) == 0) then
        Talk(1, "no", "µÀ¾ßSö dông thÊt b¹i.")
        WriteLog("[La S¸t Ma ThÇn MËt LÖnh¿Û³ıÊ§°Ü]")
        return
    end

    AddNpc(533 + math.random(1, 4), 60, SubWorld, x * 32, y * 32)
    AddNpc(538, 60, SubWorld, x * 32, y * 32)
    AddNpc(538, 60, SubWorld, x * 32, y * 32)
    AddNpc(538, 60, SubWorld, x * 32, y * 32)
    AddNpc(538, 60, SubWorld, x * 32, y * 32)

    TopMessage(13151)
    Talk(1, "no", 13151)

    WriteLog("[La S¸t Ma ThÇn MËt LÖnh¿Û³ı³É¹¦][ÕÙ»½ÁË 5 c¸i ÂŞÉ²Ä§Éñ]")
end

function no()
    CloseDialog()
end
