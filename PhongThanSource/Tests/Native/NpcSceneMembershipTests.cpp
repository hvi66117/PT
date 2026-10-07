// Headless regression using the actual client scene branches and runtime leaves.
// No game state, PAKs, renderer window, or server process is needed.
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Scene/KIpotLeaf.h"
#include "Scene/KIpotBranch.h"
#include "Scene/PhongThanSceneMembership.h"
#include "CoreDrawGameObj.h"

struct iRepresentShell;
iRepresentShell* g_pRepresent = NULL;
int g_bShowObstacle = 0;
// Referenced by unused built-in animation paths in the real leaf translation unit.
unsigned int IR_GetCurrentTime() { return 0; }
void IR_NextFrame(int&, int, unsigned int, unsigned int&) {}

#define REQUIRE(condition) do { if (!(condition)) { \
    fprintf(stderr, "FAIL line=%d: %s\n", __LINE__, #condition); exit(1); \
} } while (0)

static int s_body[4], s_name[4], s_enum[4];

void CoreDrawGameObj(unsigned int genre, unsigned int id, int x, int y,
                     int width, int height, int layer)
{
    REQUIRE(genre == 1 && id >= 1 && id <= 3);
    REQUIRE(x > 0 && y > 0 && width == 0 && height == 0);
    if (layer == IPOT_RL_OBJECT) ++s_body[id];
    else if (layer == IPOT_RL_INFRONTOF_ALL) ++s_name[id];
    else REQUIRE(false);
}

static void CountLeaf(void*, KIpotLeaf* leaf)
{
    if (leaf->eLeafType != KIpotLeaf::IPOTL_T_RUNTIME_OBJ) return;
    KIpotRuntimeObj* npc = (KIpotRuntimeObj*)leaf;
    REQUIRE(npc->nId >= 1 && npc->nId <= 3);
    REQUIRE(++s_enum[npc->nId] == 1); // Detect duplicate draw-tree membership.
}

static KIpotRuntimeObj* NewNpc(int id, int x, int y)
{
    KIpotRuntimeObj* npc = (KIpotRuntimeObj*)calloc(1, sizeof(KIpotRuntimeObj));
    REQUIRE(npc != NULL);
    npc->eLeafType = KIpotLeaf::IPOTL_T_RUNTIME_OBJ;
    npc->uGenre = 1;
    npc->nId = id;
    npc->oPosition.x = x;
    npc->oPosition.y = y + POINT_LEAF_Y_ADJUST_VALUE;
    npc->eLayerParam = IPOT_RL_OBJECT | IPOT_RL_INFRONTOF_ALL;
    return npc;
}

// The new membership predicate and actual Pluck/AddLeafPoint match MoveObject.
static bool MoveStationaryNpc(KIpotBranch& branch, KIpotRuntimeObj* npc)
{
    const int x = npc->oPosition.x, adjustedY = npc->oPosition.y;
    if (!PhongThanSceneNeedsAttach(npc, x, adjustedY)) return false;
    npc->Pluck();
    branch.AddLeafPoint(npc);
    return true;
}

static void CheckScene(KIpotBranch& branch, RECT area, int expectedCount,
                       bool visible)
{
    memset(s_body, 0, sizeof(s_body));
    memset(s_name, 0, sizeof(s_name));
    memset(s_enum, 0, sizeof(s_enum));
    branch.EnumerateObjects(NULL, CountLeaf);
    branch.PaintObjectLayer(&area);
    branch.PaintNoneObjectLayer(&area, IPOT_RL_INFRONTOF_ALL);
    for (int id = 1; id <= 3; ++id)
    {
        const int expected = id <= expectedCount ? 1 : 0;
        REQUIRE(s_enum[id] == expected);
        REQUIRE(s_body[id] == (visible ? expected : 0));
        REQUIRE(s_name[id] == (visible ? expected : 0));
    }
}

static void CheckPending(KIpotLeaf& sentinel, int count)
{
    int seen[4] = {0, 0, 0, 0}, actual = 0;
    KIpotLeaf* previous = &sentinel;
    for (KIpotLeaf* leaf = sentinel.pBrother; leaf; leaf = leaf->pBrother)
    {
        REQUIRE(++actual <= count);
        KIpotRuntimeObj* npc = (KIpotRuntimeObj*)leaf;
        REQUIRE(npc->nId >= 1 && npc->nId <= 3);
        REQUIRE(++seen[npc->nId] == 1);
        REQUIRE(npc->pAheadBrother == previous);
        REQUIRE(npc->pParentBranch == NULL && npc->pParentLeaf == NULL);
        previous = leaf;
    }
    REQUIRE(actual == count);
}

