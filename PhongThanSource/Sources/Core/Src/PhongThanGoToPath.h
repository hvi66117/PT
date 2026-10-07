// Phong Than 2026-10-04 timduong: pure helpers of the client "go to coordinates" feature (Alt+F, like VNG's
// "tim duong"). No engine dependency: PhongThanGoTo.inl (client build, end of KPlayerAI.cpp) supplies the
// region loader (KPakFile), the offline smoke test (scratchpad timduong\smoke) one reading the map files.
// ASCII only. Loop variables are declared at function scope (the modern build keeps /Zc:forScope-).
//
// Coordinates
//   Mps     : scene pixels (KNpc::GetMpsPos, do_run / do_walk destinations).
//   cell    : 32 x 32 Mps, the obstacle grid (KScenePlaceRegionC::m_ObstacleInfo[16][32]).
//   region  : 16 x 32 cells = 512 x 1024 Mps, file \maps\<map>\v_<ry>\<rx>_Region_C.dat.
//   display : what the mini map shows (KUiMiniMap::UpdateSceneTimeInfo: pos / 32 / 8 and pos / 32 / 16) and
//             what the quest texts print, "168/192" or "(168.192)":
//             x = Mps x / 256 (8 cells), y = Mps y / 512 (16 cells).
#ifndef PHONGTHAN_GOTOPATH_H
#define PHONGTHAN_GOTOPATH_H

#include <stdlib.h>
#include <string.h>

#define PTGP_CELL           32
#define PTGP_RCX            16          // cells per region, x
#define PTGP_RCY            32          // cells per region, y
#define PTGP_UNIT_X         256         // display unit, Mps
#define PTGP_UNIT_Y         512

#define PTGP_FREE           0
#define PTGP_PART           1           // half obstacle (diagonal wall edge): walkable for the search, not for lines
#define PTGP_TRAP           2           // event cell (map exits ...): very expensive, never crossed by a line
#define PTGP_BLOCK          3
#define PTGP_UNKNOWN        0xFF        // region not read yet

#define PTGP_COST_ORTH      10
#define PTGP_COST_DIAG      14
#define PTGP_PART_MUL       3
#define PTGP_TRAP_MUL       30
#define PTGP_WALL_EXTRA     4           // free cell touching a full obstacle: keeps the path off the walls

#define PTGP_OK_HERE        0           // already there
#define PTGP_ERR_NOPATH     (-1)
#define PTGP_ERR_OUTSIDE    (-2)        // start or goal outside the map rectangle
#define PTGP_ERR_GOAL       (-3)        // goal inside obstacles, no free cell nearby
#define PTGP_ERR_LIMIT      (-4)        // search limit reached
#define PTGP_ERR_MEMORY     (-5)

//---------------------------------------------------------------------------------------------------------
// text
//---------------------------------------------------------------------------------------------------------
static int PTGP_IsDigit(int c)
{
	return c >= '0' && c <= '9';
}

static int PTGP_ReadNum(const unsigned char** pp, int* pv)
{
	const unsigned char* p = *pp;
	int v = 0, k = 0;
	while (PTGP_IsDigit(*p))
	{
		v = v * 10 + (*p - '0');
		k++;
		p++;
		if (k > 5)
			return 0;
	}
	if (k == 0)
		return 0;
	*pp = p;
	*pv = v;
	return 1;
}

