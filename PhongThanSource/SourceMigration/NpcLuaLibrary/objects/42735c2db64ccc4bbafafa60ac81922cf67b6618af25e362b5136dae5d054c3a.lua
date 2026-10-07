--description: ?Îñ-?É½¹Ø
--author: yangfeng
--date: 2005/6/14

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    UTask_Wizard = GetTask(1)
    UTask_Knight = GetTask(3)
    UTask_Druid = GetTask(2)
    tasks = {
        { "Hoa thÇn bİ", "renwu"; show = 0 },
        { "Th«ng Thiªn", "renwu1"; show = 0 }


    }

    if (GetTask(361) == 1) then
        tasks[1].show = 1;
    end ;
    if ((UTask_Knight == 84) or (UTask_Wizard == 84) or (UTask_Druid == 84)) and (IsExistItem(4, 177, 0, 1) == 0) then
        tasks[2].show = 1;
    end

    SetTask(142, GetNpcID(DialogNpcIdx)) --±£´æÍæ¼Ò¶Ô»°µÄnpcId	
    SayTask(11206, tasks)

end;

function no()
    CloseDialog()
end;

function renwu()
    CloseDialog()
    MsgBox(11205, "no")
    SetTask(361, 2)
    SetTask(365, 0)
    TaskNote(34, 16)
    local count = GetGlobalValue(361)
    if (count < 3) then
        SetGlobalValue(361, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end

        SetGlobalValue(361, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1390, y = 3497 },
            { x = 1364, y = 3205 },
            { x = 1492, y = 3104 },
            { x = 1700, y = 3278 },
            { x = 1569, y = 3469 }
        }
        local sel = random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\ÉñÃØ»¨»ÜÈÎÎñ\\ÈÎÎñ-ÈıÉ½¹Ø.lua")
        SetGlobalValue(29, pos[sel].x)
        SetGlobalValue(30, pos[sel].y)
    end ;
    --	ranaddition()
end;
function renwu1()

    Talk(3, "renwu2", 13945, "Cã ph¶i lµ b¶o vËt kú qu¸i, cã thÓ cho ta xem?", "Ng­¬i cÇm lÊy ®i!")
end
function renwu2()
    CloseDialog()
    Talk(3, "no", 13946, "Xem ra ng­¬i rÊt cÇn nã. TÆng cho ng­¬i! ChØ cÇn ng­¬i t×m nhiÒu hoa vÒ cho ta lµ ®­îc råi.", "§a t¹! Ta ®i t×m hoa ngay ®©y.")

    -- modified by yaoxin for 92ÓÅ»¯ 2009/12 begin
    --921£º1byte mapid 9bitÍê³É¾íÖá 10bitÍê³É»¨Éñ£¬11bitÍê³É±ùÅÜÉÌ
    SetTaskBit(921, 10, 1)
    -- modified by yaoxin for 92ÓÅ»¯  2009/12 end
    AddEventItem(177)
    TopMessage(13947)
    Msg2Player("B¹n nhËn ®­îc V« Tri")
    local count = GetGlobalValue(361)
    if (count < 3) then
        SetGlobalValue(361, count + 1)
    else
        local DNpcId = GetTask(142)
        if (GetNpcID(DialogNpcIdx) == DNpcId) then
            SetTask(142, 0)
        else
            CloseDialog()
            return 1
        end
        SetGlobalValue(361, 0)
        DelNpc(DialogNpcIdx)

        local pos = {
            { x = 1390, y = 3497 },
            { x = 1364, y = 3205 },
            { x = 1492, y = 3104 },
            { x = 1700, y = 3278 },
            { x = 1569, y = 3469 }
        }
        local sel = random(1, 5)
        local npcidx = AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
        SetNpcScript(npcidx, "\\script\\ÉñÃØ»¨»ÜÈÎÎñ\\ÈÎÎñ-ÈıÉ½¹Ø.lua")
        SetGlobalValue(29, pos[sel].x)
        SetGlobalValue(30, pos[sel].y)
    end ;

end
--function ranaddition()
--		local i=random(1,20)
--		if(i==1)then
--			AddNormalItem(6,1,22,0,0,0)		--ª´ºÀªá
--			AddGlobalCountNews("<color=green>"..GetName().."<color>ÔÚÍê³ÉÁËÒ»ÂÖ»¨»ÜÈÎÎñºóÒâÍâ»ñµÃÁË<color=yellow>Ãµ¹å»¨<color>£¬ÕæÊÇÊÜµ½ÁË»¨ÉñµÄ±ÓÓÓ°¡£¡","no")
--			Msg2Player("¹§Ï²Äã»ñµÃÁËÃµ¹å»¨£¡")
--			TopMessage("¹§Ï²Äã»ñµÃÁË<color=green>Ãµ¹å»¨")
--		elseif(i==3)then
--			AddEventItem(39)		--¬h¤ì
--			
--			Msg2Player("¹§Ï²Äã»ñµÃÁËÁøÄ¾£¡")
--			TopMessage("¹§Ï²Äã»ñµÃÁË<color=green>ÁøÄ¾")
--		end
--		CloseDialog()
--end