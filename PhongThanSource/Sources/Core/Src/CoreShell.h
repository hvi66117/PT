
/*****************************************************************************************
//	������Core�ӿڷ�������
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-9-12
------------------------------------------------------------------------------------------
	��磨�����ϵͳ��ͨ���˽ӿڴ�Core��ȡ��Ϸ�������ݡ�

	��������ӿں���CoreOperationRequest��CoreGetGameData��CoreDrawGameObj��CoreProcessInput
��CoreSetCallDataChangedNofify��
	CoreOperationRequest���ڷ��Ͷ���Ϸ�Ĳ������󡣲���uOperΪ������id����ֵΪ÷������
GAMEOPERATION_INDEX��ȡֵ֮һ������uParam�Լ�nParam�ľ��庬������uOper��ȡֵ���������
����ɹ����Ͳ������󣬺������ط�0ֵ�����򷵻�0ֵ����Щ����Ҫ��Core�������ܣ�Core��
�ͻ�����֤ͨ���˺������͵������ں�������֮����Ȼ��Ч��
	��֪��Ϸ���������ַ�ʽ��һ���ǵ��ýӿں���CoreGetGameData������ȡ������һ����ע��
֪ͨ����������Ϸ���ݱ����ʱ�򣬱�ע���֪ͨ�����ͻᱻ���ã���һ���ڵ���֪ͨ������ͬʱ
���ݸı����Ϸ���ݡ��������ַ�ʽ������������Χ������ͬ��
    �ӿں���CoreGetGameData����uDataId��ʾ��ȡ��Ϸ���ݵ�������������������ֵΪ÷������
GAMEDATA_INDEX��ȡֵ֮һ������uParam��nParam�Լ���������ֵ�ľ��庬������uDataId��ȡֵ
���������
    ע��֪ͨ�����Ľӿڷ���ΪCoreSetCallDataChangedNofify������pNotifyFuncΪ֪ͨ������
ָ�롣����ֵΪ��0ֵ��ʾע��ɹ��������ʾʧ�ܡ��������pNotifyFunc��ֵ��Ϊ0�����Ѿ�ע
���֪ͨ��������ȡ����ͨ��֪ͨ����֪ͨ������Ϸ���ݸı��ʱ�򣬲�һ��ͬʱͨ��֪ͨ����
�������ݸı䡣���ԭ����������ı�����������٣����Է���򵥵�ͨ��֪ͨ�����Ĳ������ݵģ�
����֪ͨ�������ݣ�����ֻ�Ƿ���֪ͨ���ѣ��������͸ı����Ϸ��

	CoreDrawGameObj���ڻ��Ƶ�����Ϸ���󡣲���uObjGenreָ�������������uIdָ�������id��
x��yָ�����Ʒ�Χ�����Ͻ����꣬Width��Heightnָ���˻��Ʒ�Χ�Ĵ�С��Param���ڶ���Ĳ�����
�ݣ��京�彫�����ھ���Ҫ���ƵĶ������͡�
*****************************************************************************************/

#pragma once

//=========================================================
// Core�ⲿ�ͻ���core��ȡ��Ϸ���ݵ�������������������
//=========================================================
//����������������ز���uParam��nParam�����ע����δ�ἰ���򴫵ݶ�ֵ0��
//����ر�ָ������ֵ���壬��ɹ���ȡ���ݷ���1��δ�ɹ�����0��
enum GAMEDATA_INDEX
{
	GDI_GAME_OBJ_DESC = 1,		//��Ϸ��������˵���ı���
	//uParam = (KUiObjAtContRegion*) ������Ϸ����Ľṹ���ݵ�ָ�룬����KUiObjAtContRegion::Region�����ݹ̶�Ϊ0�������塣
	//nParam = (KGameObjDesc*) ��ָ�Ľṹ�ռ����ڱ���ȡ�õ�����˵����

	GDI_GAME_OBJ_DESC_INCLUDE_TRADEINFO,	//��Ϸ��������˵���ı���(�������������Ϣ)
	//��������ͬGDI_GAME_OBJ_DESC

	GDI_GAME_OBJ_DESC_INCLUDE_REPAIRINFO,	//��Ϸ��������˵���ı���(�������������Ϣ)
	//��������ͬGDI_GAME_OBJ_DESC

	GDI_GAME_OBJ_DESC_INCLUDE_MOUSEHOVER,

	GDI_GAME_OBJ_LIGHT_PROP,	//����Ĺ�Դ��������
	//uParam = (KUiGameObject*) ������Ϸ����Ľṹ���ݵ�ָ��
	//nParam = to be def

	GDI_PLAYER_UID,

	GDI_PLAYER_CURCAMP,

	GDI_PLAYER_BASE_INFO,		//���ǵ�һЩ���ױ������
	//uParam = (KUiPlayerBaseInfo*)pInfo

	GDI_PLAYER_RT_INFO,			//���ǵ�һЩ�ױ������
	//uParam = (KUiPlayerRuntimeInfo*)pInfo

	GDI_PLAYER_RT_ATTRIBUTE,	//���ǵ�һЩ�ױ����������
	//uParam = (KUiPlayerAttribute*)pInfo

	GDI_PLAYER_IMMED_ITEMSKILL,	//���ǵ�����ʹ����Ʒ���书
	//uParam = (KUiPlayerImmedItemSkill*)pInfo

	GDI_PLAYER_HOLD_MONEY,		//��������Я����Ǯ
	//nRet = ��������Я����Ǯ

	GDI_PLAYER_IS_MALE,			//�����Ƿ�����
	//nRet = (int)(bool)bMale	�Ƿ�����
	// from now on, flying add this item, get the information whether
	// a player can ride a horse.
	GDI_PLAYER_CAN_RIDE,		//�����Ƿ����������
	//nRet = (int)bCanRide		�Ƿ����
	//0 - ����������Ŷ
	//1 - ����Ŷ

	GDI_ITEM_TAKEN_WITH,		//��������Я������Ʒ��
	//uParam = (KUiObjAtRegion*) pInfo -> KUiObjAtRegion�ṹ�����ָ�룬KUiObjAtRegion
	//				�ṹ���ڴ洢��Ʒ�����ݼ����������λ����Ϣ��
	//nParam = pInfo�����а���KUiObjAtRegion�ṹ����Ŀ
	//Return = �������ֵС�ڵ��ڴ������nParam����ֵ��ʾpInfo�����е�ǰ���ٸ�KUiObjAtRegion
	//			�ṹ���������Ч�����ݣ������ʾ��Ҫ����������ٸ�KUiObjAtRegion�ṹ������
	//			�Ź��洢ȫ��������Я������Ʒ��Ϣ��

	GDI_ITEM_IN_STORE_BOX,		//�����������Ʒ
	//����������ֵ����ͬGDI_ITEM_TAKEN_WITH��
	GDI_ITEM_IN_STORE_BOX1,

	GDI_ITEM_IN_STORE_BOX2,

	GDI_ITEM_IN_STORE_BOX3,

	GDI_ITEM_IN_STORE_BOX4,

	GDI_ITEM_IN_STORE_BOX5,

