#include "../../../Headers/PhongThanEquipmentPresentation.h"
#include <map>
#include <string>

static void PhongThanDrawSlotImage(KRUImage image,int x,int y,int width,int height,bool allowShrink)
{
    KRPosition2 offset,size;
    if(!g_pRepresent || width<=0 || height<=0 ||
       !g_pRepresent->GetImageFrameParam(image.szImage,image.nFrame,&offset,&size,ISI_T_SPR) ||
       size.nX<=0 || size.nY<=0)return;
    image.bRenderStyle=IMAGE_RENDER_STYLE_ALPHA;
    image.bRenderFlag=RUIMAGE_RENDER_FLAG_FRAME_DRAW;
    image.Color.Color_b.a=255;
    if(allowShrink && (size.nX>width || size.nY>height))
    {
        int w=size.nX,h=size.nY;
        if(w>width){h=h*width/w;w=width;}
        if(h>height){w=w*height/h;h=height;}
        image.oPosition.nX=x+(width-w)/2;image.oPosition.nY=y+(height-h)/2;
        image.oEndPos.nX=image.oPosition.nX+w;image.oEndPos.nY=image.oPosition.nY+h;
        if(w>0 && h>0)g_pRepresent->DrawPrimitives(1,&image,RU_T_IMAGE_STRETCH,TRUE);
        return;
    }
    // Clip oversized effects, otherwise retain original pixels and frame offset.
    KRUImagePart part;ZeroMemory(&part,sizeof(part));
    static_cast<KRUImage&>(part)=image;
    part.oPosition.nX=x+(width-size.nX)/2;part.oPosition.nY=y+(height-size.nY)/2;
    part.oImgLTPos.nX=size.nX>width?(size.nX-width)/2:0;
    part.oImgLTPos.nY=size.nY>height?(size.nY-height)/2:0;
    part.oPosition.nX+=part.oImgLTPos.nX;part.oPosition.nY+=part.oImgLTPos.nY;
    part.oImgRBPos.nX=part.oImgLTPos.nX+(size.nX<width?size.nX:width);
    part.oImgRBPos.nY=part.oImgLTPos.nY+(size.nY<height?size.nY:height);
    g_pRepresent->DrawPrimitives(1,&part,RU_T_IMAGE_PART,TRUE);
}

static void PhongThanEquipLargeImage(KItem& item,KRUImage& image)
{
    if(item.GetGenre()!=item_equip)return;
    const KBASICPROP_EQUIPMENT* data=ItemGen.CatalogEquipment(item.GetDetailType(),item.GetRow());
    if(!data || !data->m_nHasSpecialImage)return;
    int actor=Player[CLIENT_PLAYER_INDEX].m_nIndex;
    bool female=data->m_nSpecialSex && actor>0 && actor<MAX_NPC && Npc[actor].m_nSex==1;
    char path[128];
    if(!PhongThanBigItemPath(image.szImage,female,path,sizeof(path)))return;
    // Cache misses too; missing variants must not re-open a PAK every frame.
    static std::map<std::string,bool> available;
    std::map<std::string,bool>::iterator found=available.find(path);
    if(found==available.end())
    {
        KImageParam params;ZeroMemory(&params,sizeof(params));
        bool valid=g_pRepresent->GetImageParam(path,&params,ISI_T_SPR) && params.nNumFrames>0;
        available[path]=valid;found=available.find(path);
    }
    if(!found->second)return;
    strcpy(image.szImage,path);image.uImage=0;image.nISPosition=IMAGE_IS_POSITION_INIT;image.nFrame=0;
}

static void PhongThanPaintUpgradeAura(const KItem& item,int x,int y,int width,int height)
{
    if(item.GetGenre()!=item_equip || item.m_CommonAttrib.nUpgradeLvl!=12)return;
    const char* file=NULL;
    switch(item.GetDetailType())
    {
        case equip_helm:file="tou.spr";break;
        case equip_belt:file="yao.spr";break;
        case equip_amulet:case equip_ring:case equip_cuff:case equip_signet:file="fabao.spr";break;
        case equip_meleeweapon:case equip_rangeweapon:case equip_armor:
        case equip_boots:case equip_pendant:file="shen.spr";break;
    }
    if(!file)return;
    KRUImage image;ZeroMemory(&image,sizeof(image));
    image.nType=ISI_T_SPR;image.nISPosition=IMAGE_IS_POSITION_INIT;
    sprintf(image.szImage,"%s%s",PT_VNG_EQUIP_FX_ROOT,file);
    KImageParam params;ZeroMemory(&params,sizeof(params));
    if(!g_pRepresent->GetImageParam(image.szImage,&params,ISI_T_SPR) || params.nNumFrames<=0)return;
    image.nFrame=(GetTickCount()/(params.nInterval>0?params.nInterval:100))%params.nNumFrames;
    PhongThanDrawSlotImage(image,x,y,width,height,false);
}
