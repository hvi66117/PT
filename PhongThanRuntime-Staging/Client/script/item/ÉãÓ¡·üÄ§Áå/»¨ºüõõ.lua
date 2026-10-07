function main()
    if ((GetPetType() == 0) or (GetPetHonor() == 0)) then
        MsgBox(13349, "yes", "no")
    else
        MsgBox(13343, "no")
    end
end

function yes()
    if (DelNormalItem(6, 1, 146, 1) == 1) then
        if (GetPetType() ~= 0) then
            DelPet()
        end
        Talk(1, "intro", 13350)
        AddNormalItem(6, 1, 145, 0, 0, 0, 0)
        GenPet("Hoa Hå §iªu", 1, 50, 0)
    end
end

function intro()
    Talk(1, "no", 13345)
end
function no()
    CloseDialog()
end
