#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <vector>

typedef unsigned short WORD;
typedef long HRESULT;
enum { S_OK = 0, E_FAIL = -1 };
#define STDMETHODIMP HRESULT

struct CCriticalSection {
    int depth;
    CCriticalSection() : depth(0) {}
    struct Owner {
        CCriticalSection& lock;
        Owner(CCriticalSection& value) : lock(value) { ++lock.depth; }
        ~Owner() { --lock.depth; }
    };
};

static int activeBuffers, allocated, encoded, written, failMode;
static size_t lastFrameSize;
static CCriticalSection* currentSendLock;
struct CIOBuffer {
    std::vector<unsigned char> data;
    size_t capacity;
    CIOBuffer(size_t size) : capacity(size) { ++activeBuffers; ++allocated; }
    void AddData(const char* bytes, size_t count) {
        if (failMode == 2 || count > capacity - data.size()) throw 2;
        const size_t oldSize = data.size();
        data.resize(oldSize + count);
        memcpy(&data[oldSize], bytes, count);
    }
    const unsigned char* GetBuffer() { return &data[0]; }
    void Release() { --activeBuffers; delete this; }
};
struct PacketAllocator {
    size_t capacity;
    size_t GetBufferSize() { return capacity; }
    CIOBuffer* Allocate() {
        if (failMode == 1) throw 1;
        return new CIOBuffer(capacity);
    }
};
static void KSG_EncodeBuf(size_t count, unsigned char* data, unsigned* key)
{
    assert(currentSendLock->depth == 1);
    ++encoded;
    for (size_t i = 0; i < count; ++i) data[i] ^= (unsigned char)*key;
    ++*key;
}
struct CGameClient {
    PacketAllocator m_theCacheAllocator;
    CCriticalSection m_csSendAction;
    unsigned m_uKeyMode, m_uClientKey;
    CGameClient() : m_uKeyMode(0), m_uClientKey(19) {
        m_theCacheAllocator.capacity = 128 * 1024;
        currentSendLock = &m_csSendAction;
    }
    void Write(CIOBuffer* buffer) {
        assert(m_csSendAction.depth == 1);
        if (failMode == 3) throw 3;
        ++written;
        lastFrameSize = buffer->data.size();
        const WORD size = (WORD)(buffer->data[0] | buffer->data[1] << 8);
        assert(size == buffer->data.size());
    }
    STDMETHODIMP SendPackToServer(const void* const data, const size_t& size);
};

#include "../../Sources/MultiServer/Rainbow/PhongThanClientSend.inl"

int main()
{
    CGameClient client;
    std::vector<unsigned char> payload(65534, 0x41);
    assert(client.SendPackToServer(&payload[0], 7908) == S_OK);
    assert(lastFrameSize == 7910 && activeBuffers == 0);
    assert(client.SendPackToServer(&payload[0], 65533) == S_OK);
    assert(lastFrameSize == 65535 && activeBuffers == 0);
    unsigned savedKey = client.m_uClientKey;
    int savedEncoded = encoded, savedAllocated = allocated;
    assert(client.SendPackToServer(&payload[0], 65534) == E_FAIL);
    assert(client.SendPackToServer(&payload[0], (size_t)-1) == E_FAIL);
    assert(client.SendPackToServer(NULL, 25) == E_FAIL);
    assert(client.SendPackToServer(&payload[0], 0) == E_FAIL);
    client.m_theCacheAllocator.capacity = 1024;
    assert(client.SendPackToServer(&payload[0], 1023) == E_FAIL);
    assert(client.m_uClientKey == savedKey && encoded == savedEncoded);
    assert(allocated == savedAllocated && activeBuffers == 0);
    client.m_theCacheAllocator.capacity = 128 * 1024;
    for (failMode = 1; failMode <= 3; ++failMode) {
        assert(client.SendPackToServer(&payload[0], 7908) == E_FAIL);
        assert(activeBuffers == 0 && client.m_csSendAction.depth == 0);
    }
    failMode = 0;
    client.m_uKeyMode = 1;
    savedKey = client.m_uClientKey;
    assert(client.SendPackToServer(&payload[0], 7908) == E_FAIL);
    assert(client.m_uClientKey == savedKey && activeBuffers == 0);
    puts("PASS RAINBOW_SEND: >1KiB character save, WORD boundary, no-key-mutation rejection, exception cleanup, send lock");
    return 0;
}
