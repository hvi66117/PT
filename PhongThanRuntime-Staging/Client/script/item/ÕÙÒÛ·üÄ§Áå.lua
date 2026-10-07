function main()
    if ((GetPetType() ~= 0) and (GetPetHonor() ~= 0)) then
        if (IsPetReleased() == 0) then
            ReleasePet(1)
            Talk(1, "no", 13116)
        else
            ReleasePet(0)
            Talk(1, "no", 13117)
        end
    else
        Talk(1, "no", 13118)
    end
end

function no()
    CloseDialog()
end
