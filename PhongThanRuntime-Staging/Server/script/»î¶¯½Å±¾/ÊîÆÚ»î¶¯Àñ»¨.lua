function main(nLevel, t, nTNpcIdx, nItemId)

    if (HaveNormalItem(6, 1, 879, 0) == 0) then
        return
    end

    DelItemByID(nItemId)
    PlayerCastSkill(1, 150, 1)

    local level = GetLevel()
    local Exp = level * 100
    AddOwnExp(Exp)
    Msg2Player("Bπn nhÀn Æ≠Óc " .. Exp .. " Æi”m kinh nghi÷m.")
    ScrollMessage("Bπn nhÀn Æ≠Óc " .. Exp .. " Æi”m kinh nghi÷m.")
end	
