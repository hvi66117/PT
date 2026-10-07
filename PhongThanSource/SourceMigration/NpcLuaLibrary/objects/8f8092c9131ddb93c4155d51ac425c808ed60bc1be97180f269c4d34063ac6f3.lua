--description: Ò½Éú
--author: yichuan
--date: 2005/2/28

function main(sel)
	if(GetTask(408)==10)then
		SetTask(408,100000)
		MsgBox("L¹i thªm mét tªn hå ®å, <color=green>"..GetName().."<color>. VÒ b¸o víi <color=green>Thiªn Hïng<color>: Sai ng­¬i ®Õn ®©y lµ quyÕt ®Þnh sai lÇm. Ta sÏ ë l¹i ®Ó chØ dÉn cho nh÷ng ng­êi l¹c lèi, ng­¬i ®õng lo l¾ng cho ta.","no")
	else
		MsgBox(11209,"yes","no")
	end
end;

function yes()
		CloseDialog()
		Sale(1);
end;

function no()
		CloseDialog()
end;