// "168/192", "168.192", "168 192", "168,192", "(168.192)", "168:192", "168-192", then optionally one letter:
//   a / s / d : turn on the auto fight on arrival (Alt+A / Alt+S / Alt+D mode 1 / 2 / 3)
//   - / 0 / n : no auto fight on arrival
// *pnMode = -1 without that letter. Returns 1 when the text is a coordinate.
static int PTGP_ParseCoord(const char* s, int* px, int* py, int* pnMode)
{
	const unsigned char* p = (const unsigned char*)s;
	int x = 0, y = 0, nSep = 0, nMode = -1;
	if (p == NULL)
		return 0;
	while (*p == ' ' || *p == '\t' || *p == '(' || *p == '[')
		p++;
	if (!PTGP_ReadNum(&p, &x))
		return 0;
	while (*p && strchr(" \t./,:;-|", *p))
	{
		p++;
		nSep++;
	}
	if (nSep == 0 || !PTGP_ReadNum(&p, &y))
		return 0;
	while (*p == ' ' || *p == '\t' || *p == ')' || *p == ']')
		p++;
	if (*p)
	{
		int c = *p;
		if (c >= 'A' && c <= 'Z')
			c += 'a' - 'A';
		if (c == 'a')
			nMode = 1;
		else if (c == 's')
			nMode = 2;
		else if (c == 'd')
			nMode = 3;
		else if (c == '-' || c == '0' || c == 'n')
			nMode = 0;
		else
			return 0;
		p++;
		while (*p == ' ' || *p == '\t')
			p++;
		if (*p)
			return 0;
	}
	if (x <= 0 || y <= 0 || x > 9999 || y > 9999)
		return 0;
	*px = x;
	*py = y;
	if (pnMode)
		*pnMode = nMode;
	return 1;
}

// First "(x.y)" / "(x/y)" / "(x,y)" of a quest text (TCVN3 bytes, <color=..> tags allowed). 1 when found.
static int PTGP_FindCoordInText(const char* s, int nLen, int* px, int* py)
{
	const unsigned char* b = (const unsigned char*)s;
	int i;
	if (b == NULL)
		return 0;
	if (nLen < 0)
		nLen = (int)strlen(s);
	for (i = 0; i + 4 < nLen; i++)
	{
		const unsigned char* p;
		const unsigned char* pEnd = b + nLen;
		int x = 0, y = 0, kx = 0, ky = 0;
		if (b[i] != '(')
			continue;
		p = b + i + 1;
		while (p < pEnd && *p == ' ')
			p++;
		while (p < pEnd && PTGP_IsDigit(*p) && kx < 5)
		{
			x = x * 10 + (*p - '0');
			kx++;
			p++;
		}
		if (kx == 0 || p >= pEnd || (*p != '.' && *p != '/' && *p != ','))
			continue;
		p++;
		while (p < pEnd && PTGP_IsDigit(*p) && ky < 5)
		{
			y = y * 10 + (*p - '0');
			ky++;
			p++;
		}
		while (p < pEnd && *p == ' ')
			p++;
		if (ky == 0 || p >= pEnd || *p != ')' || x <= 0 || y <= 0)
			continue;
		*px = x;
		*py = y;
		return 1;
	}
	return 0;
}

//---------------------------------------------------------------------------------------------------------
// region files
//---------------------------------------------------------------------------------------------------------
static unsigned int PTGP_U32(const unsigned char* p)
{
	return (unsigned int)p[0] | ((unsigned int)p[1] << 8) | ((unsigned int)p[2] << 16) | ((unsigned int)p[3] << 24);
}

// OBSTACLE.DAT / section 0: long[16][32] indexed [x][y]; bits 0-3 kind (0 none), bits 4-7 shape
// (1 full, 2..5 one triangle: Obstacle_LT/RT/LB/RB of ObstacleDef.h). Shorter data: free (engine behaviour).
static void PTGP_DecodeObstacle(const unsigned char* p, unsigned int n, unsigned char* pOut)
{
	int cx, cy;
	memset(pOut, PTGP_FREE, PTGP_RCX * PTGP_RCY);
	if (p == NULL || n < PTGP_RCX * PTGP_RCY * 4)
		return;
	for (cx = 0; cx < PTGP_RCX; cx++)
	{
		for (cy = 0; cy < PTGP_RCY; cy++)
		{
			unsigned int v = PTGP_U32(p + (cx * PTGP_RCY + cy) * 4);
			unsigned int nShape = (v >> 4) & 0x0f;
			if ((v & 0x0f) == 0)
				continue;
			pOut[cy * PTGP_RCX + cx] = (nShape >= 2 && nShape <= 5) ? PTGP_PART : PTGP_BLOCK;
		}
	}
}