	GDI_EQUIPMENT,				//����װ����Ʒ
	//uParam = (KUiObjAtRegion*)pInfo -> ����11��Ԫ�ص�KUiObjAtRegion�ṹ����ָ�룬
	//				KUiObjAtRegion�ṹ���ڴ洢װ�������ݺͷ���λ����Ϣ��
	//			KUiObjAtRegion::Region::h = 0
	//			KUiObjAtRegion::Region::v ��ʾ�����ĸ�λ�õ�װ��,��ֵΪ÷������
	//			UI_EQUIPMENT_POSITION��ȡֵ֮һ����ο�UI_EQUIPMENT_POSITION��ע�͡�
	//Return =  ��ֵ��ʾpInfo�����е�ǰ���ٸ�KUiObjAtRegion�ṹ���������Ч�����ݡ�

	GDI_TRADE_NAME,
	GDI_TRADE_NPC_ITEM,			//npc�г������׵���Ʒ
	//uParam = (KUiObjAtContRegion*) pInfo -> KUiObjAtContRegion�ṹ�����ָ�룬KUiObjAtContRegion
	//				�ṹ���ڴ洢��Ʒ�����ݼ����������λ����Ϣ��
	//				����KUiObjAtContRegion::nContainerֵ��ʾ�ڼ�ҳ����Ʒ
	//nParam = pInfo�����а���KUiObjAtContRegion�ṹ����Ŀ
	//Return = �������ֵС�ڵ��ڴ������nParam����ֵ��ʾpInfo�����е�ǰ���ٸ�KUiObjAtContRegion
	//			�ṹ���������Ч�����ݣ������ʾ��Ҫ����������ٸ�KUiObjAtContRegion�ṹ������
	//			�Ź��洢ȫ����npc�г������׵���Ʒ��Ϣ��


	GDI_TRADE_ITEM_PRICE,		//������Ʒ�ļ۸�
	//uParam = (KUiObjAtContRegion*) pItemInfo -> ����ָ�����Ĵ����ĸ���Ʒ
	//nParam = (KUiItemBuySelInfo*) pPriceInfo -> ���ڽ�����Ʒ���ƽ��׼۸����Ϣ
	//Return = (int)(bool) �ɷ���

	GDI_REPAIR_ITEM_PRICE,		//������Ʒ�ļ۸�
	//uParam = (KUiObjAtContRegion*) pItemInfo -> ����ָ�����Ĵ����ĸ���Ʒ
	//nParam = (KUiItemBuySelInfo*) pPriceInfo -> ���ڽ�����Ʒ����������õ���Ϣ
	//Return = (int)(bool) �ɷ�����

	GDI_TRADE_OPER_DATA,		//���ײ�����ص�����
	//uParam = (UI_TRADE_OPER_DATA)eOper ���庬���UI_TRADE_OPER_DATA
	//nParam ����Ӧ���뺬����uParam��ȡֵ״������,��UI_TRADE_OPER_DATA��˵��
	//Return ���庬����uParam��ȡֵ״������,��UI_TRADE_OPER_DATA��˵��

	//uParam = (KUiSkillData*) pSkills -> ����10��KUiSkillData���������ڴ洢��������ܵĵ����ݡ�

	GDI_FIGHT_SKILL_POINT,		//ʣ��ս�����ܵ���
	//Return = ʣ��ս�����ܵ���

	GDI_FIGHT_SKILLS,			//�������յĸ���ս������
	//uParam = (KUiSkillData*) pSkills -> ����50��KUiSkillData���������ڴ洢����ս�������ݡ�

	GDI_CUSTOM_SKILLS,			//���ǵ��Դ��书
	//uParam = (KUiSkillData*) pSkills -> ����5��KUiSkillData���������ڴ洢�����Դ��书�����ݡ�

	GDI_LEFT_ENABLE_SKILLS,		//���������������(������)����
	//uParam = (KUiSkillData*) pSkills -> ����65��KUiSkillData���������ڴ洢�����ܵ����ݡ�
	//								KUiSkillData::nLevel��������������ʾ�ڵڼ���
	//Return = ������Ч���ݵ�Skills����Ŀ

	GDI_RIGHT_ENABLE_SKILLS,	//���������Ҽ��ļ���
	//uParam = (KUiSkillData*) pSkills -> ����65��KUiSkillData���������ڴ洢�����ܵ����ݡ�
	//								KUiSkillData::nLevel��������������ʾ�ڵڼ���
	//Return = ������Ч���ݵ�Skills����Ŀ

	GDI_NEARBY_PLAYER_LIST,		//��ȡ��Χ��ҵ��б�
	//uParam = (KUiPlayerItem*)pList -> ��Ա��Ϣ�б�
	//			KUiPlayerItem::nData = 0
	//nParam = pList�����а���KUiPlayerItem�ṹ����Ŀ
	//Return = �������ֵС�ڵ��ڴ������nParam����ֵ��ʾpList�����е�ǰ���ٸ�KUiPlayerItem
	//			�ṹ���������Ч�����ݣ������ʾ��Ҫ����������ٸ�KUiPlayerItem�ṹ������
	//			�Ź��洢ȫ����Ա��Ϣ��

	GDI_NEARBY_IDLE_PLAYER_LIST,//��ȡ��Χ�µ������������ҵ��б�
	//��������ͬGDI_NEARBY_PLAYER_LIST

	GDI_NEARBY_NOT_FRIEND_LIST,//��ȡ��Χ�Ǻ��ѵ�����б�
	//��������ͬGDI_NEARBY_PLAYER_LIST

	GDI_PLAYER_LEADERSHIP,		//����ͳ˧������ص�����
	//uParam = (KUiPlayerLeaderShip*) -> ����ͳ˧������ص����ݽṹָ��

	GDI_ITEM_IN_ENVIRO_PROP,	//�����Ʒ��ĳ������λ�õ�����״̬
	//uParam = (KUiGameObject*)pObj����nParam==0ʱ����Ʒ����Ϣ
	//uParam = (KUiObjAtContRegion*)pObj����nParam!=0ʱ����Ʒ����Ϣ
	//			��ʱKUiObjAtContRegion::Region�����ݹ̶�Ϊ0�������塣
	//nParam = (int)(bool)bJustTry  �Ƿ�ֻ�ǳ��Է���
	//Return = (ITEM_IN_ENVIRO_PROP)eProp ��Ʒ������״̬

	GDI_PK_SETTING,					//��ȡpk����
	//Return = (int)(bool)bEnable	�Ƿ�����pk

	GDI_SHOW_PLAYERS_NAME,			//��ȡ��ʾ���������
	//Return = (int)(bool)bShow	�Ƿ���ʾ
	GDI_SHOW_PLAYERS_LIFE,			//��ȡ��ʾ���������
	//Return = (int)(bool)bShow	�Ƿ���ʾ

	GDI_PARADE_EQUIPMENT,				//�����װ����Ʒ,��Ϣ����ͬGDI_EQUIPMENT

	GDI_IMMEDIATEITEM_NUM,				//ȡ�ÿ����Ʒ����
	//uParam = nIndex��0��1��2��

	GDI_ITEM_EXPANDITEM,

	GDI_ITEM_GIVE,

	GDI_EXBOX_NUM,

	GDI_EQUIPEX_TIME,

	GDI_ITEM_NAME,

	GDI_ITEM_QUALITY,

	GDI_ITEM_DESC,

	GDI_CHAT_ITEM_IMAGE, //Tam LTM fix post item;

	GDI_GET_ITEM_PARAM,

	GDI_ITEM_CHAT,

