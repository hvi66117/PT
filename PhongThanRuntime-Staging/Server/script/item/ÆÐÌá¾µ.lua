Task_TwelveIdol = 1484

function main()
    local nTask = GetTaskByte(Task_TwelveIdol, 1)
    local nGrouth = GetTaskByte(Task_TwelveIdol, 3)
    if (nTask >= 3) then
        TopMessage("Hãa th©n Tinh qu©n ®· håi phôc ph¸p lùc <c=g>" .. nGrouth .. "%")
    end
end

function no()
    CloseDialog()
end
