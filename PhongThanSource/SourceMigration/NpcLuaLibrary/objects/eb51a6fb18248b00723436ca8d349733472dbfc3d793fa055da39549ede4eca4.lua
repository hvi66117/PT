require("¹ú¼ÒÈËÆø.luax")

function OnDeath(npcidx)

    Sentiment.PubFuncAddSentiment(npcidx)

    AddGlobalCountNews("Anh hïng c¸i thÕ <c=g>" .. GetName() .. "<c>1 chiªu lÊy <color=blue> Thñ cÊp BOSS Hoµng Kim---Bµn Cæ<c>.", 20)

    DelNpc(npcidx)
end;