	GDI_SHOW_OBJ_NAME,

	GDI_CHANGE_OPTIMAL,

	GDI_TRADE_PLAYER_ITEM,

	GDI_BUILD_ITEM, //TamLTM kham nam xanh

	GDI_COMPOUND,

	GDI_COMPOUND_BOX,

	GDI_LOCKMOVE,

	GDI_NPC_STATE_SKILL,

	GDI_MISSION_SELFDATA,

	GDI_MISSION_RANKDATA,

	GDI_CHATROOM_NAME,

	GDI_IS_CHECK_IMAGE,

	GDI_GET_VERSION_GAME, //TamTLM Get Version game

    GDI_SELL_ITEM, // Get sell item
};

//=========================================================
// Core�ⲿ�ͻ���core��ȡ��Ϸ���ݵ�������������������
//=========================================================
//����������������ز���uParam��nParam�����ע����δ�ἰ���򴫵ݶ�ֵ0��
enum GAMEDATA_CHANGED_NOTIFY_INDEX
{
	GDCNI_HOLD_OBJECT = 1,	//������ĳ������
	//uParam = (KUiGameObject*)pObject -> ������Ϣ�����ȡֵΪ0����ʾ���������õĶ���

	GDCNI_PLAYER_BASE_INFO,	//���ǵ�һЩ���ױ������, see also GDI_PLAYER_BASE_INFO
	GDCNI_PLAYER_RT_ATTRIBUTE,	//���ǵ�һЩ�ױ����������, see also GDI_PLAYER_RT_ATTRIBUTE
	GDCNI_PLAYER_IMMED_ITEMSKILL,//���ǵ�����ʹ����Ʒ���书
	//uParam = (KUiGameObject*)pInfo ��Ʒ�����书������
	//nParam = �ĸ�λ�õ���Ʒ�����书 ��nParam >=0 ʱ�� nParam��ʾ��nParam��������Ʒ
	//			��nParam = -1 ʱ����ʾΪ�����书��-2ʱΪ�����书

	GDCNI_PLAYER_BRIEF_PROP,//������ݵ�λ��һЩ�ؼ�������ı仯
	//uParam = (PLAYER_BRIEF_PROP)eProp �仯�����ȡֵΪö��PLAYER_BRIEF_PROP��ֵ֮һ��
	//nParam = ��������uParam�ľ��庬�����

	GDCNI_OBJECT_CHANGED,		//ĳ����Ʒ���������߼���
	//uParam = (KUiObjAtContRegion*)pInfo -> ��Ʒ���ݼ����������λ����Ϣ
	//          ��pInfo->eContainer == UOC_EQUIPTMENTʱ
	//				KUiObjAtRegion::Region::h ��ʾ���ڵڼ���װ��
	//				KUiObjAtRegion::Region::v ��ʾ�����ĸ�λ�õ�װ��,��ֵΪö������
	//				UI_EQUIPMENT_POSITION��ȡֵ֮һ����ο�UI_EQUIPMENT_POSITION��ע�͡�
	//nParam = bAdd -> 0ֵ��ʾ���������Ʒ����0ֵ��ʾ���������Ʒ

	GDCNI_CONTAINER_OBJECT_CHANGED,	//���������Ķ���ȫ������
	//uParam = (UIOBJECT_CONTAINER)eContainer;	//���λ��

	GDCNI_FIGHT_SKILL_POINT,	//ʣ��ս�����ܵ����仯
	//nParam = �µ�ʣ��ս�����ܵ���

	GDCNI_SKILL_CHANGE,			//��������һ������/��������
	//uParam = (KUiSkillData*)pSkill -> �����յļ���
	//nParam = �¼�����ͬ�?�е�����λ��

	GDCNI_PLAYER_LEADERSHIP,	//����ͳ˧������ص����ݷ����仯

	GDCNI_TEAM,					//������Ϣ�����仯�������ɢ���������������飬�ӳ�Ȩ��ת�����˵ȣ���ע���˵Ķ���ȣ�
	//uParam = (KUiPlayerTeam*)pTeam -> ������Ϣ,����ΪNULL,��ʾ��������˶���

	GDCNI_TEAM_NEARBY_LIST,		//����������б�
	//uParam = (KUiTeamItem*)pList �������Ϣ������
	//nParam = nCount �������Ŀ

	GDCNI_TRADE_START,			//����ҽ��׿�ʼ
	//uParam = (KUiPlayerItem*) pPlayer�Է�����Ϣ

	GDCNI_TRADE_DESIRE_ITEM,	//�Է������뽻�׵���Ʒ
	//uParam = (KUiObjAtRegion*) pObject -> ��Ʒ��Ϣ������������ϢΪ�ڽ��׽����е�����
	//nParam = bAdd -> 0ֵ��ʾ���٣�1ֵ��ʾ����
	//Remark : �����Ʒ�ǽ�Ǯ�Ļ�����KUiObjAtRegion::Obj::uId��ʾ�ѽ�Ǯ�����Ϊ���ֵ����nParam�����塣

	GDCNI_TRADE_OPER_DATA,		//���ײ�����ص�(״̬)���ݷ����仯
	//uParam = (const char*) pInfoText ��ʾ�����֣���"�Է��������"��

	GDCNI_TRADE_END,			//���׽���

	//nParam = (int)(bool)bTraded	�Ƿ�����˽���

	GDCNI_NPC_TRADE,			//��npc���׿�ʼ
	//nParam = (bool)bStart	�Ƿ���Ϊ���׿�ʼ�����ȡֵ�����ʾ���ף��رգ�����

	GDCNI_NPC_TRADE_ITEM,		//npc������Ʒ�ı仯
	//ͨ������iCoreShell::GetGameData,ʹ����uDataIdΪGDI_TRADE_NPC_ITEM������ȡ�µ���Ʒ��Ϣ��

	GDCNI_GAME_START,			//������Ϸ����

	GDCNI_GAME_QUIT,			//�뿪����Ϸ����

	GDCNI_QUESTION_CHOOSE,		//����ѡ��
	//uParam = (KUiQuestionAndAnswer*)pQuestionAndAnswer

	GDCNI_SPEAK_WORDS,			//npc˵������
	//uParam = (KUiInformationParam*) pWordDataList ָ��KUiInformationParam����
	//nParam = pWordDataList����KUiInformationParamԪ�ص���Ŀ

	GDCNI_INFORMATION,			//�µ���Ϣ����������ר�ŵ���Ϣ��
	//uParam = (KUiInformationParam*)pInformation	//��Ϣ����

	GDCNI_MSG_ARRIVAL,			//�£��������ݴ��ڣ���Ϣ����
	//uParam = (cons char*)pMsgBuff ��Ϣ���ݻ�����
	//nParam = (KUiMsgParam*)pMsgParam ��Ϣ����

	GDCNI_SEND_CHAT_CHANNEL,	//��ǰ������Ϣ��Ƶ���ı���

	GDCNI_CHAT_GROUP,			//������ѷ��鷢���仯

	GDCNI_CHAT_FRIEND,			//������ѷ����仯
	//nParam = nGroupIndex �������ѱ仯�ķ��������

	GDCNI_CHAT_FRIEND_STATUS,	//�������״̬�����仯
	//uParam = (KUiPlayerItem*)pFriend ����״̬�仯�ĺ���
	//			KUiPlayerItem::nData = (CHAT_STATUS)eFriendStatus ���ѵĵ�ǰ״̬
	//nParam = nGroupIndex ���������ڵ��������

