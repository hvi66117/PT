function OnDeath(npcidx)
    AddGlobalNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<color> §· tiªu diÖt thµnh c«ng --<color=yel>Ma LÔ H¶i<color>, thÇn lùc thËt ®¸ng sî!") -- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı 

    --local mapid, x, y = GetWorldPos()
    --PlayerIndex = NpcIdx2PIdx(npcidx)
    --Msg2CurMapAnnounceEx(mapid, "<c=yel>Ma LÔ H¶i<c>:  Nh©n qu¶ lu©n håi, linh hån ta bÊt diÖt.")
    NpcSay(npcidx, GetName() .. "R­¬ng B¸u cña ta!!!!!! h·y mau chãng më!!!!")
    Msg2Player(GetName() .. "R­¬ng B¸u cña ta!!!!!! h·y mau chãng më!!!!")
    Throw_QuaiPhu(npcidx, PlayerIndex)
    local nWorldId, nX, nY = GetNpcWorldPos(npcidx)
    for i = 1, 30 do
        local x = random(nX - 10, nX + 10)
        local y = random(nY - 10, nY + 10)
        local a = AddNpc(1960, 1, SubWorldID2Idx(nWorldId), x * 32, y * 32, 0, 1)
        if (a > 0) then
            SetNpcScript(a, "\\script\\gvn\\wb\\npc\\ruong_malehai.lua")
            SetNpcTimer(a, "\\script\\gvn\\wb\\npc\\ruong_malehai.lua", 30*60)
            SetNpcName(a, "<c=y>R­¬ng B¸u Ma LÔ H¶i<c>")
            SetNpcTask(a, 1, i)
        end
    end
    DelNpc(npcidx)
end

function OnTimer(npcidx)
    AddGlobalNews("<color=yel>Ma LÔ H¶i<color>: Thêi gian ®· hÕt, ta sÏ biÕn mÊt!!") -- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı
    DelNpc(npcidx)
end

function Throw_QuaiPhu(nNpcIdx, nPlayerIdx)
    no()
    ThrowItem(nNpcIdx, nPlayerIdx, 3, 374, 0, 0, 0, 1)
    WriteLog("R¬i ra <c=g>Vi Quang Qu¸i Phï (ch­a mµi)<c>")
    TopMessage("<c=r>Ma LÔ H¶i<c> r¬i rít <c=g>Vi Quang Qu¸i Phï (ch­a mµi)<c>")
    Msg2Player("§· tiªu diÖt <c=r>Ma LÔ H¶i<c> r¬i ra <c=g>Vi Quang Qu¸i Phï (ch­a mµi)<c>.")
end

function no()
    CloseDialog()
end
