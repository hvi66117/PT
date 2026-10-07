function main()
    local tasks = {
        { "Trang 1", "page1"; show = 1 },
        { "Trang 2", "page2"; show = 1 },
    }

    SayTask("Giang S¬n Y Cùu- t¸i hiÖn sù huy hoµng cña D­ Kh¸nh", tasks)
end

function page1()
    CloseDialog()

    OpenNpcCollectionDlg(1)
end

function page2()
    CloseDialog()

    OpenNpcCollectionDlg(2)
end

function no()

    CloseDialog()

end
