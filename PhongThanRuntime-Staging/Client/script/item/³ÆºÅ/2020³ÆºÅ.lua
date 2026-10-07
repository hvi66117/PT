Title_List = { { name = "∞◊Ω°§Ω Û’–≤∆", id = 1864, title = 164, },
               { name = "◊Í Ø°§Ω Û’–≤∆", id = 1865, title = 165, },
               { name = "«±¡˙°§Ω Û’–≤∆", id = 1866, title = 166, },
               { name = "Ch› T´n°§Ω Û’–≤∆", id = 1867, title = 167, },
               { name = "ŒﬁÀ´°§Ω Û’–≤∆", id = 1868, title = 168, },
               { name = "µ€Õı°§Ω Û’–≤∆", id = 1869, title = 169, },
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
        WriteLog("[2020≥∆∫≈]º§ªÓ: " .. Title_List[Item_Index].name)
        Talk(1, "no", "ChÛc mıng bπn nhÀn Æ≠Óc <c=g>" .. Title_List[Item_Index].name .. "<c> Danh hi÷u!")
    else
        Talk(1, "no", "ThÀt xin lÁi, Sˆ dÙng th t bπi, «Î…‘∫Û‘Ÿ¥Œ≥¢ ‘.")
    end
end

function no()
    CloseDialog()
end
