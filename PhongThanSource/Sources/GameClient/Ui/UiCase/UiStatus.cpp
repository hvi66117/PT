/*****************************************************************************************
//	����--״̬����
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-9-2
*****************************************************************************************/
#include "KWin32.h"
#include "KIniFile.h"
#include "KDebug.h"
#include "../Elem/WndMessage.h"
#include "../Elem/Wnds.h"
#include "../elem/popupmenu.h"
#include "UiShop.h"
#include "UiSuperShop.h"
#include "UiStatus.h"
#include "UiGetString.h"
#include "UiItem.h"
#include "UiGive.h"
#include "UiExpandItem.h"
#include "UiStoreBox.h"
#include "UiSysMsgCentre.h"
#include "../ShortcutKey.h"
#include "../../../Core/Src/CoreShell.h"
#include "../UiBase.h"
#include "../UiSoundSetting.h"
#include "UiTradeConfirmWnd.h"
#include "../../../core/src/GameDataDef.h"
#include "../../../Represent/iRepresent/iRepresentShell.h"

extern iRepresentShell *g_pRepresentShell;

extern iCoreShell *g_pCoreShell;

#define    SCHEME_INI        "UiStatus.ini"

static const char *StatusLabelSections[STATUS_LABEL_COUNT] = {
        "LabelName", "LabelTitle", "LabelLevel", "LabelStatus",
        "LabelLife", "LabelMana", "LabelStamina", "LabelExp",
        "LabelStrength", "LabelDexterity", "LabelVitality", "LabelEnergy",
        "LabelLeftDamage", "LabelRightDamage", "LabelAttack", "LabelDefense",
        "LabelMoveSpeed", "LabelAttackSpeed", "LabelRemainPoint",
        "LabelResistPhy", "LabelResistCold", "LabelResistLighting",
        "LabelResistEarth", "LabelResistFire", "LabelPrestige", "LabelFuYuan"
};

static void OffsetStatusPageControl(KWndWindow *pWnd, int nOffsetX, int nOffsetY) {
    int nLeft = 0;
    int nTop = 0;
    pWnd->GetPosition(&nLeft, &nTop);
    pWnd->SetPosition(nLeft + nOffsetX, nTop + nOffsetY);
}

// Xem tin tuc nguoi choi

enum WAIT_OTHER_WND_OPER_PARAM {
    UIITEM_WAIT_GETSTR,
    UIITEM_WAIT_GETDEX,
    UIITEM_WAIT_GETVIT,
    UIITEM_WAIT_GETENE,
};

KUiStatus *KUiStatus::m_pSelf = NULL;
// -------------------------------------------------------------------------
// ---> �����ؼ���UIEP_*�Լ��ɽ�����Ʒ�����͵Ķ�Ӧ��ϵ
static struct UE_CTRL_MAP {
    int nPosition;
    const char *pIniSection;
} CtrlItemMap[_ITEM_COUNT] =
        {
                {UIEP_HEAD,        "Cap"},
                {UIEP_HAND,        "Weapon"},
                {UIEP_NECK,        "Necklace"},
                {UIEP_FINESSE,     "Bangle"},
                {UIEP_BODY,        "Cloth"},
                {UIEP_WAIST,       "Sash"},
                {UIEP_FINGER1,     "Ring1"},
                {UIEP_FINGER2,     "Ring2"},
                {UIEP_WAIST_DECOR, "Pendant"},
                {UIEP_FOOT,        "Shoes"},
                {UIEP_HORSE,       "Horse"},
                {UIEP_SIGNET,      "Signet"},    //װ��-��
                {UIEP_SHIPIN,      "Shipin"},    //װ��-��
        };


//--------------------------------------------------------------------------
//	���ܣ��������������ʾ���򷵻�ʵ��ָ��
//--------------------------------------------------------------------------
KUiStatus *KUiStatus::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

//--------------------------------------------------------------------------
//	���ܣ��򿪴��ڣ�����Ψһ��һ�������ʵ��
//--------------------------------------------------------------------------
KUiStatus *KUiStatus::OpenWindow(bool bShow) {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiStatus;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf && bShow) {
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->UpdateData();
        m_pSelf->BringToTop();
        m_pSelf->Show();
    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	���ܣ��رմ��ڣ�ͬʱ����ѡ���Ƿ�ɾ������ʵ��
//--------------------------------------------------------------------------
void KUiStatus::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        if (bDestroy == false) {
            if (g_UiBase.GetStatus() == UIS_S_LOCK_ITEM ||
                g_UiBase.GetStatus() == UIS_S_UNLOCK_ITEM)
                g_UiBase.SetStatus(UIS_S_IDLE);

            m_pSelf->Hide();
        } else {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
    }
}

