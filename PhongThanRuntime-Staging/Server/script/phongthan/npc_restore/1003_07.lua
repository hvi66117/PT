-- AUTHORED NPC 1003_07; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1003 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Khao Co Hoc - Ngoc Hu cung (208/194)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi khao co, lien quan thong tin kho bau Phong Than. Chua co bang trao doi xac minh nen khong thu vat pham.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Tan Thu Thi Luyen (207/195); Linh Bao Dai Phap Su (206/195); Tu Hang Dao Nhan (206/196); Nhien Dang Dao Nhan (206/192); Nam Cuc Tien Ong (209/191)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
