#define WIN32_LEAN_AND_MEAN
#include <winsock2.h>
#include <windows.h>

#include <map>
#include <set>
#include <string>
#include <vector>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <time.h>

#include "../../../Headers/PhongThanRelayProtocol.h"
#include "../../../Headers/PhongThanCharacter.h"
#include "../../../Headers/PhongThanUiProtocol.h"

typedef std::vector<PHONGTHAN_U8> ByteBuffer;

static LONG g_Running = 1;
static FILE* g_Log = 0;

static void Log(const char* pFormat, ...)
{
	char szMessage[1024];
	va_list args;
	va_start(args, pFormat);
	_vsnprintf(szMessage, sizeof(szMessage) - 1, pFormat, args);
	va_end(args);
	szMessage[sizeof(szMessage) - 1] = 0;
	SYSTEMTIME now;
	GetLocalTime(&now);
	printf("[%02u:%02u:%02u] %s\n", now.wHour, now.wMinute, now.wSecond,
		szMessage);
	if (g_Log)
	{
		fprintf(g_Log, "[%04u-%02u-%02u %02u:%02u:%02u] %s\n",
			now.wYear, now.wMonth, now.wDay, now.wHour, now.wMinute,
			now.wSecond, szMessage);
		fflush(g_Log);
	}
}

static BOOL WINAPI OnConsoleControl(DWORD)
{
	InterlockedExchange(&g_Running, 0);
	return TRUE;
}

static bool HasTerminator(const PHONGTHAN_U8* pText, size_t nSize)
{
	if (!pText)
		return false;
	for (size_t i = 0; i < nSize; ++i)
		if (pText[i] == 0)
			return true;
	return false;
}

static std::string FixedText(const PHONGTHAN_U8* pText, size_t nSize)
{
	size_t nLength = 0;
	while (nLength < nSize && pText[nLength])
		++nLength;
	return std::string((const char*)pText, nLength);
}

static std::string BinaryKey(const PHONGTHAN_U8* pData, size_t nSize)
{
	return std::string((const char*)pData, nSize);
}

struct RelayClient
{
	RelayClient()
		: Socket(INVALID_SOCKET), ServiceId(0), ServiceRole(0), Capabilities(0),
		  Registered(false), CloseAfterFlush(false), ConnectedAt(0), LastSeen(0)
	{
	}
	SOCKET Socket;
	PHONGTHAN_U32 ServiceId;
	PHONGTHAN_U16 ServiceRole;
	PHONGTHAN_U32 Capabilities;
	std::string InstanceName;
	bool Registered;
	bool CloseAfterFlush;
	DWORD ConnectedAt;
	DWORD LastSeen;
	ByteBuffer Input;
	ByteBuffer Output;
};

struct SessionRoute
{
	PHONGTHAN_U32 ServiceId;
	std::string AccountName;
	std::string RoleName;
};

struct PendingTransfer
{
	PHONGTHAN_U32 SourceServiceId;
	PHONGTHAN_U32 TargetServiceId;
};

class PhongThanRelay
{
public:
	PhongThanRelay()
		: m_ListenSocket(INVALID_SOCKET), m_Port(5003), m_MaxConnections(256),
		  m_NextServiceId(1)
	{
	}

	~PhongThanRelay()
	{
		Shutdown();
	}

	bool Initialize(const char* pConfigPath)
	{
		char szValue[256];
		GetPrivateProfileString("Network", "ListenAddress", "127.0.0.1",
			szValue, sizeof(szValue), pConfigPath);
		m_Address = szValue;
		m_Port = GetPrivateProfileInt("Network", "Port", 5003, pConfigPath);
		m_MaxConnections = GetPrivateProfileInt("Network", "MaxConnections",
			256, pConfigPath);
		GetPrivateProfileString("Security", "ServiceSecret", "", szValue,
			sizeof(szValue), pConfigPath);
		m_ServiceSecret = szValue;
		if (m_ServiceSecret.empty())
		{
			Log("refusing startup: ServiceSecret is empty");
			return false;
		}
		if (m_Port <= 0 || m_Port > 65535 || m_MaxConnections <= 0)
		{
			Log("invalid relay configuration");
			return false;
		}

		WSADATA data;
		if (WSAStartup(MAKEWORD(2, 2), &data) != 0)
			return false;
		m_ListenSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
		if (m_ListenSocket == INVALID_SOCKET)
			return false;
		BOOL reuse = TRUE;
		setsockopt(m_ListenSocket, SOL_SOCKET, SO_REUSEADDR,
			(const char*)&reuse, sizeof(reuse));
		u_long nonBlocking = 1;
		ioctlsocket(m_ListenSocket, FIONBIO, &nonBlocking);

		sockaddr_in address;
		ZeroMemory(&address, sizeof(address));
		address.sin_family = AF_INET;
		address.sin_port = htons((u_short)m_Port);
		address.sin_addr.s_addr = inet_addr(m_Address.c_str());
		if (address.sin_addr.s_addr == INADDR_NONE ||
			bind(m_ListenSocket, (sockaddr*)&address, sizeof(address)) ==
				SOCKET_ERROR ||
			listen(m_ListenSocket, SOMAXCONN) == SOCKET_ERROR)
		{
			Log("cannot listen on %s:%d, winsock=%d", m_Address.c_str(),
				m_Port, WSAGetLastError());
			return false;
		}
		Log("native relay listening on %s:%d", m_Address.c_str(), m_Port);
		return true;
	}