static void CameraRebuildRegression()
{
    KIpotBranch branch;
    KIpotLeaf pending;
    memset(&pending, 0, sizeof(pending));
    KIpotRuntimeObj* npcs[3];
    for (int n = 0; n < 3; ++n)
    {
        npcs[n] = NewNpc(n + 1, 1000 + n * 32, 2000 + n * 32);
        REQUIRE(MoveStationaryNpc(branch, npcs[n]));
    }
    RECT area = {900, 1900, 1200, 2200};
    CheckScene(branch, area, 3, true);

    for (int cycle = 0; cycle < 100; ++cycle)
    {
        // Exactly the runtime-leaf preservation sequence in KIpoTree::Fell().
        branch.RemoveAllRtoLeafs(&pending);
        branch.Clear();
        CheckPending(pending, 3);
        CheckScene(branch, area, 0, true);

        for (int i = 0; i < 3; ++i)
        {
            const int index = (i + cycle) % 3;
            KIpotRuntimeObj* npc = npcs[index];
            const int x = 1000 + index * 32;
            const int y = 2000 + index * 32 + POINT_LEAF_Y_ADJUST_VALUE;
            // This is the old condition: it cannot restore a stationary NPC.
            REQUIRE(!(npc->oPosition.x != x || npc->oPosition.y != y));
            REQUIRE(PhongThanSceneNeedsAttach(npc, x, y));
            REQUIRE(MoveStationaryNpc(branch, npc));
            REQUIRE(!MoveStationaryNpc(branch, npc));
        }
        CheckPending(pending, 0);
        // Panning within the scene still draws every NPC and its name once.
        RECT shifted = {900 + cycle % 20, 1900 + cycle % 20, 1200, 2200};
        CheckScene(branch, shifted, 3, true);
        RECT outside = {3000, 4000, 3500, 4500};
        CheckScene(branch, outside, 3, false);
        CheckScene(branch, area, 3, true);
    }

    // Actual region removal releases all memberships; returning gets fresh leaves.
    for (int i = 0; i < 3; ++i) { npcs[i]->Pluck(); free(npcs[i]); npcs[i] = NULL; }
    CheckScene(branch, area, 0, true);
    for (i = 0; i < 3; ++i)
    {
        npcs[i] = NewNpc(i + 1, 1000 + i * 32, 2000 + i * 32);
        REQUIRE(MoveStationaryNpc(branch, npcs[i]));
    }
    CheckScene(branch, area, 3, true);
    for (i = 0; i < 3; ++i) { npcs[i]->Pluck(); free(npcs[i]); }
    CheckScene(branch, area, 0, true);
}

static void ParentLeafRegression()
{
    KIpotBranch branch;
    KIpotLeaf pending;
    KIpotBuildinObj wall;
    KBuildinObj geometry;
    memset(&pending, 0, sizeof(pending));
    memset(&wall, 0, sizeof(wall));
    memset(&geometry, 0, sizeof(geometry));
    wall.eLeafType = KIpotLeaf::IPOTL_T_BUILDIN_OBJ;
    wall.oPosition.x = 990; wall.oPosition.y = 2006;
    wall.oEndPos.x = 1010; wall.oEndPos.y = 2006;
    wall.pBio = &geometry;
    geometry.Props = SPBIO_P_SORTMANNER_LINE;
    // ImgPos3 stays outside the positive viewport, so no built-in sprite is drawn.
    branch.AddLeafLine(&wall);
    KIpotRuntimeObj* npc = NewNpc(1, 1000, 2000);
    REQUIRE(MoveStationaryNpc(branch, npc));
    REQUIRE(npc->pParentLeaf == &wall && npc->pParentBranch == NULL);
    REQUIRE(!PhongThanSceneNeedsAttach(npc, 1000, 2006));
    REQUIRE(PhongThanSceneNeedsAttach(npc, 1001, 2006));
    RECT area = {900, 1900, 1200, 2200};
    CheckScene(branch, area, 1, true);
    branch.RemoveAllRtoLeafs(&pending);
    branch.Clear();
    CheckPending(pending, 1);
    REQUIRE(MoveStationaryNpc(branch, npc));
    REQUIRE(npc->pParentBranch != NULL && npc->pParentLeaf == NULL);
    CheckPending(pending, 0);
    CheckScene(branch, area, 1, true);
    npc->Pluck();
    free(npc);
}

int main()
{
    CameraRebuildRegression();
    ParentLeafRegression();
    puts("PASS NPC_SCENE_MEMBERSHIP cycles=100 stationary=3 body_and_name_once=1 leave_return=1 parent_leaf=1");
    return 0;
}
