SkillByItem = {
    [1934] = 1496,
    [1935] = 1500,
    [1936] = 1516,
    [1937] = 1502,
    [1938] = 1512,
    [1939] = 1513,
    [1940] = 1520,
    [1941] = 1515,
    [1942] = 1506,
    [1943] = 1508,
    [1944] = 1510,
    [1945] = 1522,
}

function main(nItemId)
    local particular = GetItemPartByID(nItemId)
    local skillId = SkillByItem[particular]
    if skillId == nil then
        Msg2Player("P0 safety: sach ky nang khong co trong bang xac minh.")
        return
    end
    if GetNewBirthTimes() < 1 then
        Msg2Player("Can Phong Than/Chuyen Sinh truoc khi hoc ky nang nay.")
        return
    end
    if IsSkillActived(skillId) > 0 then
        Msg2Player("Ky nang nay da duoc kich hoat; vat pham khong bi tru.")
        return
    end
    if ActiveNewBirthSkill(skillId) <= 0 then
        Msg2Player("Khong the kich hoat ky nang; vat pham khong bi tru.")
        return
    end
    DelItem(1, 0, 6, particular)
    Msg2Player("Da kich hoat ky nang Phong Than ID " .. skillId .. ".")
end
