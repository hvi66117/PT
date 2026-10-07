--description:À´È¥ÈçÒâ°ü
--author: liuying
--date:2006/3/27
--½Ğ½T©w§Aªºª««~Äæ¤º¦³¨¬°÷ªºªÅ¶¡»â¨ú§A­nªºª««~¡I§A½T©w­n¥´¶}¶Ü¡H==ÇëÈ·¶¨ÄãµÄÎïÆ·À¸ÄÚÓĞ×ã¹»µÄ¿Õ¼äÁìÈ¡ÄãÒªµÄÎïÆ·<color=yellow>Ğ¡çÎç¿ÇåÂ¶¡¢Ğ¡ÈÕÔÂÕæÆø¡¢Ò°Íâ´«ËÍ·û£¨10´Î£©¡¢åĞÒ£ÁÒÑæÉ¢£¨½ğ£©<color>¡£ÄãÈ·¶¨Òª´ò¿ªÂğ£¿
function  main(itemID)
	SetExeState(0)
	MsgBox("Xin x¸c nhËn « vËt phÈm cña b¹n cßn kh«ng gian ®Ó nhËn vËt phÈm b¹n muèn <color=yellow>Phiªu lé (tiÓu), Ch©n Khİ (tiÓu), Di ngo¹i phï (10 lÇn), Dao Tr¶m t¸n<color>. B¹n x¸c ®Şnh muèn më#¿","yes","no")
end;

function yes()
	local i=FindAValidIBItem(8,49,2,0)
	if(i~=0)then
		CostIBItem(i)
		AddNormalItem(8,28,3,0,1,0)
		AddNormalItem(8,29,4,0,1,0)
		AddNormalItem(8,35,2,0,1,0)
		AddNormalItem(8,6,0,0,1,0)
		CloseDialog()
	else
		Talk(1,"no","Xin x¸c nhËn b¹n cã vËt phÈm nµy vµ vÉn cßn hiÖu lùc!")
	end;
end;

function  no()
	CloseDialog()
end;