	GDCNI_CHAT_MESSAGE,			//���з�����ѶϢ
	//uParam = (KUiChatMessage*)pMessage ��Ϣ����
	//nParam = (KUiPlayerItem*)pFriend   ����ѶϢ�ĺ���

	GDCNI_SYSTEM_MESSAGE,		//ϵͳ��Ϣ
	//uParam = (KSystemMessage*)pMsg ϵͳ��Ϣ������
	//nParam = (void*)pParamBuf ָ��һ�����������������������ݺ�������pMsg�����ݶ�����
	//			�ο�KSystemMessage��ע��˵�����������Ĵ�С��pMsg->byParamSize������

	GDCNI_NEWS_MESSAGE,			//������Ϣ
	//uParam = (KNewsMessage*)pMsg ������Ϣ����
	//nParam = (SYSTEMTIME*)pTime  ������Ϣ��ʱ����������庬��������������Ϣ�����Ͷ���
	GDCNI_NEWS_MESSAGE2,

	GDCNI_SWITCH_CURSOR,		//�л����ָ��ͼ��
	//nParam = \Ui\???\���.ini�и�����ͼ��������ֵ

	GDCNI_OPEN_STORE_BOX,		//�򿪴�����

	GDCNI_OPEN_EQUIPEX_BOX,		//�򿪴�����

	GDCNI_SWITCHING_MAPMODE,	//��ͼ�л�

	GDCNI_SWITCHING_SCENEPLACE,	//��ͼ�л�
	//nParam = (int)(bool)bStart Ϊ��0ֵ��ʾ��ʼ��ͼ�л���Ϊ0ֵ��ʾ������ͼ�л�

	GDCNI_MISSION_RECORD,		//Ҫ���¼�´�������ʾ��Ϣ
	//uParam = (KMissionRecord*) pRecord ��¼����

	GDCNI_MISSION_NOTE,

	GDCNI_EXIT_GAME,

	GDCNI_VIEW_PLAYERITEM,			//���������װ���������ѵ�
	//uParam = (KUiPlayerItem*)		//��ҵ� player data

	GDCNII_RANK_INDEX_LIST_ARRIVE,	//������id�б���
	//uParam = uCount ������id����Ŀ
	//nParam = (KRankIndex*)pIndexList ������id�����ṹ������

	GDCNII_RANK_INFORMATION_ARRIVE,	//����������ݵ���
	//uParam = ((unsigned short)usCount) | ((unsigned short)usIndexId << 16)
	//			usCount    �˴δ��������������Ŀ
	//			usIndexId  ������id����ʾ���ص������id�������������
	//nParam = (KRankMessage *) �б�����

	//====�������====
	GDCNI_TONG_INFO,				//ĳ�����ڵİ��ɵ���Ϣ
									//��Ӧ��GTOI_REQUEST_PLAYER_TONG����ѯĳ�����İ�ᣩ
	//uParam = (KUiPlayerRelationWithOther*) �Ǹ���ĳ����,�Լ�������˰��ɵĹ�ϵ
					//KUiPlayerRelationWithOther::nParam �Ƿ��ŵ����˿���
	//nParam = (KTongInfo*) pToneInfo	//���ɵ���Ϣ

	GDCNI_TONG_MEMBER_LIST,			//ĳ�������еĳ�Ա���б�
	//uParam = (KUiGameObjectWithName*) pTong �����������ĸ�����
							//KUiGameObjectWithName::szName ��������
							//KUiGameObjectWithName::nData  pMemberList�������ɳ�Ա�����ͣ��ο�TONG_MEMBER_FIGURE
							//KUiGameObjectWithName::nParam pMemberList�������ɳ�Ա�б������Ա����ʼ������
							//KUiGameObjectWithName::uParam pMemberList�������ɳ�Ա�б������Ա����Ŀ
	//nParam = (KTongMemberItem*) pMemberList

	GDCNI_TONG_ACTION_RESULT,       //���������صĽ��
	//uParam = (KUiGameObjectWithName*) pInfo ���ص�����
	                        //KUiGameObjectWithName::szName ������ҵ�����
							//KUiGameObjectWithName::nData  ���������࣬�ο�TONG_ACTION_TYPE
							//KUiGameObjectWithName::nParam   V
							//KUiGameObjectWithName::uParam   V
							//KUiGameObjectWithName::szString �⼸�������治ͬ������ͬ
	// nParam : �ɹ� 1 ʧ�� 0

	GDCNI_OPEN_TONG_CREATE_SHEET,   //֪ͨ����򿪰�ᴴ������
	//uParam = ~0 ��    0 �ر�

	GDCNI_ITEMEX,

	GDCNI_RANKDATA,

	GDCNI_ENCHASE, // Ep do tim

	GDCNI_INPUT,

	GDCNI_GIVE,

	GDCNI_VIEWTRADE,

	GDCNI_CANCELTRADE,

	GDCNI_SUPERSHOP,

	GDCNI_REQUEST_CHATROOM_LIST,

	GDCNI_REQUEST_MEMBER_LIST,

	GDCNI_REQUEST_BLACK_LIST,

	GDCNI_CHATROOM_UPDATE_INTERFACE,

	GDCNI_CHATROOM_JOIN,

	GDCNI_CHATROOM_LEAVE,

	//TamLTM da tau
	GDCNI_FINISH_QUEST, // hoan thanh da tau

	GDCNI_OPEN_TREMBLE, //TamLTM kham nam
	//end code

	GDCNI_PROGRESS_BAR, // TamLTM Progress bar

	// Phong Than: append-only UI notifications; existing ordinals stay fixed.
	GDCNI_CLOSE_DIALOG,
	GDCNI_TOP_MESSAGE,
};

enum GAMEDEBUGCONTROL
{
	DEBUG_SHOWINFO = 1,
	DEBUG_SHOWOBSTACLE,
};

//=========================================================
// Core�ⲿ�ͻ���core�Ĳ����������������
//=========================================================
enum GAMEOPERATION_INDEX
{
	GOI_EXIT_GAME = 1,		//�뿪��Ϸ
	//uParam = bIpSpotExit

	GOI_SWITCH_OBJECT_QUERY,		//����
	//uParam = (KUiObjAtContRegion*)pObject1 -> �������Ʒ����ǰ����Ϣ
	//���������Ķ�������uParam = 0
	//nParam = (KUiObjAtContRegion*)pObject2 -> ���µ���Ʒ���������Ϣ
	//����޷��µĶ�������nParam = 0
	//nRet = bSwitchable -> �Ƿ�ɽ���

	GOI_SWITCH_OBJECT,		//����
	//uParam = (KUiObjAtContRegion*)pObject1 -> �������Ʒ����ǰ����Ϣ
	//nParam = (KUiObjAtContRegion*)pObject2 -> ���µ���Ʒ���������Ϣ
	//nRet = bSwitched -> �Ƿ񽻻���

	GOI_REJECT_OBJECT,		//������Ʒ
	//uParam = (KUiObjAtContRegion*)pObject -> ����������Ʒ

	GOI_MONEY_INOUT_STORE_BOX,	//��StoreBox��ȡǮ
	//uParam = (unsigned int)bIn Ϊ��0ֵʱ��ʾ���룬�����ʾȡ��
	//nParam = Ǯ������

