Global_xuanwujianling = 256

function OnTimer(npcidx)
    NpcSay(npcidx, "Tiªn Ma NhÊt §¹i ®©y sao? Ha ha!")
    SetGlobalValue(Global_xuanwujianling, 0)
    AddGlobalCountNews("Dòng sÜ Tiªn Ma ch­a thÓ th«ng qua kh¶o nghiÖm HuyÒn Vò KiÕm Linh, HuyÒn Vò KiÕm Linh ®· ch×m xuèng ®¸y suèi.", 1)
    DelNpc(npcidx)
end;
