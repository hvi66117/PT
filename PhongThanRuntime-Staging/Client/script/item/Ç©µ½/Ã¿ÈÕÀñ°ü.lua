require("¼×¹ÇÎÄ»î¶¯.luax")
require("³£ÓÃ»î¶¯.luax")

award_list = {
    [1] = { name = "Phï nhiÖm vô chñ ®Ò ngµy", id = { 6, 1, 1005, 1 }, count = 1, prop = 25 },
    [2] = { name = "Phï nhiÖm vô chñ ®Ò ngµy", id = { 6, 1, 1005, 1 }, count = 3, prop = 5 },
    [3] = { name = "Kinh nghiÖm ®¬n", id = { 6, 1, 1062, 1 }, count = 1, prop = 30 },
    [4] = { name = "Di ngo¹i phï", id = { 8, 35, 2, 0 }, count = 1, prop = 34 },
    [5] = { name = "LÔ hép Phï Th¹ch", id = { 8, 1775, 2, 0 }, count = 1, prop = 5 },
}

exp_level = 3500
level = 60

function main(leve, t, npcidx, id)


    local index, _ = GetRandIndex()

    local value = award_list[index]

    if (IsHaveSpaceForTreasure(value.count) < 1) then
        Msg2Player("Hµnh trang ®· ®Çy, xin s¾p xÕp l¹i.")
        return
    end

    if (DelItemByID(id) == 0) then
        return
    end

    if (GetLevel() <= level) and (GetLevel() >= 40) then
        AddPlayerExp(GetLevel() * exp_level);
    end

    local str = "Më lÔ hép b¸o danh hµng ngµy, nhËn ®­îc "

    for i = 1, value.count do
        AddNormalItemBind(value.id[1], value.id[2], value.id[3], value.id[4], 0, 0, 1)
    end
    str = str .. value.count .. " c¸i " .. value.name .. "."
    Msg2Player(str)

    local PetTyte = PetGetType()
    if (PetTyte == 154 or PetTyte == 167) then
        for i = 1, value.count do
            AddNormalItemBind(value.id[1], value.id[2], value.id[3], value.id[4], 0, 0, 1)
        end
        Msg2Player("Phi th¨ng Hoµng Phi Hæ gióp ngµi nhËn ®­îc thªm " .. value.count .. " c¸i " .. value.name)
        WriteLog("[Linh Sñng Thuéc TÝnh][Phi Th¨ng-Hoµng Phi Hæ][Ký danh nhËn thªm " .. value.name .. value.count .. "]")
    elseif (value.name == "LÔ hép Phï Th¹ch") then
        WriteLog(str)
    end

    ORACLEBONE.GetCardWayApply(50, 0)

    if (UActivitie.back_IsOpen(4) == 1) and (UActivitie.back_IsGetGift() == 1) then
        index, _ = GetRandIndex()
        value = award_list[index]
        str = value.count .. "." .. value.name
        if (IsHaveSpaceForTreasure(value.count) < 1) then
            for i = 1, value.count do
                SendItemMailToSelf(4, "Hép th­", "Ho¹t ®éng håi quy: Mçi ngµy më LÔ hép Hµng ngµy nhËn ®­îc thªm 1 phÇn th­ëng ngÉu nhiªn, h«m nay lµ: " .. str .. ", xin ngµi h·y cÇm lÊy!!", value.id[1], value.id[2], value.id[3], value.id[4], 0, 0, 0, 1)
            end
            str = str .. ", ®· göi qua th­, xin kiÓm tra th­ vµ nhËn ®Ýnh kÌm!"
        else
            for i = 1, value.count do
                AddNormalItemBind(value.id[1], value.id[2], value.id[3], value.id[4], 0, 0, 1)
            end
        end
        Msg2Player("Hoan nghªnh ngµi trë l¹i Phong ThÇn, h«m nay th­ëng thªm cho ngµi " .. str)
        WriteLog("[Ho¹t ®éng håi quy][LÔ hép b¸o danh Hµng ngµy][" .. str)
    end
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
