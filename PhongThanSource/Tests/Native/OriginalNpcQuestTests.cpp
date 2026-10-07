// Actual VNG Lua4 fixtures, with ONLY engine/player state APIs mocked.
// Run prepare_original_npc_quest_tests.py --write to verify PAK provenance first.
// This proves script state transitions, not production inventory atomicity or UI.
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KLuaScript.h"

struct Tuple { int g,d,p,l,s,luck,count; };
struct PlayerState {
    int task[2048], level, playerType, camp, money, exp, credit;
    int freeCells, legacyReject, failedRewards, grants;
    Tuple items[256]; int itemTypes;
};
static PlayerState player;
static char allowed[32][64]; static int optionCount;
static int assertions, cases;
static const char* activeCase;
static KLuaScript scripts[13];
enum { TOHO, THUKHO, LOAN, LOI, DIEN, NAMCUC, HOANGLONG, NHIENDANG,
       HAUTHO, CAOGIAC, CAOMINH, HINHTHIEN, TOHOFIX };

#define CHECK(c) do { ++assertions; if(!(c)){ printf("FAIL %s line=%d %s\n",activeCase,__LINE__,#c); return false; } } while(0)

static bool Same(const Tuple&a,const Tuple&b){return a.g==b.g && a.d==b.d && a.p==b.p && a.l==b.l && a.s==b.s;}
static int Find(const Tuple&t){for(int i=0;i<player.itemTypes;++i)if(Same(player.items[i],t))return i;return -1;}
static int Count(const Tuple&t){int i=Find(t);return i<0?0:player.items[i].count;}
static int CountItem(int g,int d,int p=0,int l=0){Tuple t={g,d,p,l,0,0,0};return Count(t);}
static void Give(Tuple t){int i=Find(t);if(i<0){i=player.itemTypes++;player.items[i]=t;player.items[i].count=0;}player.items[i].count+=t.count;}
static void Seed(int g,int d,int amount,int p=0,int l=0){Tuple t={g,d,p,l,0,0,amount};Give(t);}
static void Reset(const char*name){ZeroMemory(&player,sizeof(player));optionCount=0;player.level=10;player.freeCells=100;activeCase=name;++cases;}
static int N(Lua_State*L,int i){return (int)Lua_ValueToNumber(L,i);}
static int Result(Lua_State*L,int value){Lua_PushNumber(L,value);return 1;}
static Tuple Args(Lua_State*L){Tuple t={N(L,1),N(L,2),N(L,3),N(L,4),0,0,1};if(Lua_GetTopIndex(L)>4)t.s=N(L,5);if(Lua_GetTopIndex(L)>5)t.luck=N(L,6);return t;}
static bool Supported(const Tuple&t){return !player.legacyReject || t.g==3 || t.g==4 || t.g==6 || t.g==8;}
static int GetTask(Lua_State*L){int n=N(L,1);if(n<0||n>=2048)lua_error(L,"invalid task");return Result(L,player.task[n]);}
static int SetTask(Lua_State*L){int n=N(L,1);if(n<0||n>=2048)lua_error(L,"invalid task");player.task[n]=N(L,2);return 0;}
static int Have(Lua_State*L){return Result(L,Count(Args(L)));}
static int Add(Lua_State*L){Tuple t=Args(L);if(!Supported(t)||player.freeCells<1){++player.failedRewards;return Result(L,0);}Give(t);--player.freeCells;++player.grants;return Result(L,1);}
static int Del(Lua_State*L){Tuple t=Args(L);int i=Find(t);if(i<0||!player.items[i].count)return Result(L,0);--player.items[i].count;return Result(L,1);}
static int EventHave(Lua_State*L){return Result(L,CountItem(4,N(L,1)));}
static int EventAdd(Lua_State*L){Tuple t={4,N(L,1),0,0,0,0,1};if(player.freeCells<1){++player.failedRewards;return Result(L,0);}Give(t);--player.freeCells;return Result(L,1);}
static int EventDel(Lua_State*L){Tuple t={4,N(L,1),0,0,0,0,1};int i=Find(t);if(i<0||!player.items[i].count)return Result(L,0);--player.items[i].count;return Result(L,1);}
static int Level(Lua_State*L){return Result(L,player.level);}
static int Type(Lua_State*L){return Result(L,player.playerType);}
static int Camp(Lua_State*L){return Result(L,player.camp);}
static int SetCamp(Lua_State*L){player.camp=N(L,1);return 0;}
static int Cash(Lua_State*L){return Result(L,player.money);}
static int Earn(Lua_State*L){player.money+=N(L,1);return Result(L,1);}
static int Exp(Lua_State*L){player.exp+=N(L,1);return Result(L,1);}
static int Credit(Lua_State*L){player.credit+=N(L,1);return Result(L,1);}
static int Stub(Lua_State*){return 0;}
static int Zero(Lua_State*L){return Result(L,0);}
static int Clock(Lua_State*L){return Result(L,1789516800);}
static int Random(Lua_State*L){return Result(L,N(L,1));}
static int Name(Lua_State*L){Lua_PushString(L,"QuestFixturePlayer");return 1;}
static void Offer(Lua_State*L,const char*name){
    if(!name||!name[0])return;
    lua_getglobal(L,name);bool ok=lua_isfunction(L,-1)!=0;lua_pop(L,1);
    if(!ok)lua_error(L,"dialogue references an undefined callback");
    if(optionCount>=32 || strlen(name)>=64)lua_error(L,"dialogue overflow");
    strcpy(allowed[optionCount++],name);
}
static bool Offered(const char*fn){for(int i=0;i<optionCount;++i)if(!strcmp(allowed[i],fn))return true;return false;}
static int SayTask(Lua_State*L){
    if(!lua_istable(L,2))lua_error(L,"SayTask expects table");
    int count=lua_getn(L,2);
    for(int i=1;i<=count;++i){
        lua_rawgeti(L,2,i);int row=lua_gettop(L);
        if(!lua_istable(L,row))lua_error(L,"SayTask invalid row");
        lua_pushstring(L,"show");lua_gettable(L,row);bool show=N(L,-1)!=0;lua_pop(L,1);
        if(show){lua_rawgeti(L,row,2);Offer(L,Lua_ValueToString(L,-1));lua_pop(L,1);}
        lua_pop(L,1);
    }
    return 0;
}
static int Talk(Lua_State*L){if(lua_gettop(L)<N(L,1)+2)lua_error(L,"Talk argument count");Offer(L,Lua_ValueToString(L,2));return 0;}
static int Box(Lua_State*L){for(int i=2;i<=lua_gettop(L);++i)Offer(L,Lua_ValueToString(L,i));return 0;}

