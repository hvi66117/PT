"""Compile accepted NPC positions into NPC sections of existing Region_S files.

No heuristic template selection, fake Lua, PAK writes or Region_C conversion.
Inputs are checked before writing; authored overrides have their own namespace.
"""
from __future__ import annotations

import argparse
import ctypes
import hashlib
import json
import re
import struct
from pathlib import Path


def pak_id(path: bytes) -> int:
    value = 0
    for index, byte in enumerate(b"\\" + path.replace(b"/", b"\\").lstrip(b"\\"), 1):
        if 65 <= byte <= 90:
            byte += 32
        signed = byte if byte < 128 else byte - 256
        value = (((value + index * signed) & 0xffffffff) % 0x8000000b * 0xffffffef) & 0xffffffff
    return value ^ 0x12345678


class PakReader:
    def __init__(self, root: Path, dll: Path):
        self.dll = ctypes.CDLL(str(dll))
        self.dll.CreatePak.restype = ctypes.c_void_p
        self.dll.PakLoad.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
        self.dll.PakReadBlock.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_void_p, ctypes.c_int]
        self.dll.DestroyPak.argtypes = [ctypes.c_void_p]
        self.index = {}
        self.handles = {}
        self.cache = {}
        self.paks = []
        ini = (root / "package.ini").read_bytes().decode("ascii")
        for name in re.findall(r"^\d+=([^\r\n]+)", ini, re.M):
            pak = root / "data" / name
            self.paks.append(pak)
            with pak.open("rb") as stream:
                head = stream.read(32)
                signature, count, offset = struct.unpack_from("<4sII", head)
                if signature != b"PACK" or count > 2000000 or offset + 16 * count > pak.stat().st_size:
                    raise ValueError(f"Invalid PAK index: {pak}")
                stream.seek(offset)
                entries = stream.read(16 * count)
                for n, (key, pos, size, flags) in enumerate(struct.iter_unpack("<IIII", entries)):
                    self.index.setdefault(key, (pak, n, size, pos, flags))

    def get(self, logical: str):
        logical = "\\" + logical.replace("/", "\\").lstrip("\\")
        if logical in self.cache:
            return self.cache[logical]
        key = pak_id(logical.encode("gbk"))
        entry = self.index.get(key)
        if entry is None:
            return None
        pak, n, size, pos, flags = entry
        if not 0 < size <= 64 * 1024 * 1024:
            raise ValueError(f"Invalid entry size: {logical}")
        if logical.lower().endswith('.spr'):
            # Frame-compressed SPR is not an ordinary PakReadBlock payload.
            # Its SPRHEAD is stored uncompressed; Engine validates/decompresses frames.
            with pak.open('rb') as stream:
                stream.seek(pos)
                data = stream.read(32)
            if not data.startswith(b'SPR'):
                return None
            evidence = dict(logical=logical, pak=pak.name, entry=n, id=f"{key:08X}",
                            bytes=size, validation="PAK_INDEX_AND_STORED_SPR_HEADER", flags=flags)
            self.cache[logical] = (data, evidence)
            return data, evidence
        if pak not in self.handles:
            handle = self.dll.CreatePak()
            if self.dll.PakLoad(handle, str(pak).encode("mbcs")) <= 0:
                raise ValueError(f"Cannot load PAK: {pak}")
            self.handles[pak] = handle
        buffer = ctypes.create_string_buffer(size)
        read = self.dll.PakReadBlock(self.handles[pak], n, buffer, size)
        if read != size:
            raise ValueError(f"Incomplete PAK read {logical}: {read}/{size}")
        data = buffer.raw
        evidence = dict(logical=logical, pak=pak.name, entry=n, id=f"{key:08X}",
                        sha256=hashlib.sha256(data).hexdigest(), bytes=size)
        self.cache[logical] = (data, evidence)
        return data, evidence

    def close(self):
        for handle in self.handles.values():
            self.dll.DestroyPak(handle)


