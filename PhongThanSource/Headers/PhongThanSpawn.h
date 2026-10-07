#ifndef PHONGTHAN_SPAWN_H
#define PHONGTHAN_SPAWN_H
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Runtime map IDs are explicitly namespaced in ServerCfg.ini. Coordinates are
// read unchanged from the original VNG revivepos.ini, never from minimap pixels.
inline BOOL PhongThanResolveRevivalPoint(unsigned int runtimeMap, int revivalId, POINT* point)
{
	if (!point) return FALSE;
	point->x = 0; point->y = 0;
	char config[MAX_PATH], path[MAX_PATH];
	if (!GetFullPathNameA("ServerCfg.ini", sizeof(config), config, 0) ||
		!GetFullPathNameA("settings\\revivepos.ini", sizeof(path), path, 0)) return FALSE;
	const unsigned int offset = GetPrivateProfileIntA("MapIdentity", "RuntimeIdOffset", 0, config);
	if (runtimeMap <= offset) return FALSE;
	char section[24], key[24], value[128], choices[512];
	sprintf(section, "%u", runtimeMap - offset);
	if (revivalId > 0)
	{
		sprintf(key, "%d", revivalId);
		GetPrivateProfileStringA(section, key, "", value, sizeof(value), path);
		int x, y;
		if (sscanf(value, "%d,%d", &x, &y) == 2 && x > 0 && y > 0)
		{ point->x = x; point->y = y; return TRUE; }
		return FALSE;
	}
	GetPrivateProfileStringA(section, "region", "", choices, sizeof(choices), path);
	char* cursor = choices;
	while (*cursor)
	{
		char* end = cursor;
		const long candidate = strtol(cursor, &end, 10);
		if (end == cursor) return FALSE;
		sprintf(key, "%ld", candidate);
		GetPrivateProfileStringA(section, key, "", value, sizeof(value), path);
		int x, y;
		if (sscanf(value, "%d,%d", &x, &y) == 2 && x > 0 && y > 0)
		{ point->x = x; point->y = y; return TRUE; }
		cursor = end;
		while (*cursor == ' ' || *cursor == ',') ++cursor;
	}
	return FALSE;
}
#endif
