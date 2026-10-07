#include <assert.h>
#include <stdio.h>
#include <string.h>

typedef unsigned long DWORD;
typedef int BOOL;
enum { FALSE = 0, TRUE = 1, MAX_REGION = 9, MAX_NPC = 32,
    CLIENT_PLAYER_INDEX = 0, kind_normal = 0, kind_player = 1,
    kind_dialoger = 3, obj_npc = 0, do_stand = 1 };

struct Node {
    int m_Ref, owner;
    void Remove() { owner = -1; }
    void Release() { assert(m_Ref > 0); --m_Ref; }
};
struct KNpc {
    struct { DWORD m_dwRegionID; } m_sClientNpcID;
    BOOL m_bClientOnly;
    DWORD m_dwID, m_dwRegionID, m_SyncSignal;
    int m_Kind, m_SubWorldIndex, m_RegionIndex, m_MapX, m_MapY;
    int commands, action, removedResources;
    Node m_Node;
    void SendCommand(int value) { ++commands; action = value; }
    void RemoveRes() { ++removedResources; }
} Npc[MAX_NPC];
struct PlayerMock { int m_nIndex; } Player[1];

struct KRegion {
    int m_RegionID, m_nWidth, m_nHeight, index, adds, removes;
    int cells[16][32];
    void AddNpc(int nIdx) {
        if (Npc[nIdx].m_Node.m_Ref == 0) {
            Npc[nIdx].m_Node.m_Ref = 1;
            Npc[nIdx].m_Node.owner = index;
            ++adds;
        }
    }
    void RemoveNpc(int nIdx) {
        if (Npc[nIdx].m_Node.m_Ref > 0) {
            Npc[nIdx].m_Node.Remove();
            Npc[nIdx].m_Node.Release();
            ++removes;
        }
        Npc[nIdx].RemoveRes();
    }
    void AddRef(int x, int y, int) { ++cells[x][y]; }
} Regions[MAX_REGION];

struct KSubWorld {
    KRegion* m_Region;
    int m_SubWorldID, loads;
    DWORD m_dwCurrentTime;
    int FindRegion(int id) {
        for (int i = 0; i < MAX_REGION; ++i)
            if (m_Region[i].m_RegionID == id) return i;
        return -1;
    }
    void LoadMap(int world, int id) {
        assert(world == m_SubWorldID);
        const KNpc& self = Npc[Player[0].m_nIndex];
        assert(self.m_RegionIndex == -1 && self.m_Node.m_Ref == 0);
        ++loads;
        if (FindRegion(id) < 0) m_Region[8].m_RegionID = id;
    }
    void NpcChangeRegion(int source, int dest, int npc);
} SubWorld[1];

struct UseIndices {
    BOOL used[MAX_NPC];
    int GetNext(int index) {
        for (int i = index + 1; i < MAX_NPC; ++i)
            if (used[i]) return i;
        return 0;
    }
};
struct KNpcSet {
    UseIndices m_UseIdx;
    void InsertNpcToRegion(int index);
} NpcSet;

#include "../../Sources/Core/Src/PhongThanClientNpcReattach.inl"
#include "../../Sources/Core/Src/PhongThanClientNpcChangeRegion.inl"

static void Reset()
{
    memset(Npc, 0, sizeof(Npc));
    memset(Regions, 0, sizeof(Regions));
    memset(&NpcSet, 0, sizeof(NpcSet));
    memset(SubWorld, 0, sizeof(SubWorld));
    SubWorld[0].m_Region = Regions;
    SubWorld[0].m_SubWorldID = 1052;
    SubWorld[0].m_dwCurrentTime = 900;
    Player[0].m_nIndex = 31;
    for (int i = 0; i < MAX_REGION; ++i) {
        Regions[i].index = i;
        Regions[i].m_RegionID = 100 + i;
        Regions[i].m_nWidth = 16;
        Regions[i].m_nHeight = 32;
    }
    for (int j = 0; j < MAX_NPC; ++j) {
        Npc[j].m_RegionIndex = -1;
        Npc[j].m_Node.owner = -1;
    }
}

static void ServerNpc(int index, int kind, DWORD region)
{
    NpcSet.m_UseIdx.used[index] = TRUE;
    Npc[index].m_dwID = 1000 + index;
    Npc[index].m_Kind = kind;
    Npc[index].m_dwRegionID = region;
    Npc[index].m_MapX = 4;
    Npc[index].m_MapY = 8;
    Npc[index].action = 7;
    Npc[index].m_SyncSignal = 123;
}

static void EvictRegion(int region)
{
    for (int i = 1; i < MAX_NPC; ++i) {
        if (Npc[i].m_Node.owner == region) {
            Npc[i].m_RegionIndex = -1;
            Regions[region].RemoveNpc(i);
        }
    }
    memset(Regions[region].cells, 0, sizeof(Regions[region].cells));
    Regions[region].m_RegionID = 300;
}

