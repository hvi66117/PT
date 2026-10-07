Task_tian = 951;
Task_time = 952;
function main(itemid)
    local task_step = GetByte(GetTask(53), 2)
    if (task_step < 36) then
        Msg2Player("B¹n cÇn ph¶i hoµn thµnh nhiÖm vô thu thËp 36 thiªn C­¬ng Tinh míi cã thÓ dïng Chiªu Hån Ph­ín nµy")
        return
    end
    local nLastTime = GetTask(Task_time)
    local nNowtime = math.floor(LocalSystemTime() / 86400)
    if (nNowtime == nLastTime) then
        Msg2Player("KhÝ lùc cña b¹n ®· yÕu! Ngµy mai h·y tiÕp tôc chiªu hån!")
        return
    end
    local w, x, y = GetWorldPos()
    if (w == 19) then
        local nNpcIdx = AddNpc(549, 60, SubWorld, x * 32, y * 32)
        SetNpcName(nNpcIdx, "Thiªn Kh«i tinh* <c=g>" .. GetName())
        SetNpcScript(nNpcIdx, "\\script\\item\\Ììî¸ÐÇ\\Ììî¸ÐÇºó.lua")
        SetTask(Task_tian, nNpcIdx)
        DelNormalItem(itemid)
        SetTask(Task_time, nNowtime)
        DelNormalItem(6, 1, 186, 0)
        Msg2Player("Xin chó ý! Thiªn C­¬ng tinh bÞ b¹n chiªu hån ®· xuÊt hiÖn!")
        TopMessage(13335)
    else
        Msg2Player("N¬i ®©y kh«ng thÓ chiªu hån Thiªn C­¬ng tinh")
    end
end