// Trap.dat / section 1: u32 count, 2 x u32 reserved, count x {u8 x, u8 y, u8 cells to the right, u8 0, u32 id}.
static void PTGP_DecodeTraps(const unsigned char* p, unsigned int n, unsigned char* pOut)
{
	unsigned int i, nCount;
	int j;
	if (p == NULL || n < 12)
		return;
	nCount = PTGP_U32(p);
	for (i = 0; i < nCount && 12 + (i + 1) * 8 <= n; i++)
	{
		const unsigned char* t = p + 12 + i * 8;
		int x = t[0], y = t[1], k = t[2];
		if (y >= PTGP_RCY || x + k - 1 >= PTGP_RCX)
			continue;      // same check as KScenePlaceRegionC::LoadTrap
		for (j = 0; j < k; j++)
		{
			unsigned char* c = pOut + y * PTGP_RCX + x + j;
			if (*c != PTGP_BLOCK)
				*c = PTGP_TRAP;
		}
	}
}

// Region_C.dat ("combined" file, SceneDataDef.h): u32 count, count x {u32 offset, u32 length}, then the
// sections, offsets counted from the end of that table. pData NULL (no file): the region is not part of the
// map (the server refuses moves there) -> blocked. pOut is [cy * 16 + cx].
static void PTGP_DecodeRegion(const unsigned char* pData, unsigned int uSize, unsigned char* pOut)
{
	unsigned int nCount, uHead, uOff, uLen;
	if (pData == NULL || uSize < 4)
	{
		memset(pOut, PTGP_BLOCK, PTGP_RCX * PTGP_RCY);
		return;
	}
	nCount = PTGP_U32(pData);
	if (nCount > 64 || 4 + nCount * 8 > uSize)
	{
		memset(pOut, PTGP_BLOCK, PTGP_RCX * PTGP_RCY);
		return;
	}
	uHead = 4 + nCount * 8;
	uOff = nCount > 0 ? PTGP_U32(pData + 4) : 0;
	uLen = nCount > 0 ? PTGP_U32(pData + 8) : 0;
	if (uLen && uHead + uOff + uLen <= uSize)
		PTGP_DecodeObstacle(pData + uHead + uOff, uLen, pOut);
	else
		PTGP_DecodeObstacle(NULL, 0, pOut);
	if (nCount > 1)
	{
		uOff = PTGP_U32(pData + 12);
		uLen = PTGP_U32(pData + 16);
		if (uLen && uHead + uOff + uLen <= uSize)
			PTGP_DecodeTraps(pData + uHead + uOff, uLen, pOut);
	}
}

//---------------------------------------------------------------------------------------------------------
// grid of one map, regions read on first use
//---------------------------------------------------------------------------------------------------------
typedef int (*PTGP_LOADER)(void* pCtx, int nRegionX, int nRegionY, unsigned char* pOut512);

struct PTGP_Grid
{
	int nRX0, nRY0, nRW, nRH;           // region rectangle of the map (the .wor [MAIN] rect)
	int nCX0, nCY0, nW, nH;             // the same in cells
	unsigned char* pCell;               // nW * nH codes
	unsigned char* pRegion;             // nRW * nRH, 1 when read
	int nRegionsRead;
	PTGP_LOADER pfnLoad;
	void* pCtx;
	int* pG;                            // search buffers, nW * nH
	unsigned char* pFrom;
	unsigned char* pState;
	int* pHeap;                         // (f, index) pairs
	int nHeap, nHeapCap;
};

static void PTGP_GridFree(PTGP_Grid* g)
{
	if (g->pCell) free(g->pCell);
	if (g->pRegion) free(g->pRegion);
	if (g->pG) free(g->pG);
	if (g->pFrom) free(g->pFrom);
	if (g->pState) free(g->pState);
	if (g->pHeap) free(g->pHeap);
	memset(g, 0, sizeof(*g));
}

