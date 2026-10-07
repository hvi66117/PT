snow_renwu = 1385
snow_point = 1386
Global_snow_EntryCount = 183
Global_snow_index = 184

function main(sel)
    if (HaveIBBuff(639) <= 0) and (HaveIBBuff(642) <= 0) then
        return 0
    end
    if (HaveNormalItem(6, 1, 476, 0) > 0) or (HaveNormalItemInQuick(6, 1, 476, 0) > 0) then
        Msg2Player("NhÊp trùc tiÕp chuét ph¶i vµo ®Êt trèng th× cã thÓ vÊt cÇu tuyÕt ra")
    else
        ScrollMessage("HÕt cÇu tuyÕt råi, mau t×m ®èng tuyÕt bæ sung cÇu tuyÕt")
    end
end

function no()
    CloseDialog()
end;
