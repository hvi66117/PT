-- vng_tasknote.lua  (Lua 4, Phong Than GameServer)
-- Renders VNG TaskNote(id, step, ...) as readable F11 quest-log records using
-- the VNG task registry (\ui\ui3\taskinfo.ini -> vng_tasknote_data.lua).
--
-- Hook (one line, top of an NPC script):
--   Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- Including this file defines PTTaskNote and installs TaskNote = PTTaskNote
-- in the caller's Lua state. Including it twice is harmless.
--
-- The ~280KB data table is loaded lazily, once per Lua state, on the first
-- TaskNote call (NPC states that never call TaskNote pay nothing).

PT_TASKNOTE_DATA = "\\script\\phongthan\\lib\\vng_tasknote_data.lua"
-- Client KUiTaskNote copies each record into char[512] (MAX_MESSAGE_LENGTH)
-- with a 3..7 byte prefix and no bound check: keep the raw text well below.
PT_TASKNOTE_MAXLEN = 480
-- act for step >= 0: 1 = perform (tick icon), 0 = explain colour.
PT_TASKNOTE_STEP_ACT = 1
-- "Nhiem vu hoan thanh" as TCVN3 bytes (file itself stays ASCII).
PT_TASKNOTE_DONE_TEXT = "Nhi\214m v\244 ho\181n th\181nh"

-- Keep the C++ TaskNote (LuaTaskNoteCompat) for unknown ids/steps.
if PT_TaskNote_C == nil and TaskNote ~= nil and TaskNote ~= PTTaskNote then
	PT_TaskNote_C = TaskNote
end

function PTTaskNote_Load()
	if PT_TASKINFO == nil then
		-- protected: a missing data file must not abort the NPC script
		call(Include, { PT_TASKNOTE_DATA }, "x")
		if type(PT_TASKINFO) ~= "table" then
			PT_TASKINFO = {}
		end
	end
	return PT_TASKINFO
end

-- Fill %s / %d / %_ placeholders from args[1..n]; missing args -> "".
-- %_ consumes an argument and prints nothing (VNG link coordinates).
function PTTaskNote_Fill(text, args)
	local st = { i = 0, a = args }
	local r = gsub(text, "%%([sd_])", function(c)
		local s = %st
		s.i = s.i + 1
		local v = s.a[s.i]
		if c == "_" or v == nil then
			return ""
		end
		if c == "d" then
			local x = tonumber(v)
			if x ~= nil then
				return format("%d", x)
			end
		end
		return tostring(v)
	end)
	return r
end

-- Cut to PT_TASKNOTE_MAXLEN bytes without leaving a half "<color=...".
function PTTaskNote_Clip(msg)
	if strlen(msg) <= PT_TASKNOTE_MAXLEN then
		return msg
	end
	local cut = strsub(msg, 1, PT_TASKNOTE_MAXLEN)
	local last = nil
	local p = strfind(cut, "<", 1, 1)
	while p ~= nil do
		last = p
		p = strfind(cut, "<", p + 1, 1)
	end
	if last ~= nil and strfind(cut, ">", last, 1) == nil then
		cut = strsub(cut, 1, last - 1)
	end
	return cut
end

function PTTaskNote_Fallback(id, step, args)
	if PT_TaskNote_C == nil then
		return
	end
	local t = { id, step }
	local n = 2
	local i = 1
	while i <= args.n do
		n = n + 1
		t[n] = args[i]
		i = i + 1
	end
	t.n = n
	return call(PT_TaskNote_C, t)
end

function PTTaskNote(id, step, ...)
	local nid = tonumber(id)
	local nstep = tonumber(step)
	if nid == nil or nstep == nil then
		return PTTaskNote_Fallback(id, step, arg)
	end
	local info = PTTaskNote_Load()[nid]
	if info == nil then
		return PTTaskNote_Fallback(id, step, arg)
	end
	local act, text
	if nstep < 0 then
		act = 2
		text = PT_TASKNOTE_DONE_TEXT
	else
		text = info.s and info.s[nstep]
		act = PT_TASKNOTE_STEP_ACT
		if text == nil and info.s ~= nil then
			-- taskinfo.ini has no text for this step: past the last step means the
			-- quest is finished, a gap reuses the closest earlier step.
			local maxs, below = -1, -1
			for k, v in info.s do
				if k > maxs then maxs = k end
				if k < nstep and k > below then below = k end
			end
			if maxs >= 0 and nstep > maxs then
				act = 2
				text = PT_TASKNOTE_DONE_TEXT
			elseif below >= 0 then
				text = info.s[below]
			end
		end
		if text == nil then
			return PTTaskNote_Fallback(id, step, arg)
		end
		text = PTTaskNote_Fill(text, arg)
	end
	local msg = text
	if info.t ~= nil and info.t ~= "" then
		msg = info.t .. ": " .. text
	end
	AddNote(mod(abs(nid), 36), act, PTTaskNote_Clip(msg), 0)
end

TaskNote = PTTaskNote

-- 2026-10-03 daily3: NewTaskNote(id, step, flag, ...) is VNG's newer form; the third argument is a display
-- flag, the text arguments follow it (nuanlu.lua / shoutao.lua: NewTaskNote(203, 6, 1, team, hits, rescues)).
-- The C++ NewTaskNote printed "Task N - step S"; route it through the taskinfo texts like TaskNote.
if PT_NewTaskNote_C == nil and NewTaskNote ~= nil and NewTaskNote ~= PTNewTaskNote then
	PT_NewTaskNote_C = NewTaskNote
end

function PTNewTaskNote(id, step, flag, ...)
	local t = { id, step }
	local i = 1
	while i <= arg.n do
		t[i + 2] = arg[i]
		i = i + 1
	end
	t.n = arg.n + 2
	return call(PTTaskNote, t)
end

NewTaskNote = PTNewTaskNote

-- 2026-10-01 NPC shops: KBuySell::CanBuy, KBuySell::Sell and KPlayer::RepairItem refuse every buy,
-- sell and repair while the player is in fight mode (the client shows no message: "clicks do
-- nothing"). Cities are not always entered through a script that clears it, so opening any shop
-- leaves fight mode first; task 1940 = 1 lets "Lenh Bai Huy Do" switch it back on in the field.
if PT_Sale_C == nil and Sale ~= nil and Sale ~= PTSale then
	PT_Sale_C = Sale
end

function PTSale(...)
	if GetFightState and GetFightState() == 1 then
		SetFightState(0)
		if SetTask then SetTask(1940, 1) end
	end
	return call(PT_Sale_C, arg)
end

if PT_Sale_C ~= nil then
	Sale = PTSale
end
