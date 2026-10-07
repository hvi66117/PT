#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <vector>
enum { MAX_SUBWORLD=2, MAX_NPCSTYLE=3000, kind_dialoger=3 };
struct KNpcFileHead { unsigned int uNumNpc, uReserved[2]; };
struct KSPNpc {
    int nTemplateID,nPositionX,nPositionY; bool bSpecialNpc; char reserved[3];
    char szName[32]; short nLevel,nCurFrame,nHeadImageNo,shKind;
    unsigned char cCamp,cSeries; unsigned short nScriptNameLen; char szScript[260];
};
struct World { int m_SubWorldID; } SubWorld[MAX_SUBWORLD];
struct NpcMock { int m_Kind; DWORD m_ActionScriptID; } Npc[10];
static int added=0;
struct NpcSetMock { int Add(int, KSPNpc* cell) { ++added; Npc[added].m_Kind=cell->shKind;Npc[added].m_ActionScriptID=1;return added; } } NpcSet;
static void* g_GetScript(DWORD) { return (void*)1; }
static DWORD g_FileName2Id(const char*) { return 1; }
static BOOL ReLoadScript(const char*) { return TRUE; }
static std::vector<BYTE> overrideBytes;
static std::vector<BYTE> standaloneBytes;
class KPakFile {
public:
    std::vector<BYTE> bytes;
    DWORD offset;
    KPakFile():offset(0) {}
    BOOL Open(const char* path) {
        bytes = strstr(path,"_npc_s.dat") ? standaloneBytes : overrideBytes;
        offset=0;return !bytes.empty();
    }
    DWORD Size() { return bytes.size(); }
    DWORD Seek(DWORD value,int) { offset=value;return offset; }
    DWORD Read(void* out,DWORD size) { if(offset>bytes.size() || size>bytes.size()-offset)return 0;memcpy(out,&bytes[offset],size);offset+=size;return size; }
};
class KRegion {public:int m_RegionID;BOOL LoadServerNpc(int,KPakFile*,DWORD);};
#include "../../Sources/Core/Src/PhongThanRegionNpc.inl"
#define CHECK(x) do{if(!(x)){printf("FAIL line=%d\n",__LINE__);return 1;}}while(0)
int main() {
    KRegion region;region.m_RegionID=1;SubWorld[0].m_SubWorldID=1052;
    KPakFile file;file.bytes.resize(73,0);
    KNpcFileHead header;memset(&header,0,sizeof(header));header.uNumNpc=1;
    KSPNpc cell;memset(&cell,0,sizeof(cell));cell.nTemplateID=225;cell.nLevel=1;cell.shKind=3;cell.nScriptNameLen=1;
    cell.nPositionX=512;
    memcpy(&file.bytes[0],&header,12);memcpy(&file.bytes[12],&cell,60);
    CHECK(region.LoadServerNpc(0,&file,73));CHECK(added==1);
    added=0;
    file.offset=0;
    CHECK(!region.LoadServerNpc(0,&file,72));CHECK(added==0);
    file.offset=0;
    cell.nScriptNameLen=65535;memcpy(&file.bytes[12],&cell,60);
    CHECK(!region.LoadServerNpc(0,&file,73));CHECK(added==0);
    file.offset=0;
    cell.nScriptNameLen=1;cell.nTemplateID=MAX_NPCSTYLE;memcpy(&file.bytes[12],&cell,60);
    CHECK(!region.LoadServerNpc(0,&file,73));CHECK(added==0);
    CHECK(!region.LoadServerNpc(-1,&file,73));
    CHECK(region.LoadServerNpc(0,&file,0));
    CHECK(!region.LoadServerNpc(0,&file,74));
    overrideBytes.resize(52+73,0);
    DWORD sectionCount=6, sectionOffset=0, sectionLength=73;
    memcpy(&overrideBytes[0],&sectionCount,4);
    memcpy(&overrideBytes[20],&sectionOffset,4);
    memcpy(&overrideBytes[24],&sectionLength,4);
    cell.nTemplateID=149;
    memcpy(&overrideBytes[52],&header,12);memcpy(&overrideBytes[64],&cell,60);
    CHECK(region.LoadServerNpc(0,&file,0));CHECK(added==1);
    added=0;
    sectionLength=65535;memcpy(&overrideBytes[24],&sectionLength,4);
    CHECK(!region.LoadServerNpc(0,&file,0));CHECK(added==0);
    overrideBytes.clear();
    standaloneBytes.resize(73,0);
    memcpy(&standaloneBytes[0],&header,12);memcpy(&standaloneBytes[12],&cell,60);
    CHECK(region.LoadServerNpc(0,&file,0));CHECK(added==1);
    added=0;
    // A base NPC section wins over the standalone file (one spawn pass).
    cell.nTemplateID=225;memcpy(&file.bytes[12],&cell,60);file.offset=0;
    CHECK(region.LoadServerNpc(0,&file,73));CHECK(added==1);
    added=0;
    cell.nPositionX=1024;memcpy(&standaloneBytes[12],&cell,60);
    CHECK(!region.LoadServerNpc(0,&file,0));CHECK(added==0);
    cell.nPositionX=512;cell.nScriptNameLen=100;memcpy(&standaloneBytes[12],&cell,60);
    CHECK(!region.LoadServerNpc(0,&file,0));CHECK(added==0);
    standaloneBytes.clear();
    puts("PASS ORIGINAL_AND_STANDALONE_NPC: bounds, coordinates, template, single-pass priority");
    return 0;
}
