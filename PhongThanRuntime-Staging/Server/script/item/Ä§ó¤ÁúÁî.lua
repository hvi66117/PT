itemname = "Ma Ly Long LÖnh"
itemid = { 6, 1, 1409, 1 }
npcid = 2306
function GetPlayerTaskState()
    return 0, 0
end

MapID1 = 17
PosXmin = 1590
PosXmax = 1765
PosYmin = 3035
PosYmax = 3150

function main()

    local mapid, x, y = GetWorldPos()
    if (mapid ~= MapID1 or x <= PosXmin or x >= PosXmax or y <= PosYmin or y >= PosYmax) then
        Talk(1, "no", "LÖnh bµi nµy yªu khÝ rÊt nÆng, v× an toµn cña chóng sinh, mêi ngµi tíi phô cËn  <c=g>Kú S¬n [208,193]<c> sö dông " .. itemname)
        return
    end

    if (GetFightState() == 0) then
        Talk(1, "no", "CÇn ë b¶n ®å d· ngo¹i sö dông " .. itemname)
        return
    end
    DelNormalItem(itemid[1], itemid[2], itemid[3], itemid[4])

    local n = AddNpc(npcid, 200, SubWorldID2Idx(mapid), x * 32, y * 32)
    SetNpcTimer(n, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
    WriteLog("[NhiÖm vô chuyÓn sinh][Sö dông " .. itemname .. "]")
end
function no()
    CloseDialog()
end


