-- Original VNG source payload; provenance in deployment report.
--description:Ñîê¯-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/7/14
--902,±ù´¨Ì½ÏÕ

function  main()
	local tasks = 
	{
		{"Quy Tinh","renwu1";show=0},
		{"Phu Thª","renwu2";show=0},
		{"ThÇn Long","renwu3";show=0},
		{"T×m hiÓu","renwu4";show=1},
		{"B¨ng Xuyªn ThÝ LuyÖn","shitu_1";show=0}
	}
	UTask_Knight = GetTask(3);
	if(GetPlayerType()==0)  and  (GetLevel()>=55)  and  (UTask_Knight==30)then
			tasks[3].show=1
	end;
	local task_step = GetByte(GetTask(53),2)
	if(task_step < 36)and(GetLevel()>=59)then
		 tasks[1].show=1
	end;

	UTask_world_2=GetTask(92);	
	if(UTask_world_2==1)then
			tasks[2].show=1
	end;

	if(GetLevel()>40)and(GetLevel()<=50)and(GetTask(902)<=7)then	--®{§Ìµ¥¯Åok¡A®{§Ì¨S¦³§¹¦¨¹L
		tasks[5].show=1;
	end;
			
	SayTask(10449,tasks)
end;

function  shitu_1()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		if(GetTask(902)==0)then		--±µ¥ô°È
			MsgBox("S­ phô cã nãi muèn t¨ng nhanh n¨ng lùc chØ cÇn v­ît qua nh÷ng mª cung ma qu¸i. Ng­¬i cã muèn thö kh«ng#¿","shitu_1_begin","no")
		elseif(GetTask(902)==6)then	--§¹¦¨¥ô°È
			MsgBox("Chóc mõng! Cã ph¶i ng­¬i c¶m thÊy m¹nh h¬n tr­íc nhiÒu? ","shitu_1_end","no")
		elseif(GetTask(902)==7)then
			Talk(1,"no","Ng­¬i ®· hoµn thµnh nhiÖm vô ThÝ LuyÖn B¨ng Xuyªn. NÕu ng­¬i muèn xuÊt s­ cã thÓ ®Õn TriÒu Ca gÆp Hoµng Phi Hæ! ")
		else				--©ñ±ó¥ô°È
			MsgBox("Dôc tèc bÊt ®¹t! HiÖn n¨ng lùc cña ng­¬i ch­a ®ñ ®Ó hoµn thµnh thö th¸ch nµy. H·y quay l¹i sau!","shitu_1_cancel","no")
		end
	else
		if(GetTask(902)==0)then
			Talk(1,"no","N¬i nµy v« cïng nguy hiÓm. NÕu ng­¬i ®¹t cÊp 41 cã thÓ lËp tæ ®éi víi s­ phô ®Ó v­ît mª cung. ")
		elseif(GetTask(902)==6)then
			Talk(1,"no","NhiÖm vô s­ ®å th¸m hiÓm cÇn 2 s­ ®å t¹o thµnh 1 nhãm. Xin x¸c nhËn tæ ®éi ®· h×nh thµnh!")
		elseif(GetTask(902)==7)then
			Talk(1,"no","Ng­¬i ®· hoµn thµnh nhiÖm vô ThÝ LuyÖn B¨ng Xuyªn. NÕu ng­¬i muèn xuÊt s­ cã thÓ ®Õn TriÒu Ca gÆp Hoµng Phi Hæ! ")
		else
			MsgBox("Dôc tèc bÊt ®¹t! HiÖn n¨ng lùc cña ng­¬i ch­a ®ñ ®Ó hoµn thµnh thö th¸ch nµy. H·y quay l¹i sau!","shitu_1_cancel","no")
		end
	end
end

function shitu_1_begin()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		RemoveIBBuff(216)
		local done=AddIBBuff(216)	--¼Ð»xbuff
		if(done==1)then
			SetTask(902,1)
			TaskNote(46,5)
			if(GetTask(900)<7)then
				SetTask(900,0)
				TaskNote(44,-1)
			end
			if(GetTask(901)<7)then
				SetTask(901,0)
				TaskNote(45,-1)
			end
			if(GetTask(899)<7)then
				SetTask(899,0)
				TaskNote(43,-1)
			end
			Talk(2,"no","Ng­¬i hiÖn ®øng trong vßng <color=yellow>Dòng gi¶<color>, tr­íc khi vßng trßn nµy mÊt ®i ph¶i phôc mÖnh <color=green>§¹i phu<color> ë mçi tÇng Mª cung B¨ng Xuyªn, nÕu hoµn thµnh xem nh­ thÝ luyÖn thµnh c«ng!","BÊt cø tæn th­¬ng nµo còng cã thÓ khiÕn vßng trßn cña ng­¬i mÊt ®i. C¶ qu¸ tr×nh nµy ng­¬i ph¶i cïng víi s­ phô thùc hiÖn. §¹i phu cña mçi tÇng sÏ trÞ th­¬ng gióp ng­¬i. ")
		else
			Talk(1,"no","Tr¹ng th¸i cña ng­¬i hiÖn kh«ng thÓ tiÕp nhËn nhiÖm vô s­ ®å. H·y quay l¹i sau nhÐ!")
		end
	else
		Talk(1,"no","NhiÖm vô s­ ®å th¸m hiÓm cÇn 2 s­ ®å t¹o thµnh 1 nhãm. Xin x¸c nhËn tæ ®éi ®· h×nh thµnh!")
	end
end

function shitu_1_end()
	local mark=judge_relation()
	if(mark==1)then		--º¡¨¬®v®{2¤H¶¤ 
		shitu_1_end_P()
		local oldPlayer=PlayerIndex
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			PlayerIndex=n
			shitu_1_end_M()
		end
		PlayerIndex=oldPlayer
	else
		Talk(1,"no","NhiÖm vô s­ ®å th¸m hiÓm cÇn 2 s­ ®å t¹o thµnh 1 nhãm. Xin x¸c nhËn tæ ®éi ®· h×nh thµnh!")
	end
end

function step_complete()
	local mark=0
	local step={}
	for i=1,4 do
		step[i]=8-GetTask(898+i)
		if(step[i]==1)then
			mark=mark+1
		end
	end
	return mark
end

function shitu_1_end_P()
	local exp1=GetNextExp()-GetExp()
	local exp2=2*GetNextExp()
	local exp=2*GetNextExp()
	AddOwnExp(exp1)
	exp2=exp2-exp1
	exp1=GetNextExp()-GetExp()
	if(exp1<exp2)then
		AddOwnExp(exp1)
		AddOwnExp(exp2-exp1)
	else
		AddOwnExp(exp2)
	end
	SetTask(902,7)
	TaskNote(46,6)
	TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>"..exp.."kinh nghiÖm")
	local mark=step_complete()
	if(mark==1)and(GetTask(907)==0)then	--§¹¦¨¤F¤@¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹Lºñ¦âÀY²¯
		AddNormalItem(0,7,GetPlayerType()+6,4,0,0)
		SetTask(907,1)
		Talk(1,"no","Ng­¬i thËt xuÊt s¾c! Xin nhËn phÇn th­ëng")
		AddGlobalCountNews("<color=green>"..GetName().."<color> vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <color=green>®Çu kh«i<color>",20)
--	elseif(mark==2)and(GetTask(903)==0)then		--§¹¦¨¤F¤G¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹LÂÅ¦â§¤ÃM
--		AddNormalItem(3,14,0,0,0,0)
--		SetTask(903,1)
--		Talk(1,"no","·¨áÖ¡G¯u¬O¤£Â²³æ¡A§A¤w¸g§¹¦¨¤F¨â¶µ«iÂô°g®cªº¸Õ½m¡A§Ú³o¸Ì¦³¤@¤Ç¯«¾s¡A´NÃØ»P§A¤F¡I")
	elseif(mark==4)and(GetTask(904)==0)then		--§¹¦¨¤F¥|¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹L50ÂÅ§¤ÃM
		AddNormalItem2(0,10,GetPlayerType()+15,9,0,0)
		SetTask(904,1)
		Talk(1,"no","§óng lµ anh hïng xuÊt thiÕu niªn! Xin nhËn phÇn th­ëng!")
		AddGlobalCountNews("<color=green>"..GetName().."<color>vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <color=green>thó c­ìi cÊp 50<color>",20)
	else
		Talk(1,"no","S­ ®å 2 ng­êi phèi hîp thËt xuÊt s¾c!")
	end
end

function shitu_1_end_M()
	local step=GetTask(902)
	if(step<100)then
		AddMasterPRValue(10)
		SetTask(902,100)
		TopMessage("B¹n nhËn ®­îc <color=green>10 ®iÓm s­ ®å")
	else
		AddMasterPRValue(5)
		TopMessage("Chóc mõng! B¹n nhËn ®­îc <color=green>5 ®iÓm s­ ®å")
		Talk(1,"no","12930:LÇn tr­íc ng­¬i ®· nhËn th­ëng, nªn phÇn th­ëng lÇn nµy kh«ng ®­îc nhiÒu. ")
	end
end

function shitu_1_cancel()
	RemoveIBBuff(216)
	SetTask(902,0)
	TaskNote(46,-1)
	Talk(1,"no","B¨ng Xuyªn rÊt nguy hiÓm. Ng­¬i ch­a ®ñ søc. H·y rÌn luyÖn thªm mét thêi gian n÷a!")
end

function judge_relation()		--º¡¨¬®v®{2¤H¶¤
	local mark=0
	if(GetTeam()~=0)then			-- ¦³¶¤¥î	
		if(GetTeamSize()==2)then	--2¤H¶¤
			if(IsCaptain()==0)then
				n=GetTeamMember(1)
			else
				n=GetTeamMember(2)
			end;
			mark=IsMasterPRRelation(n)
		end
	end
	return mark
end


function  renwu3()
				Talk(1,"no",10450)
				Msg2Player("H·y mang r©u ThÇn Long vÒ cho Hå Hû MÞ ")
				SetTask(3,31)
				TaskNote(27,13)
end;

map_names=
{
	"B¾c H¶i",
	"YÕn S¬n",
	"Miªu C­¬ng",
	"Cù Léc",
	"Thñ D­¬ng s¬n",
	"T©y C«n L«n",
}

function  renwu1()
	local task_val = GetTask(53)
	local task_step = GetByte(task_val, 2)
	local task_state = GetByte(task_val, 1)
	if (task_state == 0)then
		MsgBox(10454,"yes_1","no")
	elseif(task_state == 1) then
		if (HaveEventItem(42) >= 1) then
			Talk(1,"no","T¹i <color=green>"..map_names[floor(task_step/6)+1].." <color> cã thÓ t×m thÊy <color=green>Phong Ên th¸p<color>, dïng <color=green>B¸ch Linh Ph­ín<color> th¶ <color=green>Thiªn C­¬ng Ma Tinh<color> ra. Sau khi thu phôc nã sÏ nhËn ®­îc <color=green>Thiªn C­¬ng ch©n khÝ<color>.")
		else
			Talk(1,"no","B¸ch Linh ph­ín ®· bÞ mÊt, h·y ®Õn <color=green>nhµ kh¶o cæ<color> xem thö. ")
		end
	elseif(task_state == 2)then
		if HaveEventItem(43) >= 1 then
			DelEventItem(43)
			AddEventItem(42)
			Msg2Player("Ch­a giÕt ®­îc Thiªn C­¬ng Tinh ®µo tÈu, B¸ch linh ph­ín tiÕp tôc phong Ên.")
			SetTask(53,SetByte(task_val,1,1))
			Talk(1,"no",10453)
		else
			Talk(1,"no","B¸ch Linh ph­ín ®· bÞ mÊt, h·y ®Õn <color=green>nhµ kh¶o cæ<color> xem thö.")
		end
	elseif(task_state == 3) then
		if HaveEventItem(44 )>= 1 then
			if(task_step == 35) then
				DelEventItem(44)
				AddOwnExp(500000)----½±Àø40000µã¾­Ñé
				Msg2Player("B¹n nhËn ®­îc ®iÓm danh väng")
				TaskNote(23,-1)
				AddCredit(108)----½±Àø108µãÉùÍû
				local playertype = GetPlayerType()
				if (playertype == 0) then
					if(random(1,200)<100) then
						AddNormalItem(0,0,31,6,0,0,0)
					else
						AddNormalItem(0,0,32,6,0,0,0)
					end
				elseif (playertype == 1) then
					AddNormalItem(0,0,33,6,0,0,0)
				elseif (playertype == 2) then
					AddNormalItem(0,0,34,6,0,0,0)
				end
			
				SetTask(53,SetByte(SetByte(task_val,1,0),2,task_step+1))
				Talk(1,"no","36 viªn Thiªn C­¬ng Tinh ®Òu quy tô vÒ! Lµm tèt l¾m! Xin nhËn phÇn th­ëng!")
			else
				DelEventItem(44)
				AddCredit(1)
				Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc phÇn th­ëng!")
				TaskNote(23,-1)
				SetTask(53,SetByte(SetByte(task_val,1,0),2,task_step+1))
				Talk(1,"no",10452)
			end
		else
			Talk(1,"no","Thiªn C­¬ng Ch©n KhÝ ®· bÞ mÊt, h·y ®Õn <color=green>nhµ kh¶o cæ<color> xem thö. ")
		end
	end	
end;

function  yes_1()
	local task_val = GetTask(53)
	local task_step = GetByte(task_val, 2)
	local task_state = GetByte(task_val, 1)
	if (task_state == 0) then
		AddEventItem(42)
		Msg2Player("NhËn ®­îc B¸ch Linh ph­ín, ®i th¶ Thiªn C­¬ng Tinh")
		TaskNote(23, floor(task_step/6)+1)
		SetTask(53,SetByte(task_val,1,1))
		Talk(1,"no","T¹i <color=green>"..map_names[floor(task_step/6)+1].." <color> cã thÓ t×m thÊy <color=green>Phong Ên th¸p<color>, dïng <color=green>B¸ch Linh Ph­ín<color> th¶ <color=green>Thiªn C­¬ng Ma Tinh<color> ra. Sau khi thu phôc nã sÏ nhËn ®­îc <color=green>Thiªn C­¬ng ch©n khÝ<color>.")
	end
end;

function   renwu2()
		Talk(3,"next",10455,10456,10457)
end;

function next()
		Talk(2,"no",10459,10460)
		AddNormalItem(6,1,11,1,0,0)
		AddNormalItem(6,1,11,1,0,0)
		AddNormalItem(6,1,11,1,0,0)
		Msg2Player("H·y BiÕn thµnh Phi Thö vµ Ngäc N÷ ®Õn gÆp NhËm §¹i Ca, sau ®ã biÕn thµnh biÓu t­îng t×nh yªu ®Õn gÆp NhËm §¹i TÈu")
		TaskNote(26,1)
		SetTask(92,2)
end;


function no()
		CloseDialog()
end;

function  renwu4()
	local task_step = GetByte(GetTask(53), 2)
	if task_step > 35 then
		Talk(1,"no",10119)
	else	
		Talk(1,"one",10120)
	end;
end;

function  one()
		local  p={}
		local  n=0
		for n = 250,261 do
				if(GetTask(n)==0)then
						p[n-249]="green"
				elseif(GetTask(n)==1)then
						p[n-249]="red"
				end;
		end;
		Talk(1,"two","<color="..p[1]..">Thiªn Kh«i Tinh<color>-----<color="..p[2]..">Thiªn C­¬ng Tinh<color>-----<color="..p[3]..">Thiªn C¬ Tinh<color>-----<color="..p[4]..">Thiªn Nhµn Tinh<color>-----<color="..p[5]..">Thiªn Dòng Tinh<color>-----<color="..p[6]..">Thiªn Hïng Tinh<color>-----<color="..p[7]..">Thiªn M·nh Tinh<color>-----<color="..p[8]..">Thiªn Uy Tinh<color>-----<color="..p[9]..">Thiªn Anh Tinh<color>-----<color="..p[10]..">Thiªn Quý Tinh<color>-----<color="..p[11]..">Thiªn Phóc Tinh<color>-----<color="..p[12]..">Thiªn M·n Tinh<color>")
end;

function  two()
		local  p={}
		local  n=0
		for n = 262,273 do
				if(GetTask(n)==0)then
						p[n-249]="green"
				elseif(GetTask(n)==1)then
						p[n-249]="red"
				end;
		end;
		Talk(1,"three","<color="..p[13]..">Thiªn C« Tinh<color>-----<color="..p[14]..">Thiªn S¬n Tinh<color>-----<color="..p[15]..">Thiªn VÞ Tinh<color>-----<color="..p[16]..">Thiªn TiÖp Tinh<color>-----<color="..p[17]..">Thiªn ¸m Tinh<color>-----<color="..p[18]..">Thiªn H÷u Tinh<color>-----<color="..p[19]..">Thiªn Kh«ng Tinh<color>-----<color="..p[20]..">Thiªn Tèc Tinh<color>-----<color="..p[21]..">Thiªn DÞ Tinh<color>-----<color="..p[22]..">Thiªn S¸t Tinh<color>-----<color="..p[23]..">Thiªn Vi Tinh<color>-----<color="..p[24]..">Thiªn Cøu Tinh<color>")
end;

function  three()
		local  p={}
		local  n=0
		for n = 274,285 do
				if(GetTask(n)==0)then
						p[n-249]="green"
				elseif(GetTask(n)==1)then
						p[n-249]="red"
				end;
		end;
		Talk(1,"no","<color="..p[25]..">Thiªn Thèi Tinh<color>-----<color="..p[26]..">Thiªn Thä Tinh<color>-----<color="..p[27]..">Thiªn KiÕm Tinh<color>-----<color="..p[28]..">Thiªn B×nh Tinh<color>-----<color="..p[29]..">Thiªn Téi Tinh<color>-----<color="..p[30]..">Thiªn Tæn Tinh<color>-----<color="..p[31]..">Thiªn B¹i Tinh<color>-----<color="..p[32]..">Thiªn Lao Tinh<color>-----<color="..p[33]..">Thiªn TuÖ Tinh<color>-----<color="..p[34]..">Thiªn B¹o Tinh<color>-----<color="..p[35]..">Thiªn Chó Tinh<color>-----<color="..p[36]..">Thiªn X¶o Tinh<color>")
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1020_01; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Duong Tien - Tay Ky (165/185)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Thien Cuong Tinh Quy Vi va Phu The tai Tay Ky. Ten trong Lua goc la Duong Tien, khong phai duong dan Nhi Lang Than o Dieu Tri.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Loi Chan Tu (163/187); Vo Vuong (159/189); Khuong Tu Nha (158/189); Thay Tuong So (174/188); Nham Dai Ca (170/195)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Co nhanh Lua VNG goc trong PAK. Cac dieu kien va giao dich do nhanh goc kiem tra; chua nghiem thu toan bo nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
function pt_original()
    if pt_guard() == 0 then return end
    pt_original_main()
end
