Title_List = { { name = "∞◊Ω°§Õ˙Õ˙∫ÿÀÍ", id = 1740, title = 152, },
               { name = "◊Í Ø°§Õ˙Õ˙∫ÿÀÍ", id = 1741, title = 153, },
               { name = "«±¡˙°§Õ˙Õ˙∫ÿÀÍ", id = 1742, title = 154, },
               { name = "Ch› T´n°§Õ˙Õ˙∫ÿÀÍ", id = 1743, title = 155, },
               { name = "ŒﬁÀ´°§Õ˙Õ˙∫ÿÀÍ", id = 1744, title = 156, },
               { name = "µ€Õı°§Õ˙Õ˙∫ÿÀÍ", id = 1745, title = 157, },
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
