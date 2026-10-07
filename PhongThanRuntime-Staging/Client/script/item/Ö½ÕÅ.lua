function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)
    local tasks = {
        { "Thuy“n gi y", "Boat"; show = 1 },
        { "Hπc gi y", "Bird"; show = 1 },
        { "M∏y bay gi y", "Plane"; show = 1 },
    }
    SetTask(140, itemID)
    SayTask("Bπn c„ th” g p gi y nµy thµnh Thuy“n gi y, Hπc gi y, M∏y bay gi y, Æ” t∆ng cho bªng h˜u!", tasks)
end

function Boat()
    no()
    Make_Sth(1)
end

function Bird()
    no()
    Make_Sth(2)
end

function Plane()
    no()
    Make_Sth(3)
end

function Make_Sth(n)
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(n, 0, 3, "\\script\\item\\÷Ω’≈.lua", nInterrupt)
end

function InteruptMotion(MotionID)

end

Item_List = {
    { item = { 6, 1, 822 }, name = "Thuy“n gi y" },
    { item = { 6, 1, 823 }, name = "Hπc gi y" },
    { item = { 6, 1, 824 }, name = "M∏y bay gi y" },
}

function EndMotion(MotionID)
    DelItemByID(GetTask(140))
    SetTask(140, 0)
    local item = Item_List[MotionID].item
    AddNormalItem(item[1], item[2], item[3], 0, 0, 0)
    TopMessage("Bπn th´ng qua g p gi y nhÀn Æ≠Óc <c=g>" .. Item_List[MotionID].name .. "<c>")
end
