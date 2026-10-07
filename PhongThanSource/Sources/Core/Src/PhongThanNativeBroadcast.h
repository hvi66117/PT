#ifndef PHONGTHAN_NATIVE_BROADCAST_H
#define PHONGTHAN_NATIVE_BROADCAST_H
bool PhongThanQueueUiBroadcast(const void* data, unsigned int size);
int PhongThanPopUiBroadcast(void* data, unsigned int capacity);
#endif
