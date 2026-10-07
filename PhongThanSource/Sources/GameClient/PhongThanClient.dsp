# Microsoft Developer Studio Project File - Name="PhongThanClient" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=PhongThanClient - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "PhongThanClient.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "PhongThanClient.mak" CFG="PhongThanClient - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "PhongThanClient - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "PhongThanClient - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /Zi /O2 /I "../Engine/src" /I "../Core/src" /I "../Engine/include" /I "../../Headers" /D "WIN32" /D "NDEBUG_WINDOWS" /D "_MBCS" /D "PHONGTHAN_USE_MD5_PASSWORD" /Yu"KWin32.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x804 /d "NDEBUG"
# ADD RSC /l 0x804 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib Winmm.lib shlwapi.lib lualibdll.lib /nologo /subsystem:windows /map /pdb:none /machine:I386 /out:"Release/Game.exe" /libpath:"../../lib/"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=md ..\..\Output\Client\release\	copy Release\Game.exe ..\..\Output\Client\Game.exe	copy Release\Game.exe ..\..\Output\Client\release\Game.exe	copy Release\Game.pdb ..\..\Output\Client\release\Game.pdb	copy Release\Game.map ..\..\Output\Client\release\Game.map
# End Special Build Tool

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /Zi /Od /I "../Engine/src" /I "../Core/src" /I "../Engine/include" /I "../../Headers" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "PHONGTHAN_SHOW_DEBUG_INFO" /D "PHONGTHAN_USE_MD5_PASSWORD" /FR /Yu"KWin32.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x804 /d "_DEBUG"
# ADD RSC /l 0x804 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib Winmm.lib shlwapi.lib lualibdll.lib /nologo /subsystem:windows /incremental:no /map /debug /machine:I386 /out:"Debug/Game.exe" /libpath:"../../lib/"
# SUBTRACT LINK32 /profile
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=md ..\..\Output\Client\debug\	copy debug\Game.exe ..\..\Output\Client\Game.exe	copy debug\Game.exe ..\..\Output\Client\debug\Game.exe
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "PhongThanClient - Win32 Release"
# Name "PhongThanClient - Win32 Debug"
# Begin Group "????"

# PROP Default_Filter ""
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\Elem\AutoLocateWnd.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\AutoLocateWnd.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\ComWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\ComWindow.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\MouseHover.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\MouseHover.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\PopupMenu.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\PopupMenu.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\SpaceOver.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\SpaceOver.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\SpecialFuncs.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\SpecialFuncs.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\TextPic.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\TextPic.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\UiCursor.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\UiCursor.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\UiImage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\UiImage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndBorder.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndBorder.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndButton.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndButton.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndEdit.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndGameSpace.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndImage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndImage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndImagePart.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndImagePart.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndLabeledButton.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndLabeledButton.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndList.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndList.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndList2.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndList2.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndMessage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndMessageListBox.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndMessageListBox.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndMovingImage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndMovingImage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndObjContainer.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndObjContainer.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndPage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndPage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndPureTextBtn.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndPureTextBtn.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\Wnds.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\Wnds.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndScrollBar.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndScrollBar.h
# End Source File
# Begin Source File

SOURCE=.\Ui\elem\WndShadow.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\elem\WndShadow.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndShowAnimate.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndShowAnimate.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndText.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndText.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndToolBar.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndToolBar.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndValueImage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndValueImage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\Elem\WndWindow.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiConnectInfo.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiConnectInfo.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiLogin.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiLogin.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiLoginBg.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiLoginBg.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNotice.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNotice.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelServer.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelServer.h
# End Source File
# End Group
# Begin Group "????????,????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiChooseFace.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiChooseFace.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiContainer.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiContainer.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiFaceSelector.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiFaceSelector.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerBar.cpp

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

# SUBTRACT CPP /WX

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerBar.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerControlBar.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerControlBar.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiStatus.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiStatus.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiOptions.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiOptions.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiInit.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiInit.h
# End Source File
# End Group
# Begin Group "????,????,????????????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiAutoPlay.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiAutoPlay.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiBreakItem.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiBreakItem.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiExpandItem.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiExpandItem.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGetMoney.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGetMoney.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGive.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGive.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiItem.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiItem.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerLock.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerLock.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSkills.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSkills.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSkillTree.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSkillTree.h
# End Source File
# Begin Source File

SOURCE=.\Ui\uicase\UiStoreBox.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\uicase\UiStoreBox.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiESCDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiESCDlg.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGetString.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGetString.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiMsgSel.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiMsgSel.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiParadeItem.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiParadeItem.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelPlayerNearby.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelPlayerNearby.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewPlayer.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewPlayer.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelNativePlace.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelNativePlace.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelPlayer.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelPlayer.h
# End Source File
# End Group
# Begin Group "????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiChatCentre.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiChatCentre.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiChatPhrase.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiChatPhrase.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiChatRoom.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiChatRoom.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiInformation.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiInformation.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiInformation1.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiInformation1.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiInformation2.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiInformation2.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# End Group
# Begin Group "????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiTeamManage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTeamManage.h
# End Source File
# End Group
# Begin Group "????????????????????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiChatItem.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiChatItem.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiHeaderControlBar.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiHeaderControlBar.h
# End Source File
# Begin Source File

