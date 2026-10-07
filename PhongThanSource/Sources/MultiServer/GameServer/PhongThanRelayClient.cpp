#include "StdAfx.h"
#include "PhongThanRelayClient.h"

#include <string.h>
#include <time.h>

CPhongThanRelayClient::CPhongThanRelayClient()
	: m_Socket(INVALID_SOCKET), m_WsaActive(false), m_Connected(false),
	  m_Registered(false), m_ServiceId(0), m_Sequence(1), m_LastHeartbeat(0)
{
}

CPhongThanRelayClient::~CPhongThanRelayClient()
{
	Disconnect();
}

void CPhongThanRelayClient::ResetState()
{
	m_Connected = false;
	m_Registered = false;
	m_ServiceId = 0;
	m_LastHeartbeat = 0;
	m_Input.clear();
	m_Output.clear();
	m_Packets.clear();
}

void CPhongThanRelayClient::Disconnect()
{
	if (m_Socket != INVALID_SOCKET)
	{
		shutdown(m_Socket, SD_BOTH);
		closesocket(m_Socket);
		m_Socket = INVALID_SOCKET;
	}
	if (m_WsaActive)
	{
		WSACleanup();
		m_WsaActive = false;
	}
	ResetState();
}

bool CPhongThanRelayClient::Connect(const char* pAddress,
	unsigned short nPort, const char* pServiceSecret,
	PHONGTHAN_U32 nRequestedServiceId, const char* pInstanceName,
	PHONGTHAN_U32 nCapabilities, PHONGTHAN_U32 nPublicAddress,
	unsigned short nPublicPort)
{
	Disconnect();
	if (!pAddress || !pAddress[0] || !nPort || !pServiceSecret ||
		!pServiceSecret[0] || !pInstanceName || !pInstanceName[0] ||
		strlen(pServiceSecret) >= PHONGTHAN_RELAY_PROOF_SIZE ||
		strlen(pInstanceName) >= PHONGTHAN_RELAY_INSTANCE_NAME_SIZE)
		return false;

	WSADATA data;
	if (WSAStartup(MAKEWORD(2, 2), &data) != 0)
		return false;
	m_WsaActive = true;
	m_Socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (m_Socket == INVALID_SOCKET)
	{
		Disconnect();
		return false;
	}

	sockaddr_in address;
	ZeroMemory(&address, sizeof(address));
	address.sin_family = AF_INET;
	address.sin_port = htons(nPort);
	address.sin_addr.s_addr = inet_addr(pAddress);
	if (address.sin_addr.s_addr == INADDR_NONE ||
		connect(m_Socket, (sockaddr*)&address, sizeof(address)) == SOCKET_ERROR)
	{
		Disconnect();
		return false;
	}
	u_long nonBlocking = 1;
	if (ioctlsocket(m_Socket, FIONBIO, &nonBlocking) == SOCKET_ERROR)
	{
		Disconnect();
		return false;
	}
	m_Connected = true;

	PHONGTHAN_RELAY_REGISTER_REQUEST request;
	ZeroMemory(&request, sizeof(request));
	PHONGTHAN_U32 sequence = NextSequence();
	PhongThanInitializeWireHeader(&request.Header,
		PHONGTHAN_MSG_RELAY_REGISTER, sizeof(request),
		PHONGTHAN_WIRE_FLAG_REQUEST, sequence);
	request.RequestId = sequence;
	request.ServiceRole = PHONGTHAN_RELAY_SERVICE_GAME;
	request.ServiceId = nRequestedServiceId;
	request.Capabilities = nCapabilities;
	request.AddressV4 = nPublicAddress;
	request.ServicePort = nPublicPort;
	request.PublicPort = nPublicPort;
	strncpy((char*)request.InstanceName, pInstanceName,
		sizeof(request.InstanceName) - 1);
	strncpy((char*)request.CredentialProof, pServiceSecret,
		sizeof(request.CredentialProof) - 1);
	if (!Send(&request, sizeof(request)) || !Pump())
	{
		Disconnect();
		return false;
	}
	return true;
}

bool CPhongThanRelayClient::Queue(const void* pData, PHONGTHAN_U32 nSize)
{
	if (!m_Connected || !pData || nSize < sizeof(PHONGTHAN_WIRE_HEADER) ||
		nSize > PHONGTHAN_WIRE_MAX_PACKET_SIZE ||
		m_Output.size() + nSize > PHONGTHAN_WIRE_MAX_PACKET_SIZE * 4)
		return false;
	const PHONGTHAN_U8* pBytes = (const PHONGTHAN_U8*)pData;
	m_Output.insert(m_Output.end(), pBytes, pBytes + nSize);
	return true;
}

