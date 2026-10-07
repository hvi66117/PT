--description: Êê»êÖéÊ¹ÓÃ
--author: liuying	
--date: 2006/1/18

function main()
	local i=FindAValidIBItem(8,32,5,0)
	local j=FindAValidIBItem(8,171,5,0)
	if(i>0)then
		SetExeState(1)
		CostIBItem(i)
	elseif(j>0)then
		SetExeState(1)
		CostIBItem(j)
	else
		SetExeState(0)
		Talk(1,"no","Xin x¸c nhËn b¹n cßn Chuéc Hån ch©u hoÆc Chuéc Hån ch©u cã hiÖu lùc.")
	end;
end;