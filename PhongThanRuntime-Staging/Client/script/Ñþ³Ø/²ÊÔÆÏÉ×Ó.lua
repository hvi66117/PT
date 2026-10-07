--description:npc
--author: zhujialiang
--date:2005/4/13

function main(sel)
		local	tasks = 
			{
				{"§æi mµu Chiªu bµi","huanse";show=0}
			}
		
--		if(GetTask(429)>=1)then	-- 429 ±íÊ¾Ì¯Î»µÈ¼¶
--			tasks[1].show=1;
--			SayTask(11261,tasks)
--		else
			MsgBox(11261,"no")	-- Ã»ÓÐ¿ÉÏÔÊ¾ÏîÄ¿Ê±SayTask²»»áÏò¿Í»§¶Ë·¢ÏûÏ¢
--		end;

end;

function huanse()
	local tasks = 
	{
		{"Trë l¹i mµu ban ®Çu", "secai1";show=0},
		{"Nhuém mµu Chiªu bµi", "secai2";show=0}
	}
	if(GetTask(428)==0) then
		tasks[2].show = 1;
	else
		tasks[1].show = 1; 
	end;
	SayTask(11262,tasks)
end;

function secai1()
	if ((HaveNormalItem(3,77,0,0)>=1) and (GetCash()>=9000)) then
		DelNormalItem(3,77,0,0)
		Pay(9000)
		SetTask(428,0)
		MsgBox(11263,"no")
	else
		MsgBox(11264,"no")
	end;
end;

function secai2()
	if ((HaveNormalItem(3,78,0,0)>=1) and (GetCash()>=9000)) then
		DelNormalItem(3,78,0,0)
		Pay(9000)
		local r = random(1,100)
		local sel = 1
		if(r <= 10) then
			sel = 2
		elseif (r <= 30) then
			sel = 3
		elseif (r <= 60) then
			sel = 4
		end;
		SetTask(428, sel)
		MsgBox(11265,"no")
	else
		MsgBox(11266,"no")
	end;
end;

function  no()
	CloseDialog()
end;

