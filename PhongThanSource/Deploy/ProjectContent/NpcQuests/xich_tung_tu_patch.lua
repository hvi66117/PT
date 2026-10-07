-- Appendix to the exact active VNG script; keep all original help callbacks.
-- Only the two mutating services are routed through validated native APIs.
function dz()
    CloseDialog()
    if XichTungTuService(0) ~= 1 then
        MsgBox("Hay dung gan Xich Tung Tu va mo khoa hanh trang truoc khi hop thanh.", "no")
    end
end

function change()
    local result = XichTungTuService(1)
    if result == 1 then
        MsgBox(11257, "no")
    elseif result == -3 then
        MsgBox(11258, "no")
    elseif result == -1 then
        MsgBox("Hay tro lai gan Xich Tung Tu de doi Tha Son Thach.", "no")
    elseif result == -2 then
        MsgBox("Hay mo khoa hanh trang va ket thuc giao dich truoc khi doi.", "no")
    else
        MsgBox("Chua nhan duoc Tha Son Thach. Can cho trong F4. Danh vong chua bi tru.", "no")
    end
end
