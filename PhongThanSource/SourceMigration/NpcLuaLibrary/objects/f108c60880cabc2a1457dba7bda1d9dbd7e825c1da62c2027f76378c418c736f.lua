gItem = {

    [1] = { id1 = 3, id2 = 1006, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [2] = { id1 = 8, id2 = 901, id3 = 2, id4 = 0, id5 = 0, id6 = 0 },
    [3] = { id1 = 8, id2 = 900, id3 = 2, id4 = 0, id5 = 0, id6 = 0 },

    [4] = { id1 = 3, id2 = 24, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [5] = { id1 = 3, id2 = 1010, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [6] = { id1 = 3, id2 = 22, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [7] = { id1 = 4, id2 = 1009, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },
    [8] = { id1 = 3, id2 = 25, id3 = 0, id4 = 0, id5 = 0, id6 = 0 },

    [9] = { id1 = 3, id2 = 926, id3 = 38, id4 = 0, id5 = 0, id6 = 0 },
    [10] = { id1 = 3, id2 = 927, id3 = 38, id4 = 0, id5 = 0, id6 = 0 }
}

function OnDeath(npcidx)
    NpcPolyMorph(npcidx, -1)

    SetNpcTask(npcidx, 1, 1);

    SetNpcTask(npcidx, 2, 1);

    SetNpcTask(npcidx, 3, 0);
    SetNpcTask(npcidx, 4, 0);
    SetNpcTask(npcidx, 5, 0);
    SetNpcTask(npcidx, 6, 0);
    SetNpcTask(npcidx, 7, 0);
    SetNpcTask(npcidx, 8, 0);
    SetNpcTask(npcidx, 9, 0);
    SetNpcName(npcidx, "N«ng §iÒn")
end
