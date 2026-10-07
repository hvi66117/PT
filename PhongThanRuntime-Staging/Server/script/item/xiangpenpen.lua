function main()
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1012, 3)
    if (thisday ~= lastday) then
        SetTaskByte(1012, 3, thisday)
        SetTaskByte(1012, 4, 0)
    end
    local eatTime = GetTaskByte(1012, 4) + 1
    if (eatTime <= 2) then
        local lvl = GetLevel()
        local exp1
        if (lvl < 80) then
            exp1 = lvl * 3000
        else
            exp1 = lvl * 8000
        end
        DelNormalItem(6, 1, 516, 0)
        SetTaskByte(1012, 4, eatTime)
        AddOwnExp(exp1)
        TopMessage("B¹n nh©n ®­îc " .. exp1 .. "§iÓm PhÇn th­ëng kinh nghiÖm.")
        Msg2Player("B¹n nh©n ®­îc " .. exp1 .. "§iÓm PhÇn th­ëng kinh nghiÖm.")
        Talk(1, "no", "§· sö dông B¸nh Ýt do chÝnh tay V¨n Thï Qu¶ng Ph¸p Thiªn T«n lµm, c¶m gi¸c th©n khinh nh­ yÕn, tinh thÇn phÊn chÊn, ®ång thêi ®iÓm kinh nghiÖm ®­îc t¨ng lªn <c=g>" .. exp1 .. "<c> ®iÓm!")
        local strMsg = "Thu thËp 1 b¸nh Ýt"
        WriteLog(strMsg)
    else
        Talk(1, "no", "B¸nh Ýt tuy ngon miÖng, nh­ng kh«ng thÓ sö dông nhiÒu, mçi ngµy chØ cã thÓ dïng 2 c¸i!")
    end
end;

function no()
    CloseDialog()
end;
