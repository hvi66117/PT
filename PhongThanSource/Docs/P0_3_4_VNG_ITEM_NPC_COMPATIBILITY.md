# P0.3.4 - VNG item/NPC Lua compatibility

## Muc tieu

Mo khoa cac NPC death script VNG dang bi chan boi `GetNpcLevel`,
`AddNormalItem`, `IsExistItem` va `ThrowItem`, nhung khong gan API vao bang du
lieu Vo Lam hoac ham rong.

## Du lieu goc

Quest item dung nguyen payload VNG:

- logical path: `settings\item\001\questkey.txt`
- source block: `Tai nguyen VNG\vng00\block_3491_id2988111260.txt`
- length: 41.292 byte
- SHA-256: `2A6069B05472F817A0BC4948CFDE932D9B9BC4219C9BCCA1E8048261F3D3E26D`
- schema: 19 cot

`Deploy\Import-VngQuestKey.ps1` kiem tra length, hash va header truoc khi ghi
nguyen byte vao client/server. `questkey.txt` la bang bat buoc thu 12 trong item
registry; gate tiep tuc yeu cau client/server dong bo byte-for-byte.

## Hop dong API

- `GetNpcLevel(index)`: tra `Npc[index].m_Level`, index ngoai bien tra 0.
- `AddNormalItem(...)`: chi sinh Material genre 3, Quest genre 4 va MagicScript
  genre 6/detail 1 da co bang VNG. Item khong ton tai hoac khong chen duoc vao
  hanh trang bi huy ngay.
- `IsExistItem(...)`: dem so item/stack player dang so huu theo khoa bang VNG.
- `ThrowItem(...)`: sinh va tha cung ba nhom item da xac thuc; player owner -1
  duoc giu la public drop. Bind flag thu chin chua co hop dong nen bi tu choi.

QuestKey co `DetailType` thua; `KLibOfBPT::GetQuestRecord` bat buoc dung
`FindRecord`, khong dung row index.

## Ket qua audit

- payload integrity: 3.680/3.680
- callback gap: 0
- engine Lua API: 532 (truoc: 528)
- missing API name: 182 (truoc: 186)
- VNG official review_api: 14 (truoc: 23)

Audit static khong hieu mien gia tri tham so. File
`script\怪物\不义侯.lua` goi genre 8 o mot nhanh, do do van nam trong runtime
quarantine cung 14 file review_api. Danh sach va ly do nam trong
`Deploy\LUA_P0_3_4_QUARANTINE.json`.

## Gate

1. `Tests\Test-DataRegistry.ps1`
2. `Tests\Test-ItemRegistryLoader.ps1`
3. `Tests\Test-LuaVngItemNpcCompatibility.ps1`
4. `Tests\Test-LuaApiCompatibility.ps1`
5. `Tests\Test-LuaUiTimeGlobalCompatibility.ps1`
6. Build Release `CoreServer`, `CoreClient`

P0.3.4 la checkpoint source/data, khong phai cutover. Trang thai thieu
`Region_S` tai thoi diem checkpoint nay da duoc xu ly boi bo map Seaweed/VNG
duoc nhap sau do. Gate hien tai bat buoc 102 map active, 91 bo map vat ly va
34.048 cap `Region_C`/`Region_S` truoc khi cho phep publish.
