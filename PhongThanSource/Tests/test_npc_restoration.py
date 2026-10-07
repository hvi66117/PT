import importlib.util
import struct
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('restoration', Path(__file__).parents[1] / 'Tools/prepare_npc_restoration.py')
restoration = importlib.util.module_from_spec(spec)
spec.loader.exec_module(restoration)


class RegionTests(unittest.TestCase):
    def test_complete_batch_refuses_partial_publication(self):
        with self.assertRaisesRegex(ValueError, 'INCOMPLETE_BATCH'):
            restoration.require_complete_batch({'ready': 11, 'pending': 126}, True)
        restoration.require_complete_batch({'pending': 0}, True)
        restoration.require_complete_batch({'pending': 126}, False)

    def base(self):
        data = bytearray(52 + 512)
        struct.pack_into('<I', data, 0, 6)
        struct.pack_into('<II', data, 4, 0, 512)
        return bytes(data)

    def record(self):
        return struct.pack('<iiiB3x32shhhhBBH', 149, 49264, 109216, 0,
                           b'Dai Phu', 1, 0, 0, 3, 0, 0, 0)

    def test_preserves_geometry_and_is_idempotent(self):
        base = self.base()
        result = restoration.merge_region(base, [self.record(), self.record()])
        _, _, payload = restoration.split_region(result)
        self.assertEqual(len(restoration.npc_records(payload)), 1)
        self.assertEqual(result[52:len(base)], base[52:])
        second = restoration.merge_region(result, [self.record()])
        self.assertEqual(restoration.npc_records(restoration.split_region(second)[2]), [self.record()])

    def test_bad_script_count(self):
        record = bytearray(self.record())
        struct.pack_into('<H', record, 58, 100)
        with self.assertRaises(ValueError):
            restoration.npc_records(struct.pack('<III', 1, 0, 0) + record)

    def test_bad_section(self):
        base = bytearray(self.base())
        struct.pack_into('<II', base, 20, 510, 10)
        with self.assertRaises(ValueError):
            restoration.split_region(base)

    def test_standalone_is_original_npc_section_not_fake_geometry(self):
        record = self.record()
        result = restoration.standalone_npcs([record, record])
        self.assertEqual(len(result), 12 + 60)
        self.assertEqual(struct.unpack_from('<III', result), (1, 0, 0))
        self.assertEqual(restoration.npc_records(result), [record])

    def test_sparse_loader_uses_same_npc_loader(self):
        source = (Path(__file__).parents[1] / 'Sources/Core/Src/KRegion.cpp').read_bytes()
        self.assertTrue(b'ZeroMemory(m_dwTrap, sizeof(m_dwTrap));\n\t\t\treturn LoadServerNpc(nSubWorld, &cData, 0);' in source.replace(b'\r\n', b'\n'))


if __name__ == '__main__':
    unittest.main()