	GOI_PLAYER_ACTION,		//���ִ��/ȡ��ĳ������
	//uParam = (PLAYER_ACTION_LIST)eAction ������ʶ

	GOI_PLAYER_RENASCENCE,		//�������
	//nParam = (int)(bool)bBackTown �Ƿ�س�

	GOI_INFORMATION_CONFIRM_NOTIFY,	//��Ϣ���ȷ�ϵ�֪ͨ

	GOI_QUESTION_CHOOSE,	//����ѡ���
	//nParma = nAnswerIndex
	GOI_USE_ITEM,

	GOI_SET_IMMDIA_SKILL,	//������������
	//uParam = (KUiGameObject*)pSKill, ������Ϣ
	//nParam = ����λ�ã�0��ʾΪ������ܣ�1��ʾΪ�Ҽ�����

	GOI_TONE_UP_SKILL,		//��ǿһ�ּ��ܣ���һ�μ�һ��
	//uParam = ��������
	//nParam = (uint)����id

	GOI_TONE_UP_ATTRIBUTE,	//��ǿһЩ���Ե�ֵ��һ�μ�һ��
	//uParam = ��ʾҪ��ǿ�����ĸ����ԣ�ȡֵΪUI_PLAYER_ATTRIBUTE��÷��ֵ֮һ

	//============����������ң��������================
	GOI_TRADE_INVITE_RESPONSE,	//��Ӧ/�ܾ���������
	//uParam = (KUiPlayerItem*)pRequestPlayer ������������
	//nParam = (int)(bool)bAccept �Ƿ��������
	GOI_TRADE_FOLKGAME_INVITE_RESPONSE,

	GOI_TRADE_DESIRE_ITEM,		//����һ������������Ʒ
	//uParam = (KUiObjAtRegion*) pObject -> ��Ʒ��Ϣ������������ϢΪ�ڽ��׽����е�����
	//nParam = bAdd -> 0ֵ��ʾ���٣�1ֵ��ʾ����
	//Remark : �����Ʒ�ǽ�Ǯ�Ļ�����KUiObjAtRegion::Obj::uId��ʾ�ѽ�Ǯ�����Ϊ���ֵ����nParam�����塣

	GOI_TRADE_WILLING,			//���޽�������
	//uParam = (const char*)pszTradMsg ���ڽ�����Ϣһ�仰����bWillingΪtrueʱ��Ч
	//nParam = (int)(bool)bWilling �Ƿ��ڴ�����(����)

	GOI_TRADE_LOCK,				//��������
	//nParam = (int)(bool)bLock �Ƿ�����

	GOI_TRADE,					//����
	//nParam = (int)(bool)bTrading
	GOI_TRADE_FOLKGAMEID,					//����

	GOI_TRADE_CANCEL,			//����ȡ��

	GOI_SPAR_INVITE_RESPONSE,	//��Ӧ/�ܾ���������

	//============����npc���������================
	GOI_TRADE_NPC_BUY,			//��npc����Ʒ
	//uParam = (KUiGameObject*)pObj -> ��Ʒ��Ϣ

	GOI_TRADE_NPC_SELL,			//����Ʒ��npc
	//uParam = (KUiObjAtContRegion*)pObj -> ��Ʒ��Ϣ

	GOI_TRADE_NPC_REPAIR,		//������Ʒ
	//uParam = (KUiObjAtContRegion*) pObj -> ��Ҫ����Ʒ����Ϣ

	GOI_TRADE_NPC_CLOSE,		//��������

	GOI_CHAT_FRIEND_ADD,		//������������

	GOI_CHAT_FRIEND_INVITE,		//�Ա���Ҫ���Լ�Ϊ���ѵĻظ�
	//uParam = (KUiPlayerItem*)pRequestPlayer ������������
	//nParam = (int)(bool)bAccept �Ƿ��������

	GOI_OPTION_SETTING,			//ѡ������
	//uParam = (OPTIONS_LIST)eOptionItem Ҫ���õ�ѡ��
	//nParam = (int)nValue ���õ�ֵ���京��������eOptionItem�ĺ���
	//					�ο�OPTIONS_LIST��ֵ��ע��

	GOI_PLAY_SOUND,				//��������
	//uParam = (const char*)pszFileName

	GOI_PK_SETTING,				//����PK
	//nParam = (int)(bool)bEnable	�Ƿ�����pk

	GOI_REVENGE_SOMEONE,		//��ɱĳ��
	//uParam = (KUiPlayerItem*) pTarget	��ɱĿ��
	GOI_SPAR_SOMEONE,		//��ɱĳ��

	GOI_SHOW_PLAYERS_NAME,		//��ʾ���������
	//nParam = (int)(bool)bShow	�Ƿ���ʾ
	GOI_SHOW_PLAYERS_LIFE,		//��ʾ���������

	GOI_GAMESPACE_DISCONNECTED,	//��Ϸ����Ͽ�������

	GOI_VIEW_PLAYERITEM,		//���뿴���װ��
	//uParam = dwNpcID	��ҵ�m_dwID
	GOI_VIEW_PLAYERITEM_END,	//�����װ������

	GOI_FOLLOW_SOMEONE,			//����ĳ��
	//uParam = (KUiPlayerItem*) pTarget	����Ŀ��
	GOI_VIEW_PLAYERSHOP,

	GOI_QUERY_RANK_INFORMATION,  //��ȡ��������
	//uParam = usIndexId �������id
	GOI_INPUT,

	GOI_LOCKSTATE,

	GOI_GIVE,

	GOI_LOCKITEM,

	GOI_UNLOCKITEM,

	GOI_SUPERSHOP,

	GOI_SHOW_OBJ_NAME,

	GOI_PICKUP_OBJ,

	GOI_OPTIMAL,

	GOI_OFFLINE, // TamLTM Uy thac Offline

	GOI_MASKFEATURE,

	GOI_PLAYER_SETPRICE,

	GOI_PLAYER_DOTRADE,

	GOI_PLAYER_RLTRADE,

	GOI_PLAYER_BUYTRADE,

	GOI_LOCKMOVE,

	GOI_UNLOCK,

	GOI_CHATROOM,

	GOI_CP_SET_IMAGE_PLAYER,

	//TamLTM da tau
	GOI_CP_LOAD_SCRIPT, //load script da tau
	//end

	//GOI_PLAYER_ACTIONCHAT, //Ma Doc

	GOI_ADD_UI_CMD_SCRIPT, //TamLTM Kham nam Xanh

	GOI_RECOVERY_BOX_COMMAND, //TamLTM kham nam xanh

	GOI_TOI_UU_IMAGE_COMMAND, // TamLTM Toi Uu hinh anh trong game

	GOI_CP_LOAD_SCRIPT_PROGRESS_BAR, //load script progress bar
};

//=========================================================
// Core�ⲿ�ͻ���core�ĳ�����ͼ��صĲ����������������
//=========================================================
//����������������ز���uParam��nParam�����ע����δ�ἰ���򴫵ݶ�ֵ0��
//����ر�ָ������ֵ���壬��ɹ���ȡ���ݷ���1��δ�ɹ�����0��
enum GAME_SCENE_MAP_OPERATION_INDEX
{
	GSMOI_SCENE_TIME_INFO,			//��ǰ���������ĵ���ʱ�价��
	//uParam = (KUiSceneTimeInfo*)pInfo
	GSMOI_SCENE_TIME_INFO_OFTEN,			//��ǰ���������ĵ���ʱ�价��

