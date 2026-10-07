--description:Ëï×ÓÓğ
--author: yangfeng
--date:2005/10/18

--¶«ÒÄÖ÷ÏßÈÎÎñ±äÁ¿£º583
--µËæ¿ÓñÉ±ËÀÁéÈÎÎñ¼ÆÊı£º584
--°İ·ÃÄ§¼ÒËÄ½«ÈÎÎñ±äÁ¿£º585  1Îª¸Õ½ÓÈÎÎñ·ÃÎÊÁËÒ»ÈË  2£¬4£¬6 Îª·ÃÎÊÁËÁ½ÈË  5£¬7£¬9 Îª·ÃÎÊÁËÈıÈË 10 Îª·ÃÎÊÍê±Ï(ºìÈ¨ÖµÎª1 º£È¨ÖµÎª3 ÇàÈ¨ÖµÎª5)
--Ä§ÀñÊÙÉ±¶úÊóÈÎÎñ¼ÆÊı£º586 
--Ñ¯ÎÊÎäÍõæûÍõÈÎÎñ±äÁ¿£º587	1Îª¸Õ¸Õ½ÓÁËÈÎÎñ ÎäÍõÈ¨ÖµÎª1£¬æûÍõÈ¨ÖµÎª3
--Ñ°ÕÒÒÄÏÉ²İµÄÏÂÂä±äÁ¿£º588
--ÙÈÁúÈÎÎñ±äÁ¿£º589
--ÙÈ»¢ÈÎÎñ±äÁ¿£º590
--ÙÈÀÇÈÎÎñ±äÁ¿£º591
--ÎäÍõÔÄĞÅ£º592
--æûÍõÔÄĞÅ£º593
--µË¾Å¹«´ğÌâ²½Öè£º594
--ÒÄ×åÅ®×ÓËµ»°²½Öè£º595
--Àî¾¸¶Ô»°²½Öè£º596
function  main()
	tasks =
		{
			{"Chiªu mé anh hµo","zhaomu1";show=0}
		}
--	if(GetTask(597)==0)then
--		tasks[1].show=1
--	end;
	SayTask("Qu©n doanh träng ®Şa, kh«ng ®­îc tù tiÖn vµo!",tasks)
end;

function zhaomu1()
	MsgBox("<color=green>§Æng ®¹i nh©n<color> truyÒn c¸o: Ai cã thÓ gióp triÒu ®×nh trÊn gi÷ quan ¶i, lËp ®¹i c«ng sÏ cã träng th­ëng! Ng­¬i cã tµi c¸n g× kh«ng?","yes","no")
end;

function yes()
	if (GetLevel()>=70) then
--		SetTask(597,1)
--		Talk(3,"no","<color=green>"..GetName().."<color>¡G°ê®a¦³Ãø¡A¤Ç¤Ò¦³³d¡C¦óªp¤E¤½«Â¦W¡A¥@¤H¬Òª¾¡C¦b¤UÄ@·N«e©¹¡I","®]¤l¦Ğ¡G§Ú´Nª¾¹D­^¶¯§A¬O¤£·|©Úµ´ªº¡C§A²{¦b³t¥h<color=red>¤T¤sÃö<color>§ä<color=green>¾H¤E¤½<color>¤j¤H§a¡C","<color=green>"..GetName().."<color>¡G¦nªº¡C¦b¤U°¨¤W´N°Ê¨­¡C")
--		Msg2Player("«e©¹¤T¤sÃö»P¾H¤E¤½¹ï¸Ü¡C")
--		TaskNote(35,0) 
	else
		Talk(2,"no","TrÊn gi÷ quan ¶i hiÓm nguy trïng trïng. Ng­¬i ch­a ®ñ søc ®©u! VÒ tu luyÖn thªm ®i!","<color=green>"..GetName().."<color>: Uhm! Xem ra ta cÇn ph¶i luyÖn tËp thªm!")
	end;
end;

function  no()
	CloseDialog()
end;
