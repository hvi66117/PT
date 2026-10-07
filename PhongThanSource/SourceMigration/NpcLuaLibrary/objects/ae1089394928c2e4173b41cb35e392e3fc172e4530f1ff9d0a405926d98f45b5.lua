--description: ×¼ÌáµÀÈË
--author: xiakun
--date: 2005/7/5

function main()
	local t=GetPK()
	local str="Ng­¬i cã thÓ lËp tøc rêi Khai Minh ®¶o, cã muèn t×m hiÓu Khai Minh ®¶o kh«ng?"
	if(t>0)then
		str="Ng­¬i hiÖn cÇn "
		local h=floor(t/60)
		local m=t-h*60
		if (h>0)then
			str=str..h.."giê"
		end
		if(m==0)then
			str=str.." ."
		else
			str=str..m.."m"
		end
		str=str.."trõ s¸t khİ, cã muèn t×m hiÓu Khai Minh ®¶o kh«ng?"
	end
	MsgBox(str,"yes","no")
end;

function yes()
	Talk(1,"no","Khai Minh ®¶o: \n\t\t 1, \t bŞ ®iÓm PK tö vong sÏ r¬i vËt phÈm nh­ng kh«ng r¬i trang bŞ; \n\t\t 2, \tTrªn ®¶o,  TruyÒn phï, VŞ lai phï kh«ng thÓ sö dông; \n\t\t 3, \tTö vong sÏ kh«ng bŞ mÊt ®iÓm kinh nghiÖm; \n\t\t 4, \t trªn ®¶o sÏ kh«ng t¨ng ®iÓm PK. ")
end

function no()
	CloseDialog()
end;
