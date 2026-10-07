# P0.3.3 - Lua UI, time va global compatibility

Muc tieu cua checkpoint la port dung semantics VNG cho nhom UI/message, thoi
gian va bien global ma khong thay ordinal protocol da khoa.

| API | Semantics da khoa |
|---|---|
| `TopMessage` | Thong bao ngan co dinh o kenh tren man hinh cua nguoi choi hien tai |
| `ScrollMessage` | Dong chu chay cua nguoi choi hien tai |
| `CloseDialog` | Dong UI hoi thoai NPC va huy trang thai server dang cho lua chon |
| `AddGlobalNews` | Broadcast news binh thuong den toan server |
| `AddGlobalCountNews` | Broadcast news co thoi luong dem giay den toan server |
| `WriteLog` | Ghi noi log Lua voi timestamp dia phuong |
| `SystemTime` | Unix epoch giay |
| `LocalSystemTime` | Unix epoch giay cong UTC offset hien tai |
| `GetGlobalValue` | Doc mot o trong global registry 0..4999 |
| `SetGlobalValue` | Ghi mot o trong global registry 0..4999 |

`SCRIPTACTION_CLOSEDIALOG`, `UI_TOPMESSAGE`, `UI_SCROLLMESSAGE`,
`GDCNI_CLOSE_DIALOG` va `GDCNI_TOP_MESSAGE` deu duoc them o cuoi enum tuong ung.
Hai gia tri cu cua `SCRIPTACTION` va cac ordinal UI/callback cu khong thay doi.

Gate `Tests\Test-LuaUiTimeGlobalCompatibility.ps1` khoa cac dieu kien:

- 10 ten API phai dang ky exact va khong con nam trong bao cao missing API.
- `TopMessage` va `ScrollMessage` phai di qua hai kenh UI khac nhau.
- `CloseDialog` phai co du server action, client decode va UI callback.
- Hai ham thoi gian va global registry phai dung semantics/kiem tra bien da chot.
- Payload audit phai sach, callback gap bang 0, engine API it nhat 528 va API
  con thieu khong qua 186.
- `TaskNote` van phai nam trong quarantine vi chua co task-note registry VNG.

Ket qua checkpoint: build Release `CoreServer` va `CoreClient` PASS; audit co
3.680/3.680 payload hop le, 528 engine API, 186 API con thieu, 457 Lua static
candidate va 0 callback gap. Khong cutover runtime trong P0.3.3.