static bool ReadTuple(Lua_State*L,int table,int i,Tuple&t){
    lua_rawgeti(L,table,i);int row=lua_gettop(L);
    if(!lua_istable(L,row)||lua_getn(L,row)!=7){lua_pop(L,1);return false;}
    int values[7];for(int k=1;k<=7;++k){lua_rawgeti(L,row,k);values[k-1]=N(L,-1);lua_pop(L,1);}
    t.g=values[0];t.d=values[1];t.p=values[2];t.l=values[3];t.s=values[4];t.luck=values[5];t.count=values[6];lua_pop(L,1);
    return t.count>0 && t.count<=100;
}
// Model the parent's QuestExchange API contract, not its implementation. Native
// production tests must separately prove reserve/rollback/save behavior.
static int Exchange(Lua_State*L){
    int task=N(L,1),expected=N(L,2),next=N(L,3);
    if(task<0||task>=2048||player.task[task]!=expected)return Result(L,0);
    if(!lua_istable(L,4)||!lua_istable(L,5))return Result(L,0);
    int nr=lua_getn(L,4),ng=lua_getn(L,5),needed=0;
    if(nr>16||ng>16)return Result(L,0);
    Tuple req[16],gift[16];
    for(int i=0;i<nr;++i)if(!ReadTuple(L,4,i+1,req[i])||Count(req[i])<req[i].count)return Result(L,0);
    for(i=0;i<ng;++i){if(!ReadTuple(L,5,i+1,gift[i])||!Supported(gift[i]))return Result(L,0);needed+=gift[i].count;}
    if(player.freeCells<needed)return Result(L,0);
    for(i=0;i<nr;++i)player.items[Find(req[i])].count-=req[i].count;
    for(i=0;i<ng;++i)Give(gift[i]);
    player.freeCells-=needed;player.grants+=needed;player.task[task]=next;
    return Result(L,1);
}

