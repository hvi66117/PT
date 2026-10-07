Task_Partner = 801
Task_ZhenAiTime = 1631
function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (IsMarried() == 1) then
        local myname = GetName()
        local other = GetMateName()
        Talk(1, "no", "Vßng tay ch©n t×nh: <c=g>" .. myname .. "<c> vµ <c=g>" .. other .. "<c> sÏ m·i h¹nh phóc bªn nhau!")
    elseif (GetTask(Task_Partner) ~= 0 and GetTask(800) ~= 0) then
        Talk(1, "no", "Vßng tay ch©n t×nh: H·y mau hoµn thµnh nghi thøc, ta sÏ lµ minh chøng h¹nh phóc cho hai ng­êi!")
    else
        Talk(1, "no", "Vßng tay ch©n t×nh: ThiÕu ®i nöa kia, ta ®· mÊt ®i hµo quang!")
        DelNormalItem(6, 1, 779, 0)
    end
end

function no()
    CloseDialog()
end