static void TestServerNpcSurvivesRegionEviction()
{
    Reset();
    ServerNpc(1, kind_dialoger, 100);
    ServerNpc(2, kind_normal, 100);
    NpcSet.InsertNpcToRegion(0);
    assert(Regions[0].adds == 2 && Regions[0].cells[4][8] == 2);
    assert(Npc[1].m_RegionIndex == 0 && Npc[2].m_RegionIndex == 0);
    assert(Npc[1].commands == 0 && Npc[1].action == 7);
    assert(Npc[1].m_SyncSignal == 123);
    NpcSet.InsertNpcToRegion(0);
    assert(Regions[0].adds == 2 && Regions[0].cells[4][8] == 2);

    EvictRegion(0);
    NpcSet.InsertNpcToRegion(0);
    assert(Npc[1].m_RegionIndex == -1);
    Regions[4].m_RegionID = 100;
    NpcSet.InsertNpcToRegion(4);
    assert(Npc[1].m_RegionIndex == 4 && Npc[1].m_Node.owner == 4);
    assert(Npc[2].m_RegionIndex == 4 && Regions[4].cells[4][8] == 2);
    assert(Npc[1].action == 7 && Npc[1].commands == 0);
}

static void TestClientNpcAndEligibility()
{
    Reset();
    ServerNpc(1, kind_dialoger, 100);
    Npc[1].m_bClientOnly = TRUE;
    Npc[1].m_sClientNpcID.m_dwRegionID = 100;
    ServerNpc(2, kind_player, 100);
    ServerNpc(3, kind_dialoger, 100);
    Npc[3].m_MapY = 32;
    ServerNpc(4, kind_dialoger, 100);
    Npc[4].m_SubWorldIndex = 1;
    ServerNpc(5, kind_dialoger, 100);
    Npc[5].m_RegionIndex = 2;
    ServerNpc(6, kind_dialoger, 100);
    Npc[6].m_Node.m_Ref = 1;
    ServerNpc(7, kind_dialoger, 100);
    Npc[7].m_dwID = 0;
    NpcSet.InsertNpcToRegion(-1);
    NpcSet.InsertNpcToRegion(MAX_REGION);
    NpcSet.InsertNpcToRegion(0);
    assert(Regions[0].adds == 1 && Regions[0].cells[4][8] == 0);
    assert(Npc[1].action == do_stand && Npc[1].commands == 1);
    assert(Npc[1].m_SyncSignal == 900);
}

static void TestMissingDestinationAndReentry()
{
    Reset();
    ServerNpc(1, kind_dialoger, 100);
    NpcSet.InsertNpcToRegion(0);
    SubWorld[0].NpcChangeRegion(100, 999, 1);
    assert(Npc[1].m_RegionIndex == -1 && Npc[1].m_dwRegionID == 999);
    assert(Npc[1].m_Node.m_Ref == 0 && Npc[1].m_Node.owner == -1);
    Regions[3].m_RegionID = 999;
    NpcSet.InsertNpcToRegion(3);
    assert(Npc[1].m_RegionIndex == 3 && Npc[1].m_Node.owner == 3);
    assert(Regions[3].cells[4][8] == 1);
}

static void TestAlreadyWrittenDestinationAndSelfLoadOrder()
{
    Reset();
    ServerNpc(1, kind_dialoger, 100);
    NpcSet.InsertNpcToRegion(0);
    Npc[1].m_RegionIndex = 1; // ServerMove writes destination before callback.
    SubWorld[0].NpcChangeRegion(100, 101, 1);
    assert(Npc[1].m_RegionIndex == 1 && Npc[1].m_dwRegionID == 101);
    assert(Npc[1].m_Node.owner == 1 && Npc[1].m_Node.m_Ref == 1);
    SubWorld[0].NpcChangeRegion(-1, 101, 1); // Already-attached recovery.
    assert(Npc[1].m_Node.owner == 1 && Npc[1].m_Node.m_Ref == 1);
    assert(Regions[1].adds == 2);

    ServerNpc(31, kind_player, 100);
    Regions[0].AddNpc(31);
    Npc[31].m_RegionIndex = 0;
    SubWorld[0].NpcChangeRegion(100, 888, 31);
    assert(SubWorld[0].loads == 1);
    assert(Npc[31].m_RegionIndex == 8 && Npc[31].m_Node.owner == 8);
    SubWorld[0].NpcChangeRegion(888, -1, 31);
    assert(Npc[31].m_RegionIndex == -1 && Npc[31].m_dwRegionID == 0);
}

int main()
{
    TestServerNpcSurvivesRegionEviction();
    TestClientNpcAndEligibility();
    TestMissingDestinationAndReentry();
    TestAlreadyWrittenDestinationAndSelfLoadOrder();
    puts("PASS NPC_REGION_LIFECYCLE: reentry, duplicate/ref guards, authoritative action, detached slots, self load order");
    return 0;
}