//--------------------------------------------------------------------------
//	���ܣ���ʼ��
//--------------------------------------------------------------------------
void KUiStatus::Initialize() {
    // F3 is the official Phong Than character-status page.  Equipment is
    // rendered by F4 (KUiItem); inspecting another player is KUiParadeItem.
    AddChild(&m_StatusPageMain);
    AddChild(&m_NormalStatusBg);
    AddChild(&m_StatusTab);
    AddChild(&m_NormalStatusBtn);
    AddChild(&m_JEvilStatusBtn);
    AddChild(&m_Avt);

    AddChild(&m_Name);
    AddChild(&m_Experience);

    AddChild(&m_RemainPoint);
    AddChild(&m_Strength);
    AddChild(&m_Dexterity);
    AddChild(&m_Vitality);
    AddChild(&m_Energy);

    AddChild(&m_AddStrength);
    AddChild(&m_AddDexterity);
    AddChild(&m_AddVitality);
    AddChild(&m_AddEnergy);

    AddChild(&m_LeftDamage);
    AddChild(&m_RightDamage);
    AddChild(&m_Attack);
    AddChild(&m_Defence);
    AddChild(&m_MoveSpeed);
    AddChild(&m_AttackSpeed);
    AddChild(&m_CastSpeed);

    AddChild(&m_CoolDef);
    AddChild(&m_LightDef);
    AddChild(&m_EarthDef);
    AddChild(&m_FireDef);
    AddChild(&m_Level);
    AddChild(&m_StatusDesc);
    AddChild(&m_PKValue);
    AddChild(&m_Repute);
    AddChild(&m_WorldRank);
    AddChild(&m_Close);

    Wnd_AddWindow(this);

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
}

void KUiStatus::SwitchExpand(BOOL bShow) {
    m_EquipExpandBtn.CheckButton(FALSE);
    m_MaskFeature.Hide();
    m_EquipExpandImg.Hide();
    m_EquipSkin.Hide();
}

//--------------------------------------------------------------------------
//	���ܣ����봰�ڵĽ��淽��
//--------------------------------------------------------------------------
void KUiStatus::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
        if (Ini.Load(Buff))
            m_pSelf->LoadScheme(&Ini);
    }
}

//������淽��
void KUiStatus::LoadScheme(class KIniFile *pIni) {
    Init(pIni, "Main");
    m_StatusPageMain.Init(pIni, "StatusPage_Main");
    m_NormalStatusBg.Init(pIni, "ImgNormalStatusBG");
    m_StatusTab.Init(pIni, "StatusBtn");
    m_NormalStatusBtn.Init(pIni, "BtnNormalStatus");
    m_JEvilStatusBtn.Init(pIni, "BtnJEvilStatus");
    m_Close.Init(pIni, "CloseBtn");

    m_Avt.Init(pIni, "StatusPage_Face");
    m_Name.Init(pIni, "StatusPage_Name");
    m_StatusDesc.Init(pIni, "StatusPage_Career");
    m_Level.Init(pIni, "StatusPage_Level");
    m_WorldRank.Init(pIni, "StatusPage_Rank");
    m_PKValue.Init(pIni, "StatusPage_PK");
    m_Experience.Init(pIni, "StatusPage_Exp");
    m_Repute.Init(pIni, "StatusPage_Credit");
    m_RemainPoint.Init(pIni, "StatusPage_ShituPoint");

    m_LeftDamage.Init(pIni, "StatusPage_Damage");
    m_RightDamage.Init(pIni, "StatusPage_DamageRight");
    m_Attack.Init(pIni, "StatusPage_Accuracy");
    m_Defence.Init(pIni, "StatusPage_Defence");
    m_AttackSpeed.Init(pIni, "StatusPage_WeaponSpeed");
    m_CastSpeed.Init(pIni, "StatusPage_MagicSpeed");
    m_CoolDef.Init(pIni, "StatusPage_IceDef");
    m_LightDef.Init(pIni, "StatusPage_LightingDef");
    m_EarthDef.Init(pIni, "StatusPage_EarthDef");
    m_FireDef.Init(pIni, "StatusPage_FireDef");
    m_Strength.Init(pIni, "StatusPage_Strength");
    m_Dexterity.Init(pIni, "StatusPage_Dexterity");
    m_Vitality.Init(pIni, "StatusPage_Constitution");
    m_Energy.Init(pIni, "StatusPage_Intelligence");

    int nPageLeft = 0;
    int nPageTop = 0;
    m_StatusPageMain.GetPosition(&nPageLeft, &nPageTop);
    OffsetStatusPageControl(&m_NormalStatusBg, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_NormalStatusBtn, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_JEvilStatusBtn, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Avt, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Name, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_StatusDesc, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Level, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_WorldRank, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_PKValue, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Experience, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Repute, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_RemainPoint, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_LeftDamage, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_RightDamage, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Attack, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Defence, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_AttackSpeed, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_CastSpeed, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_CoolDef, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_LightDef, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_EarthDef, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_FireDef, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Strength, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Dexterity, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Vitality, nPageLeft, nPageTop);
    OffsetStatusPageControl(&m_Energy, nPageLeft, nPageTop);

    m_NormalStatusBtn.CheckButton(TRUE);
    m_JEvilStatusBtn.CheckButton(FALSE);
}

