--description: ¨ªªQ¤l
--author:yichuan
--date: 2004/6/10
--modify:liuying 2005/4/5(¥[¤J¤F¥L¤s¤§¥Ûªº¥æ´«¥ô°È)

function main(sel)
			tasks = 
			{
				{"Hîp thµnh vËt phÈm","dz";show=1},
				{"Tha S¬n th¹ch","tszs";show=1},
                                {"b¶o ®iÓn","hcbd";show=1}  
			}
			SayTask(10499,tasks)
end;

function no()
		CloseDialog()
end;

function   dz()
	CloseDialog()
	EnchaseItem();
end;

function  tszs()		--Án±æ´«¥L¤s¤§¥Û
	MsgBox(11256,"change","no")
end;

function  change()
	if(GetCredit()>=10)then
		DecCredit(10)
		AddNormalItem(3,82,0,1,0,0)
		MsgBox(11257,"no")
	else
		MsgBox(11258,"no")
	end;
end;

function   hcbd()              --¦X¦¨Ä_¨å
			tasks1 =
			{
				{"Th¨ng cÊp vò khİ","wqsj";show=1},
				{"Th¨ng cÊp trang bŞ","zbsj";show=1},
				{"Ph¸p b¶o","fbhc";show=1},
				{"B¸ L¹c","blhc";show=1},
				{"B¶o th¹ch","bshc";show=1},
				{"Lo¹i kh¸c","qthc";show=1}
                        }
                        SayTask("Ta cã bé B¶o ®iÓn hîp thµnh, chia lµm 6 quyÓn! Cã muèn xem thö kh«ng?",tasks1)
	
end;

function   wqsj()
		Talk(1,"wqsj1","<color=green>Th¨ng cÊp phæ th«ng<color>: Mçi lÇn th¨ng cÊp vò khİ yªu cÇu ®¼ng cÊp t¨ng 4 cÊp\nNgò Quang th¹ch+Lam B¶o th¹ch+Vò khİ=Vò khİ+STCB\nHçn Thiªn L¨ng+Lam B¶o th¹ch+Vò khİ=Vò khİ+Thæ s¸t\nCµn Kh«n xİch+Lam B¶o th¹ch+Vò khİ=Vò khİ+L«i s¸t\nHáa Long tiªu+Lam B¶o th¹ch+Vò khİ=Vò khİ+Háa s¸t\nB×nh L­u Ly+Lam B¶o th¹ch+Vò khİ=Vò khİ+B¨ng s¸t")
end;     
function   wqsj1()
                Talk(1,"wqsj2","<color=green>Vò khİ<color>: Mçi lÇn th¨ng cÊp vò khİ yªu cÇu ®¼ng cÊp t¨ng 4 cÊp\nNgò Quang th¹ch+3 Lam B¶o th¹ch+Vò khİ=Vò khİ+STCB\nHçn Thiªn L¨ng+3 Lam B¶o th¹ch+Vò khİ=Vò khİ+Thæ s¸t\nCµn Kh«n xİch+3 Lam B¶o th¹ch+Vò khİ=Vò khİ+L«i s¸t\nHáa Long tiªu+3 Lam B¶o th¹ch+Vò khİ=Vò khİ+Háa s¸t\nB×nh L­u Ly+3 Lam B¶o th¹ch+Vò khİ=Vò khİ+B¨ng s¸t")
end;
function   wqsj2() 
                Talk(1,"wqsj3","<color=green>Th¨ng cÊp tinh chÕ<color>: Mçi lÇn th¨ng cÊp vò khİ yªu cÇu kh«ng cÇn ®¼ng cÊp t¨ng\nNgò Quang th¹ch+Lam B¶o th¹ch+Vò khİ+TrÇm §iÖn §ång=Vò khİ+STCB\nHçn Thiªn L¨ng+Lam B¶o th¹ch+Vò khİ+TrÇm §iÖn §ång=Vò khİ+Thæ s¸t\nCµn Kh«n xİch+Lam B¶o th¹ch+Vò khİ+TrÇm §iÖn §ång=Vò khİ+L«i s¸t\nHáa Long tiªu+Lam B¶o th¹ch+Vò khİ+TrÇm §iÖn §ång=Vò khİ+Háa s¸t\nB×nh L­u Ly+Lam B¶o th¹ch+Vò khİ+TrÇm §iÖn §ång=Vò khİ+B¨ng s¸t") 
end;
function   wqsj3() 
                Talk(1,"wqsj4","<color=green>Tû lÖ th¨ng cÊp<color>: \n3 lÇn th¨ng cÊp ®Çu tiªn nhÊt ®Şnh thµnh c«ng, 3 lÇn kÕ tiÕp tû lÖ thµnh c«ng cao, sau khi thÊt b¹i vò khİ sÏ th¨ng cÊp 3 lÇn, 3 lÇn kÕ tiÕp tû lÖ thµnh c«ng cao, sau khi thÊt b¹i vò khİ sÏ mÊt ®i, th¨ng cÊp thµnh c«ng 9 lÇn kh«ng thÓ tiÕp tôc th¨ng cÊp\n Chó ı: <color=red>Th¨ng cÊp phæ th«ng <color>vµ  <color=red>th¨ng cÊp tinh chÕ<color> kh«ng thÓ phèi hîp sö dông, vò khİ lóc ®Çu ®· cã thuéc tİnh s¸t th­¬ng t­¬ng øng")                
end;
function   wqsj4() 
                Talk(1,"hcbd","<color=green>Hoµn nguyªn vò khİ<color>: \nVò khİ ®· th¨ng cÊp+Qui Ch©n th¹ch=Vò khİ ban ®Çu")                
end;
function  zbsj()
		Talk(1,"zbsj1"," <color=green>Th¨ng cÊp phæ th«ng<color>: Mçi lÇn th¨ng cÊp trang bŞ yªu cÇu ®¼ng cÊp t¨ng 4 cÊp\nH×nh Thiªn Ên+Lam B¶o th¹ch+Kh¶i gi¸p=Kh¶i gi¸p+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+Ngäc béi=Ngäc béi+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+Giµy=Giµy+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+Yªu ®¸i=Yªu ®¸i+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+§Çu kh«i=§Çu kh«i+Søc phßng thñ")
end;  
function  zbsj1()
		Talk(1,"zbsj2"," <color=green>Th¨ng cÊp tinh chÕ<color>: Mçi lÇn th¨ng cÊp trang bŞ kh«ng cÇn ®¼ng cÊp t¨ng\nH×nh Thiªn Ên+Lam B¶o th¹ch+Kh¶i gi¸p+TrÇm §iÖn §ång=Kh¶i gi¸p+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+Ngäc béi+TrÇm §iÖn §ång=Ngäc béi+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+Giµy+TrÇm §iÖn §ång=Giµy+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+Yªu ®¸i+TrÇm §iÖn §ång=Yªu ®¸i+Søc phßng thñ\nH×nh Thiªn Ên+Lam B¶o th¹ch+§Çu kh«i+TrÇm §iÖn §ång=§Çu kh«i+Søc phßng thñ")   
end;
function  zbsj2()
		Talk(1,"zbsj3","<color=green>Tû lÖ th¨ng cÊp<color>: \n3 lÇn th¨ng cÊp ®Çu nhÊt ®Şnh thµnh c«ng, 3 lÇn th¨ng cÊp kÕ tiÕp tû lÖ thµnh c«ng t­¬ng ®èi! sau 9 lÇn n©ng cÊp thµnh c«ng sÏ kh«ng thÓ tiÕp tôc.")  
end;
function  zbsj3()
		Talk(1,"hcbd","<color=green>Hoµn nguyªn trang bŞ<color>: \nTrang bŞ ®· th¨ng cÊp+Qui Ch©n th¹ch=Trang bŞ ban ®Çu")  
end;
function  fbhc()
		Talk(2,"fbhc1","<color=green>hîp thµnh Ph¸p b¶o song thuéc tİnh<color>: \nHçn Thiªn L¨ng+Tói Ng« Phong+Hång thñy tinh=Toµn T©m ®inh\nCµn Kh«n xİch+¢m D­¬ng kİnh+Hång thñy tinh=L¹c Hån chung\nHáa Long tiªu+Kim Cang ph¸ch+Hång thñy tinh=Hång hå l«\nB×nh L­u Ly+Bİch Tú Bµ+Hång thñy tinh=Ngäc H­ phï\n Chó ı: Tû lÖ thµnh c«ng cao, sau khi thÊt b¹i vËt phÈm sÏ mÊt ®i","<color=green>hîp thµnh Ph¸p b¶o song thuéc tİnh<color>: \nBµn Cæ ph­ín+Tói Ng« Phong+Hång thñy tinh=Cäc §én Long\nTh¸i D­¬ng ch©m+¢m D­¬ng kİnh+Hång thñy tinh=ChiÕu Yªu kİnh\nÊm V¹n Nha+Kim Cang ph¸ch+Hång thñy tinh=Phong Háa lu©n\nD©y Ph­îc Long+Bİch Tú Bµ+Hång thñy tinh=Kim Quang táa\n Chó ı: Tû lÖ thµnh c«ng cao, sau khi thÊt b¹i vËt phÈm sÏ mÊt ®i.")
              
end;
function  fbhc1()
		Talk(1,"hcbd"," <color=green>hîp thµnh Ph¸p b¶o song thuéc tİnh<color>: \nHçn Thiªn L¨ng+Bµn Cæ ph­ín+Hång thñy tinh=H¹nh Hoµng kú\nTh¸i D­¬ng ch©m+Cµn Kh«n xİch+Hång thñy tinh=Cµn Kh«n khuyªn\nHáa Long tiªu+Êm V¹n Nha+Hång thñy tinh=B¹ch Cèt ph­ín\nB×nh L­u Ly+D©y Ph­îc Long+Hång thñy tinh=§Şnh Phong ch©u\n Chó ı: Tû lÖ thµnh c«ng cao, sau khi thÊt b¹i vËt phÈm sÏ mÊt ®i.")
end;
function   blhc()
		Talk(1,"blhc1","<color=green>hîp thµnh B¸ L¹c nh·n<color>: \nB¸ L¹c nh·n cÊp 1+B¸ L¹c nh·n cÊp 1+Tr­êng sinh cèc=B¸ L¹c nh·n cÊp 2\nB¸ L¹c nh·n cÊp 2+B¸ L¹c nh·n cÊp 2+Tr­êng sinh cèc=B¸ L¹c nh·n cÊp 3\nB¸ L¹c nh·n cÊp 3+B¸ L¹c nh·n cÊp 3+Tr­êng sinh cèc=B¸ L¹c nh·n cÊp 4\nB¸ L¹c nh·n cÊp 4+B¸ L¹c nh·n cÊp 4+Tr­êng sinh cèc=B¸ L¹c nh·n cÊp 5\n Chó ı: NhÊt ®Şnh thµnh c«ng")
end;
function   blhc1()
		Talk(1,"blhc2","<color=green> hîp thµnh B¸ L¹c nh·n<color>: \nB¸ L¹c nh·n cÊp 5+B¸ L¹c nh·n cÊp 5+Hång thñy tinh=B¸ L¹c nh·n cÊp 6\nB¸ L¹c nh·n cÊp 6+B¸ L¹c nh·n cÊp 6+Hång thñy tinh=B¸ L¹c nh·n cÊp 7\nB¸ L¹c nh·n cÊp 7+B¸ L¹c nh·n cÊp 7+Hång thñy tinh=B¸ L¹c nh·n cÊp 8\nB¸ L¹c nh·n cÊp 8+B¸ L¹c nh·n cÊp 8+Hång thñy tinh=B¸ L¹c nh·n cÊp 9\n Chó ı: NhÊt ®Şnh thµnh c«ng")
end;
function   blhc2()
		Talk(1,"hcbd","<color=green>hîp thµnh B¸ L¹c nh·n<color>: \nB¸ L¹c nh·n cÊp 9+B¸ L¹c nh·n cÊp 9+Lam B¶o th¹ch=B¸ L¹c nh·n cÊp 10\nB¸ L¹c nh·n cÊp 10+B¸ L¹c nh·n cÊp 10+Lam B¶o th¹ch=1B¸ L¹c nh·n cÊp 1\n1B¸ L¹c nh·n cÊp 1+B¸ L¹c nh·n cÊp 11+Lam B¶o th¹ch=1B¸ L¹c nh·n cÊp 2\n1B¸ L¹c nh·n cÊp 2+B¸ L¹c nh·n cÊp 12+Lam B¶o th¹ch=1B¸ L¹c nh·n cÊp 3\n Chó ı: NhÊt ®Şnh thµnh c«ng")
end;
function   bshc()
		Talk(1,"hcbd","<color=green>hîp thµnh M¶nh b¶o th¹ch<color>: \n3 m¶nh Hång thñy tinh+Tha S¬n th¹ch=1 Hång thñy tinh\n3 Hång thñy tinh+Tha S¬n th¹ch=1 Hång b¶o th¹ch\n3 m¶nh Lam thñy tinh+Tha S¬n th¹ch=1 Lam thñy tinh\n3 Lam thñy tinh+Tha S¬n th¹ch=1 Lam B¶o th¹ch\n Chó ı: Tû lÖ thµnh c«n cao, sau khi thÊt b¹i vËt phÈm sÏ mÊt ®i")
end;

function   qthc()
		Talk(1,"hcbd","<color=green> hîp thµnh V¹n Tiªn phï<color>: \n3 Thæ linh phï=Háa linh phï\n3 Thñy linh phï=Háa linh phï\n3 Háa linh phï=Phong linh phï\n Chó ı: Tû lÖ thµnh c«ng cao, sau khi thÊt b¹i vËt phÈm sÏ mÊt ®i")
end;