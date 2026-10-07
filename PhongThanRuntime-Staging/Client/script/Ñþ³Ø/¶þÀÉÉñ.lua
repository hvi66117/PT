--description: ¶þÀÉÉñ
--author: yichuan
--date: 2005/3/10

function main(sel)
			tasks =
			{
				 {"Thiªn Thô","renwu";show=0},
				 {"C©y thÇn bÝ","zhishu";show=1}
			}
			if(GetLevel()>=35)then
					tasks[1].show=1
			end;
			SayTask(11267,tasks)
end;

function no()
		CloseDialog()
end;

function zhishu()
		Talk(1,"zhishunext","Ta cã mét Ýt <color=green>h¹t gièng thÇn bÝ<color>, nh­ng kh«ng biÕt lµm sao ®Ó trång. Nghe nãi <color=green>Tú Bµ<color> ë TriÒu Ca biÕt c¸ch. Ng­¬i cã thÓ ®Õn ®ã hái xem")
end;

function zhishunext()
		Talk(1,"no","Nghe nãi Thiªn §×nh ®ang cÇn mét sè c©y thÇn. Ng­¬i cã thÓ giao c©y non cho <color=green>B¸ch Gi¸m<color> ë Phong ThÇn ®µi, tïy theo <color=green>®é tr­ëng thµnh<color> sÏ ban th­ëng cho ng­¬i!")
end;




function  renwu()
		if(GetItemCount(39)>=3)then
					for  i=1,3 do
						DelEventItem(39)
					end;
					AddEventItem(48)
					Talk(1,"no",11268)
		else
					Talk(1,"no",11269)
		end;
end;
