static int ProbeAuthoredNpc(Connection& game,const PHONGTHAN_SELF_SNAPSHOT& self)
{
    Bytes packet;PHONGTHAN_NPC_SNAPSHOT target;ZeroMemory(&target,sizeof(target));
    const bool viewportTest=getenv("PHONGTHAN_NPC_VIEWPORT_TEST")!=NULL;
    const char* targetName=viewportTest?"Chuyen Sinh Lao Lao":"Thai Thuong Lao Quan";
    printf("AUTHORED_SELF map=%u\n",self.MapId);
    DWORD until=GetTickCount()+15000;
    while(GetTickCount()<until){
        if(!game.Read(PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT,packet,1000))continue;
        if(!PhongThanValidateNpcSnapshot(&packet[0],packet.size()))continue;
        const PHONGTHAN_NPC_SNAPSHOT* npc=(const PHONGTHAN_NPC_SNAPSHOT*)&packet[0];
        printf("NPC_RECEIVED map=%u name=%s template=%d x=%d y=%d\n",npc->MapId,npc->Name,npc->TemplateId,npc->X,npc->Y);
        if(npc->Kind==3 && strcmp((const char*)npc->Name,targetName)==0){target=*npc;break;}
    }
    if(viewportTest){
        REQUIRE(target.EntityId && target.MapId==1003 && target.X==54400 && target.Y==100608,"NPC beyond legacy circle received");
        puts("PASS NPC_VIEWPORT_NGOCHU map=1003 y_distance=992 npc=Chuyen_Sinh_Lao_Lao");
        return 0;
    }
    REQUIRE(target.EntityId && target.MapId==1052 && target.X==48256 && target.Y==102656,"authored NPC name and position received");
    PHONGTHAN_ENTITY_REFERENCE interact;
    ZeroMemory(&interact,sizeof(interact));
    PhongThanInitializeWireHeader(&interact.Header,PHONGTHAN_MSG_NPC_INTERACT_REQUEST,sizeof(interact),PHONGTHAN_WIRE_FLAG_REQUEST,50);
    interact.MapId=self.MapId;interact.EntityId=target.EntityId;
    REQUIRE(game.Send(&interact,sizeof(interact)),"authored NPC click");
    REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,8000),"authored NPC menu");
    REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"menu packet valid");
    PHONGTHAN_UI_ACTION_HEADER ui=*(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
    REQUIRE(ui.DialogToken && ui.OptionCount==4,"four authored menu choices");
    const int selections[]={0,0,1,0,2,0,3}; // about/back, routes/back, status/back, close
    for(int i=0;i<7;++i){
        PHONGTHAN_UI_CHOICE_REQUEST choice;ZeroMemory(&choice,sizeof(choice));
        PhongThanInitializeWireHeader(&choice.Header,PHONGTHAN_MSG_UI_CHOICE_REQUEST,sizeof(choice),PHONGTHAN_WIRE_FLAG_REQUEST,51+i);
        choice.MapId=ui.MapId;choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=selections[i];
        REQUIRE(game.Send(&choice,sizeof(choice)),"authored option click");
        REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"authored option response");
        REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"authored response valid");
        ui=*(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
        if(i==6)REQUIRE(ui.Operation==PHONGTHAN_SCRIPT_CLOSE,"authored close works");
        else REQUIRE(ui.OptionCount==(i%2==0?2:4),"authored callback returned expected menu");
    }
    REQUIRE(game.Send(&interact,sizeof(interact)),"reopen authored NPC");
    REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"reopened NPC menu");
    REQUIRE(((const PHONGTHAN_UI_ACTION_HEADER*)&packet[0])->OptionCount==4,"reopen count");
    printf("PASS AUTHORED_NPC_LIVE map=%u template=%d name=Thai_Thuong_Lao_Quan about_routes_status_back_close_reopen\n",self.MapId,target.TemplateId);
    return 0;
}