//--------------------------------------------------------------------------
//	���ܣ����ں���
//--------------------------------------------------------------------------
int KUiStatus::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_Close /*&& !g_UiBase.GetStatus()*/) //Fix close status
            {
                CloseWindow(false);
                //g_DebugLog("CloseWindow(false);");
            } else if (uParam == (unsigned int) (KWndWindow *) &m_NormalStatusBtn ||
                       uParam == (unsigned int) (KWndWindow *) &m_JEvilStatusBtn) {
                // The current CoreShell exposes the human-realm status data.
                // Keep that complete VNG page selected until the J/Evil data
                // contract is ported instead of showing an empty page.
                m_NormalStatusBtn.CheckButton(TRUE);
                m_JEvilStatusBtn.CheckButton(FALSE);
            } else if (uParam == (unsigned int) (KWndWindow *) &m_OpenItemPad)
                KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_ITEMS);

            else if (uParam == (unsigned int) (KWndWindow *) &m_BtnBind && g_pCoreShell->GetTradeState() == 0) {

                if (g_UiBase.GetStatus() != UIS_S_LOCK_ITEM)
                    g_UiBase.SetStatus(UIS_S_LOCK_ITEM);
                else
                    g_UiBase.SetStatus(UIS_S_IDLE);

                if (!KUiItem::GetIfVisible())
                    KUiItem::OpenWindow();

            } else if (uParam == (unsigned int) (KWndWindow *) &m_BtnUnBind && g_pCoreShell->GetTradeState() == 0) {
                if (g_UiBase.GetStatus() != UIS_S_UNLOCK_ITEM)
                    g_UiBase.SetStatus(UIS_S_UNLOCK_ITEM);
                else
                    g_UiBase.SetStatus(UIS_S_IDLE);

                if (!KUiItem::GetIfVisible())
                    KUiItem::OpenWindow();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_EquipExpandBtn)
                SwitchExpand(m_EquipExpandBtn.IsButtonChecked());
            else if (uParam == (unsigned int) (KWndWindow *) &m_MaskFeature)
                g_pCoreShell->OperationRequest(GOI_MASKFEATURE, 0, 0);
            else if (uParam == (unsigned int) (KWndWindow *) &m_UnlockBtn) {
                if (g_pCoreShell->GetLockState())
                    KUiGetString::OpenWindow(GSA_PW, "Nh�p m�t kh�u", "", this, 0, 0, 1, 16);
                else
                    g_pCoreShell->OperationRequest(GOI_LOCKSTATE, 0, 0);
            } else if (m_nRemainPoint > 0) {
                if (uParam == (unsigned int) (KWndWindow *) &m_AddStrength) {
                    if (GetKeyState(VK_CONTROL) & 0x8000)
                        KUiGetString::OpenWindow(GSA_NORMAL, "Nh�p S� �i�m", "", this, UIITEM_WAIT_GETSTR,
                                                 m_nRemainPoint);
                    else
                        UseRemainPoint(0, 1);
                } else if (uParam == (unsigned int) (KWndWindow *) &m_AddDexterity) {
                    if (GetKeyState(VK_CONTROL) & 0x8000)
                        KUiGetString::OpenWindow(GSA_NORMAL, "Nh�p S� �i�m", "", this, UIITEM_WAIT_GETDEX,
                                                 m_nRemainPoint);
                    else
                        UseRemainPoint(1, 1);
                } else if (uParam == (unsigned int) (KWndWindow *) &m_AddVitality) {
                    if (GetKeyState(VK_CONTROL) & 0x8000)
                        KUiGetString::OpenWindow(GSA_NORMAL, "Nh�p S� �i�m", "", this, UIITEM_WAIT_GETVIT,
                                                 m_nRemainPoint);
                    else
                        UseRemainPoint(2, 1);
                } else if (uParam == (unsigned int) (KWndWindow *) &m_AddEnergy) {
                    if (GetKeyState(VK_CONTROL) & 0x8000)
                        KUiGetString::OpenWindow(GSA_NORMAL, "Nh�p S� �i�m", "", this, UIITEM_WAIT_GETENE,
                                                 m_nRemainPoint);
                    else
                        UseRemainPoint(3, 1);
                }
            }
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM) || g_UiBase.GetStatus() == UIS_S_TRADE_REPAIR ||
                g_UiBase.IsOperationEnable(UIS_O_LOCK_ITEM) || g_UiBase.IsOperationEnable(UIS_O_UNLOCK_ITEM))
                OnEquiptChanged((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            if (nParam) {
                if (uParam == UIITEM_WAIT_GETSTR)
                    UseRemainPoint(0, nParam);
                else if (uParam == UIITEM_WAIT_GETDEX)
                    UseRemainPoint(1, nParam);
                else if (uParam == UIITEM_WAIT_GETVIT)
                    UseRemainPoint(2, nParam);
                else if (uParam == UIITEM_WAIT_GETENE)
                    UseRemainPoint(3, nParam);
            }
            break;
        default:
            nRet = KWndShowAnimate::WndProc(uMsg, uParam, nParam);
    }
    return nRet;
}


