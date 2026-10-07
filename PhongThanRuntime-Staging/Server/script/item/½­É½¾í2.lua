function main()
    local tasks = {
        { "Trang 3", "page3"; show = 1 },
        { "Trang 4", "page4"; show = 1 },
    }

    SayTask("Giang S¬n Y Cùu- t¸i hiÖn sù huy hoµng cña D­ Kh¸nh", tasks)
end

TASK_JS_BOOK2 = 1433
TASK_JIANGSHAN_RETRIEVE_ITEM = 1456

function page3()
    CloseDialog()

    local status = GetTaskByte(TASK_JS_BOOK2, 2)
    local retrieve = GetTaskByte(TASK_JIANGSHAN_RETRIEVE_ITEM, 1)
    if (status > 0 and status < 10 and IsExistItem(6, 1, 502, 1) == 0 and retrieve == 0) then
        SetTaskByte(TASK_JIANGSHAN_RETRIEVE_ITEM, 1, 1)
        ClearItem(6, 1, 502, 1)
        AddNormalItem(6, 1, 502, 1, 0, 0)
    end

    OpenNpcCollectionDlg(3)
end

function page4()
    CloseDialog()

    local status = GetTaskByte(TASK_JS_BOOK2, 3)
    local retrieve = GetTaskByte(TASK_JIANGSHAN_RETRIEVE_ITEM, 1)
    if (status > 0 and status < 13 and status ~= 10 and IsExistItem(6, 1, 502, 1) == 0 and retrieve == 0) then
        SetTaskByte(TASK_JIANGSHAN_RETRIEVE_ITEM, 1, 1)
        ClearItem(6, 1, 502, 1)
        AddNormalItem(6, 1, 502, 1, 0, 0)
    end

    OpenNpcCollectionDlg(4)
end

function no()

    CloseDialog()

end
