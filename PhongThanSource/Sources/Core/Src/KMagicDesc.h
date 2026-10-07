#ifndef KMagicDescH
#define	KMagicDescH

#include "KIniFile.h"

class KMagicDesc
{
private:
	enum
	{
		MAGIC_DESC_COUNT = 357,
		MAGIC_DESC_LENGTH = 256
	};
	// MagicDesc.ini cua VNG co 358 dong nhung khoa knockback_p xuat hien hai
	// lan. Numeric ID cua Phong Than la danh sach 357 khoa duy nhat; dong lap
	// sau cap nhat noi dung cua cung ID, khong duoc lam lech cac ID phia sau.
	char		m_aryTemplate[MAGIC_DESC_COUNT][MAGIC_DESC_LENGTH];
	int		m_nTemplateCount;
	char		m_szDesc[256];
public:
	KMagicDesc();
	~KMagicDesc();
	BOOL		Init();
	const char*	GetDesc(void* pData);
	int	String2MagicID(char * szMagicAttribName);
};

extern KMagicDesc	g_MagicDesc;
const char* g_MagicID2String(int nAttrib);
int g_String2MagicID(char* szMagicAttribName);
#endif