//--------------------------------------------------------------------------
//	���ܣ�����ĳ������
//--------------------------------------------------------------------------
void KUiStatus::UseRemainPoint(int ntype, int nPoint) {
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_TONE_UP_ATTRIBUTE, ntype, nPoint);
    m_nRemainPoint -= nPoint;
    m_AddStrength.Enable(m_nRemainPoint > 0);
    m_AddDexterity.Enable(m_nRemainPoint > 0);
    m_AddVitality.Enable(m_nRemainPoint > 0);
    m_AddEnergy.Enable(m_nRemainPoint > 0);
}

//--------------------------------------------------------------------------
//	���ܣ����»������ݣ������Ȳ��ױ����ݣ�
//--------------------------------------------------------------------------
void KUiStatus::UpdateBaseData() {
    KUiPlayerBaseInfo Info;
    memset(&Info, 0, sizeof(KUiPlayerBaseInfo));
    g_pCoreShell->GetGameData(GDI_PLAYER_BASE_INFO, (int) &Info, 0);
    m_Name.SetText(Info.Name);
    m_StatusDesc.SetText(Info.StatusDesc);
    m_PKValue.SetIntText(Info.nPKValue);
    m_Repute.SetIntText(Info.nRepute);
    m_WorldRank.Set5IntText(Info.nRankInWorld);
}

void KUiStatus::Breathe() {
    if (g_pCoreShell == NULL)
        return;

    // F3 can be opened while the map/character snapshot is still arriving.
    // Refresh through the existing CoreShell ABI so the official VNG fields
    // are populated as soon as the player data becomes available.
    static DWORD s_dwLastStatusRefresh = 0;
    DWORD dwNow = GetTickCount();
    if (dwNow - s_dwLastStatusRefresh >= 250) {
        s_dwLastStatusRefresh = dwNow;

        UpdateBaseData();

        KUiPlayerRuntimeInfo RuntimeInfo;
        memset(&RuntimeInfo, 0, sizeof(RuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO,
                                  (unsigned int) &RuntimeInfo, 0);
        UpdateRuntimeInfo(&RuntimeInfo);

        KUiPlayerAttribute RuntimeAttribute;
        memset(&RuntimeAttribute, 0, sizeof(RuntimeAttribute));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_ATTRIBUTE,
                                  (unsigned int) &RuntimeAttribute, 0);
        UpdateRuntimeAttribute(&RuntimeAttribute);
    }

    nNumIcon = g_pCoreShell->GetGameData(GDI_IS_CHECK_IMAGE, 0, 0);
    int nFaceVariant = nNumIcon > 0 ? (nNumIcon - 1) % 3 : 0;
    int nPortrait = nFaceVariant * 2 +
                    (g_pCoreShell->GetGameData(GDI_PLAYER_IS_MALE, 0, 0) ? 1 : 2);
    char szPortrait[128];
    // GBK bytes D0 A4 CF F1 are the VNG resource directory "portrait".
    sprintf(szPortrait, "\\Spr\\Ui4\\\xD0\xA4\xCF\xF1\\%03d.spr", nPortrait);
    m_Avt.SetImage(ISI_T_SPR, szPortrait, true);
}