	int Run()
	{
		while (g_Running)
		{
			fd_set readSet;
			fd_set writeSet;
			FD_ZERO(&readSet);
			FD_ZERO(&writeSet);
			FD_SET(m_ListenSocket, &readSet);
			ClientMap::iterator it;
			for (it = m_Clients.begin(); it != m_Clients.end(); ++it)
			{
				FD_SET(it->first, &readSet);
				if (!it->second.Output.empty())
					FD_SET(it->first, &writeSet);
			}
			timeval timeout;
			timeout.tv_sec = 0;
			timeout.tv_usec = 250000;
			int result = select(0, &readSet, &writeSet, 0, &timeout);
			if (result == SOCKET_ERROR)
			{
				Log("select failed, winsock=%d", WSAGetLastError());
				return 2;
			}
			if (FD_ISSET(m_ListenSocket, &readSet))
				AcceptClients();

			std::vector<SOCKET> closed;
			for (it = m_Clients.begin(); it != m_Clients.end(); ++it)
			{
				bool alive = true;
				if (FD_ISSET(it->first, &readSet))
					alive = Receive(it->second);
				if (alive && FD_ISSET(it->first, &writeSet))
					alive = Flush(it->second);
				if (alive && it->second.CloseAfterFlush &&
					it->second.Output.empty())
					alive = false;
				if (!alive)
					closed.push_back(it->first);
			}
			for (size_t i = 0; i < closed.size(); ++i)
				Disconnect(closed[i]);
			ExpireClients();
		}
		return 0;
	}

private:
	typedef std::map<SOCKET, RelayClient> ClientMap;
	typedef std::map<PHONGTHAN_U32, SOCKET> ServiceMap;

	SOCKET m_ListenSocket;
	int m_Port;
	int m_MaxConnections;
	PHONGTHAN_U32 m_NextServiceId;
	std::string m_Address;
	std::string m_ServiceSecret;
	ClientMap m_Clients;
	ServiceMap m_Services;
	std::map<std::string, SessionRoute> m_Sessions;
	std::map<std::string, PHONGTHAN_U32> m_Accounts;
	std::map<std::string, PHONGTHAN_U32> m_Roles;
	std::map<PHONGTHAN_U32, PHONGTHAN_U32> m_Maps;
	std::map<PHONGTHAN_U32, PendingTransfer> m_Transfers;
	std::map<PHONGTHAN_U32, PHONGTHAN_U32> m_ClanRequests;
	std::map<PHONGTHAN_U32, PHONGTHAN_U32> m_FriendRequests;

	void Shutdown()
	{
		ClientMap::iterator it;
		for (it = m_Clients.begin(); it != m_Clients.end(); ++it)
			closesocket(it->first);
		m_Clients.clear();
		if (m_ListenSocket != INVALID_SOCKET)
		{
			closesocket(m_ListenSocket);
			m_ListenSocket = INVALID_SOCKET;
		}
		WSACleanup();
	}

	void AcceptClients()
	{
		for (;;)
		{
			sockaddr_in peer;
			int peerSize = sizeof(peer);
			SOCKET clientSocket = accept(m_ListenSocket, (sockaddr*)&peer,
				&peerSize);
			if (clientSocket == INVALID_SOCKET)
			{
				if (WSAGetLastError() != WSAEWOULDBLOCK)
					Log("accept failed, winsock=%d", WSAGetLastError());
				break;
			}
			if ((int)m_Clients.size() >= m_MaxConnections)
			{
				closesocket(clientSocket);
				continue;
			}
			u_long nonBlocking = 1;
			ioctlsocket(clientSocket, FIONBIO, &nonBlocking);
			RelayClient client;
			client.Socket = clientSocket;
			client.ConnectedAt = client.LastSeen = GetTickCount();
			m_Clients.insert(std::make_pair(clientSocket, client));
			Log("connection accepted socket=%u", (unsigned int)clientSocket);
		}
	}

