-- Phong Than 2026-10-05 (luawave #1): clean login hook, replaces the VLTK leftover (backup in
-- _backup\20261005-luawave\). The old file Include'd files that do not exist and called split / TaoBang /
-- SaveData / PhongThanGiveStarterPack, so main() aborted on every login and nothing in it ever ran.
-- Engine: KPlayer::LaunchPlayer -> ExecuteScript("\script\player\playerlogin.lua", "main") once per world
-- entry (login), PlayerIndex = the player. The work lives in script\phongthan\luawave\lw_login.lua, loaded at
-- call time (cwd = Server), never at the top level. Every hook runs under call(): one error never breaks the
-- login, it goes to admin_bridge\login_error.log. The minute ticks of servertimer.lua keep running as before.
-- ASCII only.

function PTLWL_Err(m)
	local h = openfile("admin_bridge\\login_error.log", "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S ") .. "login " .. tostring(m) .. "\n")
		closefile(h)
	end
end

function PTLWL_Load()
	if not PTLW_Login then dofile("script\\phongthan\\luawave\\lw_login.lua") end
end

function main()
	call(PTLWL_Load, {}, "x", PTLWL_Err)
	if PTLW_Login then call(PTLW_Login, {}, "x", PTLWL_Err) end
end
