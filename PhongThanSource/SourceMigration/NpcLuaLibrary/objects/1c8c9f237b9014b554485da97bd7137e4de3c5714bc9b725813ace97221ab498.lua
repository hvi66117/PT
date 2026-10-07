--description: Î÷ÓòÉñÃØ?
--author: yichuan
--date: 2004/7/13

function  main()
	tasks = 
	{
		{"Phi Tiªn","renwu1";show=0},
		{"B¸ L¹c Nh·n","yan";show=0},
		{"Trïng Méc","renwu2";show=0},--ÁÙÊ±¹Ø±Õ
		{"Bá ®i","renwu3";show=0},--±¾À´¾Í¹Ø±Õ
		{"T©n Thñ tÇm b¶o","renwu4";show=0}	
	}
		UTask_xq_1=GetTask(51);
		if(UTask_xq_1==4)and(HaveEventItem(37)>=1)then
				tasks[1].show=1;
		end;
		if(UTask_xq_1==0)and(GetLevel()>=39)then
				tasks[1].show=1;
		end;
		if(UTask_xq_1==5)then
				tasks[2].show=1;
		end;
		if(GetLevel()>=19)then
				tasks[3].show=1;
		end;
		if(GetTask(344)==2)then
				tasks[5].show=1;
		end;
		SayTask(10492,tasks)
end;
function   renwu3()
		if(HaveItem2(0,10,0,1)>=1)or(HaveItem2(0,10,1,1)>=1)or(HaveItem2(0,10,2,1)>=1)then
		MsgBox(11216,"hecheng3","no")
		elseif(HaveItem2(0,10,0,2)>=1)or(HaveItem2(0,10,1,2)>=1)or(HaveItem2(0,10,2,2)>=1)then
		MsgBox(11217,"hecheng3","no")
		elseif(HaveItem2(0,10,0,3)>=1)or(HaveItem2(0,10,1,3)>=1)or(HaveItem2(0,10,2,3)>=1)then
		MsgBox(11218,"hecheng3","no")
		elseif(HaveItem2(0,10,0,4)>=1)or(HaveItem2(0,10,1,4)>=1)or(HaveItem2(0,10,2,4)>=1)then
		MsgBox(11219,"hecheng3","no")
		elseif(HaveItem2(0,10,0,5)>=1)or(HaveItem2(0,10,1,5)>=1)or(HaveItem2(0,10,2,5)>=1)then
		MsgBox(11220,"hecheng3","no")
		elseif(HaveItem2(0,10,0,6)>=1)or(HaveItem2(0,10,1,6)>=1)or(HaveItem2(0,10,2,1)>=6)then
		MsgBox(11221,"hecheng3","no")
		elseif(HaveItem2(0,10,0,7)>=1)or(HaveItem2(0,10,1,7)>=1)or(HaveItem2(0,10,2,7)>=1)then
		MsgBox(11222,"hecheng3","no")
		elseif(HaveItem2(0,10,0,8)>=1)or(HaveItem2(0,10,1,8)>=1)or(HaveItem2(0,10,2,8)>=1)then
		MsgBox(11223,"hecheng3","no")
		elseif(HaveItem2(0,10,0,9)>=1)or(HaveItem2(0,10,1,9)>=1)or(HaveItem2(0,10,2,9)>=1)then
		MsgBox(11224,"hecheng3","no")
		elseif(HaveItem2(0,10,0,10)>=1)or(HaveItem2(0,10,1,10)>=1)or(HaveItem2(0,10,2,10)>=1)then
		MsgBox(11225,"hecheng3","no")
		elseif(HaveItem2(0,10,3,10)>=1)or(HaveItem2(0,10,4,10)>=1)or(HaveItem2(0,10,5,10)>=1)then
		MsgBox(11226,"hecheng3","no")
		elseif(HaveItem2(0,10,6,10)>=1)or(HaveItem2(0,10,7,10)>=1)or(HaveItem2(0,10,8,10)>=1)then
		MsgBox(11227,"hecheng3","no")
		elseif(HaveItem2(0,10,9,10)>=1)or(HaveItem2(0,10,10,10)>=1)or(HaveItem2(0,10,11,10)>=1)then
		MsgBox(11228,"hecheng3","no")
		else
		MsgBox(11229,"no")
		end;
