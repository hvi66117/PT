--description: ¸±±¾Ö÷½Å±¾-Ìì¾øÕó
--author: yaoxin
--date: 2009-9-8
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø
--2byte:0=Î´½Ó 1=½Ó 2=É±µØÁÒBOSS 3=½ÓÏŞÊ±É±·çºğ 4=Íê³É 

item_list = {--id µÈ¼¶ x×ø±ê y×ø±ê ËÀÍöÂ·¾¶ ÊÇ·ñai aiÂ·¾¶ ÏÔÊ¾Ãû×Ö 
    [1] = { id = 1324, lvl = 70, x = 1553, y = 3317, deathscript = "\\script\\instance\\death\\Èıá¦»¤·¨Õß.lua", isai = 1, aisrcipt = "\\script\\ai\\Èıá¦»¤·¨Õß.lua", npcname = "<c=yel>Thiªn Ph­ín Hé Ph¸p<c>" }, --Ììá¦»¤·¨Õß
    [2] = { id = 1325, lvl = 70, x = 1690, y = 3156, deathscript = "\\script\\instance\\death\\Èıá¦»¤·¨Õß.lua", isai = 1, aisrcipt = "\\script\\ai\\Èıá¦»¤·¨Õß.lua", npcname = "<c=yel>§Şa Ph­ín Hé Ph¸p<c>" }, --µØá¦»¤·¨Õß
    [3] = { id = 1326, lvl = 70, x = 1547, y = 3154, deathscript = "\\script\\instance\\death\\Èıá¦»¤·¨Õß.lua", isai = 1, aisrcipt = "\\script\\ai\\Èıá¦»¤·¨Õß.lua", npcname = "<c=yel>Nh©n Ph­ín Hé Ph¸p<c>" }, --ÈËá¦»¤·¨Õß
    [4] = { id = 1321, lvl = 80, x = 1624, y = 3228, deathscript = "\\script\\instance\\death\\ÇØÌì¾ı.lua", isai = 1, aisrcipt = "\\script\\ai\\ÇØÌì¾ı.lua", npcname = "<c=yel>TÇn Thiªn Qu©n<c>" }, --ÇØÌì¾ı
    --bugĞŞÕıÂ·¾¶²»¶Ô  modified by yaoxin for 2009-12-10
    [5] = { id = 1340, lvl = 1, x = 1602, y = 3207, deathscript = "\\script\\¹ÖÎï\\death.lua", isai = 0, aisrcipt = "", npcname = "" }, --ÃÅ
    [6] = { id = 1341, lvl = 1, x = 1605, y = 3245, deathscript = "\\script\\¹ÖÎï\\death.lua", isai = 0, aisrcipt = "", npcname = "" }, --ÃÅ
    [7] = { id = 1340, lvl = 1, x = 1645, y = 3249, deathscript = "\\script\\¹ÖÎï\\death.lua", isai = 0, aisrcipt = "", npcname = "" }, --ÃÅ
    [8] = { id = 1341, lvl = 1, x = 1636, y = 3209, deathscript = "\\script\\¹ÖÎï\\death.lua", isai = 0, aisrcipt = "", npcname = "" }, --ÃÅ			
    --bugĞŞÕıÂ·¾¶²»¶Ô  modified by yaoxin for 2009-12-10
    [9] = { id = 1332, lvl = 70, x = 1560, y = 3310, deathscript = "\\script\\instance\\death\\Èıá¦.lua", isai = 0, aisrcipt = "", npcname = "Thiªn Ph­ín" }, --Ììá¦
    [10] = { id = 1333, lvl = 70, x = 1683, y = 3164, deathscript = "\\script\\instance\\death\\Èıá¦.lua", isai = 0, aisrcipt = "", npcname = "§Şa Ph­ín" }, --µØá¦
    [11] = { id = 1334, lvl = 70, x = 1555, y = 3162, deathscript = "\\script\\instance\\death\\Èıá¦.lua", isai = 0, aisrcipt = "", npcname = "Nh©n Ph­ín" }, --ÈËá¦
    --[12] = {id = 1334, lvl=70,  x=1520, y=3139, deathscript="\\script\\instance\\death\\Ìì¾øÒş²Ø.lua", isai =0, aisrcipt="", npcname="<c=pk>H×nh quan TriÖt Gi¸o<c>"},--ÈËá¦
}
session_mapid = 1
-- ¸±±¾³õÊ¼»¯£¬½øĞĞ¸±±¾µÄ³õÊ¼ÉèÖÃ£¬Èç°ÚBoss£¬ÖÃ³£Á¿µÈ£¬ÔÚ´´½¨¸±±¾ºó×Ô¶¯µ÷ÓÃ
function OnInitialize()
    --³õÊ¼»¯£¬¸±±¾Î´Æô¶¯Ê±
    for j = 1, 5 do
        --?????
        SetInstanceSaveValue(j, 0)
    end

    --¼Óboss
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(InstanceID)
    local list = {}
    local bossidx = -1
    local temp
    local nums = getn(item_list)
    for i = 1, nums do
        temp = item_list[i]
        bossidx = AddNpc(temp.id, temp.lvl, nSubWorldIdx, temp.x * 32, temp.y * 32)
        if (bossidx > 0) then
            list[i] = bossidx
            SetNpcScript(bossidx, temp.deathscript)
            SetNpcName(bossidx, temp.npcname)
            if (temp.isai == 1) then
                SetAIScript(bossidx, temp.aisrcipt)
            end
            SetInstanceTempValue(i, bossidx)
            SetInstanceTempValue(nums + i, GetNpcID(bossidx))
            NpcAddIBBuff(bossidx, 1064)
        end
    end
    -----------------------Òş²ØÈÎÎñ£¬Add by jrt-------------------
    local random1 = random(1, 100)
    if (random1 <= 5) then
        local bossidx1 = AddNpc(1518, 85, nSubWorldIdx, 1520 * 32, 3139 * 32)  --¼ÓÒş²ØBOSS
        SetInstanceTempValue(24, bossidx1)
        SetInstanceTempValue(25, GetNpcID(bossidx1))
    end
    -----------------------Òş²ØÈÎÎñ£¬Add by jrt-------------------

    for k = 1, 3 do
        --Èıá¦»¤·¨°ó¶¨ÆäËûnpc
        for l = 1, 11 do
            SetNpcTask(list[k], l, list[l])
        end
        SetNpcTask(list[k], 12, 0)--1ÎªËÀÁË
    end

    for k = 9, 11 do
        --Èıá¦°ó¶¨ÇØÌì¾ı
        SetNpcTask(list[k], 0, 0)
        SetNpcTask(list[k], 1, k - 8)
        SetGuardLevel(list[k], 2)
    end

    for n = 5, 8 do
        --ÃÅ¼Ó±£»¤
        SetGuardLevel(list[n], 2)
    end

    --ÇØÌì¾ı
    SetNpcTask(list[4], 2, nSubWorldIdx)--Îª¼ÓÃÅ£¬¼Ó¹í÷ÈÓÃ
    SetNpcTask(list[4], 8, InstanceIndex)--Îª¼Ó±¾µØ¶Ô»°ÓÃ,È¡¸±±¾±äÁ¿ÓÃ
    SetNpcTask(list[4], 9, InstanceID)--ÎªÈ¡´´½¨Ê±¼äÓÃ

    --Èıá¦»¤·¨
    SetNpcTask(list[1], 13, nSubWorldIdx)--¼ÓÈÎÎñ¹ÖÓÃ
    SetNpcTask(list[1], 14, InstanceID)--ÎªÈ¡´´½¨Ê±¼äÓÃ
    SetNpcTask(list[1], 15, InstanceIndex)--Îª¼Ó±¾µØ¶Ô»°ÓÃ,È¡¸±±¾±äÁ¿ÓÃ
    SetNpcTask(list[2], 13, nSubWorldIdx)--
    SetNpcTask(list[2], 14, InstanceID)--ÎªÈ¡´´½¨Ê±¼äÓÃ
    SetNpcTask(list[2], 15, InstanceIndex)--Îª¼Ó±¾µØ¶Ô»°ÓÃ,È¡¸±±¾±äÁ¿ÓÃ
    SetNpcTask(list[3], 13, nSubWorldIdx)--
    SetNpcTask(list[3], 14, InstanceID)--ÎªÈ¡´´½¨Ê±¼äÓÃ
    SetNpcTask(list[3], 15, InstanceIndex)--Îª¼Ó±¾µØ¶Ô»°ÓÃ,È¡¸±±¾±äÁ¿ÓÃ

    for m = 3, 5 do
        --´æÈıá¦
        SetNpcTask(list[4], m, list[m + 6])
    end
