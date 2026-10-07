--description: ¸t½Ï³·¤H
--author:lilingxu
--date: 2006/12/8


function main()
    local npcname = GetDialogNpcName()
    local playername = GetName()
    if (npcname == playername .. ".") then
        DelNpc(DialogNpcIdx)
        renwu1()
    else
        renwu2()
    end
end

function renwu1()
    local a = GetLevel()
    local b = random(1, 5)
    if (b == 1) then
        AddOwnExp(a * 1000)
        Talk(1, "no", 13263)
        TopMessage(13264)
    elseif (b == 2) then
        AddOwnExp(a * 3000)
        Talk(1, "no", 13263)
        TopMessage(13264)
    elseif (b == 3) then
        AddNormalItemPile(6, 0, 20, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13268)
    elseif (b == 4) then
        AddNormalItemPile(6, 1, 22, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13269)
    else
        renwu3()
    end
end

function renwu2()
    local npcname = GetDialogNpcName()
    local a = random(1, 10)
    if (a == 1) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:Gi¸ng sinh vui vÎ!")
    elseif (a == 2) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:N¨m míi h¹nh phóc!")
    elseif (a == 3) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>Nãng qu¸ !")
    elseif (a == 4) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:TuyÕt r¬i ®Ñp qu¸!")
    elseif (a == 5) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:§õng ®ông vµo, ta sÏ tan ra mÊt.")
    elseif (a == 6) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:Nh×n xem, ta vµ c¸i c©y kia ai ®Ñp h¬n?")
    elseif (a == 7) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:§õng quªn tÆng quµ cho ng­êi th©n yªu trong ®ªm gi¸ng sinh nhÐ!")
        RestoreLife()
        TopMessage(13265)
    elseif (a == 8) then
        Talk(1, "no", "<color=yellow>" .. npcname .. "<c>:§ªm Gi¸ng sinh ta muèn tÆng ng­êi th©n yªu 1 viªn thñy tinh")
        RestoreMana()
        TopMessage(13266)
    elseif (a == 9) then
        MsgBox("<color=yellow>" .. npcname .. "<c>:C« g¸i b¸n diªm! Cã muèn vÒ nhµ kh«ng?", "yes_1", "no")
    else
        MsgBox("<color=yellow>" .. npcname .. "<c>:T«i biÕt cã 1 n¬i rÊt Êm ¸p, c« muèn ®i ®Õn ®ã kh«ng?", "yes_2", "no")
    end
end

function renwu3()
    local b = random(1, 18)
    if (b == 1) then
        --ºìÉ·±äÉí·û
        AddNormalItem(8, 96, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13270)
    elseif (b == 2) then
        --±ù½¾³æ±äÉí·û
        AddNormalItem(8, 110, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13271)
    elseif (b == 3) then
        --»Ã¾«±äÉí·û
        AddNormalItem(8, 93, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13272)
    elseif (b == 4) then
        --»ðÐ°±äÉí·û
        AddNormalItem(8, 90, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13273)
    elseif (b == 5) then
        --Á×Ñý±äÉí·û
        AddNormalItem(8, 78, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13274)
    elseif (b == 6) then
        --«ÊÒ©Â¨×Ó±äÉí·û¢H¡^
        AddNormalItem(8, 83, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13275)
    elseif (b == 7) then
        --ÈýÌ«×Ó±äÉí·û¢H¡^
        AddNormalItem(8, 224, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13276)
    elseif (b == 8) then
        --ÑÒ½¬ÊÞ±äÉí·û¢H¡^
        AddNormalItem(8, 58, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13277)
    elseif (b == 9) then
        --½ª×ÓÑÀ±äÉí·û¢H¡^
        AddNormalItem(8, 225, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13278)
    elseif (b == 10) then
        --ÙÁÈË±äÉí·û¢H¡^
        AddNormalItem(8, 54, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13279)
    elseif (b == 11) then
        --´óÅô±äÉí·û¢H¡^
        AddNormalItem(8, 105, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13280)
    elseif (b == 12) then
        --ÅÌ¹Å±äÉí·û¢H¡^
        AddNormalItem(8, 75, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13281)
    elseif (b == 13) then
        --ÁúµÄ´«ÈË±äÉí·û¢H¡^
        AddNormalItem(8, 52, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13282)
    elseif (b == 14) then
        --²¢·â±äÉí·û¢H¡^
        AddNormalItem(8, 108, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13283)
    elseif (b == 15) then
        --«°²ÝÏÉ±äÉí·û¢H¡^
        AddNormalItem(8, 107, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13284)
    elseif (b == 16) then
        --±ùÁé±äÉí·û¢H¡^
        AddNormalItem(8, 109, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13285)
    elseif (b == 17) then
        --«°»¢ÈË±äÉí·û¢H¡^
        AddNormalItem(8, 113, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13286)
    else
        --¹íµÆ±äÉí·û
        AddNormalItem(8, 99, 2, 1, 0, 0)
        Talk(1, "no", 13263)
        TopMessage(13287)
    end
end

function yes_1()
    local w, x, y = GetWorldPos()
    if (w == 64) or (71 == w) or (w == 72) or (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", 13288)
    else
        UseTownPortal()
        SetFightState(0)
        CloseDialog()
    end

end

function yes_2()
    local w, x, y = GetWorldPos()
    if (w == 64) or (71 == w) or (w == 72) or (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", 13288)
    else
        NewWorld(16, 1633, 3192)
        SetFightState(1)
        CloseDialog()
    end
end

function no()
    CloseDialog()
end