void KUiStatus::UpdateRuntimeInfo(KUiPlayerRuntimeInfo *pInfo) {
    if (pInfo) {
        m_Life.Set2IntText(pInfo->nLife, pInfo->nLifeFull, '/');
        m_Mana.Set2IntText(pInfo->nMana, pInfo->nManaFull, '/');
        m_Stamina.Set2IntText(pInfo->nStamina, pInfo->nStaminaFull, '/');
        m_Experience.Set2IntText(pInfo->nExperience, pInfo->nExperienceFull, '/');
    }
    m_UnlockBtn.CheckButton(g_pCoreShell->GetLockState());
}

//--------------------------------------------------------------------------
//	���ܣ���������
//--------------------------------------------------------------------------
void KUiStatus::UpdateData() {
    UpdateBaseData();

    // Opening F3 may happen before the next runtime notification. Pull the
    // current values through the existing CoreShell contract so all character
    // fields are populated immediately; this does not change the protocol.
    KUiPlayerRuntimeInfo RuntimeInfo;
    memset(&RuntimeInfo, 0, sizeof(RuntimeInfo));
    g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO,
                              (unsigned int) &RuntimeInfo, 0);
    UpdateRuntimeInfo(&RuntimeInfo);

    KUiPlayerAttribute RuntimeAttribute;
    memset(&RuntimeAttribute, 0, sizeof(RuntimeAttribute));
    g_pCoreShell->GetGameData(GDI_PLAYER_RT_ATTRIBUTE,
                              (unsigned int) &RuntimeAttribute, 0);
    UpdateRuntimeAttribute(&RuntimeAttribute);

    // Keep live values above the official Phong Than status-page artwork.
    m_Name.BringToTop();
    m_Experience.BringToTop();
    m_RemainPoint.BringToTop();
    m_Strength.BringToTop();
    m_Dexterity.BringToTop();
    m_Vitality.BringToTop();
    m_Energy.BringToTop();
    m_LeftDamage.BringToTop();
    m_RightDamage.BringToTop();
    m_Attack.BringToTop();
    m_Defence.BringToTop();
    m_AttackSpeed.BringToTop();
    m_CastSpeed.BringToTop();
    m_CoolDef.BringToTop();
    m_LightDef.BringToTop();
    m_EarthDef.BringToTop();
    m_FireDef.BringToTop();
    m_Level.BringToTop();
    m_StatusDesc.BringToTop();
    m_PKValue.BringToTop();
    m_Repute.BringToTop();
    m_WorldRank.BringToTop();

    Breathe();
}

void KUiStatus::UpdateAllEquips() {
    KUiObjAtRegion Equips[_ITEM_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_EQUIPMENT, (unsigned int) &Equips, 0);
    int i;
    for (i = 0; i < _ITEM_COUNT; i++)
        m_EquipBox[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Equips[i].Obj.uGenre != CGOG_NOTHING)
            UpdateEquip(&Equips[i], true);
    }
}