def rows(data: bytes):
    return [line.split(b"\t") for line in data.replace(b"\r", b"").split(b"\n") if line]


def disk_path(root: Path, logical: str) -> Path:
    # Engine's ANSI filesystem names preserve GBK byte values as Latin-1.
    return root.joinpath(*logical.encode("gbk").decode("latin1").strip("\\").split("\\"))


def split_region(data: bytes):
    if len(data) < 52:
        raise ValueError("short Region_S")
    count, = struct.unpack_from("<I", data)
    if not 6 <= count <= 64:
        raise ValueError("invalid section count")
    head = 4 + count * 8
    sections = list(struct.iter_unpack("<II", data[4:head]))
    spans = []
    for offset, length in sections:
        if head + offset + length > len(data):
            raise ValueError("section outside Region_S")
        if length:
            spans.append((head + offset, head + offset + length))
    spans.sort()
    if any(a[1] > b[0] for a, b in zip(spans, spans[1:])):
        raise ValueError("overlapping sections")
    offset, length = sections[2]
    return head, sections, data[head + offset:head + offset + length]


def npc_records(payload: bytes):
    if not payload:
        return []
    if len(payload) < 12:
        raise ValueError("short KNpcFileHead")
    count, _, _ = struct.unpack_from("<III", payload)
    offset = 12
    records = []
    for _ in range(count):
        if offset + 60 > len(payload):
            raise ValueError("short KSPNpc")
        nscript, = struct.unpack_from("<H", payload, offset + 58)
        end = offset + 60 + nscript
        if end > len(payload):
            raise ValueError("short NPC script")
        records.append(payload[offset:end])
        offset = end
    if offset != len(payload):
        raise ValueError("trailing NPC data")
    return records


def standalone_npcs(records: list[bytes]) -> bytes:
    """Original Npc_S payload only. No manufactured obstacle/trap sections."""
    records = list(dict.fromkeys(records))
    payload = struct.pack('<III', len(records), 0, 0) + b''.join(records)
    if npc_records(payload) != records:
        raise ValueError('NPC-only payload failed roundtrip')
    return payload


def require_complete_batch(report: dict, required: bool) -> None:
    if required and report.get('pending', 0):
        raise ValueError(f"INCOMPLETE_BATCH: {report['pending']} unresolved NPC rows; no publication files written")


