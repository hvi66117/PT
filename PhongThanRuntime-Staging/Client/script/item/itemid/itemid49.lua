Bind_Coin_Count = {
    1, 5, 10, 30, 50
}

gIndex = 5

function main()
    AddBindCoin(Bind_Coin_Count[gIndex] * 100);
    TopMessage("B¹n nhËn ®­îc <c=yel>" .. Bind_Coin_Count[gIndex] .. "<c> Linh B¶o")
    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. Bind_Coin_Count[gIndex] .. " Linh B¶o")
    WriteLog("båi th­êng Linh B¶o, sè l­îng" .. Bind_Coin_Count[gIndex])
end;

function no()
    CloseDialog()
end;
