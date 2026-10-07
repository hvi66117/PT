Task_Protect_2012 = 1817

Task_Protect_2012_2 = 1818

Task_Protect_KillNum = 1819

G_Buff_Protect = 1406

function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (HaveNormalItem(6, 1, 893, 1) <= 0) then
        return
    end
    local nMap, nX, nY = GetWorldPos()
    if (nMap ~= 55) then
        Talk(1, "no", "¿¹ÙÁ´óÆìÖ»ÄÜÔÚ¶«å­µºÊ¹ÓÃ.")
        return
    end

    MsgBox("È·¶¨Òª°Ñ¿¹ÙÁ´óÆì·ÅÖÃµ½´Ë´¦ sao?", "Yes_Add", "no")
end

function Yes_Add()
    no()
    if (HaveNormalItem(6, 1, 893, 1) <= 0) then
        return
    end

    local nMap, nX, nY = GetWorldPos()
    local nNpcidx = AddNpc(1924, 1, SubWorld, nX * 32, nY * 32)
    if (nNpcidx > 0) then
        SetNpcTimer(nNpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 30 * 60)
        SetTaskByte(Task_Protect_2012, 2, 2)
        TaskNote(1627, 1)
        Talk(1, "no", "Hoµn thµnh nhiÖm vô , »ØÈ¥¸æËßLı TŞnh°É.")
        DelNormalItem(6, 1, 893, 1)
    else
        Talk(1, "no", "´Ë´¦²»ÄÜÊ¹ÓÃ¿¹ÙÁ´óÆì, »»¸öµØ·½ÖØĞÂÊÔÊÔ°É.")
    end
end

function no()
    CloseDialog()
end
