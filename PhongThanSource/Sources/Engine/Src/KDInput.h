//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KDInput.h
// Date:	2000.08.08
// Code:	WangWei(Daphnis)
// Desc:	Header File
//---------------------------------------------------------------------------
#ifndef KDInput_H
#define KDInput_H

#define DIRECTINPUT_VERSION 0x0800
#include <dinput.h>

// Some newer Windows SDK DirectInput headers expose only the A/W typedefs
// when compiling this legacy VC6 project.  The engine is built as an MBCS
// application, so provide the generic aliases expected by the old source.
#ifndef IDirectInput8
#define LPDIRECTINPUT8 void *
#endif
#ifndef IDirectInputDevice8
#define LPDIRECTINPUTDEVICE8 void *
#endif

//---------------------------------------------------------------------------
class ENGINE_API KDirectInput
{
private:
	LPDIRECTINPUT8			m_pDirectInput;
	LPDIRECTINPUTDEVICE8	m_pMouseDevice;
	LPDIRECTINPUTDEVICE8	m_pKeyboardDevice;
private:
	BOOL	CreateDirectInput();
	BOOL	CreateMouseDevice();
	BOOL	CreateKeyboardDevice();
public:
	KDirectInput();
	~KDirectInput();
	BOOL	Init();
	void	Exit();
	BOOL	GetMouseState(PINT dx, PINT dy, PBYTE lb, PBYTE rb);
	BOOL	GetKeyboardState(PBYTE KeyBuffer);
	BOOL	SetMouseBehavior(BOOL bExclusive);
};

extern ENGINE_API KDirectInput* g_pDirectInput;
#endif
