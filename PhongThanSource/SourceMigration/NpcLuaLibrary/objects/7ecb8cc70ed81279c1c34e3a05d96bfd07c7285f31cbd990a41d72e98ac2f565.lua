Include("\\script\\gvn\\lib.lua")
function OnDeath(npcidx)
    AddGiftOnDeath(GetNpcLevel(npcidx))
    AddGlobalCountNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<c>1 chiªu lÊy <color=blue> Thñ cÊp BOSS Hoµng Kim---Bµn Cæ<c>.", 20)
    -- ËÀÍöÖ®ºó²»ÈÃËüÖØÉúĞèÒª´ÓÊÀ½çÖĞÉ¾³ı
    DelNpc(npcidx)
end;
