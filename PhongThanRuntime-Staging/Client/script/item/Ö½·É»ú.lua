Task_TombSweeping = 1692

function main(nLevel, nTime, nTNpcIdx, itemID)

    local nYear, nMonth, nDay = GetYMD()
    if GetTaskByte(Task_TombSweeping, 2) ~= nDay then
        SetTask(Task_TombSweeping, 0)
        SetTaskByte(Task_TombSweeping, 2, nDay)
    end

    if IsItemBind(itemID) > 0 then
        if GetTaskBit(Task_TombSweeping, 30) == 0 then
            local i = math.random(1, 100)
            if i <= 80 then
                EarnBind(200000)
                Msg2Player("Chóc mõng b¹n nhËn ®­îc 20 v¹n b¹c khãa")
            else
                EarnBind(400000)
                Msg2Player("Chóc mõng b¹n nhËn ®­îc 40 v¹n b¹c khãa")
            end
            SetTaskBit(Task_TombSweeping, 30, 1)
            DelItemByID(itemID)
        else
            Msg2Player("H«m nay b¹n ®· më lÔ vËt TiÕt Thanh Minh 1 lÇn, lÔ vËt cßn l¹i ngµy mai h·y sö dông!")
        end
    else
        Msg2Player("VËt phÈm nµy chØ ®­îc tÆng b»ng h÷u, b¶n th©n kh«ng thÓ sö dông!")
    end
end
