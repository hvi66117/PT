/*****************************************************************************************
//	读取打包文件
//	Copyright : Kingsoft 2003
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2003-9-16
*****************************************************************************************/
#include "KWin32.h"
#include "XPackFile.h"
#include "KSpriteValidation.h"
#include "ucl/ucl.h"
#include <crtdbg.h>

// All archives share ms_ElemFileCache. Per-archive locks do not protect it
// against the scene-loading thread racing the render/audio thread.
struct XPackSharedCacheLock
{
	CRITICAL_SECTION section;
	XPackSharedCacheLock() { InitializeCriticalSection(&section); }
	~XPackSharedCacheLock() { DeleteCriticalSection(&section); }
};
static XPackSharedCacheLock g_XPackSharedCacheLock;

//一个Pack文件具有的头结构:
struct XPackFileHeader
{
	unsigned char cSignature[4];		//四个字节的文件的头标志，固定为字符串'PACK'
	unsigned long uCount;				//数据的条目数
	unsigned long uIndexTableOffset;	//索引的偏移量
	unsigned long uDataOffset;			//数据的偏移量
	unsigned long uCrc32;				//校验和
	unsigned char cReserved[12];		//保留的字节
};

#define	XPACKFILE_SIGNATURE_FLAG		0x4b434150	//'PACK'

//Pack中对应每个子文件的索引信息项
struct XPackIndexInfo
{
	unsigned long	uId;				//子文件id
	unsigned long	uOffset;			//子文件在包中的偏移位置
	long			lSize;				//子文件的原始大小
	long			lCompressSizeFlag;	//子文件压缩后的大小和压缩方法
										//最高字节表示压缩方法，见XPACK_METHOD
										//低的三个字节表示子文件压缩后的大小
};

//包文件的压缩方式
enum XPACK_METHOD
{
	TYPE_NONE	= 0x00000000,			//没有压缩
	TYPE_UCL	= 0x01000000,			//UCL压缩
	TYPE_UPL_NEW = 0x20000000, 			//Load Pak new
	TYPE_BZIP2	= 0x02000000,			//bzip2压缩
	TYPE_FRAME	= 0x10000000,			//使用了独立帧压缩,子文件为spr类型时才可能用到

	TYPE_METHOD_FILTER = 0x0f000000,	//过滤标记
	TYPE_FILTER = 0xff000000,			//过滤标记
};

//pak包中保存的spr帧信息项
struct XPackSprFrameInfo
{
	long lCompressSize;
	long lSize;
} ;

XPackFile::XPackElemFileCache	XPackFile::ms_ElemFileCache[MAX_XPACKFILE_CACHE];
int								XPackFile::ms_nNumElemFileCache = 0;

XPackFile::XPackFile()
{
	m_hFile = INVALID_HANDLE_VALUE;
	m_uFileSize = 0;
	m_pIndexList = NULL;
	m_nElemFileCount = 0;
	InitializeCriticalSection(&m_ReadCritical);
}

XPackFile::~XPackFile()
{
	Close();
	DeleteCriticalSection(&m_ReadCritical);
}