bool CPhongThanRelayClient::Send(const void* pData, PHONGTHAN_U32 nSize)
{
	if (!pData || nSize < sizeof(PHONGTHAN_WIRE_HEADER))
		return false;
	const PHONGTHAN_WIRE_HEADER* pHeader =
		(const PHONGTHAN_WIRE_HEADER*)pData;
	if (!PhongThanValidateWireHeader(pHeader, nSize) ||
		pHeader->PacketSize != nSize || !Queue(pData, nSize))
		return false;
	return Flush();
}

bool CPhongThanRelayClient::Flush()
{
	if (!m_Connected)
		return false;
	while (!m_Output.empty())
	{
		int sent = send(m_Socket, (const char*)&m_Output[0],
			(int)m_Output.size(), 0);
		if (sent == SOCKET_ERROR)
		{
			if (WSAGetLastError() == WSAEWOULDBLOCK)
				return true;
			return false;
		}
		if (sent <= 0)
			return false;
		m_Output.erase(m_Output.begin(), m_Output.begin() + sent);
	}
	return true;
}

bool CPhongThanRelayClient::ProcessControlPacket(const PHONGTHAN_U8* pData,
	PHONGTHAN_U32 nSize)
{
	const PHONGTHAN_WIRE_HEADER* pHeader =
		(const PHONGTHAN_WIRE_HEADER*)pData;
	if (pHeader->MessageType != PHONGTHAN_MSG_RELAY_REGISTER)
		return false;
	if (nSize != sizeof(PHONGTHAN_RELAY_REGISTER_RESPONSE))
		return true;
	const PHONGTHAN_RELAY_REGISTER_RESPONSE* response =
		(const PHONGTHAN_RELAY_REGISTER_RESPONSE*)pData;
	if (!PhongThanValidateRelayFixedPacket(&response->Header, nSize,
			PHONGTHAN_MSG_RELAY_REGISTER, sizeof(*response)) ||
		response->Result != PHONGTHAN_RELAY_SUCCESS ||
		!response->AssignedServiceId)
		return true;
	m_ServiceId = response->AssignedServiceId;
	m_Registered = true;
	m_LastHeartbeat = GetTickCount();
	return true;
}

bool CPhongThanRelayClient::ParseFrames()
{
	while (m_Input.size() >= sizeof(PHONGTHAN_WIRE_HEADER))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)&m_Input[0];
		if (pHeader->Magic != PHONGTHAN_WIRE_MAGIC ||
			pHeader->Version != PHONGTHAN_WIRE_VERSION ||
			pHeader->HeaderSize != sizeof(PHONGTHAN_WIRE_HEADER) ||
			pHeader->PacketSize < sizeof(PHONGTHAN_WIRE_HEADER) ||
			pHeader->PacketSize > PHONGTHAN_WIRE_MAX_PACKET_SIZE)
			return false;
		if (m_Input.size() < pHeader->PacketSize)
			break;
		const PHONGTHAN_U32 packetSize = pHeader->PacketSize;
		if (!ProcessControlPacket(&m_Input[0], packetSize))
			m_Packets.push_back(ByteBuffer(m_Input.begin(),
				m_Input.begin() + packetSize));
		m_Input.erase(m_Input.begin(), m_Input.begin() + packetSize);
	}
	return true;
}

bool CPhongThanRelayClient::Pump()
{
	if (!m_Connected || !Flush())
		return false;
	PHONGTHAN_U8 buffer[8192];
	for (;;)
	{
		int received = recv(m_Socket, (char*)buffer, sizeof(buffer), 0);
		if (received == 0)
			return false;
		if (received == SOCKET_ERROR)
		{
			if (WSAGetLastError() == WSAEWOULDBLOCK)
				break;
			return false;
		}
		m_Input.insert(m_Input.end(), buffer, buffer + received);
		if (m_Input.size() > PHONGTHAN_WIRE_MAX_PACKET_SIZE * 2)
			return false;
	}
	if (!ParseFrames())
		return false;
	if (m_Registered && GetTickCount() - m_LastHeartbeat >= 30000)
	{
		PHONGTHAN_RELAY_HEARTBEAT heartbeat;
		ZeroMemory(&heartbeat, sizeof(heartbeat));
		PhongThanInitializeWireHeader(&heartbeat.Header,
			PHONGTHAN_MSG_RELAY_HEARTBEAT, sizeof(heartbeat),
			PHONGTHAN_WIRE_FLAG_REQUEST, NextSequence());
		heartbeat.ServiceId = m_ServiceId;
		heartbeat.ServerTime = (PHONGTHAN_U32)time(0);
		if (!Send(&heartbeat, sizeof(heartbeat)))
			return false;
		m_LastHeartbeat = GetTickCount();
	}
	return true;
}

