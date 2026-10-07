//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KZipList.cpp
// Date:	2000.08.08
// Code:	WangWei(Daphnis)
// Desc:	Pack Data List Class
//---------------------------------------------------------------------------
#include "KWin32.h"
#include "KDebug.h"
#include "KMemBase.h"
#include "KStrBase.h"
#include "KFilePath.h"
#include "KIniFile.h"
#include "KZipList.h"
//---------------------------------------------------------------------------
ENGINE_API KZipList* g_pZipList = NULL;
//---------------------------------------------------------------------------
// ����:	KZipList
// ����:	���캯��
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
KZipList::KZipList()
{
	g_pZipList = this;
	m_nNumber  = 0;
	m_nActive  = 0;
}
//---------------------------------------------------------------------------
// ����:	~KZipList
// ����:	���캯��
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
KZipList::~KZipList()
{
	m_nNumber = 0;
	m_nActive = 0;
}
//---------------------------------------------------------------------------
// ����:	Open
// ����:	��һ���ļ���
// ����:	FileName	�ļ���
// ����:	TRUE		�ɹ�
//			FALSE		ʧ��
//---------------------------------------------------------------------------
BOOL KZipList::Open(LPSTR FileName)
{
	KIniFile IniFile;
	char Section[16] = "Package";
	char Key[16];
	char PakPath[32];
	char PakFile[32];
	
	if (!IniFile.Load(FileName))
		return FALSE;
	if (!IniFile.GetString(Section, "Path", "", PakPath, 32))
		return FALSE;
	g_SetFilePath(PakPath);
	Close();
	while (m_nNumber < MAX_PAK)
	{
		sprintf(Key, "%d", m_nNumber);
		if (!IniFile.GetString(Section, Key, "", PakFile, 32))
			break;
		if (!m_ZipFile[m_nNumber].Open(PakFile))
			g_DebugLog("PakList Open : %s ... Fail", PakFile);
		m_nNumber++;
		//g_DebugLog("PakList Open : %s ... Ok", PakFile);
	}
	return TRUE;
}
//---------------------------------------------------------------------------
// ����:	Close
// ����:	�ر������ļ�
// ����:	void
// ����:	void
//---------------------------------------------------------------------------
void KZipList::Close()
{
	for (int i = 0; i < m_nNumber; i++)
		m_ZipFile[i].Close();
	m_nNumber = 0;
	m_nActive = 0;
}
//---------------------------------------------------------------------------
// ����:	Read
// ����:	��ȡ�ļ�����
// ����:	pBuffer		����
//			dwLen		����
// ����:	��ȡ����
//---------------------------------------------------------------------------
DWORD KZipList::Read(PVOID pBuffer, DWORD dwLen)
{
	return m_ZipFile[m_nActive].Read(pBuffer, dwLen);
}
//---------------------------------------------------------------------------
// ����:	Seek
// ����:	�ļ�ָ�붨λ
// ����:	Offset		ƫ��
//			Method		����
// ����:	�ļ�ָ��λ��
//---------------------------------------------------------------------------
DWORD KZipList::Seek(LONG lOffset, DWORD Method)
{
	return m_ZipFile[m_nActive].Seek(lOffset, Method);
}
//---------------------------------------------------------------------------
// ����:	Tell
// ����:	ȡ���ļ�ָ��λ��
// ����:	void
// ����:	�ļ�ָ��λ��
//---------------------------------------------------------------------------
DWORD KZipList::Tell()
{
	return m_ZipFile[m_nActive].Tell();
}
//---------------------------------------------------------------------------
// ����:	Search
// ����:	�����а���ɨ���ƶ��ļ�
// ����:	FileName	�ļ���
//			pOffset		�ļ�ƫ��
//			pLen		�ļ���С
// ����:	int			zipfile index
//---------------------------------------------------------------------------
int KZipList::Search(LPSTR FileName, PDWORD pOffset, PDWORD pLen)
{
	// if no pack file in list
	if (m_nNumber == 0)
		return -1;

	// search in all package files
	for (int i = 0; i < m_nNumber; i++)
	{
		if (m_ZipFile[i].Search(FileName, pOffset, pLen))
		{
			m_nActive = i;
			return m_nActive;
		}
	}
	return -1;
}
//---------------------------------------------------------------------------
// ����:	Decode
// ����:	��ѹ��
// ����:	pIn			ѹ������ָ��
//			pOut		��ѹ����ָ��
//			pLf			Local File header
// ����:	TRUE		�ɹ�
//			FALSE		ʧ��
//---------------------------------------------------------------------------
BOOL KZipList::Decode(
	PBYTE	pIn,		// ѹ������ָ��
	PBYTE	pOut,		// ��ѹ����ָ��
	LF*		pLf			// Local Header ptr
	)
{
	return m_ZipCodec.Decode(pIn, pOut, pLf);
}
//---------------------------------------------------------------------------

