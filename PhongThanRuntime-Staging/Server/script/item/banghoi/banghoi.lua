Include("\\script\\header\\taskid.lua")
Include("\\script\\lib\\worldlibrary.lua")
Include("\\datascript\\banghoi\\danhsachbanghoi.lua")
Include("\\datascript\\banghoi\\danhsachthanhthi.lua")
---------------------set value--
DANH_SACH_BANG_HOI={}
DSTT = {}
TONG_LEVEL_EXP = {{1,80,40,5,1000},{2,80,40,5,2000},{3,80,40,5,4000},{4,80,40,5,8000},{5,80,40,5,16000}}
NGOAI_HIEU_BANG_CHU_MAC_DINH = "BangChñ"
NGOAI_HIEU_TRUONG_LAO_MAC_DINH = "Tr­ëngL·o"
NGOAI_HIEU_DUONG_CHU_MAC_DINH = "§­êngChñ"
NGOAI_HIEU_NAM_MAC_DINH = "NamNh©n"
NGOAI_HIEU_NU_MAC_DINH = "N÷Nh©n"
--------------save table--------------
function save()
BANGI = ""
BANG = "DANH_SACH_BANG_HOI = {}\n"
for i=1,getn(DANH_SACH_BANG_HOI) do
BANGI = TaoBang(DANH_SACH_BANG_HOI[i],"DANH_SACH_BANG_HOI["..i.."]")
LuuBang("datascript/banghoi/danhsachbanghoi"..i..".lua",BANGI)
BANG = BANG..'Include("datascript/banghoi/danhsachbanghoi'..i..'.lua")\n'
end
LuuBang("datascript/banghoi/danhsachbanghoi.lua",BANG)

BANG2 = TaoBang(DSTT,"DSTT")
LuuBang("datascript/banghoi/danhsachthanhthi.lua",BANG2)

BANGMAP = TaoBang(MAP_BANG_HOI,"MAP_BANG_HOI")
LuuBang("datascript/banghoi/mapbanghoi.lua",BANGMAP)
end

function savetimer()
BANGI = ""
BANG = "DANH_SACH_BANG_HOI = {}\n"
for i=1,getn(DANH_SACH_BANG_HOI) do
BANGI = TaoBang(DANH_SACH_BANG_HOI[i],"DANH_SACH_BANG_HOI["..i.."]")
LuuBang("datascript/banghoi/danhsachbanghoi"..i..".lua",BANGI)
BANG = BANG..'Include("/datascript/banghoi/danhsachbanghoi'..i..'.lua")\n'
end
LuuBang("datascript/banghoi/danhsachbanghoi.lua",BANG)
BANG2 = TaoBang(DSTT,"DSTT")
LuuBang("datascript/banghoi/danhsachthanhthi.lua",BANG2)
BANGMAP = TaoBang(MAP_BANG_HOI,"MAP_BANG_HOI")
LuuBang("datascript/banghoi/mapbanghoi.lua",BANGMAP)
end

----------------------

function SetTongMapMain(nMapId,szTongName,dwTongName,szTongBC,dwTongBC,nTongT,nTongVG)
for i=1,getn(DSTT) do
if (DSTT[i][3] == nMapId) then
DSTT[i][1] = 1
DSTT[i][4] = szTongName
DSTT[i][5] = dwTongName
DSTT[i][6] = nTongT
DSTT[i][7] = nTongVG
DSTT[i][8] = szTongBC
DSTT[i][9] = dwTongBC
save()
LoadTongMap(DSTT[i][3],DSTT[i][4],DSTT[i][5],DSTT[i][6],DSTT[i][7],DSTT[i][8],DSTT[i][9],DSTT[i][1])
return end
end
end;

function LoadTongMapMain()
for i=1,getn(DSTT) do
LoadTongMap(DSTT[i][3],DSTT[i][4],DSTT[i][5],DSTT[i][6],DSTT[i][7],DSTT[i][8],DSTT[i][9],DSTT[i][1])
end
end;


function AddMoneyMain(dwname,nameBC,money)
for i=1,getn(DANH_SACH_BANG_HOI) do
	if (DANH_SACH_BANG_HOI[i][1][2] ~= 0 and dwname == DANH_SACH_BANG_HOI[i][1][2]) then
		save()
		if (DANH_SACH_BANG_HOI[i][2][1] == nameBC) then
			if ((DANH_SACH_BANG_HOI[i][1][7] + money) <= 2000000000) then
				DANH_SACH_BANG_HOI[i][1][7] = DANH_SACH_BANG_HOI[i][1][7] + money
				save()
			end
		end
	end
end
end;
