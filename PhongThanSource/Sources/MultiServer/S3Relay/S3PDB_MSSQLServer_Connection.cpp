// S3PDB_MSSQLServer_Connection.cpp: implementation of the S3PDB_MSSQLServer_Connection class.
//
//////////////////////////////////////////////////////////////////////
#include "stdafx.h"
#include "S3PDB_MSSQLServer_Connection.h"
#include "S3P_MSSQLServer_Result.h"
#include "S3Relay.h"

WINOLEAPI  CoInitializeEx(LPVOID pvReserved, DWORD dwCoInit);

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

static int nSQLServer = 0;

S3PDB_MSSQLServer_Connection::S3PDB_MSSQLServer_Connection()
	: m_pCon(NULL), m_pCmd(NULL)
{
	if (nSQLServer == 0)
		CoInitializeEx(NULL, 0);
	nSQLServer++;
}

S3PDB_MSSQLServer_Connection::~S3PDB_MSSQLServer_Connection()
{
	assert(m_pCon == NULL);

	nSQLServer--;

	if (nSQLServer == 0)
		CoUninitialize();
}

void S3PDB_MSSQLServer_Connection::CloseConnect()
{
	if (NULL != m_pCon)
	{
		m_pCon->Close();
		m_pCon = NULL;
	}

	m_pCmd = NULL;
}

bool S3PDB_MSSQLServer_Connection::OpenConnect(_LPDATABASEINFO lpDBIdentifier)
{
	assert(lpDBIdentifier);
	assert(NULL == m_pCon);
	bool bRet = true;
	if (NULL == m_pCon)
	{
		bRet = false;
		_ConnectionPtr pCon;
		HRESULT hr = pCon.CreateInstance("ADODB.Connection");
		if ((SUCCEEDED(hr))
			&& (NULL != pCon))
		{
			std::string strSource = "driver={SQL Server};";
			std::string strTemp = "Server=";
			strTemp += lpDBIdentifier->strServer;
			strTemp += ";";
			strSource += strTemp;
			strTemp = "Database=";
			strTemp += lpDBIdentifier->strDataBase;
			strTemp += ";";
			strSource += strTemp;
			lpDBIdentifier->strDataBase.c_str();
			try
			{
				pCon->CursorLocation = adUseClient;
				hr = pCon->Open(strSource.c_str(),
								lpDBIdentifier->strUser.c_str(),
								lpDBIdentifier->strPassword.c_str(),
								adConnectUnspecified);
				if (SUCCEEDED(hr))
				{
					m_pCon = pCon;

					m_pCmd.CreateInstance("ADODB.Command");

					if (m_pCmd)
						m_pCmd->ActiveConnection = m_pCon;

					bRet = true;
				}
			}
			catch( _com_error &error )
			{
				gTrace("[S3PDB_MSSQLServer_Connection::OpenConnect]COM error: %s", error.ErrorMessage());
			}
		}
	}
	return bRet;
}

/*bool S3PDB_MSSQLServer_Connection::OpenConnect()
{
	assert(NULL == m_pCon);
	bool bRet = true;
	if (NULL == m_pCon)
	{
		bRet = false;
		_ConnectionPtr pCon;
		HRESULT hr = pCon.CreateInstance("ADODB.Connection");
		if ((SUCCEEDED(hr))
			&& (NULL != pCon))
		{
			std::string strSource = "driver={SQL Server};";
			std::string strTemp = "Server=";
			strTemp += "192.168.1.3";
			strTemp += ";";
			strSource += strTemp;
			strTemp = "Database=";
			strTemp += "account";
			strTemp += ";";
			strSource += strTemp;
			try
			{
				pCon->CursorLocation = adUseClient;
				hr = pCon->Open(strSource.c_str(),"sa","sa",adConnectUnspecified);
				if (SUCCEEDED(hr))
				{
					m_pCon = pCon;
					m_pCmd.CreateInstance("ADODB.Command");
					if (m_pCmd)
						m_pCmd->ActiveConnection = m_pCon;
					bRet = true;
				}
			}
			catch( _com_error &error )
			{
				gTrace("[S3PDB_MSSQLServer_Connection::OpenConnect]COM error: %s", error.ErrorMessage());
			}
		}
	}
	return bRet;
}*/

bool S3PDB_MSSQLServer_Connection::Do(const char* lpszSql)
{
	if (m_pCmd)
		return DoCmd(lpszSql);
	else
		return DoResult(lpszSql);
}

