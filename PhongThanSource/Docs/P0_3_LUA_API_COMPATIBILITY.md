# P0.3.2 - Lua API compatibility

Audit ban dau co 207 ten API chua tuong thich trong 760 Lua da xac thuc. Chung
duoc chia thanh cac nhom sau, khong coi mot ten gan giong trong source Vo Lam la
tuong duong neu tham so hoac gia tri tra ve khac nhau.

| Nhom | So ten | So luot Lua tham chieu | Xu ly |
|---|---:|---:|---|
| API loi da port P0 | 11 | 815 | Da dang ky va co gate semantics |
| Helper Lua cua project | 5 | 190 | Phai khoi phuc include graph, khong viet lai C++ |
| Lua runtime/version | 2 | 8 | `pcall`, `ipairs`; can doi chieu Lua VM truoc khi mo |
| Task-note data contract | 1 | 162 | Giu quarantine; khong anh xa gia sang `AddNote` |
| Can port theo subsystem | 188 | con lai | Buff, item, UI/message, time/global, instance, city/tong, NPC/AI, skill |

11 API P0 gom:

- `GetTaskByte`, `SetTaskByte`, `GetTaskWord`, `SetTaskWord`, `GetTaskBit`,
  `SetTaskBit`.
- `GetTeamMember`, `GetNpcWorldPos`, `GetPlayerID`, `GetNpcTask`, `SetNpcTask`.

Quyet dinh semantics:

1. Chi so byte/word/bit la 1-based. Task ID la sparse ID cua Phong Than; core
   cho phep 0..4999, bao phu ID truc tiep lon nhat 2277 trong tap Lua hien co.
2. `GetTeamMember(1)` la doi truong; 2 tro di la thanh vien. Khong dung truc
   tiep `GetTeamMem`, vi API cu dung 0 cho doi truong.
3. `GetNpcWorldPos` tra map ID va toa do tile `(map, x/32, y/32)`.
4. `GetNpcTask`/`SetNpcTask` dung vung tham so song cung NPC. Audit dung chi so
   0..10; core cap 16 o va chan moi truy cap vuot bien.
5. `GetPlayerID` chap nhan player index tuy chon, dong thoi van ho tro cach goi
   khong tham so trong ngu canh script hien tai.
6. Database role ABI van giu `nTaskCount` mot byte. Loader ho tro task ID 16-bit,
   con saver dung gate 255 gia tri khac rong de khong wrap/corrupt role blob.

`TaskNote` chua duoc port trong checkpoint nay. Ham VNG nhan task/template ID,
step va tham so thay the; `AddNote` cua engine cu nhan chuoi/header da render.
Anh xa hai ham se lam Lua het bao loi nhung hien sai nhiem vu, nen gate bat buoc
giu Lua lien quan trong quarantine cho den khi co bang task-note VNG va loader.