	bool Receive(RelayClient& client)
	{
		PHONGTHAN_U8 buffer[8192];
		for (;;)
		{
			int received = recv(client.Socket, (char*)buffer, sizeof(buffer), 0);
			if (received == 0)
				return false;
			if (received == SOCKET_ERROR)
			{
				int error = WSAGetLastError();
				if (error == WSAEWOULDBLOCK)
					break;
				return false;
			}
			client.Input.insert(client.Input.end(), buffer, buffer + received);
			client.LastSeen = GetTickCount();
			if (client.Input.size() > PHONGTHAN_WIRE_MAX_PACKET_SIZE * 2)
				return false;
		}

		while (client.Input.size() >= sizeof(PHONGTHAN_WIRE_HEADER))
		{
			const PHONGTHAN_WIRE_HEADER* pHeader =
				(const PHONGTHAN_WIRE_HEADER*)&client.Input[0];
			if (pHeader->Magic != PHONGTHAN_WIRE_MAGIC ||
				pHeader->Version != PHONGTHAN_WIRE_VERSION ||
				pHeader->HeaderSize != sizeof(PHONGTHAN_WIRE_HEADER) ||
				pHeader->PacketSize < sizeof(PHONGTHAN_WIRE_HEADER) ||
				pHeader->PacketSize > PHONGTHAN_WIRE_MAX_PACKET_SIZE)
			{
				Log("invalid frame socket=%u", (unsigned int)client.Socket);
				return false;
			}
			if (client.Input.size() < pHeader->PacketSize)
				break;
			if (!Dispatch(client, &client.Input[0], pHeader->PacketSize))
			{
				Log("rejected message type=0x%04X service=%u",
					(unsigned int)pHeader->MessageType,
					(unsigned int)client.ServiceId);
				return false;
			}
			client.Input.erase(client.Input.begin(),
				client.Input.begin() + pHeader->PacketSize);
		}
		return true;
	}

	bool Flush(RelayClient& client)
	{
		if (client.Output.empty())
			return true;
		int sent = send(client.Socket, (const char*)&client.Output[0],
			(int)client.Output.size(), 0);
		if (sent == SOCKET_ERROR)
			return WSAGetLastError() == WSAEWOULDBLOCK;
		if (sent <= 0)
			return false;
		client.Output.erase(client.Output.begin(), client.Output.begin() + sent);
		return true;
	}

	bool Queue(SOCKET socketValue, const void* pData, size_t nSize)
	{
		ClientMap::iterator it = m_Clients.find(socketValue);
		if (it == m_Clients.end() || !pData || !nSize ||
			it->second.Output.size() + nSize >
				PHONGTHAN_WIRE_MAX_PACKET_SIZE * 4)
			return false;
		const PHONGTHAN_U8* pBytes = (const PHONGTHAN_U8*)pData;
		it->second.Output.insert(it->second.Output.end(), pBytes,
			pBytes + nSize);
		return true;
	}

	SOCKET FindService(PHONGTHAN_U32 serviceId) const
	{
		ServiceMap::const_iterator it = m_Services.find(serviceId);
		return it == m_Services.end() ? INVALID_SOCKET : it->second;
	}

	PHONGTHAN_U32 FindServiceByCapability(PHONGTHAN_U32 capability,
		PHONGTHAN_U16 preferredRole) const
	{
		ServiceMap::const_iterator it;
		for (it = m_Services.begin(); it != m_Services.end(); ++it)
		{
			ClientMap::const_iterator client = m_Clients.find(it->second);
			if (client != m_Clients.end() &&
				(client->second.Capabilities & capability) &&
				(!preferredRole || client->second.ServiceRole == preferredRole))
				return it->first;
		}
		return 0;
	}

	PHONGTHAN_U32 AllocateServiceId()
	{
		for (PHONGTHAN_U32 attempts = 0; attempts < 0xffffffffu; ++attempts)
		{
			PHONGTHAN_U32 candidate = m_NextServiceId++;
			if (!candidate)
				candidate = m_NextServiceId++;
			if (m_Services.find(candidate) == m_Services.end())
				return candidate;
		}
		return 0;
	}

	void SendRegisterResult(RelayClient& client, PHONGTHAN_U32 requestId,
		PHONGTHAN_U32 sequence, PHONGTHAN_S32 result,
		PHONGTHAN_U32 assignedServiceId)
	{
		PHONGTHAN_RELAY_REGISTER_RESPONSE response;
		ZeroMemory(&response, sizeof(response));
		PhongThanInitializeWireHeader(&response.Header,
			PHONGTHAN_MSG_RELAY_REGISTER, sizeof(response),
			result == PHONGTHAN_RELAY_SUCCESS ? PHONGTHAN_WIRE_FLAG_RESPONSE :
				(PHONGTHAN_WIRE_FLAG_RESPONSE | PHONGTHAN_WIRE_FLAG_ERROR),
			sequence);
		response.RequestId = requestId;
		response.Result = result;
		response.AssignedServiceId = assignedServiceId;
		response.ServerTime = (PHONGTHAN_U32)time(0);
		Queue(client.Socket, &response, sizeof(response));
	}

	void SendRouteResult(RelayClient& client, PHONGTHAN_U32 routeId,
		PHONGTHAN_U32 sequence, PHONGTHAN_S32 result,
		PHONGTHAN_U32 targetServiceId)
	{
		PHONGTHAN_RELAY_ROUTE_RESULT response;
		ZeroMemory(&response, sizeof(response));
		PhongThanInitializeWireHeader(&response.Header,
			PHONGTHAN_MSG_RELAY_ROUTE_RESULT, sizeof(response),
			result == PHONGTHAN_RELAY_SUCCESS ? PHONGTHAN_WIRE_FLAG_RESPONSE :
				(PHONGTHAN_WIRE_FLAG_RESPONSE | PHONGTHAN_WIRE_FLAG_ERROR),
			sequence);
		response.RouteId = routeId;
		response.Result = result;
		response.TargetServiceId = targetServiceId;
		Queue(client.Socket, &response, sizeof(response));
	}