def merge_region(base: bytes, additions: list[bytes]) -> bytes:
    head, sections, payload = split_region(base)
    current = npc_records(payload)
    keys = {(r[:12], r[16:48]) for r in current}
    for record in additions:
        key = (record[:12], record[16:48])
        if key not in keys:
            current.append(record)
            keys.add(key)
    newpayload = struct.pack("<III", len(current), 0, 0) + b"".join(current)
    # Preserve every original byte/offset, append a replacement NPC section.
    out = bytearray(base)
    struct.pack_into("<II", out, 20, len(base) - head, len(newpayload))
    out.extend(newpayload)
    _, check_sections, check = split_region(bytes(out))
    assert npc_records(check) == current
    assert all(a == b for i, (a, b) in enumerate(zip(sections, check_sections)) if i != 2)
    assert out[head:len(base)] == base[head:]
    return bytes(out)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--content", type=Path, default=Path(r"D:\Lam game phong than\PhongThanRuntime-Content"))
    parser.add_argument("--dll", type=Path, default=Path(r"D:\Lam game phong than\SeaweedUnpack_SprView\SeaweedUnpack_SprView\UnpackCore.dll"))
    parser.add_argument("--write", action="store_true")
    parser.add_argument("--require-complete", action="store_true", help="Refuse all output writes if any catalog row is unresolved")
    args = parser.parse_args()
    current_report=args.project / 'Docs/NPC_RESTORATION_DEPLOYMENT.json'
    if args.write and current_report.exists() and json.loads(current_report.read_text('utf8')).get('scope')=='USER_APPROVED_ALL_126_RECONSTRUCTION':
        raise ValueError('Authored batch is active. Use build_authored_npcs.py; do not replace it with the old verified-only subset.')
    catalog = json.loads((args.project / "Deploy/ProjectContent/NpcRestoration/coordinates.json").read_text("utf-8"))
    originals = json.loads((args.project / "Docs/VNG_NPC_REGION_IMPORT.json").read_text("utf-8-sig"))
    source = args.content / "Server"
    reader = PakReader(args.content / "Client", args.dll)
    try:
        template_data, template_evidence = reader.get(r"\settings\Npcs.txt")
        template_rows = rows(template_data)[1:]
        # Deployment must not silently substitute a different template registry.
        for role in ("Server", "Client"):
            if (args.content / role / "settings/phongthan/Npcs.txt").read_bytes() != template_data:
                raise ValueError(f"{role} NPC registry differs from priority PAK")
        named = {}
        for i, row in enumerate(template_rows):
            if row[1] == b"3":
                named.setdefault(row[0].decode("gbk", "replace").strip(), []).append(i)
        original_names = {}
        for npc in originals["Npcs"]:
            if npc["Kind"] == 3:
                name = npc["NameBytes"].encode("latin1").decode("gbk").strip()
                original_names.setdefault(name, []).append(npc)
        world_text = (source / "settings/WorldSet.ini").read_bytes().decode("gbk")
        worlds = dict(re.findall(r"^(\d+)=([^\r\n]+)", world_text, re.M))
        kind_data, _ = reader.get(r"\settings\npcres\人物类型.txt")
        spr_data, _ = reader.get(r"\settings\npcres\普通npc资源.txt")
        kinds = {row[0].decode("gbk"): row for row in rows(kind_data)[1:]}
        resources = {row[0].decode("gbk"): row for row in rows(spr_data)[1:]}
        report = dict(schema=1, accepted_coordinates=True, templates=template_evidence,
                      original_npcs=38, original_monsters=1183, rows=[], overrides=[],
                      complete=False, visual_acceptance=False)
        plans = {}
        for world, items in catalog["maps"].items():
            for vn, cn, x, y, note in items:
                result = dict(world=int(world), name=vn, original_name=cn, x=x, y=y,
                              note=note, status="PENDING", reasons=[])
                report["rows"].append(result)
                if cn and any(int(world) in n["MapIds"] for n in original_names.get(cn, [])):
                    result["status"] = "EXISTING_PAK"
                    continue
                candidates = sorted(set(n["Template"] for n in original_names.get(cn, []))) or named.get(cn, [])
                if not cn or not candidates:
                    result["reasons"].append("NO_PROVEN_NAME_TO_TEMPLATE")
                elif len({template_rows[t][12] for t in candidates}) > 1:
                    # Physician identity is demonstrated by the field NPC template 149.
                    if cn == "医生" and world == "1015":
                        candidates = [149]
                    else:
                        result["reasons"].append("AMBIGUOUS_TEMPLATE_APPEARANCE")
                base_name = worlds.get(world)
                if not base_name:
                    result["reasons"].append("WORLD_UNRESOLVED")
                    continue
                # VNG script directories are not always physical map directories.
                script_scope = {"1073": "不周天关", "1074": "不周山", "1075": "狱法山"}.get(world, base_name)
                logical_lua = f"\\script\\{script_scope}\\{cn}.lua" if cn else ""
                if cn == "医生" and world == "1015":
                    logical_lua = "\\script\\龙套\\野外医生-孟津.lua"
                lua = reader.get(logical_lua) if logical_lua else None
                if lua and re.search(rb"function\s+main\s*\(", lua[0]):
                    result["lua"] = lua[1]
                else:
                    result["reasons"].append("NO_PROVEN_MAP_DIALOGUE_LUA")
                    result["lua_candidate"] = logical_lua
                if candidates:
                    template = candidates[0]
                    row = template_rows[template]
                    res = row[12].decode("gbk")
                    result.update(template=template, npc_res_type=res)
                    kind = kinds.get(res)
                    resource = resources.get(res)
                    if not kind or not resource or len(resource) < 2 or not resource[1]:
                        result["reasons"].append("SPR_MAPPING_UNRESOLVED")
                    else:
                        spr = kind[2].decode("gbk").rstrip("\\") + "\\" + resource[1].decode("gbk")
                        found = reader.get(spr)
                        if not found or len(found[0]) < 32 or not found[0].startswith(b"SPR"):
                            result["reasons"].append("SPR_NOT_IN_PAK_OR_INVALID_HEADER")
                        else:
                            result["spr"] = found[1]
                if result["reasons"]:
                    continue
                # Website display coordinates are MPS / (256,512). Choose tile center.
                wx, wy = x * 256 + 128, y * 512 + 256
                mm = re.search(r"minimap MPS (\d+)/(\d+)", note)
                if mm and not (world == "1015" and cn == "医生"):
                    wx, wy = map(int, mm.groups())
                result["coordinate_selection"] = ("VNG_WEB_TILE_CENTER; minimap alternative retained" if world == "1015" and cn == "医生" else "ACCEPTED_COORDINATE")
                rx, ry = wx // 512, wy // 1024
                result.update(world_x=wx, world_y=wy, region_x=rx, region_y=ry,
                              local_x=wx % 512, local_y=wy % 1024)
                wor_path = disk_path(source, f"maps\\{base_name}.wor")
                if not wor_path.is_file():
                    result["reasons"].append("MISSING_TARGET_WOR")
                    continue
                wor = wor_path.read_bytes().decode("gbk", "replace")
                bounds = re.search(r"(?im)^rect\s*=\s*(\d+),(\d+),(\d+),(\d+)", wor)
                if not bounds:
                    result["reasons"].append("MISSING_WOR_BOUNDS")
                    continue
                left, top, right, bottom = map(int, bounds.groups())
                if not (left <= rx <= right and top <= ry <= bottom):
                    result["reasons"].append("POSITION_OUTSIDE_MAP")
                    continue
                target = f"maps\\{base_name}_S\\v_{ry:03d}\\{rx:03d}_region_s.dat"
                disk = disk_path(source, target)
                pak_base = reader.get(target)
                if pak_base:
                    base, base_evidence = pak_base
                elif disk.is_file():
                    base, base_evidence = disk.read_bytes(), {"source": str(disk), "kind": "runtime_geometry_only"}
                else:
                    pak_base = reader.get(target.replace(base_name + "_S", base_name))
                    if not pak_base:
                        base = None
                        # Validation only: establish that this is an existing
                        # client map cell. Never publish or convert Region_C.
                        client_logical = f"maps\\{base_name}\\v_{ry:03d}\\{rx:03d}_region_c.dat"
                        client_cell = reader.get(client_logical)
                        if not client_cell:
                            result["reasons"].append("NO_PAK_CLIENT_CELL_FOR_NPC_ONLY")
                            continue
                        base_evidence = {"kind": "NPC_ONLY_NO_SERVER_GEOMETRY", "client_cell_validation": client_cell[1]}
                    else:
                        base, base_evidence = pak_base
                result["base_evidence"] = base_evidence
                validation_bytes = base if base is not None else client_cell[0]
                head, sections, payload = split_region(validation_bytes)
                if base is not None:
                    npc_records(payload)
                # Verify the existing obstruction section but do not move accepted positions.
                barrier_offset, barrier_size = sections[0]
                result["barrier_section_bytes"] = barrier_size
                if barrier_size == 2048:
                    gx, gy = (wx % 512) // 32, (wy % 1024) // 32
                    barrier, = struct.unpack_from("<I", validation_bytes, head + barrier_offset + 4 * (gx * 32 + gy))
                    result["barrier_cell"] = barrier
                    code, shape = barrier & 15, (barrier >> 4) & 15
                    ox, oy = wx % 32, wy % 32
                    free_half = ((shape == 2 and ox + oy > 32) or (shape == 3 and ox < oy)
                                 or (shape == 4 and ox > oy) or (shape == 5 and ox + oy < 32))
                    if code and not free_half:
                        result["reasons"].append("ACCEPTED_POINT_IS_BLOCKED")
                        continue
                elif barrier_size:
                    result["reasons"].append("UNSUPPORTED_OBSTACLE_LAYOUT")
                    continue
                script = logical_lua.encode("gbk")
                name = cn.encode("gbk")
                if len(name) >= 32 or len(script) >= 128:
                    result["reasons"].append("NAME_OR_SCRIPT_EXCEEDS_ENGINE_LIMIT")
                    continue
                # KSPNpc prefix from SceneDataDef.h (verified sizeof = 60).
                record = struct.pack("<iiiB3x32shhhhBBH", template, wx, wy, 0,
                                     name, 1, 0, 0, 3, int(row[2] or 0), int(row[3] or 0), len(script)) + script
                assert len(record) == 60 + len(script)
                suffix = 'region_s' if base is not None else 'npc_s'
                relative = f"settings/phongthan/npc_regions/{world}/v_{ry:03d}/{rx:03d}_{suffix}.dat"
                entry = plans.setdefault(relative, dict(base=base, source=str(disk) if base is not None else None, records=[]))
                entry["records"].append(record)
                result["status"] = "READY"
                result["override"] = relative
        artifacts = {}
        for relative, plan in plans.items():
            compiled = merge_region(plan["base"], plan["records"]) if plan["base"] is not None else standalone_npcs(plan["records"])
            artifacts[relative] = compiled
            report["overrides"].append(dict(relative=relative, base=plan["source"],
                base_sha256=hashlib.sha256(plan["base"]).hexdigest() if plan["base"] is not None else None,
                sha256=hashlib.sha256(compiled).hexdigest(), added=len(plan["records"])))
        report["ready"] = sum(r["status"] == "READY" for r in report["rows"])
        report["pending"] = sum(r["status"] == "PENDING" for r in report["rows"])
        report["existing_web_matches"] = sum(r["status"] == "EXISTING_PAK" for r in report["rows"])
        report["complete"] = report["pending"] == 0
        require_complete_batch(report, args.require_complete)
        if args.write:
            out = args.project / "Deploy/ProjectContent/NpcRestoration/compiled"
            for relative, data in artifacts.items():
                target = out / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(data)
            names = {r["original_name"]: r["name"] for r in report["rows"] if r["status"] == "READY"}
            name_data = b"Name\tDisplayName\r\n" + b"".join(
                cn.encode("gbk") + b"\t" + vn.encode("ascii") + b"\r\n" for cn, vn in sorted(names.items()))
            name_path = out / "settings/phongthan/NpcDisplayNames.txt"
            name_path.parent.mkdir(parents=True, exist_ok=True)
            name_path.write_bytes(name_data)
            spr_paths = sorted({r['spr']['logical'] for r in report['rows'] if r['status'] == 'READY'})
            (args.project / 'Docs/NPC_RESTORATION_SPR_PATHS.txt').write_bytes(
                ('\r\n'.join(spr_paths) + '\r\n').encode('gbk'))
            (args.project / "Docs/NPC_RESTORATION_DEPLOYMENT.json").write_text(
                json.dumps(report, ensure_ascii=False, indent=2) + "\n", "utf-8")
        print(json.dumps(report, ensure_ascii=False, indent=2))
    finally:
        reader.close()


if __name__ == "__main__":
    import sys
    sys.stdout.reconfigure(encoding="utf-8")
    main()
