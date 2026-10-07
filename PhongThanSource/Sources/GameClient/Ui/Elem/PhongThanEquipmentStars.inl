// Original PAK art cropped to earned stars; no new bitmap or enlargement.
static long PhongThanDrawEquipmentStars(iRepresentShell* rep,int count,int x,int y)
{
    if(!rep || count<1 || count>12)return E_FAIL;
    KRUImagePart star;ZeroMemory(&star,sizeof(star));
    star.nType=ISI_T_SPR;star.nISPosition=IMAGE_IS_POSITION_INIT;
    star.Color.Color_b.a=255;star.bRenderStyle=IMAGE_RENDER_STYLE_ALPHA;
    strcpy(star.szImage,PT_VNG_STAR_STRIP);
    star.oPosition.nX=x+(count==12?3:0);star.oPosition.nY=y+3;
    star.oImgRBPos.nX=count*14-2;star.oImgRBPos.nY=11;
    rep->DrawPrimitives(1,&star,RU_T_IMAGE_PART,true);
    if(count==12)
    {
        KRUImage frame;ZeroMemory(&frame,sizeof(frame));
        frame.nType=ISI_T_SPR;frame.nISPosition=IMAGE_IS_POSITION_INIT;
        frame.Color.Color_b.a=255;frame.bRenderStyle=IMAGE_RENDER_STYLE_ALPHA;
        strcpy(frame.szImage,PT_VNG_STAR_FRAME12);
        KImageParam params;ZeroMemory(&params,sizeof(params));
        if(!rep->GetImageParam(frame.szImage,&params,ISI_T_SPR) || params.nNumFrames<=0)return E_FAIL;
        frame.nFrame=(GetTickCount()/100)%params.nNumFrames;
        frame.oPosition.nX=x;frame.oPosition.nY=y;
        rep->DrawPrimitives(1,&frame,RU_T_IMAGE,true);
    }
    return S_OK;
}
