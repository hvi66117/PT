-- Blaze game server startup script
-- Created in 2006-08-7
-- by liuying

function main()
	if(GetWeekDay()==7)then
		AddGlobalCountNews("<color=green>Cuéc thi t×m quÎ<color> mét tuÇn mét lÇn ®· b¾t ®Çu, mêi c¸c vŞ anh hïng mang tranh b¸t qu¸i ®Õn gÆp <color=red>ThÇy bãi ë T©y Kú<color> b¸o danh tham gia, phÇn th­ëng cao quİ cho 10 ng­êi xÕp h¹ng lµ <color=yellow>quÎ cµn<color>.", 20)
		local name="Kh«ng t×m thÊy "
		local t=0
		for i=1,10 do
			SaveIniInteger("guabisai",i,t)
			SaveIniString("guabisai",i+10,name)
		end
	end
end;