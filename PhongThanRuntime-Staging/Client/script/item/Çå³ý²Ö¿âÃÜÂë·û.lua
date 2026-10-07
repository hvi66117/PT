function main(level, time, npcIndex, itemId)
    if (RemoveStorePassword() == 1) then
        DelItemByID(itemId)
        ScrollMessage("<c=y>仓库密码清除成功")
        WriteLog("清除仓库密码成功")
        Msg2Player("您已经成功清除了仓库密码")
    else
        Talk(1, "no", "Th藅 xin l鏸, <c=r>清除失败<c>, 请稍后再次尝试, 或者联系客服!")
    end
end

function no()
    CloseDialog()
end
