--description: ÃºÓÍ.lua
--author: jiaruoting
--date: 2009/5/5

Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓğ£¬3µÃµ½ĞÅ´òÃºÓÍ£¬4ÉÕËş£¬5Íê³É£©
--2byte ÓÀ³ıºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²İÏÉ£¬6É±ÅÑÍ½£¬7Íê³É£©
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function EndMotion(MotionID)
    PlayerCastSkill(1, 225, 1)
    SetTaskByte(Task_newer13, 1, 4)
    ClearItem(6, 1, 495, 0)-- modified by yaoxin for 2010-11 
    TopMessage("§· thiªu huû Tiªu Th¸p.")
    Msg2Player("Tiªu Th¸p ®æ sËp trong biÓn löa, cã thÓ vÒ phôc mÖnh T« Toµn Trung råi.")
    TaskNote(209, 4)
end

function no()
    CloseDialog()
end

--AS GaoJingwei 091118
--½ø¶ÈÌõ±»´ò¶ÏÊ±µ÷
function InteruptMotion(MotionID)
end
--AE GaoJingwei 091118