bool CPhongThanRelayClient::PopPacket(std::vector<PHONGTHAN_U8>& packet)
{
	if (m_Packets.empty())
		return false;
	packet.swap(m_Packets.front());
	m_Packets.erase(m_Packets.begin());
	return true;
}

bool CPhongThanRelayClient::IsConnected() const
{
	return m_Connected;
}

bool CPhongThanRelayClient::IsRegistered() const
{
	return m_Registered;
}

PHONGTHAN_U32 CPhongThanRelayClient::GetServiceId() const
{
	return m_ServiceId;
}

PHONGTHAN_U32 CPhongThanRelayClient::NextSequence()
{
	PHONGTHAN_U32 value = m_Sequence++;
	if (!value)
		value = m_Sequence++;
	return value;
}

bool CPhongThanRelayClient::BindMap(PHONGTHAN_U32 nMapId,
	PHONGTHAN_U32 nWorldId, PHONGTHAN_U32 nAddress, unsigned short nPort,
	bool bBind)
{
	if (!m_Registered || !nMapId)
		return false;
	PHONGTHAN_RELAY_MAP_BIND message;
	ZeroMemory(&message, sizeof(message));
	PhongThanInitializeWireHeader(&message.Header,
		bBind ? PHONGTHAN_MSG_RELAY_MAP_BIND :
			PHONGTHAN_MSG_RELAY_MAP_UNBIND,
		sizeof(message), PHONGTHAN_WIRE_FLAG_REQUEST, NextSequence());
	message.ServiceId = m_ServiceId;
	message.MapId = nMapId;
	message.WorldId = nWorldId;
	message.AddressV4 = nAddress;
	message.Port = nPort;
	return Send(&message, sizeof(message));
}

bool CPhongThanRelayClient::BindSession(const PHONGTHAN_U8* pTicket,
	const char* pAccountName, const char* pRoleName, PHONGTHAN_U32 nMapId,
	PHONGTHAN_U32 nConnectionId)
{
	if (!m_Registered || !pTicket || !pAccountName || !pAccountName[0] ||
		!pRoleName || !pRoleName[0] ||
		strlen(pAccountName) >= PHONGTHAN_RELAY_ACCOUNT_NAME_SIZE ||
		strlen(pRoleName) >= PHONGTHAN_RELAY_ROLE_NAME_SIZE)
		return false;
	PHONGTHAN_RELAY_SESSION_BIND message;
	ZeroMemory(&message, sizeof(message));
	PhongThanInitializeWireHeader(&message.Header,
		PHONGTHAN_MSG_RELAY_SESSION_BIND, sizeof(message),
		PHONGTHAN_WIRE_FLAG_REQUEST, NextSequence());
	message.ServiceId = m_ServiceId;
	memcpy(message.SessionTicket, pTicket, PHONGTHAN_SESSION_TICKET_SIZE);
	strncpy((char*)message.AccountName, pAccountName,
		sizeof(message.AccountName) - 1);
	strncpy((char*)message.RoleName, pRoleName, sizeof(message.RoleName) - 1);
	message.MapId = nMapId;
	message.ConnectionId = nConnectionId;
	return Send(&message, sizeof(message));
}

bool CPhongThanRelayClient::UnbindSession(const PHONGTHAN_U8* pTicket,
	PHONGTHAN_S32 nReason)
{
	if (!m_Registered || !pTicket)
		return false;
	PHONGTHAN_RELAY_SESSION_UNBIND message;
	ZeroMemory(&message, sizeof(message));
	PhongThanInitializeWireHeader(&message.Header,
		PHONGTHAN_MSG_RELAY_SESSION_UNBIND, sizeof(message),
		PHONGTHAN_WIRE_FLAG_REQUEST, NextSequence());
	message.ServiceId = m_ServiceId;
	memcpy(message.SessionTicket, pTicket, PHONGTHAN_SESSION_TICKET_SIZE);
	message.Reason = nReason;
	return Send(&message, sizeof(message));
}
