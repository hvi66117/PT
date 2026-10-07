#ifndef PHONGTHAN_STARTER_BAG_H
#define PHONGTHAN_STARTER_BAG_H
enum { PHONGTHAN_STARTER_BAG_ID = 61000 };
class KPlayer;
struct PHONGTHAN_UI_NUMBER_REQUEST;
#ifdef _SERVER
bool PhongThanOpenStarterBag(KPlayer& player, int itemIndex);
bool PhongThanStarterBagChoice(KPlayer& player, const char* callback);
void PhongThanStarterBagInput(KPlayer& player, const PHONGTHAN_UI_NUMBER_REQUEST& request);
void PhongThanGrantStarterBag(KPlayer& player);
#endif
#endif
