"""Structural checks for display-only integration, complementary to native PAK tests."""
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

class Wiring(unittest.TestCase):
    def test_inventory_is_separate(self):
        code=(ROOT/'Sources/Core/Src/KItem.cpp').read_text('latin1')
        bag=code.split('void KItem::PaintInventorySlot',1)[1].split('void KItem::Paint(',1)[0]
        self.assertNotIn('PaintEquipmentSlot',bag)
        self.assertNotIn('PhongThanPaintUpgradeAura',bag)
        self.assertIn('PhongThanDrawSlotImage(m_Image',bag)
    def test_tooltip_order(self):
        code=(ROOT/'Sources/Core/Src/KItem.cpp').read_text('latin1').split('void KItem::GetDesc',1)[1]
        self.assertLess(code.index('PT_UPGRADE_PIC_BASE'),code.index('m_CommonAttrib.szIntro'))
        loop=code.split('int nRemainingSetLines',1)[1]
        self.assertLess(loop.index('PhongThanUpgradeDescription'),loop.index('bSetEquipment && i >='))
        self.assertIn('if(bSetEquipment && i==MAX_ITEM_NORMAL_MAGICATTRIB)',loop)
        self.assertIn('if(!bSetEquipment)',loop)
        self.assertLess(loop.index('PT_TEXT_WEIGHT'),loop.index('PT_TEXT_CHAT_HINT'))
        self.assertNotIn('Cong luc thang cap',code)
    def test_native_equipment_art(self):
        code=(ROOT/'Sources/Core/Src/PhongThanEquipmentArt.inl').read_text()
        self.assertIn('m_nHasSpecialImage',code)
        self.assertIn('m_nSpecialSex',code)
        self.assertIn('nUpgradeLvl!=12',code)
        self.assertIn('RU_T_IMAGE_PART',code)
        self.assertIn('if(allowShrink &&',code)

if __name__=='__main__':unittest.main()