	GSMOI_SCENE_MAP_INFO,				//��ǰ���������ĳ����ĵ�ͼ��Ϣ
	//uParam = (KSceneMapInfo*) pInfo ���ڻ�ȡ��Ϣ�Ľṹ��������ָ��
	//Return = (int)(bool)bHaveMap ����ֵ��ʾ��ǰ�����Ƿ���С��ͼ���������0ֵʱ�� pInfo�ڷ��ص�ֵ������

	GSMOI_IS_SCENE_MAP_SHOWING,	//���ó�����С��ͼ�Ƿ���ʾ��״̬
	//uParam = uShowElem,		//��ʾ��Щ���ݣ�ȡֵΪSCENE_PLACE_MAP_ELEMö�ٵ�һ����������ϡ�
				//SCENE_PLACE_MAP_ELEM��GameDataDef.h�ж���
				//���С��ͼ������һЩ���ǻ����
	//nParam = ��16λ��ʾ��ʾ�Ŀ�ȣ���16λ��ʾ��ʾ�ĸ߶ȣ���λ�����ص㣩

	GSMOI_PAINT_SCENE_MAP,		//���Ƴ�����С��ͼ
	//uParam = (int)h ��ʾ������ʼ������Ļ�Ϻ��������꣨��λ�����ص㣩
	//nParam = (int)v ��ʾ������ʼ������Ļ�����������꣨��λ�����ص㣩

	GSMOI_SCENE_MAP_FOCUS_OFFSET,//����С��ͼ�Ľ��㣨/���ģ�
	//uParam = (int)nOffsetH	����С��ͼ�����ˮƽ���꣨��λ���������꣩
	//nParam = (int)nOffsetV	����С��ͼ����Ĵ�ֵ���꣨��λ���������꣩

	GSMOI_SCENE_FOLLOW_WITH_MAP,	//���ó����Ƿ����ŵ�ͼ���ƶ����ƶ�
	//nParam = (int)nbEnable �����Ƿ����ŵ�ͼ���ƶ����ƶ�

	GSMOI_IS_SCENE_DIRECT_MAP,

	GSMOI_IS_SCENE_DO_DIRECT_MAP,
};

//=========================================================
// Core�ⲿ�ͻ���core�İ����صĲ����������������
//=========================================================
//����������������ز���uParam��nParam�����ע����δ�ἰ���򴫵ݶ�ֵ0��
//����ر�ָ������ֵ���壬��ɹ���ȡ���ݷ���1��δ�ɹ�����0��
enum GAME_TONG_OPERATION_INDEX
{
	GTOI_TONG_CREATE,			//�������
	//uParam = (const char*) pszTongName ��������
	//nParam = (NPCCAMP)enFaction �����Ӫ

	GTOI_TONG_FLAG,		//��ѯĳ�˵����˿���
	//uParam = (KUiPlayerItme*) Ҫ��˭
	//Return = (int)(bool)		�Ƿ��ŵ����˿���
	GTOI_TONG_FIGURE,		//��ѯĳ�˵����˿���

	GTOI_TONG_VICEROY,

	GTOI_TONG_RECRUIT,          //���˿���
	//uParam = (int)(bool)bRecruit �Ƿ�Ը������

	GTOI_TONG_ACTION,           //�԰��ڳ�Ա���Ķ��������Լ�����Ĺ�ϵ�ĸı�
	//uParam = (KTongOperationParam*) pOperParam ����ʱ�Ĳ���
	//nParam = (KTongMemberItem*) pMember ָ���˲���������Ա������
	GTOI_TONG_JOIN,       //���������Ĵ�

	GTOI_TONG_JOIN_REPLY,       //���������Ĵ�
	//uPAram = (KUiPlayerItem *) pTarget   ���뷽
	//nParam : !=0ͬ��     ==0�ܾ�

	GTOI_REQUEST_PLAYER_TONG,	//��ѯĳ�����İ��
	//uParam = (KUiPlayerItem*) Ҫ��˭
	//nParam = (int)(bool)bReturnTongDetail �Ƿ�Ҫ�����Ǹ�������Ϣ

	GTOI_REQUEST_TONG_DATA,     //Ҫ��ĳ�����ĸ�������
	//uParam = (KUiGameObjectWithName*)pTong Ҫ��ѯ�İ��
			//KUiGameObjectWithName::szName ��������
			//KUiGameObjectWithName::nData ���ϵ����ֵ࣬ȡ��ö��TONG_MEMBER_FIGURE
			//			�б��������enumTONG_FIGURE_MASTER�Ļ�����Ҫ����ǰ�����Ѷ��
			//KUiGameObjectWithName::nParam ��ʼ������
	GTOI_TONG_MONEY_ACTION,
	GTOI_TONG_CHANGE_CREDIT,
	GTOI_TOTAL_EFF,				// tong cong hien
	GTOI_TONG_PARAM,
};

//=========================================================
// Core�ⲿ�ͻ���core�������صĲ����������������
//=========================================================
//����������������ز���uParam��nParam�����ע����δ�ἰ���򴫵ݶ�ֵ0��
//����ر�ָ������ֵ���壬��ɹ���ȡ���ݷ���1��δ�ɹ�����0��
enum GAME_TEAM_OPERATION_INDEX
{
	//----��ȡ����----
	TEAM_OI_GD_INFO,				//�������ڵĶ�����Ϣ
	//uParam = (KUiPlayerTeam*)pTeam -> ������Ϣ
	//Return = bInTeam, ���Ϊ��0ֵ��ʾ�����ڶ����У�pTeam�ṹ�Ƿ������Ϣ��
	//					���Ϊ0ֵ��ʾ���ǲ��ڶ����У�pTeam�ṹδ�������Ч��Ϣ��

	TEAM_OI_GD_FIGURE,				//�������ڵĶ�����Ϣ

	TEAM_OI_GD_MEMBER_LIST,		//��ȡ�������ڶ����Ա�б�
	//uParam = (KUiPlayerItem*)pList -> ��Ա��Ϣ�б�
	//			KUiPlayerItem::nData = (int)(bool)bCaptain �Ƿ��Ƕӳ�
	//nParam = pList�����а���KUiPlayerItem�ṹ����Ŀ
	//Return = �������ֵС�ڵ��ڴ������nParam����ֵ��ʾpList�����е�ǰ���ٸ�KUiPlayerItem
	//			�ṹ���������Ч�����ݣ������ʾ��Ҫ����������ٸ�KUiPlayerItem�ṹ������
	//			�Ź��洢ȫ���ĳ�Ա��Ϣ��

	TEAM_OI_GD_REFUSE_INVITE_STATUS,//��ȡ�ܾ������״̬
	//Return = (int)(bool)bEnableRefuse Ϊ��ֵ��ʾ�ܾ�״̬��Ч�������ʾ���ܾ���

	//----��������----
	TEAM_OI_COLLECT_NEARBY_LIST,//��ȡ��Χ������б�

	TEAM_OI_APPLY,				//����������˶���
	//uParam = (KUiTeamItem*)	Ҫ�������Ķ������Ϣ

