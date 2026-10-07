-- AUTHORED NPC 1004_10; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Chuyen Sinh Lao Lao - Xi Vuu Mo (196/202)", 4, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi chuyen sinh. Thu tuc can dieu kien cap, nhiem vu va vat pham dung phien ban; ban tai dung chua doi cap hoac thu nguyen lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Phong Ba (195/204); Thieu Hao (198/204); Hinh Thien (194/200); Chuc Dung (193/204); Ho Tro Tan Thu (194/205)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Dang mo: doi thoai, huong dan va tra cuu. Nhan/tra nhiem vu, doi thuong va giao dich chua mo khi chua du ma du lieu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
