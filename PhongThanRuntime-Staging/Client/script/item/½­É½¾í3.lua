TASK_JIANGSHAN_PAGE5_STATUS = 1438
TASK_JIANGSHAN_RETRIEVE_ITEM = 1456

function main()

    local status = GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4)
    local retrieve = GetTaskByte(TASK_JIANGSHAN_RETRIEVE_ITEM, 2)
    if (status > 0 and status < 15 and status ~= 10 and IsExistItem(6, 1, 503, 0) == 0 and retrieve == 0) then
        SetTaskByte(TASK_JIANGSHAN_RETRIEVE_ITEM, 2, 1)
        ClearItem(6, 1, 503, 0)
        AddNormalItem(6, 1, 503, 0, 0, 0)
    end

    OpenNpcCollectionDlg(5)
end

function no()

    CloseDialog()

end
