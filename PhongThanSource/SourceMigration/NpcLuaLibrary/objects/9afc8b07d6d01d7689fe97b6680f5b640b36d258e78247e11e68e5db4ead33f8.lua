BoxName = "战破军免费升级包"
boxID = { 6, 1, 1290, 1 }

function main()
    if not (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) > 0) then
        return
    end
    AddGift()
end

function AddGift()
    if (IsHaveSpaceForTreasure(4) <= 0) then
        Talk(1, "no", "您背包已满, xin h穣 s緋 x誴 l筰领取.")
        return
    end
    if not (DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) > 0) then
        return
    end
    AddNormalItemBind(3, 1618, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 1441, 2, 1, 0, 0, 1)
    for i = 1, 50 do
        AddNormalItemBind(6, 1, 941, 1, 0, 0, 1)
    end
    local str = ""
    Talk(1, "no", "Ch骳 m鮪g ng礽 nh薾 頲 <战>破军靴子升级, 白色装备碎片*50, 灵气烈焰熔金外装.")
    Msg2Player("Ch骳 m鮪g ng礽 nh薾 頲 <战>破军靴子升级, 白色装备碎片*50, 灵气烈焰熔金外装.")
    WriteLog("[" .. BoxName .. " nh薾 頲 <战>破军靴子升级, 白色装备碎片*50, 灵气烈焰熔金外装]")
end

function no()
    CloseDialog()
end
