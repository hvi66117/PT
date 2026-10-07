award_list = {
    [1] = { name = "Kinh nghiÖm ®¬n", id = { 6, 1, 1062, 1 }, prop = 15 },
    [2] = { name = "Di ngo¹i phï", id = { 8, 35, 2, 0 }, prop = 15 },
    [3] = { name = "LÔ hép Phï Th¹ch", id = { 8, 1775, 2, 0 }, prop = 35 },
    [4] = { name = "T­íng Qu©n LÖnh", id = { 3, 100, 0, 0 }, prop = 30 },
    [5] = { name = "Vi Quang Qu¸i Phï", id = { 3, 374, 0, 0 }, prop = 5 },
}

function main(leve, t, npcidx, id)


    if (DelItemByID(id) == 0) then
        return
    end

    local index, _ = GetRandIndex()
    local value = award_list[index]

    local str = "Më lÔ hép 15 ngµy, nhËn ®­îc "
    AddNormalItemBind(value.id[1], value.id[2], value.id[3], value.id[4], 0, 0, 1)
    str = str .. value.name
    WriteLog(str)
    Msg2Player(str)
end

g_Magnitude = 10000

function GetRandIndex()

    if (award_list == nil) then
        return -1, -1
    end

    local nRand = math.random(1, 100 * g_Magnitude)
    local nRandSum = 0

    local nlenth = table.getn(award_list)

    for i = 1, nlenth do

        if (award_list[i] == nil or award_list[i].prop == nil) then
            return -1, -1
        end

        nRandSum = nRandSum + (award_list[i].prop * g_Magnitude)

        if (nRand <= nRandSum) then
            return i, nRand
        end
    end

    return 1, nRand
end