// Regions nRX0..nRX1 x nRY0..nRY1 (inclusive). 1 ok.
static int PTGP_GridInit(PTGP_Grid* g, int nRX0, int nRY0, int nRX1, int nRY1, PTGP_LOADER pfnLoad, void* pCtx)
{
	int n;
	memset(g, 0, sizeof(*g));
	if (nRX0 < 0 || nRY0 < 0 || nRX1 < nRX0 || nRY1 < nRY0 || nRX1 - nRX0 >= 256 || nRY1 - nRY0 >= 256)
		return 0;
	g->nRX0 = nRX0;
	g->nRY0 = nRY0;
	g->nRW = nRX1 - nRX0 + 1;
	g->nRH = nRY1 - nRY0 + 1;
	g->nCX0 = nRX0 * PTGP_RCX;
	g->nCY0 = nRY0 * PTGP_RCY;
	g->nW = g->nRW * PTGP_RCX;
	g->nH = g->nRH * PTGP_RCY;
	g->pfnLoad = pfnLoad;
	g->pCtx = pCtx;
	n = g->nW * g->nH;
	g->pCell = (unsigned char*)malloc(n);
	g->pRegion = (unsigned char*)calloc(g->nRW * g->nRH, 1);
	if (g->pCell == NULL || g->pRegion == NULL)
	{
		PTGP_GridFree(g);
		return 0;
	}
	memset(g->pCell, PTGP_UNKNOWN, n);
	return 1;
}

// Code of an absolute cell; outside the map = blocked.
static int PTGP_Code(PTGP_Grid* g, int cx, int cy)
{
	int lx = cx - g->nCX0, ly = cy - g->nCY0;
	unsigned char* c;
	if (lx < 0 || ly < 0 || lx >= g->nW || ly >= g->nH)
		return PTGP_BLOCK;
	c = g->pCell + ly * g->nW + lx;
	if (*c == PTGP_UNKNOWN)
	{
		unsigned char aTmp[PTGP_RCX * PTGP_RCY];
		int rx = lx / PTGP_RCX, ry = ly / PTGP_RCY, y;
		if (g->pfnLoad == NULL || !g->pfnLoad(g->pCtx, g->nRX0 + rx, g->nRY0 + ry, aTmp))
			PTGP_DecodeRegion(NULL, 0, aTmp);
		for (y = 0; y < PTGP_RCY; y++)
			memcpy(g->pCell + (ry * PTGP_RCY + y) * g->nW + rx * PTGP_RCX, aTmp + y * PTGP_RCX, PTGP_RCX);
		g->pRegion[ry * g->nRW + rx] = 1;
		g->nRegionsRead++;
	}
	return *c;
}

static int PTGP_CodeMps(PTGP_Grid* g, int x, int y)
{
	if (x < 0 || y < 0)
		return PTGP_BLOCK;
	return PTGP_Code(g, x / PTGP_CELL, y / PTGP_CELL);
}

// Every cell a segment touches (grid traversal, Amanatides-Woo), the start cell excepted: the player may
// stand on the edge of a cell. Through an exact corner both side cells count. 1 when all are free.
static int PTGP_LineFree1(PTGP_Grid* g, int x0, int y0, int x1, int y1)
{
	int cx, cy, ex, ey, dx = x1 - x0, dy = y1 - y0, sx, sy, nGuard = 0;
	double tMaxX, tMaxY, tDX, tDY;
	if (x0 < 0 || y0 < 0 || x1 < 0 || y1 < 0)
		return 0;
	cx = x0 / PTGP_CELL;
	cy = y0 / PTGP_CELL;
	ex = x1 / PTGP_CELL;
	ey = y1 / PTGP_CELL;
	sx = dx > 0 ? 1 : (dx < 0 ? -1 : 0);
	sy = dy > 0 ? 1 : (dy < 0 ? -1 : 0);
	if (dx)
	{
		tMaxX = ((sx > 0 ? (cx + 1) * (double)PTGP_CELL : cx * (double)PTGP_CELL) - x0) / dx;
		tDX = (double)PTGP_CELL / abs(dx);
	}
	else
		tMaxX = tDX = 1e30;
	if (dy)
	{
		tMaxY = ((sy > 0 ? (cy + 1) * (double)PTGP_CELL : cy * (double)PTGP_CELL) - y0) / dy;
		tDY = (double)PTGP_CELL / abs(dy);
	}
	else
		tMaxY = tDY = 1e30;
	while (cx != ex || cy != ey)
	{
		if (++nGuard > 8192)
			return 0;
		if (tMaxX - tMaxY < 1e-9 && tMaxY - tMaxX < 1e-9)
		{
			if (PTGP_Code(g, cx + sx, cy) != PTGP_FREE || PTGP_Code(g, cx, cy + sy) != PTGP_FREE)
				return 0;
			cx += sx;
			cy += sy;
			tMaxX += tDX;
			tMaxY += tDY;
		}
		else if (tMaxX < tMaxY)
		{
			cx += sx;
			tMaxX += tDX;
		}
		else
		{
			cy += sy;
			tMaxY += tDY;
		}
		if (PTGP_Code(g, cx, cy) != PTGP_FREE)
			return 0;
	}
	return 1;
}

