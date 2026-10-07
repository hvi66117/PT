#ifndef PHONGTHAN_SET_TABLE_H
#define PHONGTHAN_SET_TABLE_H
#include <string.h>
#include <stdlib.h>
#include <errno.h>

// Original VNG set table: name, ID, ten (type,value) pairs. Retain source
// slots, including holes between the first and full-set tiers.
struct PhongThanSetRow { int id; int type[10]; int value[10]; };
inline bool PhongThanSetNumber(const char* first, const char* last, int& out)
{
    out=0; if(first==last) return true;
    if(last-first>=32) return false;
    char text[32]; memcpy(text,first,last-first);text[last-first]=0;
    char* end=0;errno=0;long n=strtol(text,&end,10);
    if(end==text || *end || errno==ERANGE) return false;
    out=(int)n;return true;
}
inline int PhongThanParseSetTable(const char* data, int size, PhongThanSetRow* rows, int capacity)
{
    if(!data || size<=0 || !rows || capacity<=0) return -1;
    const char* p=data;const char* end=data+size;
    // Require the known header prefix and literal ID column. Names remain bytes.
    const char prefix[]="\xC2\xCC\xD7\xB0\xC3\xFB\xB3\xC6\tID\t";
    if(size<(int)sizeof(prefix)-1 || memcmp(data,prefix,sizeof(prefix)-1))return -1;
    while(p<end && *p!='\n')++p;if(p<end)++p;
    int count=0;
    while(p<end){
        const char* line=p;while(p<end && *p!='\r' && *p!='\n')++p;
        const char* stop=p;while(p<end && (*p=='\r'||*p=='\n'))++p;
        if(line==stop)continue;
        PhongThanSetRow row;memset(&row,0,sizeof(row));
        const char* cell=line;int column=0;
        while(cell<=stop){
            const char* sep=cell;while(sep<stop && *sep!='\t')++sep;
            if(column==1){if(!PhongThanSetNumber(cell,sep,row.id))return -2;}
            else if(column>=2 && column<22){
                int slot=(column-2)/2;int& number=(column%2==0)?row.type[slot]:row.value[slot];
                if(!PhongThanSetNumber(cell,sep,number))return -2;
            }
            ++column;if(sep==stop)break;cell=sep+1;
        }
        if(row.id<=0)continue;
        for(int i=0;i<count;++i)if(rows[i].id==row.id)return -3;
        if(count>=capacity)return -4;
        rows[count++]=row;
    }
    return count;
}
#endif
