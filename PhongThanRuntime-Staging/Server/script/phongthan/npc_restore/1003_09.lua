-- AUTHORED NPC 1003_09; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1003 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Chuyen Sinh Lao Lao - Ngoc Hu cung (212/196)", 5, "Chuy\211n sinh/PTLW_CS0", "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("\167\199u m\232i chuy\211n sinh. Theo VNG, X\221ch Tinh T\246 (Ng\228c H\173 cung) \174\173a ng\173\234i v\181o Ti\170n gi\237i, Cao Minh (Xi V\173u m\233) \174\173a v\181o Ma gi\237i; ta c\227 th\211 l\181m thay. C\199n c\202p 121, t\232i \174a 3 l\199n, ch\228n m\244c Chuy\211n sinh \174\211 xem \174i\210u ki\214n v\181 ph\199n th\173\235ng.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Xich Tinh Tu (213/197); Van Trung Tu (215/194); Khao Co Hoc (208/194); Tan Thu Thi Luyen (207/195); Nam Cuc Tien Ong (209/191)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("\167ang m\235: chuy\211n sinh (v\210 c\202p 1, gi\247 k\252 n\168ng, thu\233c t\221nh g\232c theo ph\184i, +20 \174i\211m ti\210m n\168ng), h\173\237ng d\201n v\181 tra c\248u.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end

-- luawave 2026-10-05: Chuyen sinh (script\phongthan\luawave\cs_lib.lua, loaded at call time)
function PTLW_CS0()
    if pt_guard() == 0 then return end
    if not PTCS_Main then dofile("script\\phongthan\\luawave\\cs_lib.lua") end
    if PTCS_Main then PTCS_Main(0) end
end
