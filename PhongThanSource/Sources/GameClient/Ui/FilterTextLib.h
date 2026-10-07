// FilterTextLib.h: interface for the CFilterTextLib class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FILTERTEXTLIB_H__A17EADC0_A233_400A_A8F4_86A333698154__INCLUDED_)
#define AFX_FILTERTEXTLIB_H__A17EADC0_A233_400A_A8F4_86A333698154__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define FILTERTEXT_STATICLIB    //use static lib

#include "../../FilterText/FilterText.h"

#if defined(PHONGTHAN_MODERN_BUILD)
// VS2022 build: the VC6 static lib uses the old STL; link the one Build-Modern.ps1 rebuilt (relative to the GameClient project dir, which holds a VC6 copy)
#pragma comment(lib, "../../OutputModern/lib/FilterText_StaticLib.lib")
#elif defined(_DEBUG)
#pragma comment(lib, "../../Lib/Debug/FilterText_StaticLib.lib")
#else
#pragma comment(lib, "../../Lib/Release/FilterText_StaticLib.lib")
#endif

class CFilterTextLib {
public:
    CFilterTextLib();

    virtual ~CFilterTextLib();

public:
    BOOL Initialize();

    BOOL Uninitialize();

private:
/*
	HMODULE m_hFilterText;

	typedef HRESULT (*LPFNCREATETEXTFILTER)(ITextFilter** ppTextFilter);
	LPFNCREATETEXTFILTER m_lpfnCreateTextFilter;
*/
public:
    HRESULT CreateTextFilter(ITextFilter **ppTextFilter);
};

#endif // !defined(AFX_FILTERTEXTLIB_H__A17EADC0_A233_400A_A8F4_86A333698154__INCLUDED_)
