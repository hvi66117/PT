function main()
    local w, x, y = GetWorldPos()
    local playername = GetName()
    local npcidx = AddNpc(356, 1, SubWorld, x * 32, y * 32)
    Msg2Player("Bπn tπo Æ≠Óc 1 Ng≠Íi Tuy’t (k–o dµi trong 5 phÛt)!")
    SetNpcName(npcidx, playername .. ".")
    SetNpcScript(npcidx, "\\script\\item\\—©»À.lua")
end

