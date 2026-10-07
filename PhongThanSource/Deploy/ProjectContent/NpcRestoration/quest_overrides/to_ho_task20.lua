-- Project compatibility appendix; append AFTER the unchanged VNG Su Ho Lua.
-- Source: script.pak /script/崇城大营/苏护.lua
-- Original SHA256: c44b9f6b28692d77a4a4c6f51d35ebb6a509241e0be102d7b7c78eb4b026460c
-- Keeps task 20, EventItem 26, message IDs and all original reward tuples.
-- QuestExchange is a server API: reserve rewards, consume requirements and
-- advance the expected task phase together. A failed exchange changes nothing.
function renwu1()
    local phase = GetTask(20)
    if phase == 0 then
        MsgBox(10273, "yes_1", "no")
        return
    end
    if phase ~= 18 then
        CloseDialog()
        return
    end
    if QuestExchange(20, 18, 19,
        {{4, 26, 0, 0, 0, 0, 1}},
        {{1, 0, 1, 1, 0, 0, 3}, {1, 3, 1, 1, 0, 0, 3}}) ~= 1 then
        Msg2Player("Chua the nhan thuong: can Hop Gam va cho trong hanh trang.")
        CloseDialog()
        return
    end
    Talk(1, "no", 10272)
    Msg2Player("Giao Hop Gam cho To Ho: nhan 3 Tieu Hong don va 3 Tieu Hoan don.")
    TaskNote(7, 10)
end

function yes_1()
    if QuestExchange(20, 0, 1, {}, {}) ~= 1 then
        CloseDialog()
        return
    end
    Talk(1, "no", 10274)
    Msg2Player("Den Thu Kho lay Hop Gam ve cho To Ho.")
    TaskNote(7, 0)
end
