--description: Ñþ³Ø
--author: yichuan
--date: 2004/5/14

function main()
	tasks = 
	{
		{"Xãa mËt m·","renwu";show=1}
	}
	SayTask(11259,tasks)
end;

function renwu()
	MsgBox(11260,"yes","no")
end;

function yes()
	CloseDialog()
	ReplaceBoxPwd()
end;

function no()
	CloseDialog()
end;
