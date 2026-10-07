require("¼×¹ÇÎÄ»î¶¯.luax")

award_list = {

    [1] = { name = "Di ngo¹i phï", id = { 8, 35, 2, 0 }, prop = 10 },
    [2] = { name = "LÔ hép Phï Th¹ch", id = { 8, 1775, 2, 0 }, prop = 54 },
    [3] = { name = "T­íng Qu©n LÖnh", id = { 3, 100, 0, 0 }, prop = 30 },
    [4] = { name = "Vi Quang Qu¸i Phï", id = { 3, 374, 0, 0 }, prop = 5 },
    [5] = { name = "LÔ hép Phï Th¹ch-cÊp 2", id = { 8, 1818, 2, 0 }, prop = 1 }
}

function main(leve, t, npcidx, id)


    if (DelItemByID(id) == 0) then
        return
    end

    local index, _ = GetRandIndex()
    local value = award_list[index]

    local str = "Më lÔ hép 7 ngµy, nhËn ®­îc "
    AddNormalItemBind(value.id[1], value.id[2], value.id[3], value.id[4], 0, 0, 1)
    str = str .. value.name
    WriteLog(str)
    Msg2Player(str)
    ORACLEBONE.GetCardWayApply(50, 27)
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
