--ÎäÊ¿¹ê»ÃÏñ¼°ÆäÍ·Áì.lua
--author: Laiyongcong
--date:2009-05-04

star_dream2 = 1607        --¼ÇÂ¼ÕÙ»½³öµÄÎäÊ¿¹ê»½ĞÑµÄNpcidx


function no()
    CloseDialog()
end;


function OnDeath(npcindex)
    local NO = GetNpcTask(npcindex, 1) ---npcµÄĞòºÅ
    local PID = GetNpcTask(npcindex, 2) ---¸ÃnpcÊÇÄÇ¸öÍæ¼ÒÕÙ»½³öÀ´µÄ

    local _, x, y = GetNpcWorldPos(npcindex)

    --AddNpc(990,40,SubWorld,x*32,y*32)

    if (PID == GetPlayerID()) then
        --±»×Ô¼ºÉ±ËÀ

        if (HaveIBBuff(660) == 0) then
            --ÒÑ¾­³¬Ê±ÁË
            Msg2Player("Ph¸p lùc ®· biÕn mÊt, vÒ t×m TriÒu Ca Tinh Quan.")
            DelNpc(npcindex)
            return
        end

        if (NO < 4) then
            --É±ËÀµÚÈıÖ»ÎäÊ¿¹ê»ÃÏó£¬Í·Áì³öÏÖ
            ScrollMessage("B¹n ®· tiªu diÖt (lÇn thø) " .. NO .. ".")
            NO = NO + 1
            local NpcNo = 990
            local NpcLevel = 40
            local msg = "Lôc Quy ®Çu lÜnh ch­a xuÊt hiÖn, h·y tiÕp tôc cè g¾ng!"
            if (NO == 4) then
                msg = "Lôc Quy ®Çu lÜnh xuÊt hiÖn, c¬ héi tr¶ thï ®· ®Õn."
                NpcNo = 991
                NpcLevel = 45
            end
            local idx = AddNpc(NpcNo, NpcLevel, SubWorld, x * 32, y * 32)--------------------------NPCµÄ±àºÅĞèÒªĞŞ¸Ä£¬Ìí¼ÓÎäÊ¿¹êÍ·Áì
            if (idx ~= 0) then
                Msg2Player(msg)
                ScrollMessage(msg)
                SetNpcTask(idx, 1, NO)
                -------------------------------------------------±ê¼Ç×Ô¼ºÎªµÚNO¸ö»ÃÏó
                SetNpcTask(idx, 2, PID)
                -----------------------------------------------±ê¼Ç¸ÃÎäÊ¿¹êÊÇË­ÕÙ»½³öÀ´µÄ
                local mtimes = 600
                if (mtimes > GetIBBuffLeftTimes(660)) then
                    mtimes = GetIBBuffLeftTimes(660)
                end
                SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", mtimes)
                SetTask(star_dream2, idx)
            else
                ScrollMessage("Thªm NPC thÊt b¹i")  -------------------------------²âÊÔÓÃ
            end

        elseif (NO == 4) then
            --É±ËÀÁËÎäÊ¿¹êÍ·Áì
            if (HaveItemInAllRoom(4, 246, 0, 1, 0, 0, 0) == 0) then
                ScrollMessage("B¹n ®· thu phôc Lôc Quy ®Çu lÜnh, cã thÓ vÒ b¸o c«ng råi!")
                ClearItem(4, 246, 0, 1)
                AddNormalItem(4, 246, 0, 1, 0, 0)
                ----------------------------------------------Ìí¼Ó¹ÛĞÇÍ²ËéÆ¬
                Msg2Player("NhËn thµnh c«ng m¶nh vôn Quan Tinh gi¶n, cã thÓ vÒ phôc mÖnh.")
                TaskNote(1051, 7)
            else
                ScrollMessage("§· nhËn ®­îc m¶nh vôn Quan Tinh gi¶n, mau vÒ phôc mÖnh")
            end
        end
    else
        local pidx = SearchPlayerById(PID)
        if (pidx ~= 0) then
            --local str = GetName()
            local tempidx = PlayerIndex
            PlayerIndex = pidx
            Msg2Player("¶o C¶nh Lôc Quy vµ Lôc Quy ®Çu lÜnh b¹n t×m ®­îc ®Òu ®· biÕn mÊt, nh­ng b¹n vÉn cã thÓ gi¸o huÊn Lôc Quy ®Ó t×m l¹i!")
            TaskNote(1051, 5)
            --RemoveIBBuff(660)

            PlayerIndex = tempidx
        end
    end
    DelNpc(npcindex) --É¾³ı¸ÃNPC
end
