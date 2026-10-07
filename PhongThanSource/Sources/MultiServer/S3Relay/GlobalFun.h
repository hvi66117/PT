#ifndef _GLOBALFUN_H_
#define _GLOBALFUN_H_

#include <WTypes.h>
#include <stdio.h>


BOOL KPIWritePrivateProfileString( LPCTSTR lpszAppName,	/* section name */
								  LPCTSTR lpszKeyName,	/* key name */
								  LPCTSTR lpszString,	/* string to add */
								  LPCTSTR lpszFileName	/* initialization file */ );

DWORD KPIGetPrivateProfileString( LPCTSTR lpszAppName,	/* section name(Input) */
							  LPCTSTR lpszKeyName,		/* key name(Input) */
							  LPCTSTR lpszDefault,		/* default string(Input) */
							  LPTSTR lpszReturnedString,/* destination buffer(Output) */
							  DWORD dwSize,				/* size of destination buffer(Input) */
							  LPCTSTR lpszFileName		/* initialization file name(Input) */ );

void KPIGetExePath( LPSTR lpExePath, DWORD dwSize );

HANDLE KPICreateMutex( LPSECURITY_ATTRIBUTES lpMutexAttributes,	/* SD */
					  BOOL bInitialOwner,						/* initial owner */
					  LPCTSTR lpName							/* object name */ );

BOOL KPIReleaseMutex( HANDLE hMutex );


unsigned long KPIHash( char* pStr, unsigned long ulModel, unsigned long ulBaseNum );

void KPIPrintToFile( const TCHAR* lpszFilePath, const TCHAR* lpszFmt, ... );
void KPIPrintToFile( FILE* pFile, const TCHAR* lpszFmt, ... );

#endif	// _GLOBALFUN_H_