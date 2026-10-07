#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "PhongThanWorldProtocol.h"
#include "PhongThanGameplayProtocol.h"
#include "PhongThanScriptWire.h"
#include "PhongThanObjectProtocol.h"

static int checks = 0;
#define CHECK(test) do { ++checks; if (!(test)) { printf("FAIL line=%d: %s\n", __LINE__, #test); return 1; } } while (0)

// Each short buffer ends immediately before an inaccessible page. Validators
// must reject it before reading even one byte outside the supplied frame.
static int CheckShortBuffers()
{
	SYSTEM_INFO info;
	GetSystemInfo(&info);
	unsigned char* memory = (unsigned char*)VirtualAlloc(0, info.dwPageSize * 2,
		MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
	if (!memory) return 0;
	DWORD oldProtection;
	if (!VirtualProtect(memory + info.dwPageSize, info.dwPageSize, PAGE_NOACCESS, &oldProtection))
	{
		VirtualFree(memory, 0, MEM_RELEASE);
		return 0;
	}
	PHONGTHAN_NPC_SNAPSHOT snapshot;
	ZeroMemory(&snapshot, sizeof(snapshot));
	PhongThanInitializeWireHeader(&snapshot.Header, PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT,
		sizeof(snapshot), PHONGTHAN_WIRE_FLAG_RESPONSE, 5);
	for (unsigned int size = 0; size < sizeof(snapshot); ++size)
	{
		unsigned char* input = memory + info.dwPageSize - size;
		memcpy(input, &snapshot, size);
		if (PhongThanValidateNpcSnapshot(input, size) ||
			PhongThanValidateMoveRequest(input, size) ||
			PhongThanValidateEntityMove(input, size) ||
			PhongThanValidateNpcUpdate(input, size) ||
			PhongThanValidateEntityReference(input, size, PHONGTHAN_MSG_WORLD_ENTITY_REQUEST,
				PHONGTHAN_WIRE_FLAG_REQUEST))
		{
			VirtualFree(memory, 0, MEM_RELEASE);
			return 0;
		}
	}
	VirtualFree(memory, 0, MEM_RELEASE);
	return 1;
}

int main()
{
	CHECK(CheckShortBuffers());
	PHONGTHAN_ATTRIBUTE_REQUEST points;
	ZeroMemory(&points, sizeof(points));
	PhongThanInitializeWireHeader(&points.Header, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_REQUEST,
		sizeof(points), PHONGTHAN_WIRE_FLAG_REQUEST, 1);
	points.MapId = 1118; points.Points = 200; points.Attribute = PhongThanEncodeAttribute(0);
	CHECK(PhongThanValidateAttributeRequest(&points, sizeof(points)));
	CHECK(PhongThanDecodeAttribute(points.Attribute) == 0);
	points.Points = -1;
	CHECK(!PhongThanValidateAttributeRequest(&points, sizeof(points)));
	points.Points = 1; points.Attribute = 3;
	CHECK(!PhongThanValidateAttributeRequest(&points, sizeof(points)));
	PHONGTHAN_SKILL_LEVEL_REQUEST skillPoints;
	ZeroMemory(&skillPoints, sizeof(skillPoints));
	PhongThanInitializeWireHeader(&skillPoints.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_REQUEST,
		sizeof(skillPoints), PHONGTHAN_WIRE_FLAG_REQUEST, 2);
	skillPoints.MapId = 1118; skillPoints.SkillId = 115; skillPoints.Points = 10;
	CHECK(PhongThanValidateSkillLevelRequest(&skillPoints, sizeof(skillPoints)));
	skillPoints.Points = 0;
	CHECK(!PhongThanValidateSkillLevelRequest(&skillPoints, sizeof(skillPoints)));
	PHONGTHAN_ENTITY_POSITION position;
	ZeroMemory(&position, sizeof(position));
	PhongThanInitializeWireHeader(&position.Header, PHONGTHAN_MSG_WORLD_ENTITY_POSITION,
		sizeof(position), PHONGTHAN_WIRE_FLAG_RESPONSE, 3);
	position.MapId = 1118; position.EntityId = 90001; position.X = 10000; position.Y = 20000;
	position.Mode = PHONGTHAN_POSITION_TELEPORT; position.Action = PHONGTHAN_ACTION_STAND;
	CHECK(PhongThanValidateEntityPosition(&position, sizeof(position)));
	position.Mode = PHONGTHAN_POSITION_RECONCILE;
	CHECK(PhongThanValidateEntityPosition(&position, sizeof(position)));
	position.X = -1;
	CHECK(!PhongThanValidateEntityPosition(&position, sizeof(position)));
	PHONGTHAN_ENTITY_STATUS status;
	ZeroMemory(&status, sizeof(status));
	PhongThanInitializeWireHeader(&status.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS,
		sizeof(status), PHONGTHAN_WIRE_FLAG_RESPONSE, 4);
	status.MapId = 1118; status.EntityId = 90001; status.Kind = PHONGTHAN_STATUS_DEATH;
	CHECK(PhongThanValidateEntityStatus(&status, sizeof(status)));
	status.Kind = PHONGTHAN_STATUS_CURRENT_CAMP; status.Value = 8;
	CHECK(PhongThanValidateEntityStatus(&status, sizeof(status)));
	status.Value = 9;
	CHECK(!PhongThanValidateEntityStatus(&status, sizeof(status)));
	status.Kind = PHONGTHAN_STATUS_REVIVE; status.Value = 2;
	CHECK(!PhongThanValidateEntityStatus(&status, sizeof(status)));
	PHONGTHAN_POSE_REQUEST pose;
	ZeroMemory(&pose, sizeof(pose));
	PhongThanInitializeWireHeader(&pose.Header, PHONGTHAN_MSG_WORLD_POSE_REQUEST,
		sizeof(pose), PHONGTHAN_WIRE_FLAG_REQUEST, 5);
	pose.MapId = 1118; pose.Kind = PHONGTHAN_POSE_TOGGLE_MOUNT;
	CHECK(PhongThanValidatePoseRequest(&pose, sizeof(pose)));
	pose.Kind = 100;
	CHECK(!PhongThanValidatePoseRequest(&pose, sizeof(pose)));
	PHONGTHAN_OBJECT_SNAPSHOT object;
	ZeroMemory(&object, sizeof(object));
	PhongThanInitializeWireHeader(&object.Header, PHONGTHAN_MSG_WORLD_OBJECT_SNAPSHOT,
		sizeof(object), PHONGTHAN_WIRE_FLAG_RESPONSE, 6);
	object.MapId = 1118; object.RegionId = 0x01000100; object.ObjectId = 1001; object.TemplateId = 1;
	strcpy(object.Name, "Sword"); object.NameLength = 5;
	CHECK(PhongThanValidateObjectSnapshot(&object, sizeof(object)));
	object.NameLength = 128;
	CHECK(!PhongThanValidateObjectSnapshot(&object, sizeof(object)));
	PHONGTHAN_OBJECT_REFERENCE click;
	ZeroMemory(&click, sizeof(click));
	PhongThanInitializeWireHeader(&click.Header, PHONGTHAN_MSG_WORLD_OBJECT_INTERACT,
		sizeof(click), PHONGTHAN_WIRE_FLAG_REQUEST, 7);
	click.MapId = 1118; click.RegionId = 0x01000100; click.ObjectId = 1001;
	CHECK(PhongThanValidateObjectReference(&click, sizeof(click), PHONGTHAN_MSG_WORLD_OBJECT_INTERACT));
	click.MapId = 0;
	CHECK(!PhongThanValidateObjectReference(&click, sizeof(click), PHONGTHAN_MSG_WORLD_OBJECT_INTERACT));
	KPhongThanScriptAction action;
	ZeroMemory(&action, sizeof(action));
	action.Operation = PHONGTHAN_SCRIPT_SHOW;
	action.View = UI_SELECTDIALOG;
	action.OptionCount = 2;
	action.ServerOwned = 1;
	action.MapId = 1001;
	action.DialogToken = 42;
	strcpy(action.Content, "Choose|Map|Exit");
	action.ContentLength = strlen(action.Content);
	unsigned char uiPacket[5000];
	unsigned int uiSize = PhongThanBuildScriptPacket(action, uiPacket, sizeof(uiPacket));
	CHECK(uiSize == sizeof(PHONGTHAN_UI_ACTION_HEADER) + action.ContentLength);
	CHECK(PhongThanValidateUiAction(uiPacket, uiSize));
	KPhongThanScriptAction decoded;
	CHECK(PhongThanReadScriptPacket(uiPacket, uiSize, &decoded));
	CHECK(decoded.DialogToken == 42 && decoded.View == UI_SELECTDIALOG &&
		decoded.Operation == PHONGTHAN_SCRIPT_SHOW && decoded.OptionCount == 2 &&
		strcmp(decoded.Content, action.Content) == 0);
	CHECK(!PhongThanReadScriptPacket(uiPacket, uiSize - 1, &decoded));
	CHECK(!PhongThanValidateUiAction(uiPacket, uiSize + 1));
	PHONGTHAN_UI_ACTION_HEADER* uiHeader = (PHONGTHAN_UI_ACTION_HEADER*)uiPacket;
	uiHeader->KeySize = 260;
	CHECK(!PhongThanValidateUiAction(uiPacket, uiSize));
	action.OptionCount = 21;
	CHECK(!PhongThanBuildScriptPacket(action, uiPacket, sizeof(uiPacket)));
	action.OptionCount = 2; action.DialogToken = 0;
	CHECK(!PhongThanBuildScriptPacket(action, uiPacket, sizeof(uiPacket)));
	PHONGTHAN_UI_CHOICE_REQUEST choice;
	ZeroMemory(&choice, sizeof(choice));
	PhongThanInitializeWireHeader(&choice.Header, PHONGTHAN_MSG_UI_CHOICE_REQUEST,
		sizeof(choice), PHONGTHAN_WIRE_FLAG_REQUEST, 16);
	choice.MapId = 1001; choice.DialogToken = 42; choice.View = PHONGTHAN_VIEW_QUESTION; choice.Selection = 1;
	CHECK(PhongThanValidateUiChoice(&choice, sizeof(choice)));
	CHECK(PhongThanUiChoiceMatches(choice, 1001, 42, PHONGTHAN_VIEW_QUESTION, 2));
	CHECK(!PhongThanUiChoiceMatches(choice, 1001, 0, PHONGTHAN_VIEW_QUESTION, 2));
	CHECK(!PhongThanUiChoiceMatches(choice, 1001, 43, PHONGTHAN_VIEW_QUESTION, 2));
	CHECK(!PhongThanUiChoiceMatches(choice, 1002, 42, PHONGTHAN_VIEW_QUESTION, 2));
	CHECK(!PhongThanUiChoiceMatches(choice, 1001, 42, PHONGTHAN_VIEW_CONVERSATION, 2));
	choice.Selection = 2;
	CHECK(!PhongThanUiChoiceMatches(choice, 1001, 42, PHONGTHAN_VIEW_QUESTION, 2));
	choice.Selection = -1;
	CHECK(PhongThanValidateUiChoice(&choice, sizeof(choice)));
	CHECK(PhongThanUiChoiceMatches(choice, 1001, 42, PHONGTHAN_VIEW_QUESTION, 0));
	choice.Selection = -2;
	CHECK(!PhongThanValidateUiChoice(&choice, sizeof(choice)));
	PHONGTHAN_SELF_SNAPSHOT self;
	ZeroMemory(&self, sizeof(self));
	PhongThanInitializeWireHeader(&self.Header, PHONGTHAN_MSG_WORLD_SELF_SNAPSHOT,
		sizeof(self), PHONGTHAN_WIRE_FLAG_RESPONSE, 16);
	self.MapId = 1118; self.EntityId = 91000; self.PlayerId = 700; self.Level = 200; self.Power = 70000;
	CHECK(PhongThanValidateSelfSnapshot(&self, sizeof(self)));
	CHECK(self.Power == 70000 && self.Level == 200);
	self.Gender = PHONGTHAN_GENDER_COUNT;
	CHECK(!PhongThanValidateSelfSnapshot(&self, sizeof(self)));
	unsigned char skillsPacket[sizeof(PHONGTHAN_SKILL_LIST_HEADER) + 2 * sizeof(PHONGTHAN_SKILL_ENTRY)];
	ZeroMemory(skillsPacket, sizeof(skillsPacket));
	PHONGTHAN_SKILL_LIST_HEADER* list = (PHONGTHAN_SKILL_LIST_HEADER*)skillsPacket;
	PhongThanInitializeWireHeader(&list->Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LIST,
		sizeof(skillsPacket), PHONGTHAN_WIRE_FLAG_RESPONSE, 16);
	list->MapId = 1001; list->EntityId = 9001; list->Count = 2;
	PHONGTHAN_SKILL_ENTRY* entries = (PHONGTHAN_SKILL_ENTRY*)(list + 1);
	entries[0].SkillId = 115; entries[0].Level = 200; entries[1].SkillId = 120; entries[1].Level = 300;
	CHECK(PhongThanValidateSkillList(skillsPacket, sizeof(skillsPacket)));
	CHECK(entries[1].Level == 300);
	CHECK(!PhongThanValidateSkillList(skillsPacket, sizeof(skillsPacket) - 1));
	entries[1].SkillId = 115;
	CHECK(!PhongThanValidateSkillList(skillsPacket, sizeof(skillsPacket)));
	list->Count = 65535;
	CHECK(!PhongThanValidateSkillList(skillsPacket, sizeof(skillsPacket)));
	PHONGTHAN_SKILL_REQUEST skill;
	ZeroMemory(&skill, sizeof(skill));
	PhongThanInitializeWireHeader(&skill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_REQUEST,
		sizeof(skill), PHONGTHAN_WIRE_FLAG_REQUEST, 16);
	skill.MapId = 1001; skill.SkillId = 115; skill.TargetKind = PHONGTHAN_SKILL_TARGET_ENTITY;
	skill.TargetId = 0xf1234567;
	CHECK(PhongThanValidateSkillRequest(&skill, sizeof(skill)));
	skill.X = -1;
	CHECK(!PhongThanValidateSkillRequest(&skill, sizeof(skill)));
	skill.X = 0; skill.TargetId = 0;
	CHECK(!PhongThanValidateSkillRequest(&skill, sizeof(skill)));
	skill.TargetKind = PHONGTHAN_SKILL_TARGET_POSITION; skill.X = 21000; skill.Y = 42000;
	CHECK(PhongThanValidateSkillRequest(&skill, sizeof(skill)));
	skill.TargetId = 90001;
	CHECK(!PhongThanValidateSkillRequest(&skill, sizeof(skill)));
	skill.TargetId = 0; skill.SkillId = 0;
	CHECK(!PhongThanValidateSkillRequest(&skill, sizeof(skill)));
	PHONGTHAN_SKILL_CAST cast;
	ZeroMemory(&cast, sizeof(cast));
	PhongThanInitializeWireHeader(&cast.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST,
		sizeof(cast), PHONGTHAN_WIRE_FLAG_RESPONSE, 16);
	cast.MapId = 1001; cast.EntityId = 90001; cast.SkillId = 115; cast.SkillLevel = 200;
	cast.TargetKind = PHONGTHAN_SKILL_TARGET_POSITION; cast.X = 21000; cast.Y = 42000;
	CHECK(PhongThanValidateSkillCast(&cast, sizeof(cast)));
	cast.DirectEffect = 1;
	CHECK(PhongThanValidateSkillCast(&cast, sizeof(cast)));
	cast.DirectEffect = 2;
	CHECK(!PhongThanValidateSkillCast(&cast, sizeof(cast)));
	cast.DirectEffect = 0; cast.SkillLevel = 0;
	CHECK(!PhongThanValidateSkillCast(&cast, sizeof(cast)));
	PHONGTHAN_PLAYER_SNAPSHOT player;
	ZeroMemory(&player, sizeof(player));
	PhongThanInitializeWireHeader(&player.Header, PHONGTHAN_MSG_WORLD_PLAYER_SNAPSHOT,
		sizeof(player), PHONGTHAN_WIRE_FLAG_RESPONSE, 16);
	player.MapId = 1118; player.EntityId = 90001; player.Profession = PHONGTHAN_PROFESSION_GIAP_SI;
	player.Horse.ResourceId = 99; player.Horse.PaletteId = 6; player.Horse.Visible = 1;
	player.Armor.ResourceId = 32; player.Armor.PaletteId = 8; player.Armor.Visible = 1;
	player.Mounted = 1; player.FullSnapshot = 1;
	CHECK(PhongThanValidatePlayerSnapshot(&player, sizeof(player)));
	player.FullSnapshot = 0;
	CHECK(PhongThanValidatePlayerSnapshot(&player, sizeof(player)));
	player.Horse.Visible = 2;
	CHECK(!PhongThanValidatePlayerSnapshot(&player, sizeof(player)));
	player.Horse.Visible = 1; player.Profession = PHONGTHAN_PROFESSION_COUNT;
	CHECK(!PhongThanValidatePlayerSnapshot(&player, sizeof(player)));
	player.Profession = 0; memset(player.ClanName, 'A', sizeof(player.ClanName));
	CHECK(!PhongThanValidatePlayerSnapshot(&player, sizeof(player)));
	CHECK(!PhongThanValidatePlayerSnapshot(&player, sizeof(player) - 1));
	PHONGTHAN_MOVE_REQUEST move;
	ZeroMemory(&move, sizeof(move));
	PhongThanInitializeWireHeader(&move.Header, PHONGTHAN_MSG_WORLD_MOVE_REQUEST,
		sizeof(move), PHONGTHAN_WIRE_FLAG_REQUEST, 17);
	move.MapId = 1118; move.X = 53000; move.Y = 72000; move.Mode = PHONGTHAN_MOVE_RUN;
	CHECK(PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.Mode = PHONGTHAN_MOVE_WALK;
	CHECK(PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.Mode = PHONGTHAN_MOVE_JUMP;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.Mode = PHONGTHAN_MOVE_WALK; move.X = -1;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.X = PHONGTHAN_WORLD_COORDINATE_MAX + 1;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.X = 100; move.Reserved = 1;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.Reserved = 0; move.MapId = 0;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.MapId = 1001; move.Header.Flags = PHONGTHAN_WIRE_FLAG_RESPONSE;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.Header.Flags = PHONGTHAN_WIRE_FLAG_REQUEST; move.Header.PacketSize++;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));
	move.Header.PacketSize--; move.Header.Version++;
	CHECK(!PhongThanValidateMoveRequest(&move, sizeof(move)));

	PHONGTHAN_ENTITY_MOVE event;
	ZeroMemory(&event, sizeof(event));
	PhongThanInitializeWireHeader(&event.Header, PHONGTHAN_MSG_WORLD_ENTITY_MOVE,
		sizeof(event), PHONGTHAN_WIRE_FLAG_RESPONSE, 18);
	event.MapId = 1025; event.EntityId = 90001; event.X = 99; event.Y = 200;
	for (unsigned short mode = PHONGTHAN_MOVE_WALK; mode <= PHONGTHAN_MOVE_JUMP; ++mode)
	{
		event.Mode = mode;
		CHECK(PhongThanValidateEntityMove(&event, sizeof(event)));
	}
	event.Mode = 99;
	CHECK(!PhongThanValidateEntityMove(&event, sizeof(event)));

	PHONGTHAN_NPC_SNAPSHOT snapshot;
	ZeroMemory(&snapshot, sizeof(snapshot));
	PhongThanInitializeWireHeader(&snapshot.Header, PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT,
		sizeof(snapshot), PHONGTHAN_WIRE_FLAG_RESPONSE, 19);
	snapshot.MapId = 1118; snapshot.EntityId = 90001; snapshot.TemplateId = 2703;
	snapshot.Level = 200; snapshot.Action = PHONGTHAN_ACTION_STAND;
	snapshot.NameLength = 8; memcpy(snapshot.Name, "PhongTan", 8);
	CHECK(PhongThanValidateNpcSnapshot(&snapshot, sizeof(snapshot)));
	PHONGTHAN_NPC_SNAPSHOT received;
	memcpy(&received, &snapshot, sizeof(received));
	CHECK(received.TemplateId == 2703 && received.Level == 200 && received.MapId == 1118 &&
		received.NameLength == 8 && memcmp(received.Name, snapshot.Name, 8) == 0);
	snapshot.NameLength = PHONGTHAN_ENTITY_NAME_CAPACITY;
	CHECK(!PhongThanValidateNpcSnapshot(&snapshot, sizeof(snapshot)));
	snapshot.NameLength = 8; snapshot.Name[4] = 0;
	CHECK(!PhongThanValidateNpcSnapshot(&snapshot, sizeof(snapshot)));
	snapshot.Name[4] = 'g'; snapshot.Action = 1;
	CHECK(!PhongThanValidateNpcSnapshot(&snapshot, sizeof(snapshot)));
	snapshot.Action = PHONGTHAN_ACTION_STAND; snapshot.TemplateId = 0x8000;
	CHECK(!PhongThanValidateNpcSnapshot(&snapshot, sizeof(snapshot)));

	PHONGTHAN_NPC_UPDATE update;
	ZeroMemory(&update, sizeof(update));
	PhongThanInitializeWireHeader(&update.Header, PHONGTHAN_MSG_WORLD_NPC_UPDATE,
		sizeof(update), PHONGTHAN_WIRE_FLAG_RESPONSE, 20);
	update.MapId = 1118; update.EntityId = 90001; update.Action = PHONGTHAN_ACTION_RUN;
	update.RunSpeed = 400; update.Life = 2000000; update.MaxLife = 2100000;
	CHECK(PhongThanValidateNpcUpdate(&update, sizeof(update)));
	CHECK(update.RunSpeed == 400 && update.Life == 2000000);
	update.CastSpeed = -1;
	CHECK(!PhongThanValidateNpcUpdate(&update, sizeof(update)));

	PHONGTHAN_ENTITY_REFERENCE reference;
	ZeroMemory(&reference, sizeof(reference));
	PhongThanInitializeWireHeader(&reference.Header, PHONGTHAN_MSG_WORLD_ENTITY_REQUEST,
		sizeof(reference), PHONGTHAN_WIRE_FLAG_REQUEST, 21);
	reference.MapId = 1027; reference.EntityId = 321;
	CHECK(PhongThanValidateEntityReference(&reference, sizeof(reference),
		PHONGTHAN_MSG_WORLD_ENTITY_REQUEST, PHONGTHAN_WIRE_FLAG_REQUEST));
	CHECK(!PhongThanValidateEntityReference(&reference, sizeof(reference) + 1,
		PHONGTHAN_MSG_WORLD_ENTITY_REQUEST, PHONGTHAN_WIRE_FLAG_REQUEST));
	reference.EntityId = 0;
	CHECK(!PhongThanValidateEntityReference(&reference, sizeof(reference),
		PHONGTHAN_MSG_WORLD_ENTITY_REQUEST, PHONGTHAN_WIRE_FLAG_REQUEST));
	printf("PASS checks=%d guard_page_short_buffers=%u\n", checks, (unsigned int)sizeof(snapshot));
	return 0;
}
