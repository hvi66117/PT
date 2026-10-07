Title_List = { { name = "Duy Ng· §éc T«n", id = { 6, 1, 885 }, title = 69, },
               { name = "Uy ChÊn Th­¬ng Khung", id = { 6, 1, 886 }, title = 70, },
               { name = "SÊt Tr¸ Phong V©n ", id = { 6, 1, 887 }, title = 71, },
}
function main()
    if ((HaveNormalItemInQuick(Title_List[1].id[1], Title_List[1].id[2], Title_List[1].id[3], 0) >= 1) or (HaveNormalItem(Title_List[1].id[1], Title_List[1].id[2], Title_List[1].id[3], 0) >= 1)) then
        if (HaveNormalItem(Title_List[1].id[1], Title_List[1].id[2], Title_List[1].id[3], 0) >= 1) then
            DelNormalItem(Title_List[1].id[1], Title_List[1].id[2], Title_List[1].id[3], 0)
        elseif (HaveNormalItemInQuick(Title_List[1].id[1], Title_List[1].id[2], Title_List[1].id[3], 0) >= 1) then
            DelNormalItemInQuick(Title_List[1].id[1], Title_List[1].id[2], Title_List[1].id[3], 0)
        end
        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end
        ActiveTitleQualify(Title_List[1].title)
        SetCurTitle(Title_List[1].title)
        Msg2Player("B¹n nh©n ®­îc " .. Title_List[1].name .. " Danh hiÖu!")
        InfoBox("B¹n nhËn ®­îc phÇn th­ëng <c=g>" .. Title_List[1].name .. "<c> Danh hiÖu!")
        WriteLog("Sö dông danh hiÖu VIP ChÝ T«n")
    else
        Talk(1, "no", "Sö dông thÊt b¹i.")
    end
end

function no()
    CloseDialog()
end
