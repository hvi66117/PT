--¶Ô»°±ùÁéÍ·Áì.lua
--author Laiyongcong
--date 2009-04-21

-------------±³ºóÖ÷Ä±-------------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿
PlayerLightIndex = 1393 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËşnpcindex


function no()
    CloseDialog()
end;

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()
    local bindPid = GetNpcTask(DialogNpcIdx, 4) --»ñµÃÕâ¸ö¹ÖÎïÉíÉÏ°ó¶¨µÄÍæ¼Òid
    if (bindPid ~= GetPlayerID(PlayerIndex)) then
        --²»ÊÇ¸ÃÍæ¼ÒÕÙ»½³öÀ´µÄ¹Ö
        Talk(1, "no", "Ng­¬i kh«ng ph¶i lµ ng­êi ta ®ang t×m, ng­¬i t×m ta cã viÖc g×?")
        return
    end

    SetTask(142, DialogNpcIdx)
    Talk(1, "fight_yes", "V× kh«ng muèn lé diÖn nªn ta lu«n tµng h×nh, nh­ng kh«ng biÕt b»ng c¸ch nµo, Kh­¬ng Tö Nha dïng ma ph¸p ®¸nh ta träng th­¬ng, khiÕn ta kh«ng thÓ kh«ng hiÖn h×nh, ng­¬i h·y chŞu chÕt ®i!!!")

end;

function fight_yes()
    CloseDialog()
    local m, x, y = GetWorldPos()
    if (m ~= 32) then
        ----------------------------------------Íæ¼ÒÀë¿ªÁËÓñÈª±ù´¨
        Msg2Player("B¹n ®· rêi khái Ngäc TuyÒn B¨ng Xuyªn.")
        return
    end
    --ÅĞ¶ÏÍæ¼ÒµÄµÆËşÊÇ²»ÊÇÒÑ¾­Ï¨ÃğÁË
    local npcidx = GetTask(PlayerLightIndex)
    if (npcidx == 0 or (GetPlayerID() ~= GetNpcTask(npcidx, 4)) or (GetNpcTask(npcidx, 1) < 10)) then
        Talk(1, "no", "L«i §iÖn Th¸p ®· t¾t, B¨ng Linh Thñ LÜnh kh«ng kh«ng gÆp n÷a, ng­¬i cÇn t×m Kh­¬ng Tö Nha gióp ®ì?")
        return
    end

    local dlg_npcidx = GetTask(142)
    local _, npcx, npcy = GetNpcWorldPos(dlg_npcidx) --»ñÈ¡npcµÄÎ»ÖÃ

    --É¾³ı¶Ô»°±ùÁéÍ·Áì
    local towerNpcIdx = GetNpcTask(dlg_npcidx, 1)
    if (GetNpcTask(towerNpcIdx, 5) ~= dlg_npcidx) then
        DelNpc(dlg_npcidx)
        ScrollMessage("Gia t¨ng npc thÊt b¹i, ®èi tho¹i B¨ng Linh Thñ LÜnh trªn L«i §iÖn Th¸p ®· bŞ thay ®æi.")
        return
    end

    --Ìí¼ÓÕ½¶·±ùÁéÍ·Áì
    local new_npcidx = AddNpc(958, 50, SubWorld, npcx * 32, npcy * 32)
    if (new_npcidx ~= 0) then
        SetNpcTask(towerNpcIdx, 5, new_npcidx)
        SetNpcTask(new_npcidx, 1, towerNpcIdx)
        SetNpcTask(new_npcidx, 4, GetNpcTask(towerNpcIdx, 4))
        --°Ñ¸ÃnpcÉèÖÃÎªºìÑª
        SetNpcLife(new_npcidx, GetNpcLifeMax(new_npcidx) * 0.05)

        ScrollMessage("Tiªu diÖt B¨ng Linh §Çu LÜnh, ®o¹t B¨ng Linh Gia Th­")
        Msg2Player("Tiªu diÖt B¨ng Linh §Çu LÜnh, ®o¹t B¨ng Linh Gia Th­")
    else
        ScrollMessage("Gia t¨ng npc thÊt b¹i")
    end
    DelNpc(dlg_npcidx)
end