static bool Call(int script,const char*fn,bool mustBeOffered=false){
    if(mustBeOffered)CHECK(Offered(fn));
    optionCount=0;
    CHECK(scripts[script].CallFunction((char*)fn,0,""));
    return true;
}
static bool Visit(int script,const char*fn){CHECK(Call(script,"main"));CHECK(Call(script,fn,true));return true;}

static bool HopGam(int toHo){
    const int orders[6][3]={{LOAN,LOI,DIEN},{LOAN,DIEN,LOI},{LOI,LOAN,DIEN},{LOI,DIEN,LOAN},{DIEN,LOAN,LOI},{DIEN,LOI,LOAN}};
    for(int permutation=0;permutation<6;++permutation){
        Reset(toHo==TOHO?"original task20 all permutations":"derived task20 all permutations");
        CHECK(Call(THUKHO,"main"));CHECK(!Offered("renwu3"));
        CHECK(Visit(toHo,"renwu1"));CHECK(Call(toHo,"yes_1",true));CHECK(player.task[20]==1);
        CHECK(Visit(THUKHO,"renwu3"));CHECK(player.task[20]==10);
        int expected=10;
        for(int j=0;j<3;++j){
            int who=orders[permutation][j];expected+=(who==LOAN?1:who==LOI?2:4);
            CHECK(Visit(who,"renwu1"));CHECK(player.task[20]==expected);
            CHECK(Call(who,"main"));CHECK(!Offered("renwu1"));
        }
        CHECK(expected==17);CHECK(Visit(THUKHO,"renwu3"));CHECK(player.task[20]==18&&CountItem(4,26)==1);
        CHECK(Visit(toHo,"renwu1"));CHECK(player.task[20]==19&&CountItem(4,26)==0);
        CHECK(CountItem(1,0,1,1)==3&&CountItem(1,3,1,1)==3);
        CHECK(Call(toHo,"main"));CHECK(!Offered("renwu1"));
        CHECK(Call(toHo,"renwu1"));CHECK(player.grants==6&&player.task[20]==19);
    }
    return true;
}

static bool OriginalHazards(){
    Reset("original rejected medicine genre consumes reward item");
    player.task[20]=18;player.legacyReject=1;Seed(4,26,1);
    CHECK(Visit(TOHO,"renwu1"));CHECK(player.failedRewards==6&&player.grants==0);
    CHECK(player.task[20]==19&&CountItem(4,26)==0);
    printf("EVIDENCE original task20 unchecked rejected reward consumes Event26 and advances19\n");
    Reset("original full bag loses hand-in reward");player.task[20]=18;player.freeCells=0;Seed(4,26,1);
    CHECK(Visit(TOHO,"renwu1"));CHECK(player.task[20]==19&&player.grants==0&&CountItem(4,26)==0);
    Reset("original stale accept callback can reset completed task");player.task[20]=19;
    CHECK(Call(TOHO,"yes_1"));CHECK(player.task[20]==1);
    printf("EVIDENCE original stale yes_1 resets completed task20 to1 (callback must be guarded)\n");
    return true;
}