SOURCE=.\Ui\uicase\UiMsgCentrePad.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiMsgCentrePad.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiRankData.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiRankData.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiToolsControlBar.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiToolsControlBar.h
# End Source File
# End Group
# Begin Group "????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerShop.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPlayerShop.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSetPrice.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSetPrice.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UIcase\UiShop.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UIcase\UiShop.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSuperShop.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSuperShop.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTrade.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTrade.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTradeConfirmWnd.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTradeConfirmWnd.h
# End Source File
# End Group
# Begin Group "????????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiGame.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiGame.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiSysMsgCentre.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSysMsgCentre.h
# End Source File
# End Group
# Begin Group "??????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiCaveList.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiCaveList.h
# End Source File
# Begin Source File

SOURCE=.\Ui\uicase\UiMiniMap.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\uicase\UiMiniMap.h
# End Source File
# End Group
# Begin Group "??????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelColor.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiSelColor.h
# End Source File
# End Group
# Begin Group "????????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewPlayerStartMsg.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewPlayerStartMsg.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiHelper.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiHelper.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiHelper2.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiHelper2.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiReconnect.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiReconnect.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiTaskDataFile.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTaskDataFile.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTaskNote.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTaskNote.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTaskTrace.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTaskTrace.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPartyPanel.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiPartyPanel.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiWorldMap.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiWorldMap.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewsMessage.cpp

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

# ADD CPP /Yu"KWin32.h"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewsMessage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewsMessage2.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewsMessage2.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewsSysMsg.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiNewsSysMsg.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiStrengthRank.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiStrengthRank.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ui\uicase\UiTongAssignBox.cpp
# End Source File
# Begin Source File

SOURCE=.\ui\uicase\UiTongAssignBox.h
# End Source File
# Begin Source File

SOURCE=.\ui\uicase\UiTongCreateSheet.cpp

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ui\uicase\UiTongCreateSheet.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTongGetString.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTongGetString.h
# End Source File
# Begin Source File

SOURCE=.\ui\uicase\UiTongManager.cpp

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ui\uicase\UiTongManager.h
# End Source File
# End Group
# Begin Group "????????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiCase\UiEnchase.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiEnchase.h
# End Source File
# End Group
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\UiSoundSetting.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiSoundSetting.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\Ui\GameSpaceChangedNotify.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\ShortcutKey.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\ShortcutKey.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiBase.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiBase.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiShell.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiShell.h
# End Source File
# End Group
# Begin Group "????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Ui\ChatFilter.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\ChatFilter.h
# End Source File
# Begin Source File

SOURCE=.\Ui\FilterTextLib.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\FilterTextLib.h
# End Source File
# Begin Source File

SOURCE=.\PhongThanClient.cpp
# End Source File
# Begin Source File

SOURCE=.\PhongThanClient.h
# End Source File
# End Group
# Begin Group "????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\NetConnect\NetConnectAgent.cpp
# End Source File
# Begin Source File

SOURCE=.\NetConnect\NetConnectAgent.h
# End Source File
# Begin Source File

SOURCE=.\NetConnect\NetMsgTargetObject.h
# End Source File
# End Group
# Begin Group "????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Login\Login.cpp
# End Source File
# Begin Source File

SOURCE=.\Login\Login.h
# End Source File
# Begin Source File

SOURCE=.\Login\LoginDef.h
# End Source File
# End Group
# Begin Group "????????????"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\TextCtrlCmd\TextCtrlCmd.cpp
# End Source File
# Begin Source File

SOURCE=.\TextCtrlCmd\TextCtrlCmd.h
# End Source File
# End Group
# Begin Group "lib"

# PROP Default_Filter ""
# Begin Group "debug"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\Lib\debug\engine.lib

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\Lib\debug\CoreClient.lib

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "release"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\Lib\release\engine.lib

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\Lib\release\CoreClient.lib

!IF  "$(CFG)" == "PhongThanClient - Win32 Release"

!ELSEIF  "$(CFG)" == "PhongThanClient - Win32 Debug"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# End Group
# End Group
# Begin Source File

SOURCE=.\ErrorCode.cpp
# End Source File
# Begin Source File

SOURCE=.\ErrorCode.h
# End Source File
# Begin Source File

SOURCE=.\resource.h
# End Source File
# Begin Source File

SOURCE=.\Script1.rc
# End Source File
# Begin Source File

SOURCE=.\stdafx.cpp
# ADD CPP /Yc"KWin32.h"
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiDaTau.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiDaTau.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiProgressBarLoading.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiProgressBarLoading.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTimeOnline.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTimeOnline.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiToiUuImage.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiToiUuImage.h
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTrembleItem.cpp
# End Source File
# Begin Source File

SOURCE=.\Ui\UiCase\UiTrembleItem.h
# End Source File
# Begin Source File

SOURCE=.\PhongThan.ico
# End Source File
# End Target
# End Project