	void SendTransferResult(RelayClient& client, PHONGTHAN_U32 transferId,
		PHONGTHAN_U32 sequence, PHONGTHAN_S32 result)
	{
		PHONGTHAN_RELAY_TRANSFER_RESULT response;
		ZeroMemory(&response, sizeof(response));
		PhongThanInitializeWireHeader(&response.Header,
			PHONGTHAN_MSG_RELAY_TRANSFER_RESULT, sizeof(response),
			PHONGTHAN_WIRE_FLAG_RESPONSE | PHONGTHAN_WIRE_FLAG_ERROR,
			sequence);
		response.TransferId = transferId;
		response.Result = result;
		Queue(client.Socket, &response, sizeof(response));
	}

	bool Dispatch(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (!client.Registered &&
			pHeader->MessageType != PHONGTHAN_MSG_RELAY_REGISTER)
			return false;

		switch (pHeader->MessageType)
		{
		case PHONGTHAN_MSG_RELAY_REGISTER:
			return Register(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_HEARTBEAT:
			return Heartbeat(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_SESSION_BIND:
			return BindSession(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_SESSION_UNBIND:
			return UnbindSession(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_MAP_BIND:
		case PHONGTHAN_MSG_RELAY_MAP_UNBIND:
			return BindMap(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_ROUTE:
			return Route(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_TRANSFER_PREPARE:
			return PrepareTransfer(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_TRANSFER_RESULT:
			return TransferResult(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_TRANSFER_COMMIT:
			return CommitTransfer(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_CHAT_PUBLISH:
			return PublishChat(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_CLAN_REQUEST:
		case PHONGTHAN_MSG_RELAY_CLAN_EVENT:
			return RouteClan(client, pData, nSize);
		case PHONGTHAN_MSG_RELAY_FRIEND_REQUEST:
		case PHONGTHAN_MSG_RELAY_FRIEND_EVENT:
			return RouteFriend(client, pData, nSize);
		default:
			return false;
		}
	}

	bool Register(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		if (client.Registered || nSize != sizeof(PHONGTHAN_RELAY_REGISTER_REQUEST))
			return false;
		const PHONGTHAN_RELAY_REGISTER_REQUEST* request =
			(const PHONGTHAN_RELAY_REGISTER_REQUEST*)pData;
		if (!PhongThanValidateRelayFixedPacket(&request->Header, nSize,
				PHONGTHAN_MSG_RELAY_REGISTER, sizeof(*request)) ||
			request->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
			request->ServiceRole <= PHONGTHAN_RELAY_SERVICE_INVALID ||
			request->ServiceRole > PHONGTHAN_RELAY_SERVICE_SOCIAL ||
			!HasTerminator(request->InstanceName,
				PHONGTHAN_RELAY_INSTANCE_NAME_SIZE) ||
			!HasTerminator(request->CredentialProof,
				PHONGTHAN_RELAY_PROOF_SIZE))
			return false;
		if (FixedText(request->CredentialProof, PHONGTHAN_RELAY_PROOF_SIZE) !=
			m_ServiceSecret)
		{
			SendRegisterResult(client, request->RequestId,
				request->Header.Sequence, PHONGTHAN_RELAY_UNAUTHORIZED, 0);
			client.CloseAfterFlush = true;
			return true;
		}

		PHONGTHAN_U32 serviceId = request->ServiceId;
		if (!serviceId)
			serviceId = AllocateServiceId();
		if (!serviceId || m_Services.find(serviceId) != m_Services.end())
		{
			SendRegisterResult(client, request->RequestId,
				request->Header.Sequence, PHONGTHAN_RELAY_DUPLICATE_SERVICE, 0);
			client.CloseAfterFlush = true;
			return true;
		}
		client.ServiceId = serviceId;
		client.ServiceRole = request->ServiceRole;
		client.Capabilities = request->Capabilities;
		client.InstanceName = FixedText(request->InstanceName,
			PHONGTHAN_RELAY_INSTANCE_NAME_SIZE);
		client.Registered = true;
		m_Services[serviceId] = client.Socket;
		SendRegisterResult(client, request->RequestId, request->Header.Sequence,
			PHONGTHAN_RELAY_SUCCESS, serviceId);
		Log("service registered id=%u role=%u caps=0x%X name=%s",
			(unsigned int)serviceId, (unsigned int)client.ServiceRole,
			(unsigned int)client.Capabilities, client.InstanceName.c_str());
		return true;
	}

	bool Heartbeat(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_HEARTBEAT* message =
			(const PHONGTHAN_RELAY_HEARTBEAT*)pData;
		return nSize == sizeof(*message) &&
			PhongThanValidateRelayFixedPacket(&message->Header, nSize,
				PHONGTHAN_MSG_RELAY_HEARTBEAT, sizeof(*message)) &&
			message->ServiceId == client.ServiceId;
	}

	bool BindSession(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_SESSION_BIND* message =
			(const PHONGTHAN_RELAY_SESSION_BIND*)pData;
		if (nSize != sizeof(*message) ||
			!PhongThanValidateRelayFixedPacket(&message->Header, nSize,
				PHONGTHAN_MSG_RELAY_SESSION_BIND, sizeof(*message)) ||
			message->ServiceId != client.ServiceId ||
			!(client.Capabilities & PHONGTHAN_RELAY_CAPABILITY_SESSION) ||
			!HasTerminator(message->AccountName,
				PHONGTHAN_RELAY_ACCOUNT_NAME_SIZE) ||
			!HasTerminator(message->RoleName, PHONGTHAN_RELAY_ROLE_NAME_SIZE))
			return false;
		SessionRoute route;
		route.ServiceId = client.ServiceId;
		route.AccountName = FixedText(message->AccountName,
			PHONGTHAN_RELAY_ACCOUNT_NAME_SIZE);
		route.RoleName = FixedText(message->RoleName,
			PHONGTHAN_RELAY_ROLE_NAME_SIZE);
		if (route.AccountName.empty() || route.RoleName.empty())
			return false;
		std::string ticket = BinaryKey(message->SessionTicket,
			PHONGTHAN_SESSION_TICKET_SIZE);
		m_Sessions[ticket] = route;
		m_Accounts[route.AccountName] = route.ServiceId;
		m_Roles[route.RoleName] = route.ServiceId;
		return true;
	}

	bool UnbindSession(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_SESSION_UNBIND* message =
			(const PHONGTHAN_RELAY_SESSION_UNBIND*)pData;
		if (nSize != sizeof(*message) ||
			!PhongThanValidateRelayFixedPacket(&message->Header, nSize,
				PHONGTHAN_MSG_RELAY_SESSION_UNBIND, sizeof(*message)) ||
			message->ServiceId != client.ServiceId)
			return false;
		std::string ticket = BinaryKey(message->SessionTicket,
			PHONGTHAN_SESSION_TICKET_SIZE);
		std::map<std::string, SessionRoute>::iterator it =
			m_Sessions.find(ticket);
		if (it != m_Sessions.end() && it->second.ServiceId == client.ServiceId)
		{
			m_Accounts.erase(it->second.AccountName);
			m_Roles.erase(it->second.RoleName);
			m_Sessions.erase(it);
		}
		return true;
	}

	bool BindMap(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_MAP_BIND* message =
			(const PHONGTHAN_RELAY_MAP_BIND*)pData;
		PHONGTHAN_U16 type = message->Header.MessageType;
		if (nSize != sizeof(*message) ||
			(type != PHONGTHAN_MSG_RELAY_MAP_BIND &&
			 type != PHONGTHAN_MSG_RELAY_MAP_UNBIND) ||
			!PhongThanValidateRelayFixedPacket(&message->Header, nSize, type,
				sizeof(*message)) || message->ServiceId != client.ServiceId ||
			!(client.Capabilities & PHONGTHAN_RELAY_CAPABILITY_MAP) ||
			!message->MapId)
			return false;
		if (type == PHONGTHAN_MSG_RELAY_MAP_BIND)
			m_Maps[message->MapId] = client.ServiceId;
		else
		{
			std::map<PHONGTHAN_U32, PHONGTHAN_U32>::iterator it =
				m_Maps.find(message->MapId);
			if (it != m_Maps.end() && it->second == client.ServiceId)
				m_Maps.erase(it);
		}
		return true;
	}

	PHONGTHAN_U32 ResolveRoute(const PHONGTHAN_RELAY_ROUTE_HEADER* route,
		const PHONGTHAN_U8* pKey) const
	{
		switch (route->KeyType)
		{
		case PHONGTHAN_RELAY_ROUTE_DIRECT_SERVICE:
			return route->TargetServiceId;
		case PHONGTHAN_RELAY_ROUTE_SESSION:
			if (route->KeySize == PHONGTHAN_SESSION_TICKET_SIZE)
			{
				std::map<std::string, SessionRoute>::const_iterator it =
					m_Sessions.find(BinaryKey(pKey, route->KeySize));
				if (it != m_Sessions.end()) return it->second.ServiceId;
			}
			break;
		case PHONGTHAN_RELAY_ROUTE_ACCOUNT:
			{
				std::map<std::string, PHONGTHAN_U32>::const_iterator it =
					m_Accounts.find(BinaryKey(pKey, route->KeySize));
				if (it != m_Accounts.end()) return it->second;
			}
			break;
		case PHONGTHAN_RELAY_ROUTE_ROLE:
			{
				std::map<std::string, PHONGTHAN_U32>::const_iterator it =
					m_Roles.find(BinaryKey(pKey, route->KeySize));
				if (it != m_Roles.end()) return it->second;
			}
			break;
		case PHONGTHAN_RELAY_ROUTE_MAP:
			if (route->KeySize == sizeof(PHONGTHAN_U32))
			{
				PHONGTHAN_U32 mapId;
				memcpy(&mapId, pKey, sizeof(mapId));
				std::map<PHONGTHAN_U32, PHONGTHAN_U32>::const_iterator it =
					m_Maps.find(mapId);
				if (it != m_Maps.end()) return it->second;
			}
			break;
		default:
			break;
		}
		return 0;
	}

	bool Route(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_ROUTE_HEADER* route =
			(const PHONGTHAN_RELAY_ROUTE_HEADER*)pData;
		if (!PhongThanValidateRelayRoutePacket(route, nSize) ||
			route->SourceServiceId != client.ServiceId)
			return false;
		if (route->RouteFlags & PHONGTHAN_RELAY_ROUTE_FLAG_BROADCAST)
		{
			if (client.ServiceRole != PHONGTHAN_RELAY_SERVICE_GAME || route->KeySize ||
				route->KeyType != PHONGTHAN_RELAY_ROUTE_DIRECT_SERVICE || route->TargetServiceId) return false;
			const PHONGTHAN_U8* payload = pData + sizeof(*route);
			if (!PhongThanValidateUiAction(payload, route->PayloadSize)) return false;
			const PHONGTHAN_UI_ACTION_HEADER* action = (const PHONGTHAN_UI_ACTION_HEADER*)payload;
			if (action->MapId || action->DialogToken) return false;
			ByteBuffer packet(pData, pData + nSize);
			ServiceMap::iterator service;
			for (service = m_Services.begin(); service != m_Services.end(); ++service)
			{
				ClientMap::iterator peer = m_Clients.find(service->second);
				if (peer == m_Clients.end() || peer->second.ServiceRole != PHONGTHAN_RELAY_SERVICE_GAME) continue;
				((PHONGTHAN_RELAY_ROUTE_HEADER*)&packet[0])->TargetServiceId = service->first;
				Queue(service->second, &packet[0], packet.size());
			}
			return true;
		}
		const PHONGTHAN_U8* pKey = pData + sizeof(*route);
		PHONGTHAN_U32 targetId = ResolveRoute(route, pKey);
		SOCKET target = FindService(targetId);
		if (!targetId || target == INVALID_SOCKET)
		{
			SendRouteResult(client, route->RouteId, route->Header.Sequence,
				PHONGTHAN_RELAY_ROUTE_NOT_FOUND, 0);
			return true;
		}
		ByteBuffer forwarded(pData, pData + nSize);
		PHONGTHAN_RELAY_ROUTE_HEADER* mutableRoute =
			(PHONGTHAN_RELAY_ROUTE_HEADER*)&forwarded[0];
		mutableRoute->TargetServiceId = targetId;
		if (!Queue(target, &forwarded[0], forwarded.size()))
		{
			SendRouteResult(client, route->RouteId, route->Header.Sequence,
				PHONGTHAN_RELAY_TARGET_UNAVAILABLE, targetId);
			return true;
		}
		if (route->RouteFlags & PHONGTHAN_RELAY_ROUTE_FLAG_REQUIRE_RESULT)
			SendRouteResult(client, route->RouteId, route->Header.Sequence,
				PHONGTHAN_RELAY_SUCCESS, targetId);
		return true;
	}

	bool PrepareTransfer(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER* message =
			(const PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER*)pData;
		if (!PhongThanValidateRelayTransferPacket(message, nSize) ||
			message->SourceServiceId != client.ServiceId ||
			!(client.Capabilities & PHONGTHAN_RELAY_CAPABILITY_TRANSFER))
			return false;
		const PHONGTHAN_CHARACTER_STATE_HEADER* state =
			(const PHONGTHAN_CHARACTER_STATE_HEADER*)(pData + sizeof(*message));
		if (!PhongThanValidateCharacterState(state, message->StateSize))
			return false;
		if (m_Transfers.find(message->TransferId) != m_Transfers.end())
		{
			SendTransferResult(client, message->TransferId,
				message->Header.Sequence, PHONGTHAN_RELAY_STATE_CONFLICT);
			return true;
		}
		PHONGTHAN_U32 targetId = message->TargetServiceId;
		if (!targetId)
		{
			std::map<PHONGTHAN_U32, PHONGTHAN_U32>::iterator map =
				m_Maps.find(message->DestinationMapId);
			if (map != m_Maps.end()) targetId = map->second;
		}
		SOCKET target = FindService(targetId);
		if (!targetId || target == INVALID_SOCKET)
		{
			SendTransferResult(client, message->TransferId,
				message->Header.Sequence, PHONGTHAN_RELAY_ROUTE_NOT_FOUND);
			return true;
		}
		ByteBuffer forwarded(pData, pData + nSize);
		((PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER*)&forwarded[0])->
			TargetServiceId = targetId;
		if (!Queue(target, &forwarded[0], forwarded.size()))
		{
			SendTransferResult(client, message->TransferId,
				message->Header.Sequence, PHONGTHAN_RELAY_TARGET_UNAVAILABLE);
			return true;
		}
		PendingTransfer pending;
		pending.SourceServiceId = client.ServiceId;
		pending.TargetServiceId = targetId;
		m_Transfers[message->TransferId] = pending;
		return true;
	}

	bool TransferResult(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_TRANSFER_RESULT* message =
			(const PHONGTHAN_RELAY_TRANSFER_RESULT*)pData;
		if (nSize != sizeof(*message) ||
			!PhongThanValidateRelayFixedPacket(&message->Header, nSize,
				PHONGTHAN_MSG_RELAY_TRANSFER_RESULT, sizeof(*message)))
			return false;
		std::map<PHONGTHAN_U32, PendingTransfer>::iterator it =
			m_Transfers.find(message->TransferId);
		if (it == m_Transfers.end() ||
			it->second.TargetServiceId != client.ServiceId)
			return false;
		SOCKET source = FindService(it->second.SourceServiceId);
		if (source != INVALID_SOCKET)
			Queue(source, pData, nSize);
		if (message->Result != PHONGTHAN_RELAY_SUCCESS)
			m_Transfers.erase(it);
		return true;
	}

	bool CommitTransfer(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_TRANSFER_COMMIT* message =
			(const PHONGTHAN_RELAY_TRANSFER_COMMIT*)pData;
		if (nSize != sizeof(*message) ||
			!PhongThanValidateRelayFixedPacket(&message->Header, nSize,
				PHONGTHAN_MSG_RELAY_TRANSFER_COMMIT, sizeof(*message)))
			return false;
		std::map<PHONGTHAN_U32, PendingTransfer>::iterator it =
			m_Transfers.find(message->TransferId);
		if (it == m_Transfers.end() ||
			it->second.SourceServiceId != client.ServiceId ||
			message->SourceServiceId != client.ServiceId ||
			message->TargetServiceId != it->second.TargetServiceId)
			return false;
		SOCKET target = FindService(it->second.TargetServiceId);
		if (target != INVALID_SOCKET)
			Queue(target, pData, nSize);
		m_Transfers.erase(it);
		return true;
	}

	void BroadcastGames(const void* pData, size_t nSize)
	{
		ServiceMap::iterator it;
		for (it = m_Services.begin(); it != m_Services.end(); ++it)
		{
			ClientMap::iterator client = m_Clients.find(it->second);
			if (client != m_Clients.end() &&
				(client->second.Capabilities & PHONGTHAN_RELAY_CAPABILITY_CHAT))
				Queue(it->second, pData, nSize);
		}
	}

	bool PublishChat(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_CHAT_HEADER* message =
			(const PHONGTHAN_RELAY_CHAT_HEADER*)pData;
		if (!PhongThanValidateRelayChatPacket(message, nSize) ||
			message->SourceServiceId != client.ServiceId ||
			!(client.Capabilities & PHONGTHAN_RELAY_CAPABILITY_CHAT))
			return false;
		ByteBuffer delivered(pData, pData + nSize);
		PHONGTHAN_RELAY_CHAT_HEADER* output =
			(PHONGTHAN_RELAY_CHAT_HEADER*)&delivered[0];
		output->Header.MessageType = PHONGTHAN_MSG_RELAY_CHAT_DELIVER;
		output->Header.Flags = PHONGTHAN_WIRE_FLAG_RESPONSE;
		if (message->Scope == PHONGTHAN_CHAT_SCOPE_PRIVATE)
		{
			const PHONGTHAN_U8* targetName = pData + sizeof(*message);
			std::map<std::string, PHONGTHAN_U32>::iterator it =
				m_Roles.find(BinaryKey(targetName, message->TargetNameSize));
			if (it == m_Roles.end())
				return true;
			SOCKET target = FindService(it->second);
			if (target != INVALID_SOCKET)
				Queue(target, &delivered[0], delivered.size());
		}
		else
			BroadcastGames(&delivered[0], delivered.size());
		return true;
	}

	bool ValidateDomainPacket(const PHONGTHAN_WIRE_HEADER* header,
		PHONGTHAN_U32 nSize, size_t fixedSize, PHONGTHAN_U16 payloadSize) const
	{
		return header && PhongThanValidateWireHeader(header, nSize) &&
			header->PacketSize == nSize && payloadSize <=
				PHONGTHAN_RELAY_DOMAIN_PAYLOAD_MAX_SIZE &&
			fixedSize + payloadSize == nSize;
	}

	bool RouteClan(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_CLAN_HEADER* message =
			(const PHONGTHAN_RELAY_CLAN_HEADER*)pData;
		if (nSize < sizeof(*message) ||
			!ValidateDomainPacket(&message->Header, nSize, sizeof(*message),
				message->PayloadSize) ||
			message->SourceServiceId != client.ServiceId)
			return false;
		if (message->Header.MessageType == PHONGTHAN_MSG_RELAY_CLAN_REQUEST)
		{
			PHONGTHAN_U32 targetId = FindServiceByCapability(
				PHONGTHAN_RELAY_CAPABILITY_CLAN, PHONGTHAN_RELAY_SERVICE_CLAN);
			SOCKET target = FindService(targetId);
			if (target == INVALID_SOCKET) return true;
			m_ClanRequests[message->RequestId] = client.ServiceId;
			Queue(target, pData, nSize);
		}
		else if (message->Header.MessageType == PHONGTHAN_MSG_RELAY_CLAN_EVENT)
		{
			std::map<PHONGTHAN_U32, PHONGTHAN_U32>::iterator request =
				m_ClanRequests.find(message->RequestId);
			if (request != m_ClanRequests.end())
			{
				SOCKET target = FindService(request->second);
				if (target != INVALID_SOCKET) Queue(target, pData, nSize);
				m_ClanRequests.erase(request);
			}
			else BroadcastGames(pData, nSize);
		}
		else return false;
		return true;
	}

	bool RouteFriend(RelayClient& client, const PHONGTHAN_U8* pData,
		PHONGTHAN_U32 nSize)
	{
		const PHONGTHAN_RELAY_FRIEND_HEADER* message =
			(const PHONGTHAN_RELAY_FRIEND_HEADER*)pData;
		if (nSize < sizeof(*message) ||
			!ValidateDomainPacket(&message->Header, nSize, sizeof(*message),
				message->PayloadSize) ||
			message->SourceServiceId != client.ServiceId)
			return false;
		if (message->Header.MessageType == PHONGTHAN_MSG_RELAY_FRIEND_REQUEST)
		{
			PHONGTHAN_U32 targetId = FindServiceByCapability(
				PHONGTHAN_RELAY_CAPABILITY_FRIEND,
				PHONGTHAN_RELAY_SERVICE_SOCIAL);
			SOCKET target = FindService(targetId);
			if (target == INVALID_SOCKET) return true;
			m_FriendRequests[message->RequestId] = client.ServiceId;
			Queue(target, pData, nSize);
		}
		else if (message->Header.MessageType == PHONGTHAN_MSG_RELAY_FRIEND_EVENT)
		{
			std::map<PHONGTHAN_U32, PHONGTHAN_U32>::iterator request =
				m_FriendRequests.find(message->RequestId);
			if (request != m_FriendRequests.end())
			{
				SOCKET target = FindService(request->second);
				if (target != INVALID_SOCKET) Queue(target, pData, nSize);
				m_FriendRequests.erase(request);
			}
			else
			{
				std::string role = FixedText(message->TargetRoleName,
					PHONGTHAN_RELAY_ROLE_NAME_SIZE);
				std::map<std::string, PHONGTHAN_U32>::iterator targetRole =
					m_Roles.find(role);
				if (targetRole != m_Roles.end())
				{
					SOCKET target = FindService(targetRole->second);
					if (target != INVALID_SOCKET) Queue(target, pData, nSize);
				}
			}
		}
		else return false;
		return true;
	}

	void ExpireClients()
	{
		DWORD now = GetTickCount();
		std::vector<SOCKET> expired;
		ClientMap::iterator it;
		for (it = m_Clients.begin(); it != m_Clients.end(); ++it)
		{
			DWORD maxIdle = it->second.Registered ? 90000 : 10000;
			if (now - it->second.LastSeen > maxIdle)
				expired.push_back(it->first);
		}
		for (size_t i = 0; i < expired.size(); ++i)
			Disconnect(expired[i]);
	}

	void Disconnect(SOCKET socketValue)
	{
		ClientMap::iterator client = m_Clients.find(socketValue);
		if (client == m_Clients.end())
			return;
		PHONGTHAN_U32 serviceId = client->second.ServiceId;
		if (serviceId)
		{
			m_Services.erase(serviceId);
			std::map<std::string, SessionRoute>::iterator session =
				m_Sessions.begin();
			while (session != m_Sessions.end())
			{
				if (session->second.ServiceId == serviceId)
				{
					m_Accounts.erase(session->second.AccountName);
					m_Roles.erase(session->second.RoleName);
					std::map<std::string, SessionRoute>::iterator eraseIt =
						session++;
					m_Sessions.erase(eraseIt);
				}
				else ++session;
			}
			std::map<PHONGTHAN_U32, PHONGTHAN_U32>::iterator map =
				m_Maps.begin();
			while (map != m_Maps.end())
			{
				if (map->second == serviceId)
				{
					std::map<PHONGTHAN_U32, PHONGTHAN_U32>::iterator eraseIt =
						map++;
					m_Maps.erase(eraseIt);
				}
				else ++map;
			}
		}
		Log("connection closed socket=%u service=%u",
			(unsigned int)socketValue, (unsigned int)serviceId);
		closesocket(socketValue);
		m_Clients.erase(client);
	}
};

int main(int argc, char** argv)
{
	const char* pConfig = argc > 1 ? argv[1] : "PhongThanRelay.ini";
	char configPath[MAX_PATH];
	const DWORD configLength = GetFullPathNameA(pConfig, sizeof(configPath), configPath, NULL);
	if (!configLength || configLength >= sizeof(configPath)) return 1;
	g_Log = fopen("phongthan_relay.log", "a");
	SetConsoleCtrlHandler(OnConsoleControl, TRUE);
	PhongThanRelay relay;
	if (!relay.Initialize(configPath))
	{
		Log("startup failed; config=%s", pConfig);
		if (g_Log) fclose(g_Log);
		return 1;
	}
	int result = relay.Run();
	Log("relay stopped result=%d", result);
	if (g_Log) fclose(g_Log);
	g_Log = 0;
	return result;
}
