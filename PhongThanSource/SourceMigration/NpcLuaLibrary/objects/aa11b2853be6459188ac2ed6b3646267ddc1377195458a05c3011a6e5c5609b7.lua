--description: Áú¼ª¹«Ö÷--×¢ÈëÁé»ê
--author: yaoxin 
--date: 2007/05/21

--812   ÈÎÎñÐÅÏ¢  1£½ Ê±¼ä£¬ 2£½ ½ÓµÄ´ÎÊý£¬ 3 £½ Ëæ»úµÄµØÍ¼£¬ 4 £½ »ñµÃÂÌ×°µÄ´ÎÊý
--1003  Õ½»êµÄAddnpc index
--1004	Õ½»êµÄÐÅÏ¢ 1£½×¢ÈëµÄÐòºÅ£¬2 £½Ö°Òµ£¬ 3£½ ×°±¸ÀàÐÍ£¬4£½ ÐÒÔËÖµ(ÊÇÕæÊµµÄË«±¶)
--1005	ÕÐ»êµÄ¿ª¹Ø 0¸Õ½ÓÈÎÎñ£¬1ÕÒµ½ÁÑÏ¶ÕÐ³ö¶Ô»°npc£¬2ÕÐ³öboss

function OnDeath(npcidx)
    local npcindex = GetTask(1003)
    if (npcindex == npcidx) and (npcindex > 0) then
        local LuckV = GetByte(GetTask(1004), 4)
        local Luckr = random(1, 100)
        local TypeA = GetByte(GetTask(1004), 2)
        local TypeB = GetByte(GetTask(1004), 3)
        local succeed = GetByte(GetTask(812), 4) + 1
        local lvName = {
            [7] = { [3] = "Tinh Cang Kh«i", [4] = "Th¸i Êt Qu¸n", [5] = "Gi¸c Thó  Trô" },
            [6] = { [3] = "Tinh Cang Yªu §¸i", [4] = "Th¸i Êt C©n", [5] = "Gi¸c Thó Yªu §¸i" },
            [5] = { [3] = "Tinh Cang ChiÕn Ngoa", [4] = "Th¸i Êt  Lý", [5] = "Gi¸c Thó Ngoa" },
        }

        if (Luckr <= LuckV / 2) then
            ThrowItem(npcidx, PlayerIndex, 0, TypeA, TypeB, 6, 1, 0)
            local l = GetName()
            AddGlobalCountNews("ThÇn tho¹i bÊt b¹i cña chiÕn thÇn Th­îng cæ cuèi cïng ®· bÞ <c=water>" .. l .. "<c> ph¸, <c=water>" .. l .. "NhËn ®­îc <c><c=g>" .. lvName[TypeA][TypeB] .. "<c>", 20)
            SetTask(1004, SetByte(GetTask(1004), 4, 10))
            SetTask(1003, 0)
            SetTask(1005, 0)
            SetTask(812, SetByte(GetTask(812), 4, succeed))

            TaskNote(52, 4, lvName[TypeA][TypeB])
        else
            if (succeed == 1) then
                LuckV = LuckV + 4
            else
                LuckV = LuckV + 2
            end

            SetTask(1004, SetByte(GetTask(1004), 4, LuckV))
            ThrowItem(npcidx, PlayerIndex, 0, TypeA, (TypeB - 3), 6, 1, 0)
            SetTask(1003, 0)
            SetTask(1005, 0)
            TaskNote(52, 3, lvName[TypeA][TypeB], lvName[TypeA][TypeB])
        end
    end ;
    DelNpc(npcidx)
end;