end

-- ¸±±¾ÊÍ·Å£¬¿É½øĞĞ¸±±¾³õÊ¼»¯Ïà·´µÄ´¦Àí£¬ÈçÇå³£Á¿µÈ£¬ÔÚÊÍ·Å¸±±¾Ç°×Ô¶¯µ÷ÓÃ
function OnRelease()
    --AddGlobalCountNews("¸±±¾Ö÷½Å±¾-Ìì¾øÕó£¬ÊÍ·Å£¡", 1)
    --bugfsb00019821  modified by yaoxin for 2009-12-10
    local idx = -1
    local npcindex = GetInstanceTempValue(4)
    for i = 23, 35 do
        idx = GetNpcTask(npcindex, i)
        if (idx > 0) and (GetNpcID(npcindex) ~= 0) and (GetNpcTemplateID(idx) == 1336) then
            DelNpc(idx)
        end
    end
    --bugfsb00019821  modified by yaoxin for 2009-12-10

    local nums = getn(item_list)
    local npcidx = -1
    for i = 1, nums do
        npcidx = GetInstanceTempValue(i)
        if (npcidx > 0) and (GetNpcID(npcidx) ~= 0) and (GetNpcID(npcidx) == GetInstanceTempValue(i + nums)) then
            DelNpc(npcidx)
        end
    end
    npcidx = GetInstanceTempValue(24)
    if (npcidx > 0) and (GetNpcID(npcidx) ~= 0) and (GetNpcID(npcidx) == GetInstanceTempValue(25)) then
        DelNpc(npcidx)
    end
    npcidx = GetInstanceTempValue(26)
    if (npcidx > 0) and (GetNpcID(npcidx) ~= 0) and (GetNpcID(npcidx) == GetInstanceTempValue(27)) then
        DelNpc(npcidx)
    end
end