// TamLTM Khung f3 player, cap nhat tinh nang f3.
//(KUiPlayerAttribute* pInfo)->Core->src ->Truyen gia tri GameDataDef.h -> bien' gia tri dc luu tai day
void KUiStatus::UpdateRuntimeAttribute(KUiPlayerAttribute *pInfo) {
    if (pInfo && g_pCoreShell) {
        m_nRemainPoint = pInfo->nBARemainPoint;
        m_AddStrength.Enable(m_nRemainPoint);
        m_AddDexterity.Enable(m_nRemainPoint);
        m_AddVitality.Enable(m_nRemainPoint);
        m_AddEnergy.Enable(m_nRemainPoint);
        m_RemainPoint.SetIntText(pInfo->nBARemainPoint);
        m_Strength.SetIntText(pInfo->nStrength);
        m_Dexterity.SetIntText(pInfo->nDexterity);
        m_Vitality.SetIntText(pInfo->nVitality);
        m_Energy.SetIntText(pInfo->nEnergy);

        m_LeftDamage.Set2IntText2(pInfo->nKillMIN, pInfo->nKillMAX, '-', '/');
        m_RightDamage.Set2IntText2(pInfo->nRightKillMin, pInfo->nRightKillMax, '-', '/');
        m_Attack.Set2IntText2(pInfo->nLeftAttack, pInfo->nRightAttack, '-', '/');
        m_Defence.SetIntText(pInfo->nDefence);
        m_MoveSpeed.SetIntText(pInfo->nMoveSpeed);
        m_AttackSpeed.SetIntText(pInfo->nAttackSpeed);
        m_CastSpeed.SetIntText(pInfo->nCastSpeed);

        /*	// TamLTM Fix hien thi thong tin khang damage
            // 1 Phong thu vat ly
            if (pInfo->nPhyDef > BASE_PHYSICS_RESIST_MAX)
            {
                m_PhyDef.Set6IntText(BASE_PHYSICS_RESIST_MAX, '%');
            }
            else
            {
                m_PhyDef.Set6IntText(pInfo->nPhyDef, '%');
            }
            // 2 Khang bang
            if (pInfo->nCoolDef > BASE_COLD_RESIST_MAX)
            {
                m_CoolDef.Set6IntText(BASE_COLD_RESIST_MAX, '%');
            }
            else
            {
                m_CoolDef.Set6IntText(pInfo->nCoolDef, '%');
            }
            // 3 Khang loi
            if (pInfo->nLightDef > BASE_LIGHT_RESIST_MAX)
            {
                m_LightDef.Set6IntText(BASE_LIGHT_RESIST_MAX, '%');
            }
            else
            {
                m_LightDef.Set6IntText(pInfo->nLightDef, '%');
            }

            // 4 Khang hoa
            if (pInfo->nFireDef > BASE_FIRE_RESIST_MAX)
            {
                m_FireDef.Set6IntText(BASE_FIRE_RESIST_MAX, '%');
            }
            else
            {
                m_FireDef.Set6IntText(pInfo->nFireDef, '%');
            }

            // 5 Khang doc
            if (pInfo->nPoisonDef > BASE_POISON_RESIST_MAX)
            {
                m_PoisonDef.Set6IntText(BASE_POISON_RESIST_MAX, '%');
            }
            else
            {
                m_PoisonDef.Set6IntText(pInfo->nPoisonDef, '%');
            }
            //end code */

        //TamLTM Fix lai nhu cu
        m_PhyDef.Set6IntText(pInfo->nPhyDef, ' ');
        m_CoolDef.Set6IntText(pInfo->nCoolDef, '%');
        m_LightDef.Set6IntText(pInfo->nLightDef, '%');
        m_EarthDef.Set6IntText(pInfo->nEarthDef, '%');
        m_FireDef.Set6IntText(pInfo->nFireDef, '%');
        // m_PoisonDef.Set6IntText(pInfo->nPoisonDef, '%');
        //end code */

        //	g_DebugLog("pInfo->nPoisonDef %d '%'", pInfo->nPoisonDef);
        //	g_DebugLog("pInfo->nPhyDeff %d '%'", pInfo->nPhyDef);

        // TamLTM 5 loai khang khung f3 cho player nhan vat
        // Gia tri khang vuot nguong~ thi + 1
        if (pInfo->nPhyDefPlus)
            m_PhyDefPlus.SetResistPlus(pInfo->nPhyDefPlus, '+');
        else
            m_PhyDefPlus.Clear();
        if (pInfo->nCoolDefPlus)
            m_CoolDefPlus.SetResistPlus(pInfo->nCoolDefPlus, '+');
        else
            m_CoolDefPlus.Clear();
        if (pInfo->nLightDefPlus)
            m_LightDefPlus.SetResistPlus(pInfo->nLightDefPlus, '+');
        else
            m_LightDefPlus.Clear();
        if (pInfo->nEarthDefPlus)
            m_EarthDefPlus.SetResistPlus(pInfo->nEarthDefPlus, '+');
        else
            m_EarthDefPlus.Clear();
        if (pInfo->nFireDefPlus)
            m_FireDefPlus.SetResistPlus(pInfo->nFireDefPlus, '+');
        else
            m_FireDefPlus.Clear();
        // if (pInfo->nPoisonDefPlus)
        //     m_PoisonDefPlus.SetResistPlus(pInfo->nPoisonDefPlus, '+');
        // else
        //     m_PoisonDefPlus.Clear();

        //	g_DebugLog("pInfo->nPoisonDefPlus %d +", pInfo->nPoisonDefPlus);

        m_Level.SetIntText(pInfo->nLevel);            //�ȼ�
        m_StatusDesc.SetText(pInfo->StatusDesc);

        m_PKValue.SetIntText(pInfo->nPKValue);
        m_Repute.SetIntText(pInfo->nRepute);
        m_FuYuan.SetIntText(pInfo->nFuYuan);
        m_TransLife.Set4IntText(pInfo->nTranslife);
        m_Title.SetText(pInfo->Title);
    }
}

