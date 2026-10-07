--description: ÕÔ¹«Ã÷--Í­Ç®¹ºÂòÎïÆ·
--author: yichuan
--date: 2004/6/10

function main()
	tasks=
	{
		{"Mua dŞ phÈm","renwu1";show=0}
	}
	--SayTask(11237,tasks)
	SayTask("TriÖu C«ng Minh ë nói Nga My chİnh lµ ta. Ng­¬i ch­a nghe danh ta bao giê µ?",tasks)
end;

----ÌØÊâµÄSaleÃæ°å£¬ÎïÆ·±ê¼ÛÒÔÇàÍ­Îªµ¥Î»
function   renwu1()
	CloseDialog()
	SaleEx(20)
end;

function no()
		CloseDialog()
end;
