--description: ¸£ĞÇ
--author: yichuan
--date: 2004/6/10

function main(sel)
	tasks=
	{
		{"NhËn ®iÓm kinh nghiÖm","shuangbei";show=0},
		{"NhËn Lam B¶o th¹ch","renwu1";show=0}
	}
	local g=GetTask(374)-GetTask(375)----Ê£Óà´ÎÊı


	if(GetExtPoint(6)>=1)then		 --------³å¿¨ËÍÀ¶±¦Ê¯
				tasks[2].show=1
	end;
	SayTask(11254,tasks)
end;

function shuangbei()
	local p=GetExtPoint(3)
	local q=GetExtPoint(4)
	local b=GetExtPoint(5)
		if(p>0)or(q>0)or(b>0)then
			SetTask(374,3*p+7*q+7*b/2)
			if(GetTask(374)>14)then
				SetTask(374,14)
			end;
		end;
	local g=GetTask(374)-GetTask(375)----Ê£Óà´ÎÊı
		if (g<0)then
			g=0
		end;
	local h=floor((SystemTime()+28800)/86400)	
			if(g>0)and(h~=GetTask(376))then
				local time=SystemTime()-GetTask(379)      --È¡Ë«±¶¾­ÑéÊ±¼äÊ£ÓàÖµ
				if(time<7200) then
					MsgBox("Ng­¬i ®ang trong tr¹ng th¸i <color=red>kinh nghiÖm nh©n ®«i<color>, kh«ng thÓ nhËn tiÕp.","no")
				else
					MsgBox("Ng­¬i cßn <color=green>"..g.."<color> lÇn nh©n ®«i kinh nghiÖm. Mçi ngµy chØ cã 1 c¬ héi <color>. Nh­ng kh«ng thÓ sö dông cïng lóc víi tr¹ng th¸i rêi m¹ng luyÖn ®¬n. ","yes","no")
				end;

			elseif((h==GetTask(376)))then
				Talk(1,"no","H«m nay ng­¬i ®· sö dông mét c¬ héi kinh nghiÖm nh©n ®«i, chØ cßn <color=green>"..g.."<color> lÇn, mai h·y quay l¹i!")
			else
				Talk(1,"no","Ng­¬i ®· dïng hÕt c¬ héi nh©n ®«i kinh nghiÖm. §Ó biÕt thªm c¸c ho¹t ®éng xin xem trªn <color=green>trang chñ<color>.")
			end;
end;

function yes()
		local m=GetTask(375)
			SetTask(375,m+1)
		local h=floor((SystemTime()+28800)/86400)
			SetTask(376,h)
			Enhance(181,7200,100,100)
			SetTask(379,SystemTime())
			StopUsePills()
			Talk(1,"no","Chóc mõng ng­¬i nhËn ®­îc c¬ héi <color=green>nh©n ®«i kinh nghiÖm trong 2 giê<color>, mau ®i tu luyÖn ®i!")
			Msg2Player("B¹n nhËn ®­îc nh©n ®«i kinh nghiÖm trong 2 giê.")
end;

function   renwu1()
		if(GetTask(399)==0)then
			if(GetLevel()>=30)and(GetLevel()<51)then
				AddNormalItem(3,62,0,1,0,0,0)
				Msg2Player("NhËn ®­îc Thæ Linh phï.")						
			elseif(GetLevel()>=51)and(GetLevel()<71)then
				AddNormalItem(3,63,0,1,0,0,0)
				Msg2Player("NhËn ®­îc Thñy Linh phï.")
			elseif(GetLevel()>=71)and(GetLevel()<91)then
				AddNormalItem(3,64,0,1,0,0,0)
				Msg2Player("NhËn ®­îc Háa Linh phï.")
			elseif(GetLevel()>=91)then
				AddNormalItem(3,65,0,1,0,0,0)
				Msg2Player("NhËn ®­îc Phong Linh Phï.")
			end;
			SetTask(399,1)
		end;
		local  num1=floor(GetExtPoint(6)/2)	
		if(num1>=1)then
				MsgBox("Ng­¬i cßn <color=green>"..num1.."<color> Lam B¶o Th¹ch cßn ë chç ta, nh­ng v× ®Ó l©u qu¸ nªn ta thu 100 l­îng phİ tån kho. Cã lÊy ra kh«ng?","yes1","no")
		else
				Talk(1,"no","Quı kh¸ch kh«ng cßn Lam B¶o Th¹ch nµo ë ®©y c¶!")
		end;
end;

function   yes1()
		if(GetExtPoint(6)>=2)then
			if(GetCash()>=100)then
					PayExtPoint(6,2)
					Pay(100)
					AddNormalItem(3,41,0,1,0,0)
					Msg2Player("B¹n lÊy ra 1 Lam B¶o Th¹ch.")
					Talk(1,"no","Xin nhËn Lam B¶o Th¹ch!")
			else
					Talk(1,"no","Quı kh¸ch kh«ng ®ñ tiÒn! LÇn sau quay l¹i nhĞ!")
			end;
		else
					Talk(1,"no","Quı kh¸ch kh«ng cßn Lam B¶o Th¹ch nµo ë ®©y c¶!")
		end;
end;

function no()
		CloseDialog()
end;


