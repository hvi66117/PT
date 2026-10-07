function main()
    if ((GetPetType() == 0) or (GetPetHonor() == 0)) then
        MsgBox(13353, "yes", "no")
    else
        MsgBox(13343, "no")
    end
end

function yes()
    if (DelNormalItem(6, 1, 152, 1) == 1) then
        if (GetPetType() ~= 0) then
            DelPet()
        end
        Talk(1, "intro", 13354)
        AddNormalItem(6, 1, 145, 0, 0, 0, 0)
        GenPet("Phi Thè", 5, 50, 0)
    end
end

function intro()
    Talk(1, "no", 13345)
end
function no()
    CloseDialog()
end

