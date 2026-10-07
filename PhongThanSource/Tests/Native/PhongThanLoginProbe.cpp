#include <windows.h>
#include <initguid.h>
#include "IClient.h"
#include "PhongThanWorldProtocol.h"
#include "PhongThanGameplayProtocol.h"
#include "PhongThanUiProtocol.h"
#include "PhongThanPlayerProtocol.h"
#include "PhongThanCompose.h"
#include <vector>
#include <stdio.h>
#include <string.h>
#include "KCore.h"
#include "CoreShell.h"
#include "../../Sources/GameClient/Login/PhongThanLoginRole.h"

typedef HRESULT (WINAPI *CreateClient)(REFIID, void**);
typedef std::vector<unsigned char> Bytes;
static iCoreShell* s_Core = 0;
static bool s_BagProbe = false;
static void CALLBACK ClientEvent(void* context, const unsigned long& event)
{
	volatile LONG* status = (volatile LONG*)context;
	InterlockedExchange((LONG*)status, event == enumServerConnectCreate ? 1 : -1);
}
class Connection
{
public:
	IClient* Client;
	volatile LONG Connected;
	std::vector<Bytes> Queue;
	Connection() : Client(0), Connected(0) {}
	~Connection() { if (Client) { Client->Shutdown(); Client->Cleanup(); Client->Release(); } }
	bool Open(IClientFactory* factory, unsigned short port)
	{
		if (FAILED(factory->CreateClientInterface(IID_IESClient, (void**)&Client)) || !Client || FAILED(Client->Startup())) return false;
		Client->RegisterMsgFilter((void*)&Connected, ClientEvent);
		const char* address = "127.0.0.1";
		if (FAILED(Client->ConnectTo(address, port))) return false;
		DWORD start = GetTickCount();
		while (!Connected && GetTickCount() - start < 10000) Sleep(10);
		return Connected == 1;
	}
	bool Send(const void* data, size_t size) { return Client && SUCCEEDED(Client->SendPackToServer(data, size)); }
	bool Read(unsigned short type, Bytes& output, DWORD timeout)
	{
		const DWORD start = GetTickCount();
		do {
			for (size_t i = 0; i < Queue.size(); ++i)
			{
				PHONGTHAN_WIRE_HEADER* header = (PHONGTHAN_WIRE_HEADER*)&Queue[i][0];
				if (header->MessageType == type) { output.swap(Queue[i]); Queue.erase(Queue.begin() + i); return true; }
			}
			size_t size = 0;
			const unsigned char* bytes = (const unsigned char*)Client->GetPackFromServer(size);
			if (bytes && size)
			{
				// Login/load stream is expected to contain native packets. Keep exact
				// frame boundaries; encountering a legacy segment reports it explicitly.
				size_t offset = 0;
				while (offset < size)
				{
					if (size - offset < sizeof(PHONGTHAN_WIRE_HEADER) || !PhongThanIsWirePacket(bytes + offset, size - offset))
					{
						int legacySize = s_Core ? s_Core->GetProtocolSize(bytes[offset]) : 0;
						// Service-only probe has no initialized renderer/PAK Core shell.
						// These fixed control messages are interleaved with world login.
						if (legacySize == 0) switch (bytes[offset]) {
						case s2c_pksyncnormalflag: legacySize=sizeof(PK_NORMAL_FLAG_SYNC); break;
						case s2c_pksyncpkvalue: legacySize=sizeof(PK_VALUE_SYNC); break;
						case s2c_changeweather: legacySize=sizeof(SYNC_WEATHER); break;
						case s2c_npcsleepmode: legacySize=sizeof(NPC_SLEEP_SYNC); break;
						case s2c_synctaskvalue: legacySize=sizeof(S2C_SYNCTASKVALUE); break;
						case s2c_teamchangestate: legacySize=sizeof(PLAYER_TEAM_OPEN_CLOSE); break;
						case s2c_playerprofessiondata: legacySize=sizeof(PLAYER_PROFESSION_DATA); break;
						case s2c_playermissiondata: legacySize=sizeof(PLAYER_MISSION_DATA); break;
						case s2c_playersyncleadexp: legacySize=sizeof(PLAYER_LEAD_EXP_SYNC); break;
						case s2c_extpointsync: legacySize=sizeof(EXTPOINT_VALUE_SYNC); break;
						case s2c_syncmasklock: legacySize=sizeof(NPC_MASK_SYNC); break;
						case s2c_replyclientping: legacySize=sizeof(PING_COMMAND); break;
						}
						if (legacySize == -1 && size-offset >= 3) legacySize = 1 + *(const unsigned short*)(bytes+offset+1);
						printf("UNMIGRATED_FRAME byte=%u bytes=%d\n", bytes[offset], legacySize);
						if (legacySize <= 0 || (size_t)legacySize > size-offset) {
							// Bag dialogs/inventory are separate native frames. Ignore an
							// unrelated legacy-only segment, never guess its boundaries.
							if (s_BagProbe) break;
							return false;
						}
						offset += legacySize;
						continue;
					}
					const PHONGTHAN_WIRE_HEADER* header = (const PHONGTHAN_WIRE_HEADER*)(bytes + offset);
					if (!PhongThanValidateWireHeader(header, size-offset)) { printf("INVALID_NATIVE_FRAME\n"); return false; }
					if(header->MessageType!=PHONGTHAN_MSG_WORLD_SELF_VITALS &&
					   header->MessageType!=PHONGTHAN_MSG_WORLD_NPC_UPDATE &&
					   header->MessageType!=PHONGTHAN_MSG_WORLD_ENTITY_POSITION &&
					   header->MessageType!=PHONGTHAN_MSG_WORLD_PLAYER_SNAPSHOT)
						printf("RECV type=0x%04X bytes=%u\n", header->MessageType, header->PacketSize);
					Queue.push_back(Bytes(bytes+offset, bytes+offset+header->PacketSize));
					offset += header->PacketSize;
				}
			}
			if (Connected < 0) return false;
			Sleep(10);
		} while (GetTickCount() - start < timeout);
		printf("TIMEOUT type=0x%04X connected=%ld\n", type, Connected);
		return false;
	}
};
#define REQUIRE(condition, message) do { if (!(condition)) { printf("FAIL %s\n", message); return 1; } } while(0)
static int ProbeStarterBag(Connection& game)
{
	Bytes packet;
	PHONGTHAN_ITEM_SNAPSHOT bag; ZeroMemory(&bag,sizeof(bag));
	std::vector<PHONGTHAN_U32> initialIds;
	for(size_t i=0;i<game.Queue.size();++i){
		if(game.Queue[i].size()==sizeof(PHONGTHAN_ITEM_SNAPSHOT) &&
			((PHONGTHAN_WIRE_HEADER*)&game.Queue[i][0])->MessageType==PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT){
			const PHONGTHAN_ITEM_SNAPSHOT* item=(const PHONGTHAN_ITEM_SNAPSHOT*)&game.Queue[i][0];
			initialIds.push_back(item->ItemId);if(item->Genre==6 && item->DetailType==61000)bag=*item;
		}
	}
	REQUIRE(bag.ItemId && bag.Container==pos_equiproom,"starter bag present in F4 snapshot");
	PHONGTHAN_ITEM_USE_REQUEST use;ZeroMemory(&use,sizeof(use));
	PhongThanInitializeWireHeader(&use.Header,PHONGTHAN_MSG_INVENTORY_USE_REQUEST,sizeof(use),PHONGTHAN_WIRE_FLAG_REQUEST,20);
	use.ItemId=bag.ItemId;use.Container=bag.Container;use.SlotX=bag.SlotX;use.SlotY=bag.SlotY;
	REQUIRE(game.Send(&use,sizeof(use)),"right-click starter bag");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"starter bag categories");
	REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"bag menu validation");
	PHONGTHAN_UI_ACTION_HEADER ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
	REQUIRE(ui.OptionCount==16,"15 groups plus close");
	PHONGTHAN_UI_CHOICE_REQUEST choice;ZeroMemory(&choice,sizeof(choice));
	PhongThanInitializeWireHeader(&choice.Header,PHONGTHAN_MSG_UI_CHOICE_REQUEST,sizeof(choice),PHONGTHAN_WIRE_FLAG_REQUEST,21);
	choice.MapId=ui.MapId;choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=0;
	REQUIRE(game.Send(&choice,sizeof(choice)),"select MagicScript");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"number input prompt");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];REQUIRE(ui.View==PHONGTHAN_VIEW_NUMBER_INPUT&&ui.DialogToken,"native number prompt token");
	PHONGTHAN_UI_NUMBER_REQUEST input;ZeroMemory(&input,sizeof(input));
	PhongThanInitializeWireHeader(&input.Header,PHONGTHAN_MSG_UI_NUMBER_INPUT,sizeof(input),PHONGTHAN_WIRE_FLAG_REQUEST,22);
	input.MapId=ui.MapId;input.DialogToken=ui.DialogToken;input.Value=272;
	REQUIRE(game.Send(&input,sizeof(input)),"submit ID 272");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"preview item before grant");
	REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"preview validation");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];REQUIRE(ui.OptionCount==4,"confirmation choices");
	choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=0;choice.Header.Sequence=23;
	REQUIRE(game.Send(&choice,sizeof(choice)),"confirm one MagicScript item");
	PHONGTHAN_U32 delivered=0;
	for(int attempt=0;attempt<256&&!delivered;attempt++){
		REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,packet,4000),"granted inventory snapshot");
		REQUIRE(PhongThanValidateItemSnapshot(&packet[0],packet.size()),"granted item validation");
		const PHONGTHAN_ITEM_SNAPSHOT* item=(const PHONGTHAN_ITEM_SNAPSHOT*)&packet[0];
		bool old=false;for(size_t k=0;k<initialIds.size();k++)if(initialIds[k]==item->ItemId)old=true;
		if(!old&&item->Genre==6&&item->DetailType==272&&item->Container==pos_equiproom)delivered=item->ItemId;
	}
	REQUIRE(delivered,"new item 272 delivered to F4");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"delivery confirmation");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
	// Repeat the old confirmation packet: consumed token must not grant twice.
	REQUIRE(game.Send(&choice,sizeof(choice)),"replay old token");
	REQUIRE(!game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,800),"replayed confirmation ignored");
	choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=3;choice.Header.Sequence=24;
	REQUIRE(game.Send(&choice,sizeof(choice)),"close bag menu");
	Sleep(500);
	REQUIRE(game.Send(&use,sizeof(use)),"reuse same bag without consumption");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"reopened bag menu");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];REQUIRE(ui.OptionCount==16,"bag remains usable");
	choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=1;
	REQUIRE(game.Send(&choice,sizeof(choice)),"select melee equipment group");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"equipment row input");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];REQUIRE(ui.View==PHONGTHAN_VIEW_NUMBER_INPUT,"equipment input view");
	input.DialogToken=ui.DialogToken;input.Value=60;
	REQUIRE(game.Send(&input,sizeof(input)),"submit equipment STT 60");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"equipment preview");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=0;
	REQUIRE(game.Send(&choice,sizeof(choice)),"confirm equipment");
	REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,packet,5000),"equipment delivered");
	REQUIRE(PhongThanValidateItemSnapshot(&packet[0],packet.size()),"equipment snapshot validity");
	const PHONGTHAN_ITEM_SNAPSHOT* equipment=(const PHONGTHAN_ITEM_SNAPSHOT*)&packet[0];
	REQUIRE(equipment->Genre==0 && equipment->DetailType==0 && equipment->TemplateRow==59 && equipment->Container==pos_equiproom,"exact equipment row delivered to F4");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"equipment confirmation");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=1;
	REQUIRE(game.Send(&choice,sizeof(choice)),"input again");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"invalid-id input prompt");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];input.DialogToken=ui.DialogToken;input.Value=999999;
	REQUIRE(game.Send(&input,sizeof(input)),"submit missing row");
	REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"missing row explained");
	ui=*(PHONGTHAN_UI_ACTION_HEADER*)&packet[0];REQUIRE(ui.OptionCount==16,"missing row returns to group selection");
	choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=-1;
	REQUIRE(game.Send(&choice,sizeof(choice)),"cancel bag");
	printf("PASS STARTER_BAG_LIVE bag_uid=%u granted_magic_id=272 item_uid=%u melee_stt=60 input_preview_grant_replay_reuse_invalid\n",bag.ItemId,delivered);
	fflush(stdout);
	// Keep the test session attached for the controller's acknowledged save.
	if (GetEnvironmentVariableA("PHONGTHAN_BAG_HOLD_FOR_SAVE",NULL,0)) Sleep(30000);
	return 0;
}
#include "ExperienceItem1355Live.inl"
#include "AuthoredNpcLive.inl"
static int Run(IClientFactory* factory, const char* account, const char* proof, bool create, const char* roleName, bool testMovement, int testNpc)
{
	Connection gateway;
	REQUIRE(gateway.Open(factory,5622), "connect gateway");
	PHONGTHAN_SESSION_AUTHENTICATE_REQUEST auth;
	ZeroMemory(&auth,sizeof(auth));
	PhongThanInitializeWireHeader(&auth.Header,PHONGTHAN_MSG_SESSION_AUTHENTICATE,sizeof(auth),PHONGTHAN_WIRE_FLAG_REQUEST,1);
	strncpy((char*)auth.AccountName,account,sizeof(auth.AccountName)-1);
	strncpy((char*)auth.PasswordProof,proof,sizeof(auth.PasswordProof)-1);
	REQUIRE(gateway.Send(&auth,sizeof(auth)), "send auth");
	ZeroMemory(auth.PasswordProof,sizeof(auth.PasswordProof));
	Bytes packet;
	REQUIRE(gateway.Read(PHONGTHAN_MSG_SESSION_AUTHENTICATE,packet,15000), "auth response");
	REQUIRE(packet.size()==sizeof(PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE), "auth size");
	const PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE* result=(const PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE*)&packet[0];
	printf("AUTH_RESULT=%d\n",result->Result);
	REQUIRE(result->Result==0,"credentials/session");
	REQUIRE(gateway.Read(PHONGTHAN_MSG_SESSION_CHARACTER_LIST,packet,15000),"character list");
	REQUIRE(packet.size()==sizeof(PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE),"character list size");
	PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE list=*(const PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE*)&packet[0];
	printf("CHARACTERS=%u\n",list.CharacterCount);
	int selected = -1;
	for (int i = 0; i < list.CharacterCount; ++i)
		if (strcmp((const char*)list.Characters[i].Name, roleName) == 0) selected = i;
	if(selected < 0 && create)
	{
		PHONGTHAN_SESSION_CREATE_CHARACTER_REQUEST request;
		ZeroMemory(&request,sizeof(request));
		PhongThanInitializeWireHeader(&request.Header,PHONGTHAN_MSG_SESSION_CREATE_CHARACTER,sizeof(request),PHONGTHAN_WIRE_FLAG_REQUEST,2);
		strncpy((char*)request.RoleName,roleName,sizeof(request.RoleName)-1); request.Gender=0; request.Profession=0; request.NativePlaceId=testNpc?1052:1001;
		REQUIRE(gateway.Send(&request,sizeof(request)),"create request");
		REQUIRE(gateway.Read(PHONGTHAN_MSG_SESSION_CREATE_CHARACTER,packet,15000),"create response");
		REQUIRE(packet.size()==sizeof(PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE),"create response size");
		int created=((const PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE*)&packet[0])->Result;
		printf("CREATE_RESULT=%d\n",created);REQUIRE(created==0,"create failed");
		strncpy((char*)list.Characters[0].Name,roleName,sizeof(list.Characters[0].Name)-1);list.CharacterCount=1;selected=0;
	}
	REQUIRE(selected >= 0,"native character not found (create explicitly to test)");
	PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST select;
	ZeroMemory(&select,sizeof(select));
	PhongThanInitializeWireHeader(&select.Header,PHONGTHAN_MSG_SESSION_SELECT_CHARACTER,sizeof(select),PHONGTHAN_WIRE_FLAG_REQUEST,3);
	KRoleChiefInfo uiRole;
	REQUIRE(PhongThanReadLoginRole(list.Characters[selected],uiRole),"production UI role decoding");
	strncpy((char*)select.RoleName,uiRole.Name,sizeof(select.RoleName)-1);
	REQUIRE(gateway.Send(&select,sizeof(select)),"select request");
	REQUIRE(gateway.Read(PHONGTHAN_MSG_SESSION_ENTER_WORLD,packet,15000),"world permit");
	REQUIRE(packet.size()==sizeof(PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE),"permit size");
	PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE permit=*(const PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE*)&packet[0];
	printf("PERMIT=%u port=%u\n",permit.Permit,permit.ServerPort);
	REQUIRE(permit.Permit && permit.ServerPort,"world permit denied");
	Connection game;
	REQUIRE(game.Open(factory,permit.ServerPort),"connect world");
	PHONGTHAN_SESSION_ENTER_WORLD_REQUEST enter;
	ZeroMemory(&enter,sizeof(enter));
	PhongThanInitializeWireHeader(&enter.Header,PHONGTHAN_MSG_SESSION_ENTER_WORLD,sizeof(enter),PHONGTHAN_WIRE_FLAG_REQUEST,4);
	memcpy(enter.SessionTicket,permit.SessionTicket,sizeof(enter.SessionTicket));
	strcpy((char*)enter.ClientName,"PhongThanProtocolUAT");
	REQUIRE(game.Send(&enter,sizeof(enter)),"world entry request");
	REQUIRE(game.Read(PHONGTHAN_MSG_WORLD_SELF_SNAPSHOT,packet,15000),"self snapshot");
	REQUIRE(PhongThanValidateSelfSnapshot(&packet[0],packet.size()),"self validation");
	PHONGTHAN_SELF_SNAPSHOT self=*(const PHONGTHAN_SELF_SNAPSHOT*)&packet[0];
	REQUIRE(game.Read(PHONGTHAN_MSG_WORLD_SYNC_COMPLETE,packet,15000),"sync complete");
	REQUIRE(packet.size()==sizeof(PHONGTHAN_WORLD_SYNC_FENCE),"sync fence size");
	PHONGTHAN_WORLD_SYNC_FENCE fence=*(const PHONGTHAN_WORLD_SYNC_FENCE*)&packet[0];
	REQUIRE(memcmp(fence.SessionTicket,permit.SessionTicket,16)==0,"fence ticket");
	fence.Header.Flags=PHONGTHAN_WIRE_FLAG_REQUEST;
	REQUIRE(game.Send(&fence,sizeof(fence)),"sync acknowledgement");
	if (testNpc == 4) return ProbeStarterBag(game);
	if (testNpc == 5) return ProbeExperience1355(game,self);
	if (testNpc == 6) return ProbeAuthoredNpc(game,self);
	REQUIRE(game.Read(PHONGTHAN_MSG_WORLD_SELF_VITALS,packet,10000),"live vitals after acknowledgement");
	REQUIRE(PhongThanValidateSelfVitals(&packet[0],packet.size()),"vitals validation");
	if (testNpc) {
		PHONGTHAN_MOVE_REQUEST walk;
		ZeroMemory(&walk,sizeof(walk));
		PhongThanInitializeWireHeader(&walk.Header,PHONGTHAN_MSG_WORLD_MOVE_REQUEST,sizeof(walk),PHONGTHAN_WIRE_FLAG_REQUEST,6);
		walk.MapId=self.MapId; walk.Mode=PHONGTHAN_MOVE_RUN;
		walk.X=testNpc>=2?49965:50824; walk.Y=testNpc>=2?100773:96855;
		REQUIRE(game.Send(&walk,sizeof(walk)),"walk toward original VNG NPC");
		PHONGTHAN_NPC_SNAPSHOT target;
		ZeroMemory(&target,sizeof(target));
		DWORD until=GetTickCount()+15000;
		while(GetTickCount()<until) {
			if(!game.Read(PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT,packet,3000)) continue;
			REQUIRE(PhongThanValidateNpcSnapshot(&packet[0],packet.size()),"NPC snapshot validation");
			const PHONGTHAN_NPC_SNAPSHOT* npc=(const PHONGTHAN_NPC_SNAPSHOT*)&packet[0];
			if(npc->Kind==3 && npc->TemplateId==(testNpc>=2?206:225)){target=*npc;break;}
		}
		REQUIRE(target.EntityId && target.NameLength,"original Natra NPC received with name");
		PHONGTHAN_ENTITY_REFERENCE interact;
		PhongThanInitializeWireHeader(&interact.Header,PHONGTHAN_MSG_NPC_INTERACT_REQUEST,sizeof(interact),PHONGTHAN_WIRE_FLAG_REQUEST,7);
		interact.MapId=self.MapId; interact.EntityId=target.EntityId;
		until=GetTickCount()+12000;
		bool opened=false;
		while(GetTickCount()<until) {
			REQUIRE(game.Send(&interact,sizeof(interact)),"native NPC interaction");
			if(!game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,1500)) continue;
			if(!PhongThanValidateUiAction(&packet[0],packet.size())) continue;
			const PHONGTHAN_UI_ACTION_HEADER* ui=(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
			if(ui->MapId!=self.MapId || !ui->DialogToken) continue;
			if(testNpc>=2) {
				REQUIRE(ui->ResourceText==1 && ui->OptionCount==3,"Xich Tung Tu numeric VNG prompt and three options");
				int prompt=0;memcpy(&prompt,&packet[sizeof(*ui)+ui->KeySize],sizeof(prompt));
				REQUIRE(prompt==10499,"VNG prompt ID not converted to literal digits");
			}
			PHONGTHAN_UI_CHOICE_REQUEST choice;
			ZeroMemory(&choice,sizeof(choice));
			PhongThanInitializeWireHeader(&choice.Header,PHONGTHAN_MSG_UI_CHOICE_REQUEST,sizeof(choice),PHONGTHAN_WIRE_FLAG_REQUEST,8);
			choice.MapId=ui->MapId;choice.DialogToken=ui->DialogToken;choice.View=ui->View;choice.Selection=0;
			REQUIRE(game.Send(&choice,sizeof(choice)),"NPC dialogue close callback");
			REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,3000),"NPC close callback response");
			REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"NPC close packet validation");
			REQUIRE(((const PHONGTHAN_UI_ACTION_HEADER*)&packet[0])->Operation==PHONGTHAN_SCRIPT_CLOSE,"NPC Lua no() closed the dialogue");
			if(testNpc>=2) {
				REQUIRE(game.Read(PHONGTHAN_MSG_UI_PLAYER_EVENT,packet,3000),"EnchaseItem native panel response");
				REQUIRE(PhongThanValidatePlayerEventPacket(&packet[0],packet.size()),"compose panel packet validation");
				const PHONGTHAN_PLAYER_EVENT* panel=(const PHONGTHAN_PLAYER_EVENT*)&packet[0];
				REQUIRE(panel->Operation==PHONGTHAN_PLAYER_ENCHASE_PANEL && panel->Value==1,"original VNG compose panel selected");
			}
			if(testNpc==3) {
				REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,packet,3000),"fixture material snapshot");
				REQUIRE(packet.size()==sizeof(PHONGTHAN_ITEM_SNAPSHOT),"fixture snapshot size");
				PHONGTHAN_ITEM_SNAPSHOT ingredient=*(const PHONGTHAN_ITEM_SNAPSHOT*)&packet[0];
				REQUIRE(ingredient.Genre==3 && ingredient.DetailType==29 && ingredient.StackCount==2,"fixture is exact VNG recipe 83 input");
				PHONGTHAN_ITEM_MOVE_REQUEST move;
				ZeroMemory(&move,sizeof(move));
				PhongThanInitializeWireHeader(&move.Header,PHONGTHAN_MSG_INVENTORY_MOVE_REQUEST,sizeof(move),PHONGTHAN_WIRE_FLAG_REQUEST,9);
				move.FromContainer=ingredient.Container;move.FromX=ingredient.SlotX;move.FromY=ingredient.SlotY;
				move.ToContainer=ingredient.Container;move.ToX=ingredient.SlotX;move.ToY=ingredient.SlotY;
				REQUIRE(game.Send(&move,sizeof(move)),"pick compose material");
				REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_MOVE,packet,3000),"pick material response");
				move.Header.Sequence=10;move.FromContainer=pos_builditem;move.FromX=0;move.FromY=0;
				move.ToContainer=pos_builditem;move.ToX=0;move.ToY=0;
				REQUIRE(game.Send(&move,sizeof(move)),"drop material into VNG compose slot");
				REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_MOVE,packet,3000),"drop material response");
				PHONGTHAN_COMPOSE_COMMAND compose;
				ZeroMemory(&compose,sizeof(compose));
				PhongThanInitializeWireHeader(&compose.Header,PHONGTHAN_COMPOSE_REQUEST,sizeof(compose),PHONGTHAN_WIRE_FLAG_REQUEST,11);
				compose.MapId=self.MapId;compose.Items[0]=ingredient.ItemId;
				REQUIRE(game.Send(&compose,sizeof(compose)),"submit verified VNG recipe 83");
				REQUIRE(game.Read(PHONGTHAN_COMPOSE_RESPONSE,packet,5000),"compose result");
				REQUIRE(packet.size()==sizeof(PHONGTHAN_COMPOSE_RESULT),"compose result size");
				const PHONGTHAN_COMPOSE_RESULT result=*(const PHONGTHAN_COMPOSE_RESULT*)&packet[0];
				REQUIRE(result.Result==PT_COMPOSE_OK && result.RecipeId==83 && result.OutputDetail==30,"recipe 83 transaction result");
				REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE,packet,3000),"ingredient removal");
				REQUIRE(((const PHONGTHAN_ITEM_REMOVE_MESSAGE*)&packet[0])->ItemId==ingredient.ItemId,"exact ingredient removed");
				bool outputFound=false;
				for(int attempt=0;attempt<4 && !outputFound;++attempt) {
					REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,packet,3000),"compose output snapshot");
					REQUIRE(packet.size()==sizeof(PHONGTHAN_ITEM_SNAPSHOT),"compose output snapshot size");
					const PHONGTHAN_ITEM_SNAPSHOT* output=(const PHONGTHAN_ITEM_SNAPSHOT*)&packet[0];
					outputFound=output->Genre==3 && output->DetailType==30 && output->StackCount==1;
				}
				REQUIRE(outputFound,"exact VNG recipe 83 output");
				printf("PASS VNG_COMPOSE_TRANSACTION recipe=%d input=29x2 output=%d\n",result.RecipeId,result.OutputDetail);
			}
			opened=true; break;
		}
		REQUIRE(opened,"original NPC Lua dialogue response");
		printf("PASS ORIGINAL_NPC_DIALOG map=%u template=%d entity=%u name_bytes=%u\n",self.MapId,target.TemplateId,target.EntityId,target.NameLength);
		return 0;
	}
	if (!testMovement) {
		printf("PASS REAL_NATIVE_LOGIN_UI_ROLE account=%s character=%s map=%u level=%u entity=%u\n",account,select.RoleName,self.MapId,self.Level,self.EntityId);
		return 0;
	}
	PHONGTHAN_MOVE_REQUEST move;
	ZeroMemory(&move,sizeof(move));
	PhongThanInitializeWireHeader(&move.Header,PHONGTHAN_MSG_WORLD_MOVE_REQUEST,sizeof(move),PHONGTHAN_WIRE_FLAG_REQUEST,5);
	move.MapId=self.MapId;
	move.X=49472;
	move.Y=104352;
	move.Mode=PHONGTHAN_MOVE_RUN;
	REQUIRE(game.Send(&move,sizeof(move)),"send native movement");
	REQUIRE(game.Read(PHONGTHAN_MSG_WORLD_ENTITY_MOVE,packet,5000),"native movement response");
	REQUIRE(PhongThanValidateEntityMove(&packet[0],packet.size()),"movement validation");
	const PHONGTHAN_ENTITY_MOVE* moved=(const PHONGTHAN_ENTITY_MOVE*)&packet[0];
	REQUIRE(moved->MapId==self.MapId && moved->EntityId==self.EntityId,"movement identity");
	printf("PASS REAL_NATIVE_LOGIN_MOVE account=%s character=%s map=%u level=%u entity=%u target=%d,%d\n",account,select.RoleName,self.MapId,self.Level,self.EntityId,moved->X,moved->Y);
	Sleep(1000);
	return 0;
}
int main(int argc,char**argv)
{
	if(argc<4){puts("Usage: probe runtime-client-directory account password-md5 [create]");return 2;}
	SetCurrentDirectoryA(argv[1]);
	bool bagProbe = argc > 6 && (strcmp(argv[6],"starterbag") == 0 || strcmp(argv[6],"exp1355") == 0 || strcmp(argv[6],"npc-authored") == 0);
	s_BagProbe = bagProbe;
	HMODULE coreModule = bagProbe ? NULL : LoadLibraryA("CoreClient.dll");
	typedef iCoreShell* (*GetCore)();
	GetCore getCore = coreModule ? (GetCore)GetProcAddress(coreModule,"CoreGetShell") : 0;
	if (getCore) s_Core = getCore();
	// The rebuilt login path is fully native-framed. CoreClient is optional for
	// this service probe and is only needed to size an unexpected legacy frame.
	HMODULE module=LoadLibraryA("Rainbow.dll");REQUIRE(module,"Rainbow load");
	CreateClient create=(CreateClient)GetProcAddress(module,"CreateInterface");REQUIRE(create,"Rainbow factory export");
	IClientFactory* factory=0;REQUIRE(SUCCEEDED(create(IID_IClientFactory,(void**)&factory))&&factory,"factory");
	factory->SetEnvironment(512*1024);
	int npcMode=argc>6 && strcmp(argv[6],"starterbag")==0?4:(argc>6 && strcmp(argv[6],"npc-compose-transaction")==0?3:(argc>6 && strcmp(argv[6],"npc-compose")==0?2:(argc>6 && strcmp(argv[6],"npc-dialog")==0?1:0)));
	if(argc>6 && strcmp(argv[6],"exp1355")==0)npcMode=5;
	if(argc>6 && strcmp(argv[6],"npc-authored")==0)npcMode=6;
	int result=Run(factory,argv[2],argv[3],argc>4 && strcmp(argv[4],"create")==0,argc>5?argv[5]:"PhongThanTest",argc<7 || strcmp(argv[6],"login-only")!=0,npcMode);
	factory->Release();FreeLibrary(module);return result;
}