// A straight move between two Mps points crosses only free cells. Also checked 2 Mps aside on the four
// diagonals: the NPC position is fixed point and rounds a little off the ideal line.
static int PTGP_LineFree(PTGP_Grid* g, int x0, int y0, int x1, int y1)
{
	return PTGP_LineFree1(g, x0, y0, x1, y1) &&
		PTGP_LineFree1(g, x0 + 2, y0 + 2, x1 + 2, y1 + 2) && PTGP_LineFree1(g, x0 - 2, y0 - 2, x1 - 2, y1 - 2) &&
		PTGP_LineFree1(g, x0 + 2, y0 - 2, x1 + 2, y1 - 2) && PTGP_LineFree1(g, x0 - 2, y0 + 2, x1 - 2, y1 + 2);
}

static const int s_aPTGP_DX[8] = { 1, 1, 0, -1, -1, -1, 0, 1 };
static const int s_aPTGP_DY[8] = { 0, 1, 1, 1, 0, -1, -1, -1 };

static int PTGP_Heur(int dx, int dy)
{
	dx = abs(dx);
	dy = abs(dy);
	return dx > dy ? PTGP_COST_ORTH * dx + (PTGP_COST_DIAG - PTGP_COST_ORTH) * dy
	               : PTGP_COST_ORTH * dy + (PTGP_COST_DIAG - PTGP_COST_ORTH) * dx;
}

static int PTGP_HeapPush(PTGP_Grid* g, int f, int idx)
{
	int i;
	if (g->nHeap >= g->nHeapCap)
	{
		int nCap = g->nHeapCap ? g->nHeapCap * 2 : 65536;
		int* p = (int*)realloc(g->pHeap, nCap * 2 * sizeof(int));
		if (p == NULL)
			return 0;
		g->pHeap = p;
		g->nHeapCap = nCap;
	}
	i = g->nHeap++;
	while (i > 0)
	{
		int nParent = (i - 1) / 2;
		if (g->pHeap[nParent * 2] <= f)
			break;
		g->pHeap[i * 2] = g->pHeap[nParent * 2];
		g->pHeap[i * 2 + 1] = g->pHeap[nParent * 2 + 1];
		i = nParent;
	}
	g->pHeap[i * 2] = f;
	g->pHeap[i * 2 + 1] = idx;
	return 1;
}

static int PTGP_HeapPop(PTGP_Grid* g)
{
	int nTop = g->pHeap[1], f, idx, i = 0;
	g->nHeap--;
	if (g->nHeap > 0)
	{
		f = g->pHeap[g->nHeap * 2];
		idx = g->pHeap[g->nHeap * 2 + 1];
		for (;;)
		{
			int c = i * 2 + 1;
			if (c >= g->nHeap)
				break;
			if (c + 1 < g->nHeap && g->pHeap[(c + 1) * 2] < g->pHeap[c * 2])
				c++;
			if (g->pHeap[c * 2] >= f)
				break;
			g->pHeap[i * 2] = g->pHeap[c * 2];
			g->pHeap[i * 2 + 1] = g->pHeap[c * 2 + 1];
			i = c;
		}
		g->pHeap[i * 2] = f;
		g->pHeap[i * 2 + 1] = idx;
	}
	return nTop;
}