static bool FixedHazards(){
    Reset("derived wrong phase cannot reopen completed task");player.task[20]=19;
    CHECK(Call(TOHOFIX,"yes_1"));CHECK(Call(TOHOFIX,"renwu1"));CHECK(player.task[20]==19&&player.grants==0);
    Reset("derived repeated accept");CHECK(Visit(TOHOFIX,"renwu1"));CHECK(Call(TOHOFIX,"yes_1",true));CHECK(Call(TOHOFIX,"yes_1"));CHECK(player.task[20]==1);
    Reset("derived missing quest item");player.task[20]=18;CHECK(Call(TOHOFIX,"renwu1"));CHECK(player.task[20]==18&&player.grants==0);
    Reset("derived unsupported reward definition");player.task[20]=18;player.legacyReject=1;Seed(4,26,1);
    CHECK(Visit(TOHOFIX,"renwu1"));CHECK(player.task[20]==18&&CountItem(4,26)==1&&player.grants==0);
    Reset("derived insufficient reserve slots");player.task[20]=18;player.freeCells=5;Seed(4,26,1);
    CHECK(Visit(TOHOFIX,"renwu1"));CHECK(player.task[20]==18&&CountItem(4,26)==1&&player.grants==0);
    player.freeCells=6;CHECK(Visit(TOHOFIX,"renwu1"));CHECK(player.task[20]==19&&CountItem(4,26)==0&&player.grants==6);
    CHECK(Call(TOHOFIX,"renwu1"));CHECK(player.task[20]==19&&player.grants==6);
    return true;
}

static bool NguThat(){
    Reset("original NgocHu task11 entire Ng u That chain");player.playerType=1;player.level=2;
    CHECK(Call(NAMCUC,"main"));CHECK(!Offered("renwu2"));
    player.level=3;CHECK(Visit(NAMCUC,"renwu2"));CHECK(Call(NAMCUC,"yes_2",true));CHECK(player.task[11]==1);
    CHECK(Visit(HOANGLONG,"renwu2"));CHECK(player.task[11]==2);
    Seed(3,13,9);CHECK(Call(NAMCUC,"main"));CHECK(!Offered("renwu2"));
    Seed(3,13,1);CHECK(Visit(NAMCUC,"renwu2"));CHECK(player.task[11]==3&&CountItem(3,13)==0);
    CHECK(Visit(NHIENDANG,"renwu1"));CHECK(player.task[11]==4&&CountItem(4,20)==1);
    CHECK(Visit(NAMCUC,"renwu2"));CHECK(player.task[11]==5&&CountItem(4,20)==0&&player.money==600&&player.exp==500);
    CHECK(Call(NAMCUC,"main"));CHECK(!Offered("renwu2"));CHECK(Call(NAMCUC,"renwu2"));CHECK(player.money==600&&player.exp==500);
    return true;
}

static bool TanThuc(){
    Reset("original Xiyou task31 entire Tan Thuc chain");player.playerType=2;player.level=2;
    CHECK(Call(HAUTHO,"main"));CHECK(!Offered("renwu1"));
    player.level=3;CHECK(Visit(HAUTHO,"renwu1"));CHECK(Call(HAUTHO,"yes_1",true));CHECK(player.task[31]==1);
    CHECK(Visit(CAOGIAC,"renwu1"));CHECK(player.task[31]==2);
    CHECK(Visit(CAOMINH,"renwu2"));CHECK(player.task[31]==3&&CountItem(4,29)==1);
    CHECK(Visit(HINHTHIEN,"renwu1"));CHECK(player.task[31]==4&&CountItem(4,29)==0);
    CHECK(Visit(CAOMINH,"renwu2"));CHECK(player.task[31]==5);
    Seed(3,12,9);CHECK(Call(HAUTHO,"main"));CHECK(!Offered("renwu1"));
    Seed(3,12,1);CHECK(Visit(HAUTHO,"renwu1"));CHECK(player.task[31]==6&&CountItem(3,12)==0&&player.money==600&&player.exp==500);
    CHECK(Call(HAUTHO,"main"));CHECK(!Offered("renwu1"));CHECK(Call(HAUTHO,"renwu1"));CHECK(player.money==600&&player.exp==500);
    return true;
}

static bool Warehouse(){
    Reset("original ThuKho shared warehouse unlock");
    CHECK(Visit(THUKHO,"renwu1"));CHECK(Call(THUKHO,"yes_1",true));CHECK(player.task[23]==1);
    Seed(3,11,4);CHECK(Call(THUKHO,"main"));CHECK(!Offered("renwu1"));
    Seed(3,11,1);CHECK(Visit(THUKHO,"renwu1"));CHECK(CountItem(3,11)==0);
    CHECK(player.task[23]==2&&player.task[33]==2&&player.task[13]==2);
    CHECK(Call(THUKHO,"main"));CHECK(!Offered("renwu1"));
    return true;
}

