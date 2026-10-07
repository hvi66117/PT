-- Original VNG source payload; provenance in deployment report.
--description:npc
--author: zhujialiang
--date:2005/4/13

function  main()
		Talk(1,"no",11401)
end;

function  no()
	CloseDialog()
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1003_10; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1003 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Kim Ha Dong Tu - Ngoc Hu cung (212/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dong tu tai Ngoc Hu Cung. Co toa do trong danh muc Dao Si; su dung nhanh goc neu Lua tuong ung duoc tim thay.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Lao Rua (212/203); Thuong Nhan Tay Vuc (212/202); Sinh Hoat Su (217/202); Xich Tinh Tu (213/197); Chuyen Sinh Lao Lao (212/196)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Co nhanh Lua VNG goc trong PAK. Cac dieu kien va giao dich do nhanh goc kiem tra; chua nghiem thu toan bo nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
function pt_original()
    if pt_guard() == 0 then return end
    pt_original_main()
end
