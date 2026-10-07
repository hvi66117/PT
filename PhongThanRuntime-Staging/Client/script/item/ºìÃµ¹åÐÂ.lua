function main()
    if (GetLevel() < 200) then
        AddOwnExp(1000)
        Msg2Player("Ch骳 m鮪g anh h飊g 获得1000 甶觤 kinh nghi謒")
        WriteLog("Nh薾 頲 1000 甶觤 kinh nghi謒")
    else
        AddOwnExtendExp(1000)
        Msg2Player("Ch骳 m鮪g anh h飊g 获得1000点修为")
        WriteLog("Nh薾 頲 1000点修为")

    end

end