//--------------------------------------------------------------------------
//	���ܣ���Ӧ�����������װ���ĸı�
//--------------------------------------------------------------------------
void KUiStatus::OnEquiptChanged(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Drop, Pick;
    KUiDraggedObject Obj;
    KWndWindow *pWnd = NULL;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        //_ASSERT(pPickPos->pWnd);
        ((KWndObjectBox *) (pPickPos->pWnd))->GetObject(Obj);
        Pick.Obj.uGenre = Obj.uGenre;
        Pick.Obj.uId = Obj.uId;
        Pick.Region.Width = Obj.DataW;
        Pick.Region.Height = Obj.DataH;
        Pick.Region.h = 0;
        Pick.eContainer = UOC_EQUIPTMENT;
        pWnd = pPickPos->pWnd;

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        Wnd_GetDragObj(&Obj);
        Drop.Obj.uGenre = Obj.uGenre;
        Drop.Obj.uId = Obj.uId;
        Drop.Region.Width = Obj.DataW;
        Drop.Region.Height = Obj.DataH;
        Drop.Region.h = 0;
        Drop.eContainer = UOC_EQUIPTMENT;
    }

    for (int i = 0; i < _ITEM_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_EquipBox[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMap[i].nPosition;
            break;
        }
    }
    if (eStatus == UIS_S_TRADE_REPAIR) {
        KUiItemBuySelInfo Price = {0};
        if (g_pCoreShell->IsDamage(Obj.uId)) {
            if (g_pCoreShell->GetGameData(GDI_REPAIR_ITEM_PRICE,
                                          (unsigned int) (&Pick), (int) (&Price))) {
                KUiTradeConfirm::OpenWindow(&Pick, &Price, TCA_REPAIR);
            }
        }
    } else if (eStatus == UIS_S_LOCK_ITEM) {
        g_UiBase.SetStatus(UIS_S_IDLE);
        g_pCoreShell->OperationRequest(GOI_LOCKITEM, (unsigned int) (&Pick), 1);
        return;
    } else if (eStatus == UIS_S_UNLOCK_ITEM) {
        g_UiBase.SetStatus(UIS_S_IDLE);
        g_pCoreShell->OperationRequest(GOI_UNLOCKITEM, (unsigned int) (&Pick), 2);
        return;
    } else {
        //_ASSERT(i < _ITEM_COUNT);
        g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                       pPickPos ? (unsigned int) &Pick : 0,
                                       pDropPos ? (int) &Drop : 0);
    }

}

//--------------------------------------------------------------------------
//	���ܣ�װ���仯����
//--------------------------------------------------------------------------
void KUiStatus::UpdateEquip(KUiObjAtRegion *pEquip, int bAdd) {
    if (pEquip) {
        for (int i = 0; i < _ITEM_COUNT; i++) {
            if (CtrlItemMap[i].nPosition == pEquip->Region.v) {
                //UiSoundPlay(UI_SI_PICKPUT_ITEM);
                if (bAdd)
                    m_EquipBox[i].HoldObject(pEquip->Obj.uGenre, pEquip->Obj.uId,
                                             pEquip->Region.Width, pEquip->Region.Height);
                else
                    m_EquipBox[i].HoldObject(CGOG_NOTHING, 0, 0, 0);
                break;
            }
        }
    }
}
