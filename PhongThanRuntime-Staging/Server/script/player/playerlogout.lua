-- Phong Than 2026-10-05 (luawave #1): clean logout hook, replaces the VLTK leftover (backup in
-- _backup\20261005-luawave\; it Include'd missing files and called huyhamthu / NewWorld(53,...) of VLTK map 396).
-- Engine: KPlayerSet::PrepareRemove -> ExecuteScript("\script\player\playerlogout.lua", "OnLogout") when the
-- character leaves the server; KProtocolProcess (player command OFFLINE) -> "main". Both only write a line to
-- admin_bridge\login.log, protected by call(). Logic in script\phongthan\luawave\lw_login.lua. ASCII only.

function PTLWO_Err(m)
	local h = openfile("admin_bridge\\login_error.log", "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S ") .. "logout " .. tostring(m) .. "\n")
		closefile(h)
	end
end

function PTLWO_Load()
	if not PTLW_Logout then dofile("script\\phongthan\\luawave\\lw_login.lua") end
end

function main()
	call(PTLWO_Load, {}, "x", PTLWO_Err)
	if PTLW_Offline then call(PTLW_Offline, {}, "x", PTLWO_Err) end
end

function OnLogout()
	call(PTLWO_Load, {}, "x", PTLWO_Err)
	if PTLW_Logout then call(PTLW_Logout, {}, "x", PTLWO_Err) end
end
