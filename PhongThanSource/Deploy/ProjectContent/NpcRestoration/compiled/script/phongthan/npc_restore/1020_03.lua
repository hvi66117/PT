-- AUTHORED NPC 1020_03; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1020 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Nguoi Tay Vuc - Tay Ky (185/192)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi bien doi va hop thanh vat cuoi. Chuoi Thien Ngoai Phi Tien dan den Thay Tuong So va Cao Minh; chua tu bat cong thuc hop thanh.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Chuan De Dao Nhan (185/193); Chuyen Sinh Lao Lao (182/192); Tieu Bao (182/194); Vo Cat (181/195); Thong That Tau (192/194)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