// Nearest free cell around (*pcx, *pcy), rings up to nRadius. 1 found.
static int PTGP_NearestFree(PTGP_Grid* g, int* pcx, int* pcy, int nRadius)
{
	int r, dx, dy, nBest = -1, bx = 0, by = 0;
	if (PTGP_Code(g, *pcx, *pcy) == PTGP_FREE)
		return 1;
	for (r = 1; r <= nRadius && nBest < 0; r++)
	{
		for (dy = -r; dy <= r; dy++)
		{
			for (dx = -r; dx <= r; dx++)
			{
				int d;
				if (abs(dx) != r && abs(dy) != r)
					continue;
				if (PTGP_Code(g, *pcx + dx, *pcy + dy) != PTGP_FREE)
					continue;
				d = dx * dx + dy * dy;
				if (nBest < 0 || d < nBest)
				{
					nBest = d;
					bx = *pcx + dx;
					by = *pcy + dy;
				}
			}
		}
	}
	if (nBest < 0)
		return 0;
	*pcx = bx;
	*pcy = by;
	return 1;
}

static int PTGP_Walk(int nCode)
{
	return nCode != PTGP_BLOCK;
}

// Shortest path (weighted A*, 8 directions, no corner cutting) from Mps (sx, sy) to Mps (gx, gy), smoothed to
// straight free segments. Writes the turning points (x, y pairs, start excluded, the goal last) to pOut.
// Returns their number (> 0), PTGP_OK_HERE or a PTGP_ERR_* code. *pnExpanded: cells expanded.
static int PTGP_FindPath(PTGP_Grid* g, int sx, int sy, int gx, int gy, int nMaxExpand,
                         int* pOut, int nMaxPts, int* pnExpanded)
{
	int scx = sx / PTGP_CELL, scy = sy / PTGP_CELL;
	int gcx = gx / PTGP_CELL, gcy = gy / PTGP_CELL;
	int nCells, s, t, nExpanded = 0, bFound = 0, d, i, k;
	int* pPath = NULL;
	int nPath = 0, nOut = 0;
	if (pnExpanded)
		*pnExpanded = 0;
	if (sx < 0 || sy < 0 || gx < 0 || gy < 0 ||
		scx < g->nCX0 || scy < g->nCY0 || scx >= g->nCX0 + g->nW || scy >= g->nCY0 + g->nH ||
		gcx < g->nCX0 || gcy < g->nCY0 || gcx >= g->nCX0 + g->nW || gcy >= g->nCY0 + g->nH)
		return PTGP_ERR_OUTSIDE;
	if (PTGP_Code(g, gcx, gcy) != PTGP_FREE)
	{
		if (!PTGP_NearestFree(g, &gcx, &gcy, 12))
			return PTGP_ERR_GOAL;
		gx = gcx * PTGP_CELL + PTGP_CELL / 2;
		gy = gcy * PTGP_CELL + PTGP_CELL / 2;
	}
	if (scx == gcx && scy == gcy)
	{
		if (nMaxPts < 1)
			return PTGP_OK_HERE;
		pOut[0] = gx;
		pOut[1] = gy;
		return 1;
	}
	nCells = g->nW * g->nH;
	if (g->pG == NULL)
	{
		g->pG = (int*)malloc(nCells * sizeof(int));
		g->pFrom = (unsigned char*)malloc(nCells);
		g->pState = (unsigned char*)malloc(nCells);
		if (g->pG == NULL || g->pFrom == NULL || g->pState == NULL)
			return PTGP_ERR_MEMORY;
	}
	memset(g->pState, 0, nCells);
	g->nHeap = 0;
	s = (scy - g->nCY0) * g->nW + (scx - g->nCX0);
	t = (gcy - g->nCY0) * g->nW + (gcx - g->nCX0);
	g->pG[s] = 0;
	g->pFrom[s] = 0xFF;
	g->pState[s] = 1;
	if (!PTGP_HeapPush(g, 0, s))
		return PTGP_ERR_MEMORY;
	while (g->nHeap > 0)
	{
		int cur = PTGP_HeapPop(g), cx, cy;
		if (g->pState[cur] == 2)
			continue;
		g->pState[cur] = 2;
		if (cur == t)
		{
			bFound = 1;
			break;
		}
		if (++nExpanded > nMaxExpand)
			break;
		cx = cur % g->nW + g->nCX0;
		cy = cur / g->nW + g->nCY0;
		for (d = 0; d < 8; d++)
		{
			int nx = cx + s_aPTGP_DX[d], ny = cy + s_aPTGP_DY[d];
			int nCode, nCost, ng, j;
			if (nx < g->nCX0 || ny < g->nCY0 || nx >= g->nCX0 + g->nW || ny >= g->nCY0 + g->nH)
				continue;
			j = (ny - g->nCY0) * g->nW + (nx - g->nCX0);
			if (g->pState[j] == 2)
				continue;
			nCode = PTGP_Code(g, nx, ny);
			if (!PTGP_Walk(nCode))
				continue;
			if (d & 1)
			{
				int nSide1 = PTGP_Code(g, nx, cy), nSide2 = PTGP_Code(g, cx, ny);
				if (!PTGP_Walk(nSide1) || !PTGP_Walk(nSide2))
					continue;     // no corner cutting
				nCost = PTGP_COST_DIAG;
				if (nSide1 != PTGP_FREE || nSide2 != PTGP_FREE)
					nCost *= PTGP_PART_MUL;     // past a half cell: allowed, but not a straight line
			}
			else
				nCost = PTGP_COST_ORTH;
			if (nCode == PTGP_PART)
				nCost *= PTGP_PART_MUL;
			else if (nCode == PTGP_TRAP)
				nCost *= PTGP_TRAP_MUL;
			else if (PTGP_Code(g, nx + 1, ny) != PTGP_FREE || PTGP_Code(g, nx - 1, ny) != PTGP_FREE ||
				PTGP_Code(g, nx, ny + 1) != PTGP_FREE || PTGP_Code(g, nx, ny - 1) != PTGP_FREE)
				nCost += PTGP_WALL_EXTRA;
			ng = g->pG[cur] + nCost;
			if (g->pState[j] == 1 && ng >= g->pG[j])
				continue;
			g->pG[j] = ng;
			g->pFrom[j] = (unsigned char)d;
			g->pState[j] = 1;
			// weight 1.2: a little longer paths, far fewer cells expanded on big maps
			if (!PTGP_HeapPush(g, ng + PTGP_Heur(gcx - nx, gcy - ny) * 6 / 5, j))
				return PTGP_ERR_MEMORY;
		}
	}
	if (pnExpanded)
		*pnExpanded = nExpanded;
	if (!bFound)
		return nExpanded > nMaxExpand ? PTGP_ERR_LIMIT : PTGP_ERR_NOPATH;

	// cells from the goal back to the start
	for (i = t; i != s; )
	{
		d = g->pFrom[i];
		if (d > 7)
			break;
		nPath++;
		i -= s_aPTGP_DY[d] * g->nW + s_aPTGP_DX[d];
	}
	pPath = (int*)malloc((nPath + 1) * 2 * sizeof(int));
	if (pPath == NULL)
		return PTGP_ERR_MEMORY;
	k = nPath;          // pPath[0] = start cell centre ... pPath[nPath] = goal
	for (i = t; k >= 0; k--)
	{
		pPath[k * 2] = (i % g->nW + g->nCX0) * PTGP_CELL + PTGP_CELL / 2;
		pPath[k * 2 + 1] = (i / g->nW + g->nCY0) * PTGP_CELL + PTGP_CELL / 2;
		if (k == 0)
			break;
		d = g->pFrom[i];
		i -= s_aPTGP_DY[d] * g->nW + s_aPTGP_DX[d];
	}
	pPath[0] = sx;
	pPath[1] = sy;
	pPath[nPath * 2] = gx;
	pPath[nPath * 2 + 1] = gy;

	// string pulling: from each anchor, the farthest cell of the path still reachable in a straight line
	i = 0;
	while (i < nPath && nOut < nMaxPts)
	{
		int nBest = i + 1, nMiss = 0;
		for (k = i + 1; k <= nPath; k++)
		{
			if (PTGP_LineFree(g, pPath[i * 2], pPath[i * 2 + 1], pPath[k * 2], pPath[k * 2 + 1]))
			{
				nBest = k;
				nMiss = 0;
			}
			else if (++nMiss > 24)
				break;
		}
		pOut[nOut * 2] = pPath[nBest * 2];
		pOut[nOut * 2 + 1] = pPath[nBest * 2 + 1];
		nOut++;
		i = nBest;
	}
	free(pPath);
	return nOut;
}

#endif // PHONGTHAN_GOTOPATH_H
