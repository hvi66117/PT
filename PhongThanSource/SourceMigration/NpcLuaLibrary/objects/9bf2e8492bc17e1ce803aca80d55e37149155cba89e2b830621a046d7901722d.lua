--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10

function main(sel)
	if(GetTask(304)==15)then
			Talk(1,"no","T×nh h×nh ë ®©y ®¹i kh¸i nh­ thÕ, mau quay vÒ thao tr­êng b¸o cho vâ s­ ®i.")
			SetTask(304,100)
			TaskNote(31,0)
	elseif(GetTask(314)==15)then
			Talk(1,"no","Nghe nãi T©n thñ th«n cã trËn thÕ thÇn bİ, vµo thêi gian nhÊt ®Şnh c¸nh cöa thÇn bİ sÏ më, ®©y ®Òu lµ Thiªn Hïng ë TriÒu Ca nãi víi ta, mau vÒ b¸o tin cho Hoµng Thiªn Hãa.")
			SetTask(314,100)
	else
			MsgBox(10322,"yes","no")
	end;
end;

function yes()
		CloseDialog()
		Sale(15);
end;

function no()
		CloseDialog()
end;