	TEAM_OI_CREATE,				//�������

	TEAM_OI_APPOINT,			//�����ӳ���ֻ�жӳ����ò���Ч��
	//uParam = (KUiPlayerItem*)pPlayer -> �¶ӳ�����Ϣ
	//			KUiPlayerItem::nData = 0

	TEAM_OI_INVITE,			//������˼�����飬ֻ�жӳ����ò���Ч��
	//uParam = (KUiPlayerItem*)pPlayer -> Ҫ������˵���Ϣ
	//			KUiPlayerItem::nData = 0

	TEAM_OI_KICK,				//�߳������һ����Ա��ֻ�жӳ����ò���Ч��
	//uParam = (KUiPlayerItem*)pPlayer -> Ҫ�߳��Ķ�Ա����Ϣ
	//			KUiPlayerItem::nData = 0

	TEAM_OI_LEAVE,				//�뿪����

	TEAM_OI_CLOSE,				//�ر���ӣ�ֻ�жӳ����ò���Ч��
	//nParam = (int)(bool)bClose Ϊ��ֵ��ʾ���ڹر�״̬�������ʾ�����ڹر�״̬
	TEAM_OI_PKFOLLOW,

	TEAM_OI_MODEPICK,

	TEAM_OI_REFUSE_INVITE,		//�ܾ����������Լ��������
	//nParam = (int)(bool)bEnableRefuse Ϊ��ֵ��ʾ�ܾ�״̬��Ч�������ʾ���ܾ���

	TEAM_OI_APPLY_RESPONSE,			//�Ƿ���׼���˼�����飬ֻ�жӳ����ò���Ч��
	//uParam = (KUiPlayerItem*)pPlayer -> Ҫ����׼������Ϣ
	//			KUiPlayerItem::nData = 0
	//nParam = (int)(bool)bApprove -> �Ƿ���׼��

	TEAM_OI_INVITE_RESPONSE,	//���������Ļظ�
	//uParam = (KUiPlayerItem*)pTeamLeader �����������Ķӳ�
	//nParam = (int)(bool)bAccept �Ƿ��������
	TEAM_OI_GETUID,

};


enum GAME_PLAYERAI_OPERATION_INDEX
{
	GPI_SWITCH_ACTIVE,
	GPI_ISACTIVE,
	GPI_PRIORITY_USE_MOUSE,
	GPI_HOLDING_SPACEBAR,
	GPI_FOLLOW_PEOPLE,
	GPI_FOLLOW_PEOPLE_NAME,
	GPI_FOLLOW_PEOPLE_RADIUS,
	GPI_FOLLOW_PEOPLE_RADIUS_IS_CHECK, // them check auto follow radius
	GPI_FIGHTNEAR_CHECK,
	GPI_ATTACK_NPC_CHECK,
	GPI_AUTO_PARTY,
	GPI_AUTO_INVITE,
	GPI_AUTO_INVITE_LIST,
	GPI_SET_INVITE_LIST,
	GPI_AUTO_ACCEPT,
	GPI_AUTO_ACCEPT_WITH_NAME,
	GPI_FIGHT_AUTO,
	GPI_RANGER_AUTO,
	GPI_DISTANCE_AUTO, //TamLTM Distnace
	GPI_FIGHT_USE_SB,
	GPI_SUPPORT_SKILLS,
	GPI_FIGHT_SKILLS,
	GPI_FIGHTBACK,
	GPI_FIGHTBOSS,
	GPI_AURA_SKILLS1,
	GPI_AURA_SKILLS2,
	GPI_OVER_TARGET,
	GPI_FOLLOW_TARGET,
	GPI_QUANH_DIEM_TARGET, //TamLTM Quanh Diem
	GPI_SORT_EQUIPMENT,
	GPI_FILTER_EQUIPMENT,
	GPI_PICK_FIGHTNONE,
	GPI_PICK_MONEY,
	GPI_PICK_NOTEQUIP,
	GPI_PICK_EQUIP,
	GPI_FOLLOW_PICK,
	GPI_PICK_KIND,
	GPI_AUTO_FILTERMAGIC,
	GPI_SAVE_TRASH,
	GPI_SAVE_TRASH_PRICE,
	GPI_SAVE_JEWELRY,
	GPI_EAT_LIFE,
	GPI_EAT_MANA,
	GPI_LIFE_VALUE,
	GPI_LIFE_PERCENT,
	GPI_LIFE_TIME,
	GPI_MANA_VALUE,
	GPI_MANA_PERCENT,
	GPI_MANA_TIME,
	GPI_TP_LIFE,
	GPI_TP_LIFEV,
	GPI_TP_MANA,
	GPI_TP_MANAV,
	GPI_TP_NOT_MEDICINEBLOOD,
	GPI_TP_NOT_MEDICINEMANA,
	GPI_TP_HIGHTMONEY,
	GPI_TP_HIGHTMONEYV,
	GPI_TP_DAMAGEEQUIP,
	GPI_TP_DAMAGEEQUIPV,
	GPI_TP_NOT_EQUIPMENT,
	GPI_TP_NOT_EQUIPMENTV,
	GPI_ANTI_POISON,
	GPI_ENCHASEEXP,
	GPI_LIFEREPLENISH,
	GPI_LIFEREPLENISHP,
	GPI_INVENTORYMONEY,
	GPI_INVENTORYITEM,
    GPI_SELLTRASH,
	GPI_RETURNPORTAL,
	GPI_RETURNPORTALSEC,
	GPI_OPEN_MEDICINE,
	GPI_AUTO_REPAIR,
	GPI_AUTO_MOVEMPS,
	GPI_AUTO_MOVEMPSID,
	GPI_AUTO_MOVEMPSX,
	GPI_AUTO_MOVEMPSY,
	GPI_WITHDRAWA, // rut tien;
	GPI_WITHDRAWA_MONEY, // rut tien;
	GPI_PASSREPOSITORY, // rut tien;
    GPI_OTHER_SELL_TRASH, // rut tien;
    GPI_BAN_RAC,
};
//-------��Ϸ�������ݸı��֪ͨ����ԭ��---------
struct IClientCallback
{
	virtual void CoreDataChanged(unsigned int uDataId, unsigned int uParam, int nParam) = 0;
	virtual void ChannelMessageArrival(DWORD nChannelID, char* szSendName, const char* pMsgBuff, unsigned short nMsgLength = 0, const char* pItem = 0, BYTE btSomeFlag = 0, bool bSucc = false) = 0;
	virtual void MSNMessageArrival(char* szSourceName, char* szSendName, const char* pMsgBuff, unsigned short nMsgLength, const char* pItem = 0, bool bSucc = false) = 0;
	virtual void NotifyChannelID(char* ChannelName, DWORD channelid, BYTE cost) = 0;
	virtual void FriendInvite(char* roleName) = 0;
	virtual void AddFriend(char* roleName, BYTE answer) = 0;
	virtual void DeleteFriend(char* roleName) = 0;
	virtual void FriendStatus(char* roleName, BYTE state) = 0;
	virtual void FriendInfo(char* roleName, char* unitName, char* groupname, BYTE state) = 0;
	virtual void AddPeople(char* unitName, char* roleName) = 0;
};

