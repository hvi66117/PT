#include "PhongThanNativeBroadcast.h"
#include "PhongThanUiProtocol.h"
#include <deque>
#include <vector>
static std::deque<std::vector<PHONGTHAN_U8> > s_PhongThanUiBroadcasts;
bool PhongThanQueueUiBroadcast(const void* data, unsigned int size)
{
	if (!PhongThanValidateUiAction(data, size) || s_PhongThanUiBroadcasts.size() >= 128) return false;
	const PHONGTHAN_UI_ACTION_HEADER* action = (const PHONGTHAN_UI_ACTION_HEADER*)data;
	if (action->MapId || action->DialogToken) return false;
	const PHONGTHAN_U8* bytes = (const PHONGTHAN_U8*)data;
	s_PhongThanUiBroadcasts.push_back(std::vector<PHONGTHAN_U8>(bytes, bytes + size));
	return true;
}
int PhongThanPopUiBroadcast(void* data, unsigned int capacity)
{
	if (!data || s_PhongThanUiBroadcasts.empty()) return 0;
	const std::vector<PHONGTHAN_U8>& packet = s_PhongThanUiBroadcasts.front();
	if (packet.size() > capacity) return -1;
	const int size = packet.size();
	memcpy(data, &packet[0], size);
	s_PhongThanUiBroadcasts.pop_front();
	return size;
}
