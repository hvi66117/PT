function main()
    if ((GetPetType() == 0) or (GetPetHonor() == 0)) then
        MsgBox(13355, "yes", "no")
    else
        MsgBox(13347, "no")
    end
end

function yes()
    if (DelNormalItem(6, 1, 151, 1) == 1) then
        if (GetPetType() ~= 0) then
            DelPet()
        end
        Talk(1, "intro", 13356)

        AddNormalItem(6, 1, 145, 0, 0, 0, 0)
        GenPet("Phi Thiªn Miªu", 3, 50, 0)
    end
end

function intro()
    Talk(1, "no", 13345)
end

function no()
    CloseDialog()
end

