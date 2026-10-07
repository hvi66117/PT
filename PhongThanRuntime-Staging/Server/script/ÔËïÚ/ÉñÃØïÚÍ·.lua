--description:ÉñÃØïÚÍ· ----- ÔËïÚ½ÓÈÎÎñNPC£¨³ç³Ç´óÓª£©
--author:ÈÙ½¯·É
--data:2004.7.25


function main()
    local playerlevel,carriagenum,playername,guardindex
    playerlevel=GetLevel()
	carriagenum=GetTGuardNum()                           --È¡µÃµ±Ç°ÓÎÏ·ÖĞÕıÔÚÔËĞĞïÚ³µ×ÜÊıÁ¿
    playername=GetName()
	guardindex=GetTGuardIndexByPlayerName(playername)
    if (GetTeam()~=0) then				    --¼ì²âÊÇ·ñÔÚ¶ÓÎéÀï
        Talk(1,"no",11405)
    elseif (GetCamp()==0) then		                     --¼ì²âÊÇ·ñÎªĞÂÊÖ
    	Talk(1,"no",11406)
    elseif (GetTask(60)~=0) then			     --¼ì²âÊÇ·ñÎªÅÜÉÌ×´Ì¬
    	Talk(1,"no",11407)
    elseif (playerlevel <30 ) then
		Talk(1,"no",11408)
    elseif (guardindex >0) then
	     Talk(1,"no",11409)
	elseif (GetGlobalValue(422) == 0) then --±íÊ¾Ã»µ½ÏµÍ³ÊÇ·ñ´¥·¢ÁË¿ªÊ¼ÔËïÚ»î¶¯
		 Talk(1,"no",11410)
	elseif (GetGlobalValue(423) == 1) then --±íÊ¾ÊÇ·ñÒÑ¾­·¢ËÍÁËÒ»ÌËïÚ³µ
	     Talk(1,"no",11411)
	else
	     Talk(1,"che",11412)
    end;
end;

function  che()
	MsgBox(11413,"ok","no")
end;

function no()
	CloseDialog()
end;

function ok()
    local mapid,x,y,playercredit,playergold,playername,carriagelevel,carriageindex,lasttime,playerlevel
    playerlevel=GetLevel()
	playercredit=GetCredit()
    mapid,x,y=GetWorldPos()
    playername=GetName()
	x=32*x   --ĞŞ¸Äby Rocker 2004-9-4 17:35 °ÑÂí³µÖ±½ÓÉú³Éµ½ÈËÉíÉÏ
	y=32*y
    lasttime=1800

	--Rocker ĞŞ¸Ä¿ªÊ¼ ·ÅÔÚÉñÃØïÚÍ·Éí±ß×ÜÊÇ°²È«µÄ
	local mapid2,x2,y2
	mapid2,x2,y2 = GetNpcWorldPos(DialogNpcIdx)
	x2 = 32 * x2
	y2 = 32 * y2
	x2 = x2 - random(100,200)
	y2 = y2 + random(120,150)
	--Rocker ĞŞ¸Ä½áÊø

	if (playerlevel>=30) and (playercredit>=10) then
		 if (mapid2 == 0) then
			carriageindex=NewSiegeWeapon(mapid,x,y,363)
		 else
			carriageindex=NewSiegeWeapon(mapid2,x2,y2,363)
		 end;
		 carriagelevel=1
         --ÉèÖÃïÚ³µ½Å±¾
		 carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
		 SetNpcScript(carriagenpcindex, "\\script\\ÔËïÚ\\ïÚ³µ.lua" )
		 SendCarriage(carriageindex,playername,carriagelevel,lasttime)
		 DelNpc(DialogNpcIdx)
		 SetGlobalValue(426,0)
		 --±äÕóÓª
		 if (carriagenpcindex>0 )then
		if(GetPK()>=88) then
		      SetNpcCurCamp ( carriagenpcindex , 8 )
		      SetCamp(8)   --Rocker ĞŞ¸Ä³ÉÓÀ¾ÃÕóÓª2004-9-4 17:37
			SetCurCamp(8)
		else
		      SetNpcCurCamp ( carriagenpcindex , 2 )
		      SetCamp(2)   --Rocker ĞŞ¸Ä³ÉÓÀ¾ÃÕóÓª2004-9-4 17:37
			SetCurCamp(2)
	end;
			  lasttime = lasttime / 60
			  AddGlobalCountNews("<color=green>"..playername.."<color> nhËn nhiÖm vô ¸p tiªu TuyÖt Long lÜnh, ®­îc Tiªu ®Çu thÇn bİ tin t­ëng",10)
			  CloseDialog()
		 end;
		 SetGlobalValue(423,1)
		 SetGlobalValue(424,0) --ïÚ³µËÀÍö´ÎÊı
	elseif((playerlevel>=30) and (playercredit<10)) then
	     Talk(1,"no",11414)
    end;
end;