//-------------------------------------------------
//功能：打开包文件
//返回：成功与否
//-------------------------------------------------
bool XPackFile::Open(const char* pszPackFileName, int nSelfIndex)
{
	bool bResult = false;
	Close();
	EnterCriticalSection(&g_XPackSharedCacheLock.section);
	m_nSelfIndex = nSelfIndex;
	m_hFile = ::CreateFile(pszPackFileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
	while (m_hFile != INVALID_HANDLE_VALUE)
	{
		m_uFileSize = ::GetFileSize(m_hFile, NULL);
		if (m_uFileSize == 0 || m_uFileSize == INVALID_FILE_SIZE ||
			m_uFileSize <= sizeof(XPackFileHeader))
		{
			break;
		}
		XPackFileHeader	Header;
		DWORD			dwListSize, dwReaded;
		//--读取包文件头--
		if (::ReadFile(m_hFile, &Header, sizeof(Header), &dwReaded, NULL) == FALSE)
			break;
		//--包文件标记与内容的合法性判断--
		if (dwReaded != sizeof(Header) ||
			*(int*)(&Header.cSignature) != XPACKFILE_SIGNATURE_FLAG ||
			Header.uCount == 0 ||
			Header.uCount > m_uFileSize / sizeof(XPackIndexInfo) ||
			Header.uIndexTableOffset < sizeof(XPackFileHeader) ||
			Header.uIndexTableOffset >= m_uFileSize ||
			Header.uDataOffset < sizeof(XPackFileHeader) ||
			Header.uDataOffset >= m_uFileSize)
		{
			break;
		}

		//--读取索引信息表--
		dwListSize = sizeof(XPackIndexInfo) * Header.uCount;
		m_pIndexList = (XPackIndexInfo*)malloc(dwListSize);
		if (m_pIndexList == NULL ||
			::SetFilePointer(m_hFile, Header.uIndexTableOffset, NULL, FILE_BEGIN) != Header.uIndexTableOffset)
		{
			break;
		}
		if (::ReadFile(m_hFile, m_pIndexList, dwListSize, &dwReaded, NULL) == FALSE)
			break;
		if (dwReaded != dwListSize)
			break;
		bool bIndexOk = true;
		for (unsigned long i = 0; i < Header.uCount; i++)
		{
			unsigned long uStoredSize =
				(unsigned long)(m_pIndexList[i].lCompressSizeFlag & (~TYPE_FILTER));
			if (m_pIndexList[i].uId == 0 || m_pIndexList[i].lSize <= 0 ||
				uStoredSize == 0 || m_pIndexList[i].uOffset > m_uFileSize ||
				uStoredSize > m_uFileSize - m_pIndexList[i].uOffset)
			{
				bIndexOk = false;
				break;
			}
		}
		if (!bIndexOk)
			break;
		m_nElemFileCount = Header.uCount;
		bResult = true;
		break;
	};
	if (bResult == false)
		Close();
	LeaveCriticalSection(&g_XPackSharedCacheLock.section);
	return bResult;
}

//-------------------------------------------------
//功能：关闭包文件
//-------------------------------------------------
void XPackFile::Close()
{
	EnterCriticalSection(&g_XPackSharedCacheLock.section);

	if (m_pIndexList)
	{
		//----清除cache中缓存到的（可能）是此包中的子文件----
		for (int i = ms_nNumElemFileCache - 1; i >=0; i--)
		{
			if (ms_ElemFileCache[i].nPackIndex == m_nSelfIndex)
			{
				FreeElemCache(i);
				ms_nNumElemFileCache --;
				for (int j = i; j < ms_nNumElemFileCache; j++)
					ms_ElemFileCache[j] = ms_ElemFileCache[j + 1];
			}
		}
		free (m_pIndexList);
		m_pIndexList = NULL;
	}
	m_nElemFileCount = 0;

	if (m_hFile != INVALID_HANDLE_VALUE)
	{
		::CloseHandle(m_hFile);
		m_hFile = INVALID_HANDLE_VALUE;
	}
	m_uFileSize = 0;

	LeaveCriticalSection(&g_XPackSharedCacheLock.section);
}

//-------------------------------------------------
//功能：释放一个cache结点的内容
//返回：成功与否
//-------------------------------------------------
void XPackFile::FreeElemCache(int nCacheIndex)
{
	_ASSERT(nCacheIndex >= 0 && nCacheIndex < ms_nNumElemFileCache);
	if (ms_ElemFileCache[nCacheIndex].pBuffer)
	{
		free(ms_ElemFileCache[nCacheIndex].pBuffer);
		ms_ElemFileCache[nCacheIndex].pBuffer = NULL;
	}
	ms_ElemFileCache[nCacheIndex].uId = 0;
	ms_ElemFileCache[nCacheIndex].lSize = 0;
	ms_ElemFileCache[nCacheIndex].uRefFlag = 0;
	ms_ElemFileCache[nCacheIndex].nPackIndex = -1;
}

//-------------------------------------------------
//功能：直接读取包文件数据中的数据到缓冲区
//返回：成功与否
//-------------------------------------------------
bool XPackFile::DirectRead(void* pBuffer, unsigned int uOffset, unsigned int uSize) const
{
	bool bResult = false;
	DWORD dwReaded;
	_ASSERT(pBuffer && m_hFile != INVALID_HANDLE_VALUE);
	if (uOffset <= m_uFileSize && uSize <= m_uFileSize - uOffset &&
		::SetFilePointer(m_hFile, uOffset, 0, FILE_BEGIN) == uOffset)
	{
		if (ReadFile(m_hFile, pBuffer, uSize, &dwReaded, NULL))
		{
			if (dwReaded == uSize)
				bResult = true;
		}
	}
	return bResult;
}

//-------------------------------------------------
//功能：带解压地读取包文件到缓冲区
//参数：pBuffer --> 缓冲区指针
//		uExtractSize  --> 数据（期望）解压后的大小，pBuffer缓冲区的大小不小于此数
//		lCompressType --> 直接从包中度取得原始（/压缩）大小
//		uOffset  --> 从包中的此偏移位置开始读取
//		uSize    --> 从包中直接读取得（压缩）数据的大小
//返回：成功与否
//-------------------------------------------------
bool XPackFile::ExtractRead(void* pBuffer, unsigned int uExtractSize,
							long lCompressType, unsigned int uOffset, unsigned int uSize) const
{
	_ASSERT(pBuffer);
	bool bResult = false;
	if (lCompressType == TYPE_NONE)
	{
		if (uExtractSize == uSize)
			bResult = DirectRead(pBuffer, uOffset, uSize);
	}
	else
	{
		void*	pReadBuffer = malloc(uSize);
		if (pReadBuffer)
		{
		     if ((lCompressType == TYPE_UCL || lCompressType == TYPE_UPL_NEW) && DirectRead(pReadBuffer, uOffset, uSize))
			{
				unsigned int uDestLength = uExtractSize;
				int nResult = ucl_nrv2b_decompress_safe_8(
					(BYTE*)pReadBuffer, uSize, (BYTE*)pBuffer, &uDestLength, NULL);
				bResult = (nResult == UCL_E_OK && uDestLength == uExtractSize);
			}
			free (pReadBuffer);
		}
	}
	return bResult;
}

//-------------------------------------------------
//功能：在索引表中查找子文件项(二分法找)
//返回：如找到返回在索引表中的位置(>=0)，如未找到返回-1
//-------------------------------------------------
int XPackFile::FindElemFile(unsigned long ulId) const
{
	int nBegin, nEnd, nMid;
	nBegin = 0;
	nEnd = m_nElemFileCount - 1;
	while (nBegin <= nEnd)
	{
		nMid = (nBegin + nEnd) / 2;
		if (ulId < m_pIndexList[nMid].uId)
			nEnd = nMid - 1;
		else if (ulId > m_pIndexList[nMid].uId)
			nBegin = nMid + 1;
		else
			break;
	}
	return ((nBegin <= nEnd) ? nMid : -1);
}

//-------------------------------------------------
//功能：查找包内的子文件
//参数：uId --> 子文件的id
//		ElemRef -->如果找到则在此结构里填上子文件的相关信息
//返回：是否找到
//-------------------------------------------------
bool XPackFile::FindElemFile(unsigned long uId, XPackElemFileRef& ElemRef)
{
	ElemRef.nElemIndex = -1;
	if (uId)
	{
		EnterCriticalSection(&g_XPackSharedCacheLock.section);
		ElemRef.nCacheIndex = FindElemFileInCache(uId, -1);
		if (ElemRef.nCacheIndex >= 0)
		{
			ElemRef.uId = uId;
			ElemRef.nPackIndex = ms_ElemFileCache[ElemRef.nCacheIndex].nPackIndex;
			ElemRef.nElemIndex = ms_ElemFileCache[ElemRef.nCacheIndex].nElemIndex;
			ElemRef.nSize = ms_ElemFileCache[ElemRef.nCacheIndex].lSize;
			ElemRef.nOffset = 0;
		}
		else
		{
			ElemRef.nElemIndex = FindElemFile(uId);
			if (ElemRef.nElemIndex >= 0)
			{
				ElemRef.uId = uId;
				ElemRef.nPackIndex = m_nSelfIndex;
				ElemRef.nOffset = 0;
				ElemRef.nSize = m_pIndexList[ElemRef.nElemIndex].lSize;
			}
		}
		LeaveCriticalSection(&g_XPackSharedCacheLock.section);
	}
	return (ElemRef.nElemIndex >= 0);
}

//-------------------------------------------------
//功能：分配缓冲区，并读包内的子文件的内容到其中
//参数：子文件在包内的索引
//返回：成功则返回缓冲区的指针，否则返回空指针
//-------------------------------------------------
void* XPackFile::ReadElemFile(int nElemIndex) const
{
	_ASSERT(nElemIndex >= 0 && nElemIndex < m_nElemFileCount);
	void*	pDataBuffer = malloc(m_pIndexList[nElemIndex].lSize);
	if (pDataBuffer)
	{
		if (ExtractRead(pDataBuffer,
				m_pIndexList[nElemIndex].lSize,
				(m_pIndexList[nElemIndex].lCompressSizeFlag & TYPE_FILTER),
				m_pIndexList[nElemIndex].uOffset,
				(m_pIndexList[nElemIndex].lCompressSizeFlag & (~TYPE_FILTER))) == false)
		{
			free (pDataBuffer);
			pDataBuffer = NULL;
		}
	}
	return pDataBuffer;
}

//-------------------------------------------------
//功能：在cache里查找子文件
//参数：uId --> 子文件id
//		nDesireIndex --> 在cache中的可能位置
//返回：成功则返回cache节点索引(>=0),失败则返回-1
//-------------------------------------------------
int XPackFile::FindElemFileInCache(unsigned int uId, int nDesireIndex)
{
	if (nDesireIndex >= 0 && nDesireIndex < ms_nNumElemFileCache &&
		m_nSelfIndex == ms_ElemFileCache[nDesireIndex].nPackIndex &&
		uId == ms_ElemFileCache[nDesireIndex].uId)
	{
		ms_ElemFileCache[nDesireIndex].uRefFlag = 0xffffffff;
		return nDesireIndex;
	}

	nDesireIndex = -1;
	for (int i = 0; i < ms_nNumElemFileCache; i++)
	{
		if (uId == ms_ElemFileCache[i].uId && m_nSelfIndex == ms_ElemFileCache[i].nPackIndex)
		{
			ms_ElemFileCache[i].uRefFlag = 0xffffffff;
			nDesireIndex = i;
			break;
		}
	}
	return nDesireIndex;
}

//-------------------------------------------------
//功能：把子文件数据添加到cache
//参数：pBuffer --> 存有子文件数据的缓冲区
//		nElemIndex --> 子文件在包中的索引
//返回：添加到cache的索引位置
//-------------------------------------------------
int XPackFile::AddElemFileToCache(void* pBuffer, int nElemIndex)
{
	_ASSERT(pBuffer && nElemIndex >= 0 && nElemIndex < m_nElemFileCount);
	int nCacheIndex;
	if (ms_nNumElemFileCache < MAX_XPACKFILE_CACHE)
	{	//找到一个空位置
		nCacheIndex = ms_nNumElemFileCache++;
	}
	else
	{	//释放一个旧的cache节点
		nCacheIndex = 0;
		if (ms_ElemFileCache[0].uRefFlag)
			ms_ElemFileCache[0].uRefFlag --;
		for (int i = 1; i < MAX_XPACKFILE_CACHE; i++)
		{
			if (ms_ElemFileCache[i].uRefFlag)
				ms_ElemFileCache[i].uRefFlag --;
			if (ms_ElemFileCache[i].uRefFlag < ms_ElemFileCache[nCacheIndex].uRefFlag)
				nCacheIndex = i;

		}
		FreeElemCache(nCacheIndex);
	}
	ms_ElemFileCache[nCacheIndex].pBuffer = pBuffer;
	ms_ElemFileCache[nCacheIndex].uId = m_pIndexList[nElemIndex].uId;
	ms_ElemFileCache[nCacheIndex].lSize = m_pIndexList[nElemIndex].lSize;
	ms_ElemFileCache[nCacheIndex].nPackIndex = m_nSelfIndex;
	ms_ElemFileCache[nCacheIndex].nElemIndex = nElemIndex;
	ms_ElemFileCache[nCacheIndex].uRefFlag = 0xffffffff;
	return nCacheIndex;
}

//-------------------------------------------------
//功能：读取子文件一定长度的数据到缓冲区
//参数：pBuffer --> 用来读取数据的缓冲区
//		uSize --> 要读取的数据的长度
//返回：成功读取得字节数
//-------------------------------------------------
int XPackFile::ElemFileRead(XPackElemFileRef& ElemRef, void* pBuffer, unsigned uSize)
{
	int nResult = 0;
	if (pBuffer && ElemRef.uId &&ElemRef.nElemIndex >= 0)
	{
		EnterCriticalSection(&g_XPackSharedCacheLock.section);

		//--先看是否已经在cache里了---
		ElemRef.nCacheIndex = FindElemFileInCache(ElemRef.uId, ElemRef.nCacheIndex);

		if (ElemRef.nCacheIndex < 0 &&								//在cache里未找到
			ElemRef.nElemIndex < m_nElemFileCount &&
			m_pIndexList[ElemRef.nElemIndex].uId == ElemRef.uId)
		{
			void*	pDataBuffer = ReadElemFile(ElemRef.nElemIndex);
			if (pDataBuffer)
				ElemRef.nCacheIndex = AddElemFileToCache(pDataBuffer, ElemRef.nElemIndex);
		}

		if (ElemRef.nCacheIndex >= 0 &&
			//此下面三项应该展开检查，防止被模块外部改变，引起错误。
			//为效率可考虑省略，但需外部按照规则随便改变ElemRef的内容。
			ElemRef.nPackIndex == ms_ElemFileCache[ElemRef.nCacheIndex].nPackIndex &&
			ElemRef.nElemIndex == ms_ElemFileCache[ElemRef.nCacheIndex].nElemIndex &&
			ElemRef.nSize == ms_ElemFileCache[ElemRef.nCacheIndex].lSize
			)
		{
			//_ASSERT(ElemRef.nPackIndex == ms_ElemFileCache[ElemRef.nCacheIndex].nPackIndex);
			//_ASSERT(ElemRef.nElemIndex == ms_ElemFileCache[ElemRef.nCacheIndex].nElemIndex);
			//_ASSERT(ElemRef.nSize == ms_ElemFileCache[ElemRef.nCacheIndex].lSize);

			if (ElemRef.nOffset < 0)
				ElemRef.nOffset = 0;
			if (ElemRef.nOffset < ElemRef.nSize)
			{
				if (ElemRef.nOffset + (int)uSize <= ElemRef.nSize)
					nResult = uSize;
				else
					nResult = ElemRef.nSize - ElemRef.nOffset;
				memcpy(pBuffer, (char*)ms_ElemFileCache[ElemRef.nCacheIndex].pBuffer + ElemRef.nOffset, nResult);
				ElemRef.nOffset += nResult;
			}
			else
			{
				ElemRef.nOffset = ElemRef.nSize;
			}
		}
		LeaveCriticalSection(&g_XPackSharedCacheLock.section);
	}
	return nResult;
}

#define	NODE_INDEX_STORE_IN_RESERVED	2

#ifndef _SERVER
extern SPRHEAD* NormalizeSeaweedSpr(const unsigned char*, unsigned long,
	const SPRHEAD&, SPROFFS*&);
#endif

SPRHEAD* XPackFile::GetSprHeader(XPackElemFileRef& ElemRef, SPROFFS*& pOffsetTable)
{
	SPRHEAD* pSpr = NULL;
	bool bOk = false;
	pOffsetTable = NULL;
	if (ElemRef.uId == 0 || ElemRef.nElemIndex < 0)
		return NULL;

	EnterCriticalSection(&g_XPackSharedCacheLock.section);
	if (ElemRef.nElemIndex < m_nElemFileCount &&
		m_pIndexList[ElemRef.nElemIndex].uId == ElemRef.uId)
	{
		XPackIndexInfo& Index = m_pIndexList[ElemRef.nElemIndex];
		if ((Index.lCompressSizeFlag & TYPE_FRAME) == 0)
		{
			pSpr = (SPRHEAD*)ReadElemFile(ElemRef.nElemIndex);
			if (pSpr && Index.lSize > 0 &&
				KSprIsLegacyIndexedBlob((const unsigned char*)pSpr,
					(unsigned long)Index.lSize, *pSpr))
			{
				pOffsetTable = (SPROFFS*)(((char*)pSpr) + sizeof(SPRHEAD) + pSpr->Colors * 3);
				bOk = true;
			}
		}
		else
		{
			SPRHEAD Header;
			if (Index.lSize >= (long)sizeof(SPRHEAD) &&
				Index.uOffset <= m_uFileSize && sizeof(SPRHEAD) <= m_uFileSize - Index.uOffset &&
				DirectRead(&Header, Index.uOffset, sizeof(SPRHEAD)) &&
				KSprIsValidHeader(Header, (unsigned long)Index.lSize))
			{
				unsigned long uPaletteSize = Header.Colors * sizeof(KPAL24);
				unsigned long uFrameListSize = Header.Frames * sizeof(XPackSprFrameInfo);
				unsigned long uBodySize = uPaletteSize + uFrameListSize;
				unsigned long uPrefixSize = sizeof(SPRHEAD) + uBodySize;
				if (uBodySize >= uPaletteSize && uPrefixSize >= uBodySize &&
					Index.uOffset <= m_uFileSize && uPrefixSize <= m_uFileSize - Index.uOffset)
				{
					pSpr = (SPRHEAD*)malloc(uPrefixSize);
					if (pSpr && DirectRead((char*)(&pSpr[1]),
						Index.uOffset + sizeof(SPRHEAD), uBodySize))
					{
						memcpy(pSpr, &Header, sizeof(SPRHEAD));
						XPackSprFrameInfo* pFrames = (XPackSprFrameInfo*)((char*)pSpr +
							sizeof(SPRHEAD) + uPaletteSize);
						unsigned long uDataOffset = Index.uOffset + uPrefixSize;
						bOk = true;
						for (unsigned int i = 0; i < Header.Frames; i++)
						{
							long lRawSize = pFrames[i].lSize;
							unsigned long uRawSize = lRawSize < 0 ?
								(unsigned long)(-(lRawSize + 1)) + 1 : (unsigned long)lRawSize;
							long lStoredSize = pFrames[i].lCompressSize;
							if (lStoredSize <= 0 || uRawSize < KSPR_FRAME_HEADER_SIZE ||
								uRawSize > KSPR_MAX_FRAME_BYTES || uDataOffset > m_uFileSize ||
								(unsigned long)lStoredSize > m_uFileSize - uDataOffset)
							{
								bOk = false;
								break;
							}
							uDataOffset += (unsigned long)lStoredSize;
						}
					}
				}
			}
		}

		if (pSpr)
		{
			if (bOk)
				*((int*)&pSpr->Reserved[NODE_INDEX_STORE_IN_RESERVED]) = ElemRef.nElemIndex;
			else
			{
				free(pSpr);
				pSpr = NULL;
				pOffsetTable = NULL;
			}
		}
		#ifndef _SERVER
		// New VNG frame-compressed RGB sprites omit the global palette.
		// Reconstruct their bounded frame blob and use the shared converter.
		if (!bOk && (Index.lCompressSizeFlag & TYPE_FRAME))
		{
			SPRHEAD h;
			unsigned long stored = Index.lCompressSizeFlag & ~TYPE_FILTER;
			if (stored >= sizeof(h) && DirectRead(&h, Index.uOffset, sizeof(h)) &&
				KSprIsValidHeader(h, Index.lSize))
			{
				unsigned long prefix = sizeof(h) + h.Frames * sizeof(XPackSprFrameInfo);
				XPackSprFrameInfo* list = (XPackSprFrameInfo*)malloc(h.Frames * sizeof(XPackSprFrameInfo));
				bool valid = list && prefix <= stored && DirectRead(list,
					Index.uOffset + sizeof(h), prefix - sizeof(h));
				unsigned long total = prefix, consumed = prefix;
				for (unsigned int f = 0; valid && f < h.Frames; ++f)
				{
					long raw = list[f].lSize;
					unsigned long size = raw < 0 ? (unsigned long)(-(raw + 1)) + 1 : raw;
					valid = size >= 8 && size <= KSPR_MAX_FRAME_BYTES &&
						total <= KSPR_MAX_FRAME_BYTES - size && list[f].lCompressSize > 0 &&
						(unsigned long)list[f].lCompressSize <= stored - consumed;
					if (valid) { total += size; consumed += list[f].lCompressSize; }
				}
				unsigned char* blob = valid ? (unsigned char*)malloc(total) : NULL;
				if (blob)
				{
					memcpy(blob, &h, sizeof(h));
					SPROFFS* offsets = (SPROFFS*)(blob + sizeof(h));
					unsigned long src = Index.uOffset + prefix, dst = prefix;
					for (unsigned int f = 0; valid && f < h.Frames; ++f)
					{
						long raw = list[f].lSize;
						unsigned long size = raw < 0 ? (unsigned long)(-(raw + 1)) + 1 : raw;
						offsets[f].Offset = dst - prefix; offsets[f].Length = size;
						valid = ExtractRead(blob + dst, size, raw < 0 ? TYPE_NONE :
							(Index.lCompressSizeFlag & TYPE_METHOD_FILTER), src, list[f].lCompressSize);
						src += list[f].lCompressSize; dst += size;
					}
					if (valid && KSprIsSeaweedTrueColorBlob(blob, total, h))
						pSpr = NormalizeSeaweedSpr(blob, total, h, pOffsetTable);
					free(blob);
				}
				free(list);
			}
		}
		#endif
	}
	LeaveCriticalSection(&g_XPackSharedCacheLock.section);
	return pSpr;
}
SPRFRAME* XPackFile::GetSprFrame(SPRHEAD* pSprHeader, int nFrame)
{
	SPRFRAME* pFrame = NULL;
	if (pSprHeader && nFrame >= 0 && nFrame < pSprHeader->Frames &&
		KSprIsValidHeader(*pSprHeader, sizeof(SPRHEAD)))
	{
		EnterCriticalSection(&g_XPackSharedCacheLock.section);
		int nNodeIndex = *((int*)&pSprHeader->Reserved[NODE_INDEX_STORE_IN_RESERVED]);
		if (nNodeIndex >= 0 && nNodeIndex < m_nElemFileCount)
		{
			XPackIndexInfo& Index = m_pIndexList[nNodeIndex];
			long lCompressType = Index.lCompressSizeFlag;
			if ((lCompressType & TYPE_FRAME) != 0)
			{
				lCompressType &= TYPE_METHOD_FILTER;
				unsigned long uPaletteSize = pSprHeader->Colors * sizeof(KPAL24);
				XPackSprFrameInfo* pFrameList = (XPackSprFrameInfo*)((char*)pSprHeader +
					sizeof(SPRHEAD) + uPaletteSize);
				unsigned long uPrefixSize = sizeof(SPRHEAD) + uPaletteSize +
					pSprHeader->Frames * sizeof(XPackSprFrameInfo);
				unsigned long uSrcOffset = Index.uOffset + uPrefixSize;
				bool bRangeOk = uSrcOffset >= Index.uOffset && uSrcOffset <= m_uFileSize;
				for (int i = 0; bRangeOk && i < nFrame; i++)
				{
					if (pFrameList[i].lCompressSize <= 0 ||
						(unsigned long)pFrameList[i].lCompressSize > m_uFileSize - uSrcOffset)
						bRangeOk = false;
					else
						uSrcOffset += (unsigned long)pFrameList[i].lCompressSize;
				}

				long lRawSize = pFrameList[nFrame].lSize;
				unsigned long uFrameSize = lRawSize < 0 ?
					(unsigned long)(-(lRawSize + 1)) + 1 : (unsigned long)lRawSize;
				long lStoredSize = pFrameList[nFrame].lCompressSize;
				if (bRangeOk && lStoredSize > 0 && uFrameSize >= KSPR_FRAME_HEADER_SIZE &&
					uFrameSize <= KSPR_MAX_FRAME_BYTES && uSrcOffset <= m_uFileSize &&
					(unsigned long)lStoredSize <= m_uFileSize - uSrcOffset)
				{
					pFrame = (SPRFRAME*)malloc(uFrameSize);
					bool bOk = false;
					if (pFrame)
					{
						if (lRawSize < 0)
							bOk = ((unsigned long)lStoredSize == uFrameSize) &&
								DirectRead(pFrame, uSrcOffset, uFrameSize);
						else if (lCompressType == TYPE_NONE || lCompressType == TYPE_UCL)
							bOk = ExtractRead(pFrame, uFrameSize, lCompressType,
								uSrcOffset, (unsigned long)lStoredSize);
						if (bOk)
							bOk = pFrame->Width > 0 && pFrame->Height > 0 &&
								pFrame->Width <= KSPR_MAX_DIMENSION &&
								pFrame->Height <= KSPR_MAX_DIMENSION &&
								KSprIsValidIndexedRle(pFrame->Sprite,
									uFrameSize - KSPR_FRAME_HEADER_SIZE,
									pFrame->Width, pFrame->Height, pSprHeader->Colors);
						if (!bOk)
						{
							free(pFrame);
							pFrame = NULL;
						}
					}
				}
			}
		}
		LeaveCriticalSection(&g_XPackSharedCacheLock.section);
	}
	return pFrame;
}
