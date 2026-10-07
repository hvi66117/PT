// Bishop.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "Application.h"
#include "Macro.h"
#include <stdio.h>

int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
	FILE* fe = fopen("bishop_entry.log", "w");
	if (fe) {
		fprintf(fe, "WinMain enter\n");
		fclose(fe);
	}

	CBishopApp app( hInstance );

	int nRet = app.Run();

	return nRet;
}
