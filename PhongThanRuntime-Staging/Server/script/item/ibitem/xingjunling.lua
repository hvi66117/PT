function main(itemID)
	CostIBItem(itemID)
	SetTask(885, GetTask(885) + 5)
	Talk(1, "no", "<color=green>§iÓm hµnh ®éng<color> cña b¹n t¨ng lªn <color=red>5<color>, tæng céng hiÖn cã <color=red>"..(GetTask(884)+GetTask(885)).."<color> ®iÓm." )
end

function no()
	CloseDialog()
end