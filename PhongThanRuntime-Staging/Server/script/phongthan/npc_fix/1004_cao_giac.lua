-- Phong Than npc_fix 2026-09-28: Cao Giac (gao jue, map 1004); original \script\ChiYouMu\GaoJue.lua (pinyin of GBK PAK path); changes: exit row in SayTask; "Mua den" grants event 41 first and charges 5000 only on success (rollback via DelEventItem if Pay fails); "Bon phan" consumes 10 x (3,j) with task 322 j->0 via QuestExchange before the 1000 fee; renwu1 guarded to task 31 ==1; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ∏ﬂæı-À≥∑Á∂˙
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks =
	{
		{"T©n Th¯c","renwu1";show=0},
		{"Mua ÆÃn","ma";show=1},
		{"B„n ph©n","renwu";show=0},
		{"K’t thÛc ÆËi thoπi","no";show=1}
	}
	UTask_21 = GetTask(31);
	if (UTask_21==1) then
			tasks[1].show=1
	end;
	if(GetLevel()>=35)and(HaveEventItem(49)>=1)and(GetTask(321)==0)and(GetTask(323)==0) and (GetTask(804)==1) then
		tasks[3].show=1
		SayTask(11155,tasks)
	elseif(GetLevel()>=35)and(HaveEventItem(164)>=1)and(GetTask(321)==0)and(GetTask(323)==0) and (GetTask(804)==2) then
		tasks[3].show=1
		SayTask(11155,tasks)
	else
		SayTask(10142,tasks)
	end;
end;

function   renwu1()
		if (GetTask(31)~=1) then	-- npc_fix: phase guard (original advanced unconditionally)
			CloseDialog()
			return
		end;
		Talk(1,"no",10143)
		Msg2Player("T◊m Cao Minh h·i nguy™n li÷u nµo c„ th” t®ng t›nh n®ng cÒa trang bﬁ.")
		TaskNote(14,1)
		SetTask(31,2)
end;

function  ma()
		if (GetCash()>=5000)then
			-- npc_fix: grant first; money is taken only when event 41 is really in the bag
			if (AddEventItem(41)<=0) then
				Msg2Player("Chua the mua den: hanh trang da day.")
				CloseDialog()
				return
			end;
			if (Pay(5000)~=1) then
				DelEventItem(41)
				Msg2Player("Chua the mua den: khong du 5000 luong.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10144)
		else
			Talk(1,"no",10145)
		end;
end;

function  no()
		CloseDialog()
end;

function  renwu()
	if(GetTask(320)>=20)then
		Talk(1,"no",11156)
		return
	end;

	local j=GetTask(322)
	if(j==0)then
	    local i=random(1,4);
		local  w=""
					if (i==1) then
							w="ßﬁa t©m"
					elseif(i==2)then
							w="Phong l÷"
					elseif(i==3)then
							w="ThÒy hÂn"
					elseif(i==4)then
							w="H·a linh"
					end;
		Talk(2,"no","TËt! Nguy™n li÷u l«n nµy ta c«n lµ 10 <color=Red>"..w.."<color>.","ß” ta Æi t◊m nguy™n li÷u v“.")
		SetTask(322,i+21)
		Msg2Player("ßÂng ˝ t◊m cho Cao Gi∏c 10 "..w.." ")
			SetTask(320,GetTask(320)+1)
	else
		if(HaveNormalItem(3,j,0,0)>=10)and(GetCash()>=1000)then
			-- npc_fix: 10 x (3,j) consumed + task 322 j->0 in one transaction, then the fee
			if (QuestExchange(322,j,0,{{3,j,0,0,0,0,10}},{})~=1) then
				Msg2Player("Chua the bon phan: can du 10 nguyen lieu trong hanh trang.")
				CloseDialog()
				return
			end;
			Pay(1000)
			local k=GetTask(325)+10
			local l=random(1,100)
			if (l>k)and((GetGlobalValue(6)==0)or(GetTask(327)<=49))then
				local chengzhang=random(3,5)
				SetTask(327,GetTask(327)+chengzhang)
				if (GetTask(813)==1) then
					AddOwnExp(50*GetLevel())
				else
					AddOwnExp(10*GetLevel())
				end
				SetTask(320,GetTask(320)+1)
				Talk(1,"no","TËt læm! C©y non cÒa ng≠¨i Æ∑ Æ≠Óc b„n th™m <color=green>"..floor(GetTask(320)/2).."<color> l«n, nhÀn Æ≠Óc <color=green>"..chengzhang.."<color> Æi”m tr≠Îng thµnh, ÆÈ tr≠Îng thµnh hi÷n tπi lµ <color=green>"..GetTask(327).."<color>. Loπi c©y non nµy chÿ c«n 10 l«n ch®m s„c, n’u b„n ph©n qu∏ nhi“u sœ ∂nh h≠Îng x u")
			else
				SetTask(327,GetTask(327)+1)
				SetTask(320,GetTask(320)+1)
				Talk(1,"no","Do ng≠¨i b„n qu∏ nhi“u ∂nh h≠Îng Æ’n s˘ sinh tr≠Îng cÒa c©y. C©y non cÒa ng≠¨i hi÷n tπi Æ∑ Æ≠Óc b„n <color=green>"..floor(GetTask(320)/2).."<color> l«n, nhÀn Æ≠Óc <color=green>1 Æi”m<color> tr≠Îng thµnh, ÆÈ tr≠Îng thµnh hi÷n tπi lµ <color=green>"..GetTask(327).."<color>.")
			end;
			SetTask(322,0)

			local m=GetTask(325)+10
			if m>90 then
			m=90
			end;
			SetTask(325,m)

			local n=GetTask(324)-5
			if n<0 then
			n=0
			end;
			SetTask(324,n)

			local o=GetTask(326)-5
			if o<0 then
			o=0
			end;
			SetTask(326,o)
		elseif (HaveNormalItem(3,j,0,0)<10) then
			local  w=""
			if (j==22) then
					w="ßﬁa t©m"
			elseif(j==23)then
					w="Phong l÷"
			elseif(j==24)then
					w="ThÒy hÂn"
			elseif(j==25)then
					w="H·a linh"
			end;
			Talk(1,"no","B„n ph©n c«n <color=green>10"..w.."<color>, ng≠¨i mau Æi l y v“, n’u tr‘ sœ h·ng h’t. ")
		elseif (GetCash()<1000) then
			Talk(1,"no","Ng≠¨i kh´ng ÆÒ 1000 l≠Óng. ")	
		else
			Talk(1,"no",11157)
		end;
	end;
end;
