//---------------------------------------------------------------------------
// Sword3 Core (c) 2002 by Kingsoft
//
// File:	KItemGenerator.h
// Date:	2002.08.26
// Code:	DongBo
// Desc:    header file. 本文件定义的类用于生成道具
//---------------------------------------------------------------------------

#ifndef	KItemGeneratorH
#define	KItemGeneratorH

#include "KBasPropTbl.h"
#include "KItem.h"

#define		IN
#define		OUT

//class KItem;

class KItemGenerator
{
public:
	KItemGenerator();
	~KItemGenerator();

// 以下是核心成员变量
protected:
	KLibOfBPT	m_BPTLib;

// 以下是辅助成员变量
	int			m_EquipNumOfEntries[equip_detailnum];
	int			m_MedNumOfEntries;
// 以下是对外接口
public:
	BOOL Init();
	const KLibOfBPT& Catalog() const { return m_BPTLib; }
	const KBASICPROP_EQUIPMENT* CatalogEquipment(int type, int row) const { return GetEquipmentTemplate(type, row); }
	int CatalogEquipmentCount(int type) const { return type >= 0 && type < 11 ? m_EquipNumOfEntries[type] : 0; }
	BOOL Gen_Quest(IN int, IN OUT KItem*);
	BOOL Gen_SkillBook(IN int nDetail, IN int nSkill, IN int nLevel, IN OUT KItem*);
	BOOL Gen_TownPortal(IN int, IN OUT KItem*);
	BOOL Gen_MagicScript(IN int, IN OUT KItem*,IN int,IN int,IN int);
	BOOL Gen_IBItem(IN int, IN int, IN OUT KItem*);
	BOOL Gen_Event(IN int, IN OUT KItem*);
	BOOL Gen_Material(IN int, IN OUT KItem*);
	BOOL Gen_Medicine(IN int, IN int, IN int, IN OUT KItem*);
	BOOL Gen_Equipment(IN int, IN int, IN int, IN int, IN const int*, IN int,
						IN int, IN OUT KItem*);
	BOOL Gen_EquipmentByTemplateRow(IN int, IN int, IN int, IN const int*, IN int,
						IN int, IN OUT KItem*);
	BOOL Gen_ExistEquipment(IN int, IN int, IN int, IN int, IN const int*, IN int,
						IN int, IN OUT KItem*);	
	BOOL Gen_ExistEquipmentByTemplateRow(IN int, IN int, IN int, IN const int*, IN int,
						IN int, IN OUT KItem*);
	BOOL GetEquipmentCommonAttrib(IN int, IN int, IN int, IN int, IN OUT KItem*);
	BOOL GetMedicineCommonAttrib(IN int, IN int, IN OUT KItem*);
	
// 以下是辅助函数
private:
	const KBASICPROP_EQUIPMENT* GetEquipmentTemplate(IN int, IN int) const;
	int FindEquipmentTemplateRow(IN int, IN int, IN int, IN int) const;
	BOOL ApplyPhongThanSetAttrib(KItem*, const KBASICPROP_EQUIPMENT*) const;
};

extern KItemGenerator	ItemGen;			//	装备生成器
#endif	// #ifndef	KItemGeneratorH
