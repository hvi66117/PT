// One real use through the normal bag, inventory and EXP network messages.
// Does not edit character files or grant by a privileged backdoor.
static int ProbeExperience1355(Connection& game, const PHONGTHAN_SELF_SNAPSHOT& self)
{
    Bytes packet;
    PHONGTHAN_ITEM_SNAPSHOT bag;ZeroMemory(&bag,sizeof(bag));
    std::vector<PHONGTHAN_U32> initialIds;
    for(size_t i=0;i<game.Queue.size();++i){
        const Bytes& bytes=game.Queue[i];
        if(bytes.size()!=sizeof(PHONGTHAN_ITEM_SNAPSHOT) ||
           ((const PHONGTHAN_WIRE_HEADER*)&bytes[0])->MessageType!=PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT)continue;
        const PHONGTHAN_ITEM_SNAPSHOT& item=*(const PHONGTHAN_ITEM_SNAPSHOT*)&bytes[0];
        initialIds.push_back(item.ItemId);
        if(item.Genre==6 && item.DetailType==61000)bag=item;
    }
    REQUIRE(self.Level==1,"1355 live fixture must be level 1");
    REQUIRE(bag.ItemId && bag.Container==pos_equiproom,"starter bag in F4");
    PHONGTHAN_ITEM_USE_REQUEST use;ZeroMemory(&use,sizeof(use));
    PhongThanInitializeWireHeader(&use.Header,PHONGTHAN_MSG_INVENTORY_USE_REQUEST,sizeof(use),PHONGTHAN_WIRE_FLAG_REQUEST,20);
    use.ItemId=bag.ItemId;use.Container=bag.Container;use.SlotX=bag.SlotX;use.SlotY=bag.SlotY;
    REQUIRE(game.Send(&use,sizeof(use)),"open bag");
    REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"bag menu");
    REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"valid bag menu");
    PHONGTHAN_UI_ACTION_HEADER ui=*(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
    REQUIRE(ui.OptionCount==16,"bag groups");
    PHONGTHAN_UI_CHOICE_REQUEST choice;ZeroMemory(&choice,sizeof(choice));
    PhongThanInitializeWireHeader(&choice.Header,PHONGTHAN_MSG_UI_CHOICE_REQUEST,sizeof(choice),PHONGTHAN_WIRE_FLAG_REQUEST,21);
    choice.MapId=ui.MapId;choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=0;
    REQUIRE(game.Send(&choice,sizeof(choice)),"select MagicScript");
    REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"number prompt");
    REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"valid number prompt");
    ui=*(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
    REQUIRE(ui.View==PHONGTHAN_VIEW_NUMBER_INPUT,"number input view");
    PHONGTHAN_UI_NUMBER_REQUEST input;ZeroMemory(&input,sizeof(input));
    PhongThanInitializeWireHeader(&input.Header,PHONGTHAN_MSG_UI_NUMBER_INPUT,sizeof(input),PHONGTHAN_WIRE_FLAG_REQUEST,22);
    input.MapId=ui.MapId;input.DialogToken=ui.DialogToken;input.Value=1355;
    REQUIRE(game.Send(&input,sizeof(input)),"input 1355");
    REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"preview 1355");
    REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"valid preview");
    ui=*(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];
    choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=0;
    REQUIRE(game.Send(&choice,sizeof(choice)),"grant one 1355");
    PHONGTHAN_ITEM_SNAPSHOT granted;ZeroMemory(&granted,sizeof(granted));
    for(int attempt=0;attempt<256 && !granted.ItemId;++attempt){
        REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,packet,5000),"item snapshot");
        REQUIRE(PhongThanValidateItemSnapshot(&packet[0],packet.size()),"valid snapshot");
        const PHONGTHAN_ITEM_SNAPSHOT& item=*(const PHONGTHAN_ITEM_SNAPSHOT*)&packet[0];
        bool old=false;for(size_t k=0;k<initialIds.size();++k)if(initialIds[k]==item.ItemId)old=true;
        if(!old && item.Genre==6 && item.DetailType==1355)granted=item;
    }
    REQUIRE(granted.ItemId,"new 1355 in F4");
    REQUIRE(game.Read(PHONGTHAN_MSG_UI_SCRIPT_ACTION,packet,5000),"grant confirmation");
    REQUIRE(PhongThanValidateUiAction(&packet[0],packet.size()),"valid confirmation");
    ui=*(const PHONGTHAN_UI_ACTION_HEADER*)&packet[0];choice.DialogToken=ui.DialogToken;choice.View=ui.View;choice.Selection=3;
    REQUIRE(game.Send(&choice,sizeof(choice)),"close bag");
    use.ItemId=granted.ItemId;use.Container=granted.Container;use.SlotX=granted.SlotX;use.SlotY=granted.SlotY;
    REQUIRE(game.Send(&use,sizeof(use)),"right-click 1355");
    REQUIRE(game.Read(PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE,packet,5000),"1355 consumed by Lua");
    REQUIRE(packet.size()==sizeof(PHONGTHAN_ITEM_REMOVE_MESSAGE),"removal size");
    REQUIRE(((const PHONGTHAN_ITEM_REMOVE_MESSAGE*)&packet[0])->ItemId==granted.ItemId,"exact granted item consumed");
    REQUIRE(game.Read(PHONGTHAN_MSG_GAMEPLAY_EXPERIENCE,packet,5000),"EXP synchronization");
    REQUIRE(packet.size()==sizeof(PHONGTHAN_EXPERIENCE_EVENT),"EXP packet size");
    const PHONGTHAN_EXPERIENCE_EVENT& exp=*(const PHONGTHAN_EXPERIENCE_EVENT*)&packet[0];
    REQUIRE(exp.EntityId==self.EntityId && exp.MapId==self.MapId && exp.Experience>0,"positive EXP for same character");
    printf("PASS LIVE_1355 level=%u consumed_uid=%u exp=%d entity=%u\n",self.Level,granted.ItemId,exp.Experience,self.EntityId);
    return 0;
}
