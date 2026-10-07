function main()
    if ((GetPetType() == 0) or (GetPetHonor() == 0)) then
        MsgBox(13342, "yes", "no")
    else
        MsgBox(13343, "no")
    end
end

function yes()
    if (DelNormalItem(6, 1, 153, 1) == 1) then
        if (GetPetType() ~= 0) then
            DelPet()
        end
        Talk(1, "intro", 13344)
        AddNormalItem(6, 1, 145, 0, 0, 0, 0)
        GenPet("NguyÖt Thè", 6, 50, 0)
    end
end

function intro()
    Talk(1, "no", 13345)
end
function no()
    CloseDialog()
end

