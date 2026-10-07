function main()
	MsgBox("B¹n muèn rêi khái thµnh nµy ph¶i kh«ng?","yes","no")
end

function   yes()
	CloseDialog()
	CityTrapOut(DialogNpcIdx)
end;

function   no()
	CloseDialog()
end;
