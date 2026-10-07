--description: Ñþ³Ø
--author: yichuan
--date: 2004/5/14

function main()

		if(GetTask(13)==2)or(GetTask(23)==2)or(GetTask(33)==2)then
				SetFightState(0)
				OpenBox(2);
		else
				Msg2Player("B¹n ch­a nhËn ®­îc sù cho phÐp sö dông r­¬ng chøa ®å.")
		end;
		SetRevPos(52,197)
		Msg2Player("B¹n ®· thiÕt lËp ®iÓm håi sinh t¹i Diªu Tr×.")

end;
