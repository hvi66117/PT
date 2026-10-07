Title_List = { { name = "∞◊Ω°§÷Ì÷Ì∫ÿÀÍ", id = 1801, title = 158, },
               { name = "◊Í Ø°§÷Ì÷Ì∫ÿÀÍ", id = 1802, title = 159, },
               { name = "«±¡˙°§÷Ì÷Ì∫ÿÀÍ", id = 1803, title = 160, },
               { name = "Ch› T´n°§÷Ì÷Ì∫ÿÀÍ", id = 1804, title = 161, },
               { name = "ŒﬁÀ´°§÷Ì÷Ì∫ÿÀÍ", id = 1805, title = 162, },
               { name = "µ€Õı°§÷Ì÷Ì∫ÿÀÍ", id = 1806, title = 163, },
}

function main(nLevel, nTime, nTNpcIdx, itemID)
    local nParticular = GetItemPartByID(itemID)
    local Item_Index = 0
    for i = 1, getn(Title_List) do
        if (nParticular == Title_List[i].id) then
            Item_Index = i
            break
        end
    end

    if (Item_Index == 0) then
        Talk(1, "no", "Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end

    if (DelItemByID(itemID) > 0) then
        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end
        ActiveTitleQualify(Title_List[Item_Index].title)
        SetCurTitle(Title_List[Item_Index].title)
        Msg2Player("Bπn nh©n Æ≠Óc " .. Title_List[Item_Index].name .. " Danh hi÷u!")
        Talk(1, "no", "ChÛc mıng bπn nhÀn Æ≠Óc <c=g>" .. Title_List[Item_Index].name .. "<c> Danh hi÷u!")
    else
        Talk(1, "no", "ThÀt xin lÁi, Sˆ dÙng th t bπi, «Î…‘∫Û‘Ÿ¥Œ≥¢ ‘.")
    end
end

function no()
    CloseDialog()
end