static bool WarehouseCollection(){
    Reset("original ThuKho repeatable collect task26");player.level=5;
    CHECK(Call(THUKHO,"main"));CHECK(!Offered("renwu2"));
    player.level=6;CHECK(Visit(THUKHO,"renwu2"));CHECK(Call(THUKHO,"yes_2",true));
    CHECK(Call(THUKHO,"qd1",true));CHECK(player.task[26]==10);
    Seed(3,10,9);CHECK(Call(THUKHO,"main"));CHECK(!Offered("renwu2"));
    Seed(3,10,1);CHECK(Visit(THUKHO,"renwu2"));CHECK(Call(THUKHO,"huan",true));
    CHECK(player.task[26]==0&&CountItem(3,10)==0&&CountItem(4,39)==1);
    CHECK(player.money==600&&player.credit==1);
    CHECK(Call(THUKHO,"huan"));CHECK(player.money==600&&player.credit==1&&CountItem(4,39)==1);
    CHECK(Visit(THUKHO,"renwu2"));CHECK(Call(THUKHO,"yes_2",true));CHECK(Call(THUKHO,"qd1",true));
    Seed(3,10,10);CHECK(Visit(THUKHO,"renwu2"));CHECK(Call(THUKHO,"huan",true));
    CHECK(player.task[26]==0&&player.money==1200&&player.credit==2&&CountItem(4,39)==2);
    return true;
}

int main(int argc,char**argv){
    if(argc!=2)return 2;
    SetErrorMode(SEM_FAILCRITICALERRORS|SEM_NOGPFAULTERRORBOX);
    if(!SetCurrentDirectoryA(argv[1]))return 3;
    g_SetRootPath(NULL);g_SetFilePath("\\");
    char* names[]={"\\to_ho.lua","\\thu_kho.lua","\\sung_ung_loan.lua","\\trieu_loi.lua","\\trieu_dien.lua",
        "\\nam_cuc.lua","\\hoang_long.lua","\\nhien_dang.lua","\\hau_tho.lua","\\cao_giac.lua","\\cao_minh.lua","\\hinh_thien.lua","\\to_ho_transactional.lua"};
    TLua_Funcs api[]={{"GetTask",GetTask},{"SetTask",SetTask},{"HaveNormalItem",Have},{"AddNormalItem",Add},{"AddNormalItem2",Add},
        {"DelNormalItem",Del},{"HaveEventItem",EventHave},{"AddEventItem",EventAdd},{"DelEventItem",EventDel},
        {"GetLevel",Level},{"GetPlayerType",Type},{"GetCamp",Camp},{"SetCamp",SetCamp},{"GetCash",Cash},{"Earn",Earn},
        {"AddOwnExp",Exp},{"AddCredit",Credit},{"Msg2Player",Stub},{"TaskNote",Stub},{"CloseDialog",Stub},
        {"GetExtPoint",Zero},{"SystemTime",Clock},{"SayTask",SayTask},{"Talk",Talk},{"MsgBox",Box},
        {"random",Random},{"GetName",Name},{"QuestExchange",Exchange}};
    for(int i=0;i<13;++i){
        if(!scripts[i].Init()||!scripts[i].RegisterFunctions(api,sizeof(api)/sizeof(api[0]))||!scripts[i].Load(names[i])){
            printf("FAIL load original fixture %s\n",names[i]);return 4;
        }
    }
    if(!HopGam(TOHO)||!OriginalHazards()||!HopGam(TOHOFIX)||!FixedHazards()||!NguThat()||!TanThuc()||!Warehouse()||!WarehouseCollection())return 5;
    printf("PASS ORIGINAL_NPC_QUESTS original_scripts=12 derived_scripts=1 cases=%d assertions=%d chains=5 notify_permutations=12\n",cases,assertions);
    printf("SCOPE actual Lua4 + mock state APIs; no runtime UI/save/production transaction assertion\n");
    return 0;
}
