-- AUTHORED NPC 1021_12; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1021 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thuong Diem - Trieu Ca (211/198)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Diem giao dich duoc tai dung. Danh muc va gia ban rieng chua duoc xac minh; khong tu dung danh muc cua mot cua hang khac.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Chu Tiem Cam Do (209/198); Thay Tuong So (214/195); Cu Luu Ton (206/197); Con Bac (204/196); Chuyen Sinh Lao Lao (212/190)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
