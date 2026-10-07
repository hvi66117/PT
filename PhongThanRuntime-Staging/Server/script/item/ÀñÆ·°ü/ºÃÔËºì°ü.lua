require("春节活动模板.luax")
SendMsg = HappyNewYear.SendMsg
SendMsg_Yes = HappyNewYear.SendMsg_Yes
GiveItem = HappyNewYear.GiveItem
function main(itemID)
    HappyNewYear.UseHaoYunHongBao()
end
function no()
    CloseDialog()
end
