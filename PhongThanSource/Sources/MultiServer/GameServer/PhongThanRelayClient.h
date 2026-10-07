#ifndef PHONGTHAN_GAME_RELAY_CLIENT_H
#define PHONGTHAN_GAME_RELAY_CLIENT_H

#include <winsock2.h>
#include <vector>

#include "../../../Headers/PhongThanRelayProtocol.h"

class CPhongThanRelayClient
{
public:
	CPhongThanRelayClient();
	~CPhongThanRelayClient();

	bool Connect(const char* pAddress, unsigned short nPort,
		const char* pServiceSecret, PHONGTHAN_U32 nRequestedServiceId,
		const char* pInstanceName, PHONGTHAN_U32 nCapabilities,
		PHONGTHAN_U32 nPublicAddress, unsigned short nPublicPort);
	void Disconnect();
	bool Pump();
	bool Send(const void* pData, PHONGTHAN_U32 nSize);
	bool PopPacket(std::vector<PHONGTHAN_U8>& packet);
	bool IsConnected() const;
	bool IsRegistered() const;
	PHONGTHAN_U32 GetServiceId() const;
	PHONGTHAN_U32 NextSequence();

	bool BindMap(PHONGTHAN_U32 nMapId, PHONGTHAN_U32 nWorldId,
		PHONGTHAN_U32 nAddress, unsigned short nPort, bool bBind);
	bool BindSession(const PHONGTHAN_U8* pTicket, const char* pAccountName,
		const char* pRoleName, PHONGTHAN_U32 nMapId,
		PHONGTHAN_U32 nConnectionId);
	bool UnbindSession(const PHONGTHAN_U8* pTicket, PHONGTHAN_S32 nReason);

private:
	typedef std::vector<PHONGTHAN_U8> ByteBuffer;
	typedef std::vector<ByteBuffer> PacketQueue;

	SOCKET m_Socket;
	bool m_WsaActive;
	bool m_Connected;
	bool m_Registered;
	PHONGTHAN_U32 m_ServiceId;
	PHONGTHAN_U32 m_Sequence;
	DWORD m_LastHeartbeat;
	ByteBuffer m_Input;
	ByteBuffer m_Output;
	PacketQueue m_Packets;

	bool Flush();
	bool ParseFrames();
	bool ProcessControlPacket(const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize);
	bool Queue(const void* pData, PHONGTHAN_U32 nSize);
	void ResetState();
};

#endif
