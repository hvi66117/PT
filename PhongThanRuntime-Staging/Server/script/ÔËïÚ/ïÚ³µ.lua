--description:ïÚ³µ
--author:ÈÙ½¯·É
--data:2004.7.27

function main()
	local playername,guardindex,a,b,c,d,carriageindex,carriagenpcindex,npcindex
	playername=GetName()
	guardindex=GetTGuardIndexByPlayerName(playername)
	if (guardindex == 0) then
		return
	end;

	a,b,c,d,carriageindex=GetTGuardInfo(guardindex)
	carriagenpcindex=GetSiegeWeaponNpcIndex(carriageindex)
	npcindex=DialogNpcIdx
	SetTask(140,npcindex) --±£´æÍæ¼Ò¶Ô»°µÄnpcIndex
	if(GetMorphType()==364)then
		Msg2Player("Víi tr¹ng th¸i hiÖn t¹i kh«ng thÓ ¸p tiªu.")
	elseif (npcindex==carriagenpcindex) then
		MsgBox("Chän x¸c ®Şnh: Vµo tiªu xa. Chän hñy bá: Rêi khái tiªu xa","enter","out")
    end;
end;

function enter()
	local npcindex
	npcindex = GetTask(140)
	PlayerInOrOut(1, npcindex)
	CloseDialog()
	SetTask(140,0)
	local  skill,type = GetCreatureInfo()
	if(type>=0)then
		 SetCreatureType(skill,type)
	end;
end;

function out()
	local npcindex
	npcindex = GetTask(140)
	PlayerInOrOut(0, npcindex)
	CloseDialog()
	SetTask(140,0)
end;

function OnDeath(carriagenpcindex)
	if (GetGlobalValue(424) >= 6) then --ïÚ³µÖ»ÄÜËÀ10´Î
		local mapid,x,y=GetNpcWorldPos(carriagenpcindex)
		x=32*x
		y=32*y
		local carriageindex=GetSiegeWeaponIndexByNpcIndex(carriagenpcindex)
		DeleteSiegeWeapon(carriageindex) -- ³ÌĞò°ÑÍæ¼ÒµÄÕóÓªÉèÖÃ»ØÀ´
		SetGlobalValue(422,0)
		SetGlobalValue(423,0)
		SetGlobalValue(424,0)
	elseif(GetGlobalValue(424) >= 3) then
		local i=random(1,2)
		if(i==1)then
			local mapid,x,y=GetNpcWorldPos(carriagenpcindex)
			x=32*x
			y=32*y
			local carriageindex=GetSiegeWeaponIndexByNpcIndex(carriagenpcindex)

			SetGlobalValue(424,GetGlobalValue(424)+1) --ïÚ³µËÀÍö´ÎÊı
			local npcidx=AddNpc(416,1,SubWorld,x,y) -- ÔÚÔ­µØÉú³ÉÒ»¸ö±¦Ïä
			SetNpcName(npcidx,"B¶o r­¬ng tiªu xa")
			SetNpcScript(npcidx,"\\script\\ÔËïÚ\\±¦Ïä.lua")
			SetGlobalValue(425,npcidx)
			DeleteSiegeWeapon(carriageindex) -- ³ÌĞò°ÑÍæ¼ÒµÄÕóÓªÉèÖÃ»ØÀ´
		else
			local mapid,x,y=GetNpcWorldPos(carriagenpcindex)
			x=32*x
			y=32*y
			local carriageindex=GetSiegeWeaponIndexByNpcIndex(carriagenpcindex)
			DeleteSiegeWeapon(carriageindex) -- ³ÌĞò°ÑÍæ¼ÒµÄÕóÓªÉèÖÃ»ØÀ´
			SetGlobalValue(422,0)
			SetGlobalValue(423,0)
			SetGlobalValue(424,0)
		end;
	else
		local mapid,x,y=GetNpcWorldPos(carriagenpcindex)
		x=32*x
		y=32*y
		local carriageindex=GetSiegeWeaponIndexByNpcIndex(carriagenpcindex)

		SetGlobalValue(424,GetGlobalValue(424)+1) --ïÚ³µËÀÍö´ÎÊı
		local npcidx=AddNpc(416,1,SubWorld,x,y) -- ÔÚÔ­µØÉú³ÉÒ»¸ö±¦Ïä
		SetNpcName(npcidx,"B¶o r­¬ng tiªu xa")
		SetNpcScript(npcidx,"\\script\\ÔËïÚ\\±¦Ïä.lua")
		SetGlobalValue(425,npcidx)
		DeleteSiegeWeapon(carriageindex) -- ³ÌĞò°ÑÍæ¼ÒµÄÕóÓªÉèÖÃ»ØÀ´
	end;
end;


function no()
		CloseDialog()
end;