struct _declspec (novtable) iCoreShell
{
	virtual	int	 GetProtocolSize(BYTE byProtocol) = 0;
	//����Ϸ���Ͳ���
	virtual int	 OperationRequest(unsigned int uOper, unsigned int uParam = 0, int nParam = 0) = 0;
	//���������豸�����������Ϣ
	virtual void ProcessInput(unsigned int uMsg, unsigned int uParam, int nParam) = 0;
	virtual int GetTargetNPC() = 0;
	//��x, y��ָ��Player
	virtual int FindSelectNPC(int x, int y, int nRelation, bool bSelect, void* pReturn, int& nKind, bool bFind = false) = 0;
	//��Nameָ����Player
	virtual int FindSpecialNPC(char* Name, void* pReturn, int& nKind) = 0;
	//��x, y��ָ��Obj
	virtual int FindSelectObject(int x, int y, bool bSelect, int& nObjectIdx, int& nKind) = 0;
	virtual int ChatSpecialPlayer(void* pPlayer, const char* pMsgBuff, unsigned short nMsgLength) = 0;
	virtual void ApplyAddTeam(void* pPlayer) = 0;
	virtual void TradeApplyStart(void* pPlayer, bool bFolkGame = false) = 0;
	virtual void JoinTongReply(void* pPlayer) = 0;
	virtual int UseSkill(int x, int y, int nSkillID) = 0;
	virtual int LockSomeoneUseSkill(int nTargetIndex, int nSkillID) = 0;
	virtual int LockSomeoneAction(int nTargetIndex) = 0;
	virtual int LockObjectAction(int nTargetIndex) = 0;
	virtual void GotoWhere(int x, int y, int mode) = 0;	//mode 0 is auto, 1 is walk, 2 is run
	virtual void GetWhere(int x, int y, void* pInfo) = 0;
	virtual void Goto(int nDir, int mode) = 0;	//nDir 0~63, mode 0 is auto, 1 is walk, 2 is run
	virtual void Turn(int nDir) = 0;	//nDir 0 is left, 1 is right, 2 is back
	virtual int ThrowAwayItem() = 0;
	virtual int GetNPCRelation(int nIndex) = 0;
	virtual BOOL CheckMouse() = 0;




	//===========����Ϸ����ķ������==========
	//���ͼ��صĲ���, uOper��ȡֵ���� GAME_SCENE_MAP_OPERATION_INDEX
	virtual int	SceneMapOperation(unsigned int uOper, unsigned int uParam, int nParam) = 0;
	//������صĲ���, uOper��ȡֵ���� GAME_TONG_OPERATION_INDEX
	virtual int	TongOperation(unsigned int uOper, unsigned int uParam, int nParam) = 0;
	//�������صĲ�����uOper��ȡֵ���� GAME_TEAM_OPERATION_INDEX
	virtual int TeamOperation(unsigned int uOper, unsigned int uParam, int nParam) = 0;

	virtual int	PAIOperation(unsigned int uOper, unsigned int uParam, int nParam, int nParam1) = 0;
	//����Ϸ�����ȡ����
	virtual int	 GetGameData(unsigned int uDataId, unsigned int uParam, int nParam) = 0;

	//������Ϸ����
	virtual void DrawGameObj(unsigned int uObjGenre, unsigned int uId, int x, int y, int Width, int Height, int nParam) = 0;
	//������Ϸ����
	virtual void DrawGameSpace() = 0;
	virtual void DrawGameSpace1() = 0;
	virtual int	 Debug(unsigned int uDataId, unsigned int uParam, int nParam) = 0;

	virtual DWORD GetPing() = 0;
	//virtual void SendPing() = 0;
	//������Ϸ�������ݸı��֪ͨ����
	virtual int	 SetCallDataChangedNofify(IClientCallback* pNotifyFunc) = 0;
	//��������ɴ���������Ϣ
	virtual void NetMsgCallbackFunc(void* pMsgData, unsigned int nMsgSize) = 0;
	//���û�ͼ�ӿ�ʵ����ָ��
	virtual void SetRepresentShell(struct iRepresentShell* pRepresent) = 0;
	virtual void SetMusicInterface(void* pMusicInterface) = 0;
	virtual void SetRepresentAreaSize(int nWidth, int nHeight) = 0;
	//�ճ����core���Ҫ���������򷵻�0�����򷵻ط�0ֵ
	virtual int  Breathe() = 0;
	//�ͷŽӿڶ���
	virtual void Release() = 0;
	virtual void SetClient(LPVOID pClient) = 0;

	virtual void SendNewDataToServer(void* pData, int nLength) = 0;
	virtual void DirectFindPos(unsigned int uParam, int nParam, BOOL bSync, BOOL bPaintLine) = 0;
	virtual	BOOL GetPaintMode() = 0;
	virtual	void SetPaintMode(BOOL nIndex) = 0;
	virtual	BOOL GetFlagMode() = 0;
	virtual	void SetFlagMode(BOOL nIndex) = 0;
	virtual void GetSizeItem(unsigned int uItemId, int *nW, int *nH) = 0;
	virtual int GetExtPoint() = 0;
	virtual int GetItemQuality(unsigned int uItemId, unsigned int uGenre = 0) = 0;
	virtual int GetGenreItem(unsigned int uItemId, unsigned int uGenre = 0) = 0;
	virtual BOOL IsDamage(unsigned int uItemId) = 0;
	virtual	BOOL GetLockState() = 0;
	virtual int GetStackNum(unsigned int uItemId) = 0;
	virtual	BOOL GetSkillData(int nSkillId, int *nLevel) = 0;
	virtual	void GetSkillName(int nSkillId, char* szSkillName) = 0;
	virtual	int GetTradePrice(unsigned int uItemId) = 0;
	virtual	int GetTradeState(int nIndex = 0, int uId = 0) = 0;
	virtual int	GetFightState() = 0;
	virtual void BreakItem(unsigned int uParam, int nParam, BOOL bIsBreakAll) = 0;
	virtual DWORD GetdwIDPlayer(unsigned int uId) = 0;
	virtual int GetOwnValue(int nMoneyUnit) = 0;
	virtual int GetDataSuperShop(int nSaleId, unsigned int uParam, int nParam) = 0;
	virtual int GetDataDynamicShop(int nSaleId, unsigned int uParam, int nParam) = 0;
	virtual int GetNextSkill(int nType, int nIndex) = 0;
//	virtual BOOL IsSkillAura(int nSkillId);

	// TamLTM code kham nam xanh
	virtual int GetDetailItem(unsigned int uId ) = 0;
	virtual int GetParticularItem(unsigned int uId ) = 0;
	virtual int GetLevelItem(unsigned int uId ) = 0;
	virtual int GetSeriesItem(unsigned int uId ) = 0;
	virtual int GetItemColor(unsigned int uItemId);
	// End code

	//TamLTM auto run
	virtual void SetAutoRun(BOOL autoRun) = 0;
	virtual void SetFlagAutoRun(BOOL autoRunFlag, int x, int y) = 0;
	virtual void CheckHoverMouseMiniMap(BOOL hover) = 0;
	//end code
};

#ifndef CORE_EXPORTS

	//��ȡiCoreShell�ӿ�ʵ����ָ��
	extern "C" iCoreShell* CoreGetShell();

#else

	//���ⷢ����Ϸ�������ݷ����ı��֪ͨ
	void	CoreDataChanged(unsigned int uDataId, unsigned int uParam = 0, int nParam = 0);

#endif
