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

function main()
    local tasks = {
        { "B¶o vÖ Vò V­¬ng", "HongShangZhen"; show = 1 },
    }

    SetTask(140, DialogNpcIdx)
    SayTask("Vò V­¬ng: §¹i hiÖp, cuèi cïng còng ®· tíi!", tasks)

end

function HongShangZhen()
    no()
    if (GetTeam() == 0) then
        Talk(1, "no", "Vò V­¬ng: §ång ®éi cña ng­¬i ®©u? ë ®©y mét m×nh rÊt nguy hiÓm!")
    else
        if (GetTeamMember(1) ~= PlayerIndex) then
            Talk(1, "no", "Vò V­¬ng: H·y mêi ®éi tr­ëng cña ng­¬i tíi nãi chuyÖn víi ta.")
        else
            MsgBox("Vò V­¬ng: Ng­¬i cã cÇn ®i cïng víi ®ång ®éi ®Ó b¶o vÖ ta kh«ng?", "RefreshNpc", "no")
        end
    end

end

function RefreshNpc()
    no()
    local npcidx = GetTask(140)
    local oldInstance = InstanceIndex
    local instanceID = GetTask(1741)  --modify by liujifang at 2010-12-09
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    InstanceIndex = GetNpcTask(npcidx, 0)

    local trapIdx = 0
    local step = GetInstanceTempValue(instance_Step)
    local npcIdx = 0
    local mapid, x, y = GetNpcWorldPos(npcidx)

    npcIdx = AddNpc(1861, 150, nSubWorldIdx, 1625 * 32, 3186 * 32)    --¼ÓÎäÍõÕ½¶·
    if (npcIdx > 0) then

        SetNpcScript(npcIdx, "\\script\\instance\\death\\ÎäÍõ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
        SetNpcName(npcIdx, "<c=g>Vò V­¬ng<c>")

        SetNpcTask(npcIdx, 0, InstanceIndex);
        SetNpcTask(npcIdx, 1, instanceID);
        SetGuardLevel(npcIdx, 1)
        SetNpcCamp(npcIdx, 0)
        SetInstanceTempValue(instance_WuWangBoss, npcIdx)
        SetInstanceTempValue(51, 0)

        for i = 1, 3 do
            trapIdx = GetInstanceTempValue(41 + i)
            if (trapIdx > 0 and GetNpcTemplateID(trapIdx) == 1867) then
                if (step < 5) then
                    SetNpcTask(trapIdx, 2, 0)  --Ë¢¹Ö¸öÊý
                    SetNpcTask(trapIdx, 3, 0)  --Ë¢¹ÖÊ±¼ä
                    SetNpcTask(trapIdx, 4, 0)  --2ºÅBOSSÊÇ·ñÌí¼Ó
                    SetNpcTask(trapIdx, 6, 0)  --Ë¢¹ÖÅú´Î
                    SetInstanceTempValue(instance_Step, 3)
                else
                    SetNpcTask(trapIdx, 2, 0)
                    SetNpcTask(trapIdx, 3, 0)
                    SetNpcTask(trapIdx, 6, 5)
                    SetInstanceTempValue(instance_Step, 5)
                end
            end
        end

        if (step >= 5) then
            --É¾µñÏñ
            for i = 1, 4 do
                if (GetNpcTemplateID(GetInstanceTempValue(36 + i)) == (1852 + i)) then
                    DelNpc(GetInstanceTempValue(36 + i))
                end
            end

            --¼ÓµñÏñ
            local temp = -1
            local diaoXiang = 0
            for i = 1, getn(TABLE_Npc) do
                temp = TABLE_Npc[i]
                diaoXiang = AddNpc(temp.id, temp.lvl, nSubWorldIdx, temp.x * 32, temp.y * 32)

                if (diaoXiang > 0) then

                    SetNpcName(diaoXiang, "T­îng")
                    if (temp.istimer > 0) then
                        SetNpcScript(diaoXiang, temp.npcscript)
                        SetNpcTimer(diaoXiang, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
                    else
                        SetNpcTimer(diaoXiang, temp.npcscript, LeftTime)
                    end

                    SetInstanceTempValue(36 + i, diaoXiang);
                    SetNpcTask(diaoXiang, 0, InstanceIndex);
                    SetNpcTask(diaoXiang, 1, instanceID);
                end
            end
        end
    end

    DelNpc(npcidx)

    InstanceIndex = oldInstance
end

function no()
    CloseDialog()
end