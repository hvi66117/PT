--Descript:ÎäÍõ¼ÆÊ±
--Author:liujifang
--Date:2010-10-27

--¸±±¾±äÁ¿£º
instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒþ²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒþ²ØNPC
instance_Step = 30                         --¸±±¾½ø¶È(1É±ËÀÒ»²àµÄÌØÊâ¹Ö£¬2É±ËÀÁ½Ö»ÌØÊâ¹Ö£¬3É±ËÀÃùÉ³ÏÉ£¬4-5É±ËÀÉ³Áú£¬6-7É±ËÀÕÅÌì¾ý£¬8ÎäÍõËÀÍö)
instance_ShaHun_Num = 31                   --¾Þ´óÉ³»ê´æÔÚµÄ¸öÊý
instance_ShaLingLeft_Num = 32              --×ó²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊý
instance_ShaLingRight_Num = 33             --ÓÒ²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊý
instance_BossIdx = 34                      --1ºÅBOSSÃùÉ³ÏÉµÄindex
instance_DoorMid = 35                      --ÖÐ¼äµÄ×èµ²ÃÅ
instance_LastNpc = 36                      --36-40ÎªÎäÍõºÍµñÏñµÄindex
instance_WuWangBoss = 41                   --Õ½¶·ÎäÍõµÄindex
instance_TrapDoor = 42                     --42-44Õ½¶·ÎäÍõµÄindex
instance_Boss2Idx = 45                     --2ºÅBOSSÉ³ÁúµÄindex
instance_Boss3Idx = 46                     --3ºÅBOSSÕÅÌì¾ýµÄindex
--¸±±¾±äÁ¿

TABLE_Npc = {
    --id µÈ¼¶ x×ø±ê y×ø±ê ËÀÍöÂ·¾¶ ÊÇ·ñai aiÂ·¾¶ ÏÔÊ¾Ãû×Ö
    [1] = { id = 1853, lvl = 150, x = 1625, y = 3158, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [2] = { id = 1854, lvl = 150, x = 1654, y = 3188, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [3] = { id = 1855, lvl = 150, x = 1623, y = 3216, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [4] = { id = 1856, lvl = 150, x = 1592, y = 3190, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },

}

function OnTimer(npcidx)
    local oldInstance = InstanceIndex
    local instanceID = GetNpcTask(npcidx, 1)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    InstanceIndex = GetNpcTask(npcidx, 0)

    local trapIdx = 0
    local step = GetInstanceTempValue(instance_Step)
    local npcIdx = 0
    local mapid, x, y = GetNpcWorldPos(npcidx)

    if (step >= 9) then
        DelNpc(npcidx)
        return
    end

    npcIdx = AddNpc(1862, 150, nSubWorldIdx, 1625 * 32, 3186 * 32)    --¼ÓÎäÍõÕ½¶·
    if (npcIdx > 0) then
        SetNpcScript(npcIdx, "\\script\\instance\\ÎäÍõË¢ÐÂ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
        SetNpcName(npcIdx, "Vâ V­¬ng")
        SetNpcTask(npcIdx, 0, InstanceIndex);
        SetNpcTask(npcIdx, 1, instanceID);
        SetInstanceTempValue(36, npcIdx)
    end

    Msg2CurMapAnnounceEx(mapid, "Ph¸p lùc cña Nhiªn §¨ng §¹o Nh©n vµ Tõ Hµng §¹o Nh©n b¶o vÖ hån ph¸ch cña Vò V­¬ng, ®Ó Vò V­¬ng lu«n bÊt tö, b©y giê Vò V­¬ng ®· phôc sinh, mäi ng­êi h·y ®èi tho¹i víi Vò V­¬ng ®Ó b¾t ®Çu l¹i cuéc chiÕn víi Tr­¬ng Thiªn Qu©n.")

    DelNpc(npcidx)

    InstanceIndex = oldInstance
end

function no()
    CloseDialog()
end