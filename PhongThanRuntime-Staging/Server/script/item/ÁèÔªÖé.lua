g_SearchClansMan = 1483

g_Distance = 222

g_ClansMan = 223

mapChihouCoord = {

    { x = 227 * 8, y = 207 * 16 },
    { x = 215 * 8, y = 215 * 16 },
    { x = 245 * 8, y = 205 * 16 },
    { x = 255 * 8, y = 213 * 16 },
    { x = 250 * 8, y = 222 * 16 },
    { x = 234 * 8, y = 232 * 16 },
}

mapClansmanCoord = {
    { x = 241 * 8, y = 199 * 16 },
    { x = 1712, y = 3200 },
    { x = 1944, y = 3728 },
    { x = 2001, y = 3665 },
}

function main()

    local px
    local py
    local mapid = 75
    if (GetTaskByte(g_SearchClansMan, 1) == 4) then
        MsgBox("Téc nh©n cña b¹n ®· bÞ ®em ®i, tíi chç YÓn B¸ Thóc nhËn l¹i tõ ®Çu.", "no")
        return
    end

    if (GetTaskByte(g_SearchClansMan, 1) == 7) then
        MsgBox("§· t×m thÊy ng­êi bÞ th­¬ng, mau chuyÓn ®Õn chç YÓn B¸ Ých.", "no")
        return
    end

    if (GetTaskByte(g_SearchClansMan, 1) == 1) then

        local nNum1 = GetTaskByte(g_SearchClansMan, 2)
        px = mapChihouCoord[nNum1].x
        py = mapChihouCoord[nNum1].y

    end

    if (GetTaskByte(g_SearchClansMan, 1) == 2) then

        local nNum2 = GetTaskByte(g_SearchClansMan, 4)
        px = mapClansmanCoord[nNum2].x
        py = mapClansmanCoord[nNum2].y

    end
    local lightname = {
        [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }
    local l_mapid
    local x1
    local y1
    l_mapid, x1, y1 = GetWorldPos()

    if (GetTaskByte(g_SearchClansMan, 1) <= 0 or GetTaskByte(g_SearchClansMan, 1) == 4 or GetTaskByte(g_SearchClansMan, 1) == 5) then
        MsgBox("L¨ng Nguyªn Ch©u ®· bÞ vì råi.", "no");

        if (GetTaskByte(g_SearchClansMan, 1) == 4) then
            ClearItem(6, 1, 526, 0)
            SetTaskByte(g_SearchClansMan, 1, 1);
            Msg2Player("H·y ®¸nh qu¸i lÇn n÷a ®Ó nhËn ®­îc L¨ng Nguyªn ch©u")
        end

        return
    end

    if (l_mapid ~= mapid) then
        Talk(1, "no", "§Õn nhÇm chç råi!")
    else

        local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))
        local light = 1;
        if (distance <= 25) then
            light = 4;
        elseif (distance <= 400) then
            light = 3;
        elseif (distance <= 2500) then
            light = 2;
        end ;
        local msg = "L¨ng Nguyªn ch©u ph¸t ra" .. lightname[light]

        local lastdist = GetTask(g_Distance)
        if (light == 4) and (lastdist >= 0) then
            msg = msg .. "Cã lÏ ë gÇn ®©y, b¹n cã muèn thö vËn may kh«ng!"
            if (GetTaskByte(g_SearchClansMan, 1) == 1) then
                MsgBox(msg, "discover", "no")
            end
            if (GetTaskByte(g_SearchClansMan, 1) == 2) then
                MsgBox(msg, "discoverClansman", "no")
            end
        else
            if (lastdist == -1) then
                msg = msg .. "Môc tiªu ë ®©u ®ã khu vùc nµy?"
            elseif (lastdist < distance) then
                msg = msg .. ". B¹n cµng <color=red>c¸ch xa<color> môc tiªu."
            else
                msg = msg .. ". B¹n cµng <color=green>tiÕp cËn<color> môc tiªu."
            end ;
            Talk(1, "no", msg)
        end ;
        SetTask(g_Distance, distance)
    end ;
end

function no()
    CloseDialog()
end

function discover()
    CloseDialog()
    local ChiHouType = { Xian = 1101, Mo = 1102 }
    local l_mapid
    local x1
    local y1
    l_mapid, x1, y1 = GetWorldPos()

    local chihou_index
    if (GetJusticEvilCredit() > 0) then
        chihou_index = AddNpc(ChiHouType.Xian, 75, SubWorld, (x1 + 3) * 32, (y1 + 4) * 32)
        if (chihou_index > 0) then
            SetTaskByte(g_SearchClansMan, 1, 2)
            SetNpcScript(chihou_index, "\\script\\Óü·¨É½\\ÏÉ½ç³àºò.lua")
            SetNpcTimer(chihou_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 3)
            TopMessage("Ph¸t hiÖn th¸m qu©n Tiªn Giíi")
            Msg2Player("Ph¸t hiÖn th¸m qu©n Tiªn Giíi.")

        end
    elseif (GetJusticEvilCredit() < 0) then
        chihou_index = AddNpc(ChiHouType.Mo, 75, SubWorld, (x1 + 3) * 32, (y1 + 4) * 32)
        if (chihou_index > 0) then
            SetTaskByte(g_SearchClansMan, 1, 2)
            SetNpcScript(chihou_index, "\\script\\Óü·¨É½\\Ä§½ç³àºò.lua")
            SetNpcTimer(chihou_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 3)
            TopMessage("Ph¸t hiÖn th¸m qu©n Ma Giíi")
            Msg2Player("Ph¸t hiÖn th¸m qu©n Ma Giíi.")
        end
    end

    if (chihou_index > 0) then

        SetTask(g_ClansMan, chihou_index)

        SetNpcTask(chihou_index, 0, GetPlayerID())

        SetNpcTimer(chihou_index, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 3)
    end
end;

function discoverClansman()
    CloseDialog()
    local l_mapid
    local x1
    local y1
    l_mapid, x1, y1 = GetWorldPos()
    local clansman_index = AddNpc(1097, 57, SubWorld, (x1 + 3) * 32, (y1 + 4) * 32)
    if (clansman_index > 0) then

        TopMessage("Téc Nh©n mÊt tÝch ®· xuÊt hiÖn råi.")

        Msg2Player("Téc Nh©n mÊt tÝch ®· xuÊt hiÖn råi.")

        SetTaskByte(g_SearchClansMan, 1, 7)

        SetNpcScript(clansman_index, "\\script\\Óü·¨É½\\Ê§×ÙµÄ×åÈË.lua")

        SetTask(g_ClansMan, clansman_index)

        SetNpcTask(clansman_index, 0, GetPlayerID())

        SetNpcTimer(clansman_index, "\\script\\ontimer\\Ê§×ÙµÄ×åÈËÏûÊ§.lua", 60 * 5)

    end
end;











































































































