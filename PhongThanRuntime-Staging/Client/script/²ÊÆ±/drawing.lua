--description: ¶þÊ®°ËÐÇËÞ---¿ªÆô¶Ò½±½Å±¾
--author: chensong
--date: 2004/7/22


function main()
	Q=WinnerCount(4)
	if (Q==0) then
		w="Kh«ng cã ai ®o¸n tróng tªn cña 4 v× Tinh tó"
	else
		w="Tæng céng "..Q.."vÞ dù ®o¸n ®óng tªn cña 4 vÞ Tinh tó, tr­íc 9 giê mêi c¸c vÞ ®Õn gÆp Tinh Quan nhËn phÇn th­ëng"
	end;
	T=GetPicks()
	p={}
	p[0]="Gi¸c Méc Giao"
	p[1]="Kh¸ng Kim Long"
	p[2]="§Ó Thæ H¹c"
	p[3]="Phßng NhËt Thè "
	p[4]="T©m NguyÖt Hå"
	p[5]="VÜ Háa Hæ"
	p[6]="To¸n Thñy B¸o"
	p[7]="TÜnh Méc Ng¹n"
	p[8]="Quû Kim D­¬ng"
	p[9]="LiÔu Thæ Ch­¬ng"
	p[10]="Tinh NhËt M·"
	p[11]="Tr­¬ng NguyÖt Léc"
	p[12]="Dùc Háa Xµ"
	p[13]="ChÈn Thñy DÉn"
	p[14]="Khuª Méc Lang"
	p[15]="L©u Kim CÈu"
	p[16]="VÞ Thæ TrÜ"
	p[17]="M·o NhËt Kª"
	p[18]="Hoa NguyÖt ¤"
	p[19]="Tuy Háa HÇu"
	p[20]="S©m Thñy Viªn"
	p[21]="§Êu Méc Gi¶i"
	p[22]="Ng­u Kim Ng­u"
	p[23]="N÷ Thæ Bøc"
	p[24]="H­ NhËt Thö"
	p[25]="Nguy NguyÖt YÕn"
	p[26]="ThÊt Háa Tr­"
	p[27]="BÝch Thñy Du"
	AddGlobalCountNews("4 vÞ Tinh tó ®· hiÖn th©n ë Thiªn giíi, hä lµ "..p[T[0]]..", "..p[T[1]]..", "..p[T[2]]..", "..p[T[3]]..". H«m nay "..w..". ",8)
end;
