// Keep the legacy WORD framing/cipher, but use the configured packet capacity
// for sends too. The socket allocator is only a 1024-byte receive chunk pool.
STDMETHODIMP CGameClient::SendPackToServer(
	const void * const pData, const size_t &datalength)
{
	const size_t headerSize = sizeof(WORD);
	if (!pData || datalength == 0 || datalength > 65535u - headerSize)
		return E_FAIL;
	const size_t packetSize = headerSize + datalength;
	if (packetSize > m_theCacheAllocator.GetBufferSize())
		return E_FAIL;

	CIOBuffer* pBuffer = NULL;
	HRESULT result = E_FAIL;
	try
	{
		// Rolling cipher state and socket write order must be one operation.
		CCriticalSection::Owner sendLock(m_csSendAction);
		if (m_uKeyMode != 0)
			return E_FAIL;
		pBuffer = m_theCacheAllocator.Allocate();
		if (!pBuffer)
			return E_FAIL;
		const WORD frameSize = (WORD)packetSize;
		pBuffer->AddData(reinterpret_cast<const char*>(&frameSize), headerSize);
		pBuffer->AddData(reinterpret_cast<const char*>(pData), datalength);
		KSG_EncodeBuf(datalength,
			(unsigned char*)(pBuffer->GetBuffer() + headerSize), &m_uClientKey);
		Write(pBuffer);
		result = S_OK;
	}
	catch (...)
	{
		// Never unwind VC6 string/CException objects across the COM boundary.
		// In particular a character save may be much larger than 1024 bytes.
		result = E_FAIL;
	}
	if (pBuffer)
	{
		try { pBuffer->Release(); }
		catch (...) { result = E_FAIL; }
	}
	return result;
}
