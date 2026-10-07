--description: 植物死亡
--author: yangyankun
--date: 2009/09/15

gItem = {
    -- 种子秧苗类
    [1] = { id1 = 3, id2 = 1006, id3 = 0, id4 = 0, id5 = 0, id6 = 0 }, -- 幸运种子
    [2] = { id1 = 8, id2 = 901, id3 = 2, id4 = 0, id5 = 0, id6 = 0 }, -- 幸运秧苗寒
    [3] = { id1 = 8, id2 = 900, id3 = 2, id4 = 0, id5 = 0, id6 = 0 }, -- 幸运秧苗暖
    -- 付费材料类
    [4] = { id1 = 3, id2 = 24, id3 = 0, id4 = 0, id5 = 0, id6 = 0 }, -- 水之魂
    [5] = { id1 = 3, id2 = 1010, id3 = 0, id4 = 0, id5 = 0, id6 = 0 }, -- 水之灵
    [6] = { id1 = 3, id2 = 22, id3 = 0, id4 = 0, id5 = 0, id6 = 0 }, -- 地之心
    [7] = { id1 = 4, id2 = 1009, id3 = 0, id4 = 0, id5 = 0, id6 = 0 }, -- 地之息
    [8] = { id1 = 3, id2 = 25, id3 = 0, id4 = 0, id5 = 0, id6 = 0 }, -- 火之灵
    -- 收获果实类
    [9] = { id1 = 3, id2 = 926, id3 = 38, id4 = 0, id5 = 0, id6 = 0 }, -- 双叶草
    [10] = { id1 = 3, id2 = 927, id3 = 38, id4 = 0, id5 = 0, id6 = 0 }    -- 三叶草
}
--1372
function OnDeath(npcidx)
    NpcPolyMorph(npcidx, -1)
    -- 清空所有NPC变量
    SetNpcTask(npcidx, 1, 1);            -- 种植状态
    --1 【未被种植】
    --2 【种植了种子暖】
    --3 【种植了种子寒】
    --4 【种植了暖、寒两种种子】
    SetNpcTask(npcidx, 2, 1);            -- 成长状态
    --1 初始状态：【您的农田目前长势良好】
    --2 缺水状态：【您的农田有一些枯萎】    此时正确操作为【浇水】
    --3 缺肥状态：【您的农田土质有些贫瘠】  此时正确操作为【施肥】
    --4 受虫害状态：【您的农田爬满了青虫】  此时正确操作为【捉虫】
    --5 可采集状态：【已经到了收获的季节】

    SetNpcTask(npcidx, 3, 0);            -- 成长度
    SetNpcTask(npcidx, 4, 0);            -- 最后一次操作时间
    SetNpcTask(npcidx, 5, 0);            -- 设置操作次数，即一次都没有操作
    SetNpcTask(npcidx, 6, 0);            -- 玩家A ID
    SetNpcTask(npcidx, 7, 0);            -- 玩家B ID
    SetNpcTask(npcidx, 8, 0);
    SetNpcTask(npcidx, 9, 0);
    SetNpcName(npcidx, "N玭g 襫")
end