end;
function   renwu2()
		MsgBox(11230,"hecheng2","no")
end;
function   renwu1()
		UTask_xq_1=GetTask(51);
		if(UTask_xq_1==4)and(HaveEventItem(37)>=1)then
				Talk(1,"no",10493)
				DelEventItem(37)
				Msg2Player("T×m ®­îc m¶nh L­u Tinh, Ng­êi T©y Vùc sÏ gióp b¹n hîp thµnh B¸ L¹c Nh·n.")
				TaskNote(22,4)
				SetTask(51,5)
		end;

		if(UTask_xq_1==0)and(GetLevel()>=19)then
				MsgBox(10494,"yes_1","no")
		end;
end;


function  yes_1()
		Talk(1,"no",10495)
		Msg2Player("§Õn gÆp thÇy t­íng sè xem vËt g× lµ quý nhÊt.")
		TaskNote(22,0)
		SetTask(51,1)
end;

function  no()
		CloseDialog()
end;

function  yan()
		MsgBox(10496,"hecheng")
end;

function  hecheng()
		if ((HaveNormalItem(0,10,0,1)>=1)and (HaveNormalItem(3,29,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,1)		
						DelNormalItem(3,29,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,1,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,2)>=1)and (HaveNormalItem(3,30,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,2)		
						DelNormalItem(3,30,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,2,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,3)>=1)and (HaveNormalItem(3,31,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,3)		
						DelNormalItem(3,31,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,3,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,4)>=1)and (HaveNormalItem(3,32,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,4)		
						DelNormalItem(3,32,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,4,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,5)>=1)and (HaveNormalItem(3,33,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,5)		
						DelNormalItem(3,33,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,5,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,6)>=1)and (HaveNormalItem(3,42,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,6)		
						DelNormalItem(3,42,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,6,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,7)>=1)and (HaveNormalItem(3,43,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,7)		
						DelNormalItem(3,43,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,7,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,8)>=1)and (HaveNormalItem(3,44,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,8)		
						DelNormalItem(3,44,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,8,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,9)>=1)and (HaveNormalItem(3,45,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,9)		
						DelNormalItem(3,45,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,9,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,0,10)>=1)and (HaveNormalItem(3,46,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,0,10)		
						DelNormalItem(3,46,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,0,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,3,10)>=1)and (HaveNormalItem(3,47,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,3,10)		
						DelNormalItem(3,47,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,3,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,4,10)>=1)and (HaveNormalItem(3,48,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,4,10)		
						DelNormalItem(3,48,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,4,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,5,10)>=1)and (HaveNormalItem(3,49,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,5,10)		
						DelNormalItem(3,49,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,5,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,1)>=1)and (HaveNormalItem(3,29,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,1)		
						DelNormalItem(3,29,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,1,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,2)>=1)and (HaveNormalItem(3,30,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,2)		
						DelNormalItem(3,30,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,2,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,3)>=1)and (HaveNormalItem(3,31,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,3)		
						DelNormalItem(3,31,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,3,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,4)>=1)and (HaveNormalItem(3,32,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,4)		
						DelNormalItem(3,32,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,4,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,5)>=1)and (HaveNormalItem(3,33,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,5)		
						DelNormalItem(3,33,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,5,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,6)>=1)and (HaveNormalItem(3,42,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,6)		
						DelNormalItem(3,42,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,6,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,7)>=1)and (HaveNormalItem(3,43,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,7)		
						DelNormalItem(3,43,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,7,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,8)>=1)and (HaveNormalItem(3,44,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,8)		
						DelNormalItem(3,44,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,8,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,9)>=1)and (HaveNormalItem(3,45,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,9)		
						DelNormalItem(3,45,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,9,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,1,10)>=1)and (HaveNormalItem(3,46,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,1,10)		
						DelNormalItem(3,46,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,1,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,6,10)>=1)and (HaveNormalItem(3,47,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,6,10)		
						DelNormalItem(3,47,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,6,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,7,10)>=1)and (HaveNormalItem(3,48,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,7,10)		
						DelNormalItem(3,48,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,7,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,8,10)>=1)and (HaveNormalItem(3,49,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,8,10)		
						DelNormalItem(3,49,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,8,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,1)>=1)and (HaveNormalItem(3,29,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,1)		
						DelNormalItem(3,29,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,1,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,2)>=1)and (HaveNormalItem(3,30,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,2)		
						DelNormalItem(3,30,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,2,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,3)>=1)and (HaveNormalItem(3,31,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,3)		
						DelNormalItem(3,31,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,3,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,4)>=1)and (HaveNormalItem(3,32,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,4)		
						DelNormalItem(3,32,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,4,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,5)>=1)and (HaveNormalItem(3,33,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,5)		
						DelNormalItem(3,33,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,5,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,6)>=1)and (HaveNormalItem(3,42,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,6)		
						DelNormalItem(3,42,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,6,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,7)>=1)and (HaveNormalItem(3,43,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,7)		
						DelNormalItem(3,43,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,7,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,8)>=1)and (HaveNormalItem(3,44,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,8)		
						DelNormalItem(3,44,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,8,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,9)>=1)and (HaveNormalItem(3,45,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,9)		
						DelNormalItem(3,45,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,9,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,2,10)>=1)and (HaveNormalItem(3,46,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,2,10)		
						DelNormalItem(3,46,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,2,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,9,10)>=1)and (HaveNormalItem(3,47,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,9,10)		
						DelNormalItem(3,47,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,9,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,10,10)>=1)and (HaveNormalItem(3,48,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,10,10)		
						DelNormalItem(3,48,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,10,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		elseif  ((HaveNormalItem(0,10,11,10)>=1)and (HaveNormalItem(3,49,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",10497)
						DelNormalItem(0,10,11,10)		
						DelNormalItem(3,49,0,0)
						DecCredit(10)
						AddNormalItem2(0,10,11,10,0)		
						SetTask(51,3)
						Msg2Player("B¹n cã thÓ tiÕp tôc giÕt Tr­ Tinh,  ®em m¶nh L­u Tinh vÒ cho Ng­êi T©y Vùc.")
						TaskNote(22,5)
		else
						Talk(1,"no",10498)					
		end;
end;
function  hecheng2()
		 if((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,1)>=1)and(HaveNormalItem(3,29,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,1)	
						DelNormalItem(3,29,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,1,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
				
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,2)>=1)and(HaveNormalItem(3,30,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,2)		
						DelNormalItem(3,30,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,2,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,3)>=1)and(HaveNormalItem(3,31,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,3)		
						DelNormalItem(3,31,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,3,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,4)>=1)and(HaveNormalItem(3,32,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,4)		
						DelNormalItem(3,32,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,4,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif ((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,5)>=1)and (HaveNormalItem(3,33,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,5)		
						DelNormalItem(3,33,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,5,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif  ((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,6)>=1)and (HaveNormalItem(3,42,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,6)		
						DelNormalItem(3,42,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,6,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif  ((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,7)>=1)and (HaveNormalItem(3,43,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,7)		
						DelNormalItem(3,43,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,7,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
				
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,8)>=1)and (HaveNormalItem(3,44,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,8)		
						DelNormalItem(3,44,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,8,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,9)>=1)and (HaveNormalItem(3,45,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,9)		
						DelNormalItem(3,45,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,9,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,0,10)>=1)and (HaveNormalItem(3,46,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,0,10)		
						DelNormalItem(3,46,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,0,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,3,10)>=1)and (HaveNormalItem(3,47,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,3,10)		
						DelNormalItem(3,47,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,3,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,4,10)>=1)and (HaveNormalItem(3,48,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,4,10)		
						DelNormalItem(3,48,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,4,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,5,10)>=1)and (HaveNormalItem(3,49,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,5,10)		
						DelNormalItem(3,49,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,5,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,1)>=1)and (HaveNormalItem(3,29,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,1)		
						DelNormalItem(3,29,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,1,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,2)>=1)and (HaveNormalItem(3,30,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,2)		
						DelNormalItem(3,30,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,2,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,3)>=1)and (HaveNormalItem(3,31,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,3)		
						DelNormalItem(3,31,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,3,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,4)>=1)and (HaveNormalItem(3,32,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,4)		
						DelNormalItem(3,32,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,4,0)			
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,5)>=1)and (HaveNormalItem(3,33,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,5)		
						DelNormalItem(3,33,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,5,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,6)>=1)and (HaveNormalItem(3,42,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,6)		
						DelNormalItem(3,42,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,6,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,7)>=1)and (HaveNormalItem(3,43,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,7)		
						DelNormalItem(3,43,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,7,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,8)>=1)and (HaveNormalItem(3,44,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,8)		
						DelNormalItem(3,44,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,8,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
				
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,9)>=1)and (HaveNormalItem(3,45,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,9)		
						DelNormalItem(3,45,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,9,0)			
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,1,10)>=1)and (HaveNormalItem(3,46,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,1,10)		
						DelNormalItem(3,46,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,1,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,6,10)>=1)and (HaveNormalItem(3,47,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,6,10)		
						DelNormalItem(3,47,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,6,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,7,10)>=1)and (HaveNormalItem(3,48,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,7,10)		
						DelNormalItem(3,48,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,7,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,8,10)>=1)and (HaveNormalItem(3,49,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,8,10)		
						DelNormalItem(3,49,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,8,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,1)>=1)and (HaveNormalItem(3,29,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,1)		
						DelNormalItem(3,29,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,1,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,2)>=1)and (HaveNormalItem(3,30,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,2)		
						DelNormalItem(3,30,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,2,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,3)>=1)and (HaveNormalItem(3,31,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,3)		
						DelNormalItem(3,31,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,3,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,4)>=1)and (HaveNormalItem(3,32,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,4)		
						DelNormalItem(3,32,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,4,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,5)>=1)and (HaveNormalItem(3,33,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,5)		
						DelNormalItem(3,33,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,5,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,6)>=1)and (HaveNormalItem(3,42,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,6)		
						DelNormalItem(3,42,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,6,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,7)>=1)and (HaveNormalItem(3,43,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,7)		
						DelNormalItem(3,43,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,7,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,8)>=1)and (HaveNormalItem(3,44,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,8)		
						DelNormalItem(3,44,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,8,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,9)>=1)and (HaveNormalItem(3,45,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,9)		
						DelNormalItem(3,45,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,9,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,2,10)>=1)and (HaveNormalItem(3,46,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,2,10)		
						DelNormalItem(3,46,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,2,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,9,10)>=1)and (HaveNormalItem(3,47,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,9,10)		
						DelNormalItem(3,47,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,9,10,0)			
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,10,10)>=1)and (HaveNormalItem(3,48,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,10,10)		
						DelNormalItem(3,48,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,10,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		elseif((GetItemCount(39)>=3)and(HaveNormalItem(0,10,11,10)>=1)and (HaveNormalItem(3,49,0,0)>=1)and(GetCredit()>=10))then
						Talk(1,"no",11231)
						DelNormalItem(0,10,11,10)		
						DelNormalItem(3,49,0,0)
						DelEventItem(39)
						DelEventItem(39)
						DelEventItem(39)
						DecCredit(10)
						AddNormalItem2(0,10,11,10,0)		
						Msg2Player("B¹n cã thÓ tiÕp tôc mang LiÔu méc vÒ cho Ng­êi T©y Vùc ")
					
		else
						Talk(1,"no",11232)					
		end;
end;
function       hecheng3()
			if(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,1)>=1)and(GetCash()>=300)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,1)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(300)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,29,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,1)>=1)and(GetCash()>=300)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,1)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(300)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,29,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,1)>=1)and(GetCash()>=300)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,1)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(300)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,29,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,2)>=1)and(GetCash()>=600)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,2)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(600)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,29,0,0,0,0)
				else
					AddNormalItem(3,30,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,2)>=1)and(GetCash()>=600)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,2)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(600)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,29,0,0,0,0)
				else
					AddNormalItem(3,30,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,2)>=1)and(GetCash()>=600)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,2)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(600)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,29,0,0,0,0)
				else
					AddNormalItem(3,30,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,3)>=1)and(GetCash()>=1000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,3)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(1000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,30,0,0,0,0)
				else
					AddNormalItem(3,31,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,3)>=1)and(GetCash()>=1000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,3)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(1000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,30,0,0,0,0)
				else
					AddNormalItem(3,31,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,3)>=1)and(GetCash()>=1000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,3)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(1000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,30,0,0,0,0)
				else
					AddNormalItem(3,31,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,4)>=1)and(GetCash()>=3000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,4)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(3000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,31,0,0,0,0)
				else
					AddNormalItem(3,32,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,4)>=1)and(GetCash()>=3000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,4)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(3000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,31,0,0,0,0)
				else
					AddNormalItem(3,32,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,4)>=1)and(GetCash()>=3000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,4)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(3000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,31,0,0,0,0)
				else
					AddNormalItem(3,32,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,5)>=1)and(GetCash()>=6000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,5)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(6000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,32,0,0,0,0)
				else
					AddNormalItem(3,33,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,5)>=1)and(GetCash()>=6000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,5)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(6000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,32,0,0,0,0)
				else
					AddNormalItem(3,33,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,5)>=1)and(GetCash()>=6000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,5)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(6000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,32,0,0,0,0)
				else
					AddNormalItem(3,33,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,6)>=1)and(GetCash()>=10000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,6)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(10000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,33,0,0,0,0)
				else
					AddNormalItem(3,42,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,6)>=1)and(GetCash()>=10000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,6)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(10000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,33,0,0,0,0)
				else
					AddNormalItem(3,42,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,6)>=1)and(GetCash()>=10000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,6)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(10000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,33,0,0,0,0)
				else
					AddNormalItem(3,42,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,7)>=1)and(GetCash()>=30000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,7)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(30000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,42,0,0,0,0)
				else
					AddNormalItem(3,43,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,7)>=1)and(GetCash()>=30000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,7)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(30000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,42,0,0,0,0)
				else
					AddNormalItem(3,43,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,7)>=1)and(GetCash()>=30000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,7)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(30000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,42,0,0,0,0)
				else
					AddNormalItem(3,43,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,8)>=1)and(GetCash()>=60000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,8)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(60000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,43,0,0,0,0)
				else
					AddNormalItem(3,44,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,8)>=1)and(GetCash()>=60000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,8)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(60000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,43,0,0,0,0)
				else
					AddNormalItem(3,44,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,8)>=1)and(GetCash()>=60000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,8)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(60000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,43,0,0,0,0)
				else
					AddNormalItem(3,44,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,9)>=1)and(GetCash()>=100000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,9)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(100000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,44,0,0,0,0)
				else
					AddNormalItem(3,45,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,9)>=1)and(GetCash()>=100000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,9)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(100000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,44,0,0,0,0)
				else
					AddNormalItem(3,45,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,9)>=1)and(GetCash()>=100000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,9)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(100000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,44,0,0,0,0)
				else
					AddNormalItem(3,45,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,0,10)>=1)and(GetCash()>=300000)then
				Talk(1,"no",11233)
				DelItem2(0,10,0,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(300000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,45,0,0,0,0)
				else
					AddNormalItem(3,46,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,1,10)>=1)and(GetCash()>=300000)then
				Talk(1,"no",11233)
				DelItem2(0,10,1,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(300000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,45,0,0,0,0)
				else
					AddNormalItem(3,46,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,2,10)>=1)and(GetCash()>=300000)then
				Talk(1,"no",11233)
				DelItem2(0,10,2,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(300000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,45,0,0,0,0)
				else
					AddNormalItem(3,46,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,3,10)>=1)and(GetCash()>=600000)then
				Talk(1,"no",11233)
				DelItem2(0,10,3,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(600000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,46,0,0,0,0)
				else
					AddNormalItem(3,47,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,4,10)>=1)and(GetCash()>=600000)then
				Talk(1,"no",11233)
				DelItem2(0,10,4,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(600000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,46,0,0,0,0)
				else
					AddNormalItem(3,47,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,5,10)>=1)and(GetCash()>=600000)then
				Talk(1,"no",11233)
				DelItem2(0,10,5,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(600000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,46,0,0,0,0)
				else
					AddNormalItem(3,47,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,6,10)>=1)and(GetCash()>=1000000)then
				Talk(1,"no",11233)
				DelItem2(0,10,6,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(1000000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,47,0,0,0,0)
				else
					AddNormalItem(3,48,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,7,10)>=1)and(GetCash()>=1000000)then
				Talk(1,"no",11233)
				DelItem2(0,10,7,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(1000000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,47,0,0,0,0)
				else
					AddNormalItem(3,48,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,8,10)>=1)and(GetCash()>=1000000)then
				Talk(1,"no",11233)
				DelItem2(0,10,8,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(1000000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,47,0,0,0,0)
				else
					AddNormalItem(3,48,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,9,10)>=1)and(GetCash()>=3000000)then
				Talk(1,"no",11233)
				DelItem2(0,10,9,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(3000000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,48,0,0,0,0)
				else
					AddNormalItem(3,49,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,10,10)>=1)and(GetCash()>=3000000)then
				Talk(1,"no",11233)
				DelItem2(0,10,10,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(3000000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,48,0,0,0,0)
				else
					AddNormalItem(3,49,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			elseif(HaveNormalItem(3,77,0,0)>=3)and(HaveNormalItem(3,78,0,0)>=3)and(HaveItem2(0,10,11,10)>=1)and(GetCash()>=3000000)then
				Talk(1,"no",11233)
				DelItem2(0,10,11,10)
				for a=1,3 do
					DelNormalItem(3,77,0,0)
					DelNormalItem(3,78,0,0)
				end;
				Pay(3000000)
				local  i=random(1,4)
				if(i==1)then
					AddNormalItem(3,48,0,0,0,0)
				else
					AddNormalItem(3,49,0,0,0,0)
				Msg2Player("T×m nhiÒu thó c­ìi mµu xanh cho Ng­êi T©y Vùc.")
				end;
			else
			Talk(1,"no",11234)
			end;
end;

function  renwu4()
	Talk(1,"xunbao","Ta cã thÓ gióp ng­¬i khai th«ng linh tÝnh cña thó c­ìi, lÇn ®Çu miÔn phÝ! Nh÷ng lÇn sau th× cÇn ph¶i hoµn thµnh nhiÖm vô cña ta tr­íc råi ta míi gióp l¹i!")
end;

function  xunbao()
	if(HaveNormalItem(0,10,0,4)>=1)and(HaveNormalItem(3,32,0,0)>=1)then
		Talk(1,"no","Thó c­ìi ®· chÞu nghe lêi ng­¬i! Chóc ng­¬i may m¾n!")
		DelNormalItem(0,10,0,4)		
		DelNormalItem(3,32,0,0)
		AddNormalItem(0,10,0,4,0,0)		
		SetTask(344,3)
		Msg2Player("B¹n nhËn ®­îc §éc gi¸c thó.")
	elseif(HaveNormalItem(0,10,1,4)>=1)and(HaveNormalItem(3,32,0,0)>=1)then
		Talk(1,"no","Thó c­ìi ®· chÞu nghe lêi ng­¬i! Chóc ng­¬i may m¾n!")
		DelNormalItem(0,10,1,4)		
		DelNormalItem(3,32,0,0)
		AddNormalItem(0,10,1,4,0,0)		
		SetTask(344,3)
		Msg2Player("B¹n nhËn ®­îc Th­¬ng ¦ng.")
	elseif(HaveNormalItem(0,10,2,4)>=1)and(HaveNormalItem(3,32,0,0)>=1)then
		Talk(1,"no","Thó c­ìi ®· chÞu nghe lêi ng­¬i! Chóc ng­¬i may m¾n!")
		DelNormalItem(0,10,2,4)		
		DelNormalItem(3,32,0,0)
		AddNormalItem(0,10,2,4,0,0)		
		SetTask(344,3)
		Msg2Player("B¹n nhËn ®­îc 1 B¹ch V©n Hå §iÖp t¨ng thuéc tÝnh.")
	else
		Talk(1,"no","T×m ®ñ thó c­ìi vµ B¸ L¹c Nh·n råi h·y ®Õn t×m ta.")
	end;
end;