bool S3PDB_MSSQLServer_Connection::DoCmd(const char* lpszSql)
{
	bool bRet = false;
	if (m_pCon == NULL || m_pCmd == NULL)
		return bRet;

	try
	{
		m_pCmd->CommandText = lpszSql;
		m_pCmd->Execute(NULL, NULL, adCmdText);
		bRet = true;
	}
	catch (_com_error &e)
    {
		gTrace("[S3PDB_MSSQLServer_Connection::DoCmd COM error: %s ", e.ErrorMessage());
		
		CloseConnect();
    }

	return bRet;
}

bool S3PDB_MSSQLServer_Connection::DoResult(const char* lpszSql)
{
	bool bRet = false;
	if (m_pCon == NULL)
		return bRet;

	try
	{
		_RecordsetPtr pResult;
		HRESULT hr = pResult.CreateInstance("ADODB.Recordset");
		hr =
			pResult->Open(lpszSql,
			_variant_t( (IDispatch*)(m_pCon), true),
			adOpenDynamic,
			adLockOptimistic,
			adCmdText);
		if (SUCCEEDED(hr))
		{
			bRet = true;
		}
	}
	catch (_com_error &e)
    {
		gTrace("[S3PDB_MSSQLServer_Connection::DoResult COM error: %s", e.ErrorMessage());
		bRet = false;
    }

	return bRet;
}

bool S3PDB_MSSQLServer_Connection::QuerySql(const char* lpszSql, S3PResultVBC** ppResult)
{
	*ppResult = NULL;
	bool bRet = false;
	S3P_MSSQLServer_Result* pResult = NULL;
	if (GetFreeResult(&pResult))
	{
		if (m_pCmd)
		{
			bRet = QueryCmd(lpszSql, pResult);
		}
		else
		{
			bRet = QueryResult(lpszSql, pResult);
		}

		if (bRet)
		{
			*ppResult = pResult;
		}
		else
		{
			pResult->unuse();
		}
	}

	return bRet;
}

bool S3PDB_MSSQLServer_Connection::QueryResult(const char* lpszSql, S3P_MSSQLServer_Result* pRes)
{
	bool bRet = false;
	if ((NULL != m_pCon) &&
		(NULL != lpszSql) &&
		(NULL != pRes))
	{
		try
		{
			_RecordsetPtr pResult;
			HRESULT hr = pResult.CreateInstance("ADODB.Recordset");
			hr =
					pResult->Open(lpszSql,
					_variant_t( (IDispatch*)(m_pCon), true),
					adOpenStatic,
					adLockReadOnly,
					adCmdText);
			if (SUCCEEDED(hr))
			{
				pRes->AttachResult(pResult);
				bRet = true;
			}
		}
		catch ( _com_error &e )
		{
#ifdef _DEBUG
			gTrace("SQL Error: %s", lpszSql);
#endif
			gTrace("[S3PDB_MSSQLServer_Connection::QueryResult COM error: %s", e.ErrorMessage());
			bRet = false;
		}
	}

	return bRet;
}

bool S3PDB_MSSQLServer_Connection::QueryCmd(const char* lpszSql, S3P_MSSQLServer_Result* pRes)
{
	bool bRet = false;
	if ((NULL != m_pCon) &&
		(NULL != lpszSql) &&
		(NULL != pRes) &&
		(NULL != m_pCmd))
	{
		try
		{
			m_pCmd->CommandText = lpszSql;
			_RecordsetPtr pResult = m_pCmd->Execute(NULL, NULL, adCmdText);
			bRet = true;
			pRes->AttachResult(pResult);
		}
		catch ( _com_error &e )
		{
#ifdef _DEBUG
			gTrace("SQL Error: %s", lpszSql);
#endif
			gTrace("[S3PDB_MSSQLServer_Connection::QueryCmd COM error: %s", e.ErrorMessage());

			CloseConnect();

			bRet = false;
		}
	}

	return bRet;
}

bool S3PDB_MSSQLServer_Connection::GetFreeResult(S3P_MSSQLServer_Result** ppResult)
{
	assert(ppResult);
	if (m_Result.m_pResult == NULL)
	{
		*ppResult = &m_Result;
		return true;
	}
	if (m_Result2.m_pResult == NULL)
	{
		*ppResult = &m_Result2;
		return true;
	}
	assert(0);
	return false;
}
