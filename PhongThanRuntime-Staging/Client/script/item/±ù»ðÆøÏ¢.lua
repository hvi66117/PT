star_dream = 1419

ice_fireIdx = 1420
ice_fireID = 1423
ice_fire_pos = 1421
ice_fire_dist = 1422

function no()
    CloseDialog()
end;

function main()
    if (GetTaskByte(star_dream, 1) ~= 11) then
        Talk(1, "no", "TrÊn Gia chi b¶o cña Tinh Quan ë T©y Kú, cã thÓ dïng nã t×m B¨ng Háa Ma!")
        return
    end

    local m, x, y = GetWorldPos()
    if (m ~= 32) then
        Talk(1, "no", "ChØ ®Õn <c=g>Ngäc TuyÒn B¨ng Xuyªn<c> míi cã thÓ t×m ®­îc tung tÝch cña B¨ng Háa Ma.")
        return
    end

    local icefireidx = GetTask(ice_fireIdx)
    local icefireid = GetTask(ice_fireID)

    local px = GetTaskWord(ice_fire_pos, 1)
    local py = GetTaskWord(ice_fire_pos, 2)
    local distance = (x - px) ^ 2 + (y - py) ^ 2

    if (icefireidx ~= 0 and GetNpcTemplateID(icefireidx) == 995 and icefireid == GetNpcID(icefireidx)) then
        if (distance <= 400) then
            Talk(1, "no", "<c=g>B¨ng Háa Ma<c> ®· hiÖn th©n, mau dïng Hån ph¸ch hå l« thu phôc nã.")
        else
            Talk(1, "no", "B¹n ë <c=g>[" .. math.floor(px / 8) .. "," .. math.floor(py / 16) .. "]<c>T×m ®­îc B¨ng Háa Ma. Mau ®Õn ®ã xem thö ®i")
        end
        return
    end

    local lightname = {
        [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }

    local light = 1;
    if (distance <= 25) then
        light = 4;
    elseif (distance <= 400) then
        light = 3;
    elseif (distance <= 2500) then
        light = 2;
    end ;

    local msg = "B¨ng Háa ph¸t ra h¬i thë" .. lightname[light]
    if (light == 4) then
        msg = msg .. "B¨ng Háa ma chÝnh ë t¹i ®©y, b¹n muèn nã hiÖn th©n kh«ng?"
        MsgBox(msg, "FindYes", "no")
        SetTask(ice_fire_dist, distance)
        return
    end

    local lastdist = GetTask(ice_fire_dist)
    if (lastdist == -1) then
        msg = msg .. "B¨ng Háa Ma ®ang ë quanh ®©y."
        Talk(1, "no", msg)
    else
        if (lastdist > distance) then
            msg = msg .. "B¹n cµng <c=g>tiÕp cËn<c> n¬i Èn n¸u cña B¨ng Háa ma."
        else
            msg = msg .. "B¹n cµng <c=r>c¸ch xa<c> n¬i Èn n¸u cña B¨ng Háa ma."
        end
        Talk(1, "no", msg)
    end
    SetTask(ice_fire_dist, distance)
end;

function FindYes()
    CloseDialog()
    local m, x, y = GetWorldPos()
    if (m ~= 32) then
        Msg2Player("B¹n ®· rêi khái Ngäc TuyÒn B¨ng Xuyªn.")
        return
    end
    local px = GetTaskWord(ice_fire_pos, 1)
    local py = GetTaskWord(ice_fire_pos, 2)
    local npcidx = AddNpc(995, 50, SubWorld, px * 32, py * 32)

    SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
    SetNpcTask(npcidx, 1, GetPlayerID())

    Msg2Player("B¨ng Háa ma xuÊt hiÖn råi, mau dïng Hån ph¸ch hå l« thu phôc nã!")
    ScrollMessage("B¨ng Háa ma xuÊt hiÖn råi, mau dïng Hån ph¸ch hå l« thu phôc nã!")
    SetTask(ice_fireIdx, npcidx)
    SetTask(ice_fireID, GetNpcID(npcidx))
end
