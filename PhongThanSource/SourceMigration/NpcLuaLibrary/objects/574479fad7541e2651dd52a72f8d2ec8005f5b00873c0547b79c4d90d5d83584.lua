-- TaskID
ntidEventDayMonthYear = 2527;    -- Bit	5 ®Õn bit 9: ngµy

LOG_TITLE_LUNAR_NEWYEAR_2022 = "Event TÕt Nh©m DÇn"; -- Vui ®ãn giao thõa, thÎ x¨m may m¾n
LOG_TITLE_LUNAR_NEWYEAR_2022_LOTERRY = "Quay sè TÕt Nguyªn §¸n 2022";

n20140114_VDGT_nUsedBaoLiXi = 2332 -- Bit 20 - 22 (4 bits) dïng ®Ó l­u tr÷ sè lÇn sö dông bao li xi (max=10)
n20140114_VDGT_nUsedBaoLiXi_BS = 20
n20140114_VDGT_nUsedBaoLiXi_BE = 24

n20140114_VDGT_nMaxExpBaoLiXi = 2328 -- Bit 6 - 32 (27 bits) dïng ®Ó l­u tr÷ tæng ®iÓm exp nhËn ®­îc khi sö dông b¸nh ch­ng, b¸nh tÐt (max=100.000.000)
n20140114_VDGT_nMaxExpBaoLiXi_BS = 6
n20140114_VDGT_nMaxExpBaoLiXi_BE = 32

n20140116_VDGT_nExchangeBanhChung = 2331    -- bit 1-3 (3 bits) dïng ®Ó l­u tr÷ sè lÇn ®æi b¸nh ch­ng t¹i cay hoa giÊy (max = 5)
n20140116_VDGT_nExchangeBanhChung_BS = 1
n20140116_VDGT_nExchangeBanhChung_BE = 3

n20140116_VDGT_nLiXi = 2331    -- bit 4-6 (3 bits) dïng ®Ó l­u tr÷ sè lÇn nhan li xi tai cay dao tet (max =5)
n20140116_VDGT_nLiXi_Num1 = 4
n20140116_VDGT_nLiXi_Num2 = 6

G_PlayerDailogData = {}
G_PlayerMsgBoxData = {}
G_PlayerSayTaskData = {}

function SayEx(szTitle, tbOpt)
  if G_PlayerDailogData[PlayerIndex] ~= nil then
  end

  G_PlayerDailogData[PlayerIndex] = tbOpt

  local tbSayOpt = {}
  for i= 1, getn(tbOpt) do
    local szFun = "g_DailogBack_" .. i
    tinsert(tbSayOpt, tbOpt[i][1].. format("/%s", szFun))
  end
  Say(szTitle, getn(tbSayOpt), tbSayOpt)
end

function g_DailogBack_1()

  g_DailogBack(1)
end
function g_DailogBack_2()
  g_DailogBack(2)
end
function g_DailogBack_3()
  g_DailogBack(3)
end
function g_DailogBack_4()
  g_DailogBack(4)
end
function g_DailogBack_5()
  g_DailogBack(5)
end
function g_DailogBack_6()
  g_DailogBack(6)
end
function g_DailogBack_7()
  g_DailogBack(7)
end
function g_DailogBack_8()
  g_DailogBack(8)
end
function g_DailogBack_9()
  g_DailogBack(9)
end
function g_DailogBack_10()
  g_DailogBack(10)
end

function g_DailogBack(nSelectId)
  CloseDialog()
  local tbOpt = G_PlayerDailogData[PlayerIndex]
  G_PlayerDailogData[PlayerIndex] = nil

  if tbOpt and tbOpt[nSelectId] then
    local nParamCount = getn(tbOpt[nSelectId])
    if nParamCount == 1 then
      return
    elseif nParamCount == 2 then
      local pFun = tbOpt[nSelectId][2]
      pFun()
    elseif nParamCount == 3 then
      local pFun = tbOpt[nSelectId][2]
      local tbParam = tbOpt[nSelectId][3]

      call(pFun, tbParam)
    end
  end
end


function MsgBoxEx(szTitle, tbOpt)
  if G_PlayerMsgBoxData[PlayerIndex] ~= nil then
  end
  G_PlayerMsgBoxData[PlayerIndex] = tbOpt
  MsgBox(szTitle, "g_MsgBoxBack", "g_OnClose")
end

function g_MsgBoxBack()
  CloseDialog()
  local tbOpt = G_PlayerMsgBoxData[PlayerIndex]
  G_PlayerMsgBoxData[PlayerIndex] = nil

  if tbOpt and tbOpt[1] then
    local nParamCount = getn(tbOpt)
    if nParamCount == 1 then
      local pFun = tbOpt[1]
      pFun()
    elseif nParamCount == 2 then
      local pFun = tbOpt[1]
      local tbParam = tbOpt[2]
      call(pFun, tbParam)
    end
  end
end

function g_OnClose()
  CloseDialog()
end

function SayTaskEx(szTitle, tbTasks)
  if G_PlayerSayTaskData[PlayerIndex] ~= nil then
  end
  G_PlayerSayTaskData[PlayerIndex] = tbTasks
  local tbSayOpt = {}
  for i= 1, getn(tbTasks) do
    local szFun = "g_SayTaskBack_" .. i
    --tinsert(tbSayOpt, {tbTasks[i][1], szFun; show = tbTasks[i][2]})
    tbSayOpt[getn(tbSayOpt) + 1] =  {tbTasks[i][1], szFun; show = tbTasks[i][2]}
  end
  SayTask(szTitle, tbSayOpt)
end

function g_SayTaskBack_1()
  g_SayTaskBack(1)
end
function g_SayTaskBack_2()
  g_SayTaskBack(2)
end
function g_SayTaskBack_3()
  g_SayTaskBack(3)
end
function g_SayTaskBack_4()
  g_SayTaskBack(4)
end
function g_SayTaskBack_5()
  g_SayTaskBack(5)
end
function g_SayTaskBack_6()
  g_SayTaskBack(6)
end
function g_SayTaskBack_7()
  g_SayTaskBack(7)
end
function g_SayTaskBack_8()
  g_SayTaskBack(8)
end

function g_SayTaskBack(nSelectId)
  CloseDialog()
  local tbTasks = G_PlayerSayTaskData[PlayerIndex]
  G_PlayerSayTaskData[PlayerIndex] = nil

  if tbTasks and tbTasks[nSelectId] then
    local nParamCount = getn(tbTasks[nSelectId])
    if nParamCount == 3 then
      local pFun = tbTasks[nSelectId][3]
      pFun()
    elseif nParamCount == 4 then
      local pFun = tbTasks[nSelectId][3]
      local tbParam = tbTasks[nSelectId][4]
      call(pFun, tbParam)
    end
  end
end

-- TÝnh n¨ng ChuyÓn Sinh - Created by ThongPH - 20110328
tbChuyenSinhStrings = {
  [1] = "Ng­¬i ®Õn ta ®Ó thùc hiÖn <c=green>ChuyÓn Sinh<c> ®Êy ­?",
  [2] = "Muèn cã <c=green>1 Cöu ChuyÓn B×nh<c> cÇn <c=yellow>1000 Cöu ChuyÓn Tiªn §an<c>. Ng­¬i ®ång ý chø?",
  [3] = "Ng­¬i kh«ng ®ñ <c=green>Cöu ChuyÓn Tiªn §an<c>!",
  [4] = "Ng­¬i ®ang thùc hiÖn <c=yellow>nhiÖm vô ChuyÓn Sinh<c>, kh«ng thÓ nhËn nhiÖm vô n÷a.",
  [5] = "Ng­¬i ®· hoµn thµnh <c=yellow>ChuyÓn Sinh<c>, kh«ng thÓ nhËn nhiÖm vô n÷a.",
  [6] = "Ng­¬i ch­a ®ñ <c=green>®¼ng cÊp 200<c> ®Ó thùc hiÖn <c=yellow>nhiÖm vô ChuyÓn Sinh<c>. Mau luyÖn lªn cÊp ®i nhÐ.",
  [7] = "Thùc hiÖn <c=yellow>nhiÖm vô ChuyÓn Sinh<c> ng­¬i sÏ cã c¬ héi ®Ó ®­îc <c=yellow>ChuyÓn Sinh<c>. Ng­¬i ®ång ý chø?",
  [8] = "Ng­¬i ®· nhËn <c=yellow>nhiÖm vô ChuyÓn Sinh<c>. H·y mau ®i t×m <c=green>ThÇn N«ng, Hiªn Viªn, Xi V­u<c> thu phôc chóng ®Ó lÊy c¸c <c=green>Chøng NhËn<c> vµ hoµn thµnh <c=yellow>nhiÖm vô ChuyÓn Sinh<c>",
  [9] = "Ng­¬i <c=yellow>kh«ng nhËn nhiÖm vô ChuyÓn Sinh<c>. Kh«ng thÓ hñy nhiÖm vô.",
  [10] = "Ng­¬i muèn <c=yellow>hñy nhiÖm vô ChuyÓn Sinh ­<c>?",
  [11] = "Ng­¬i ®·  thùc hiÖn <c=yellow>ChuyÓn Sinh<c> råi. Kh«ng thÓ ChuyÓn Sinh lÇn n÷a.",
  [12] = "Ng­¬i ch­a ®ñ <c=green>®¼ng cÊp 200<c> ®Ó thùc hiÖn <c=yellow>ChuyÓn Sinh<c>. Mau luyÖn lªn cÊp ®i nhÐ.",
  [13] = "Sau khi thùc hiÖn <c=yellow>ChuyÓn Sinh<c>, ®¼ng cÊp cña ng­¬i sÏ lµ <c=green>118<c>. Ng­¬i ®ång ý chø?",
  [14] = "Ng­¬i kh«ng cã ®ñ <c=green>ChuyÓn Sinh B×nh hoÆc Cöu ChuyÓn B×nh<c> ®Ó thùc hiÖn <c=yellow>ChuyÓn Sinh<c>. Ta ®ang cÇn <c=green>mçi lo¹i 10 c¸i<c>, h·y mau ®i thu thËp ®ñ.",
  [15] = "Chóc mõng, ng­¬i ®· <c=yel>ChuyÓn Sinh thµnh c«ng<c>. HÖ thèng sÏ tù tho¸t ®Ó ChuyÓn Sinh cã hiÖu lùc.",
  [16] = "Ng­¬i ch­a ®­îc <c=green>ChuyÓn Sinh<c>, kh«ng thÓ kÝch ho¹t tr¹ng th¸i nµy.",
  [17] = "Ng­¬i ®· <c=green>kÝch ho¹t ChuyÓn Sinh<c> trong ngµy, kh«ng thÓ kÝch ho¹t tr¹ng th¸i nµy n÷a.",
  [18] = "Ng­¬i ch­a ®­îc <c=green>ChuyÓn Sinh<c>, kh«ng thÓ sö dông <c=yellow>Tô Hån Ch©u<c>.",
};
-- TÝnh n¨ng ChuyÓn Sinh - Created by ThongPH - 20110328

-- TÝnh n¨ng ChuyÓn Sinh - Created by ThongPH - 20110328
-- TaskID
nChuyenSinh_tidIsHaveCSTask 	= 2542; -- Bit 29 ®Õn 31 ghi nhËn tr¹ng th¸i nh©n vËt chuyÓn sinh
-- 0: ch­a nhËn nhiÖm vô chuyÓn sinh, 1: ®ang nhËn, 2: ®· hoµn thµnh ChuyÓn Sinh		
nChuyenSinh_tidTimePeriod		= 2533; -- L­u thêi ®iÓm tÝnh thêi gian online trong ngµy cña nh©n vËt
nChuyenSinh_tidOnlineTime		= 2542; -- Bit 12 ®Õn 28 l­u sè gi©y online cña nh©n vËt trong ngµy
nChuyenSinh_tidIsActivated		= 2542; -- Bit 11 ghi nhËn nh©n vËt ®· kÝch ho¹t ChuyÓn Sinh hay ch­a	
nCHUYENSINH_tidTHCUSED	= 2542; -- Bit 6 ®Õn bit 10 l­u sè lÇn sö dông Tô Hån Ch©u cña nh©n vËt	

-- Global Variable
nChuyenSinh_gvMissionStatus		= 2445; -- ghi nhËn tr¹ng th¸i mission
-- Tõ 2436 ®Õn 2444: ghi nhËn index c¸c boss chÝnh
-- Tõ 2391 ®Õn 2435: ghi nhËn index c¸c boss con

-- Const		
nChuyenSinh_MissionID 				= 19;
nChuyenSinh_MissionTimerTask 		= 73;
-- TÝnh n¨ng ChuyÓn Sinh - Created by ThongPH - 20110328

-- TÝnh n¨ng ChuyÓn Sinh 1 & 2 - BaoNLT created - 20121127
nChuyenSinhLan1New						= 2548 -- Bit 32 ghi nhËn ®· chuyÓn sinh lÇn 1 (míi)
nChuyenSinhLan2New						= 2548 -- Bit 31 ghi nhËn ®· chuyÓn sinh lÇn 2 (ViLH - 1: da chuyen sinh lan 2, 0: ch­a chuyÓn sinh lÇn 2)
nChuyenSinhProgess							= 2543 -- Bit 10 ghi nhËn process thùc hiÖn nhiÖm vô chuyÓn sinh (1: ®ang thùc hiÖn, 0: kh«ng thùc hiÖn)
nTuHonChauUsedCountExt				= 2516 -- Bit 2 ®Õn bit 4 l­u sè lÇn cã thÓ sö dông thªm 20 Tô Hån Ch©u (max = 7)
--- TÝnh n¨ng ChuyÓn Sinh 1 & 2 - BaoNLT created - 20121127

-- Feature ChuyÓn sinh lÇn 3 - VÞLH - 20/11/2013	
nChuyenSinhLan3New	= 2495 			-- Bit 23 ghi nhËn ®· chuyÓn sinh lÇn 3 (1: da chuyen sinh lan 3, 0: ch­a chuyÓn sinh lÇn 3)
-- Feature ChuyÓn sinh lÇn 3 - VÞLH - 20/11/2013	
	

TB_ITEM_TRAN_NGUYEN = {
  [0] = {
    [2] = { szName = "Ph¸ Qu©n*Tr¶m Long Gi¸p", nId = 1401 },
    [5] = { szName = "Ph¸ Qu©n*Tr¶m Long ChiÕn Ngoa", nId = 1201 },
    [6] = { szName = "Ph¸ Qu©n*Tr¶m Long Yªu §¸i", nId = 1101 },
    [7] = { szName = "Ph¸ Qu©n*Tr¶M Long Kh«i", nId = 1001 },
    [9] = { szName = "Ph¸ Qu©n*Tr¶m Long Phi Phong", nId = 1301 },
  },
  [1] = {
    [2] = { szName = "Ph¸ Qu©n*Nguyªn Thñy §¹o Bµo", nId = 1402 },
    [5] = { szName = "Ph¸ Qu©n*Nguyªn Thñy Lý", nId = 1202 },
    [6] = { szName = "Ph¸ Qu©n*Nguyªn Thñy C©n", nId = 1102 },
    [7] = { szName = "Ph¸ Qu©n*Nguyªn Thñy Qu¸n", nId = 1002 },
    [9] = { szName = "Ph¸ Qu©n*Nguyªn Thñy LÖnh", nId = 1302 },
  },
  [2] = {
    [2] = { szName = "Ph¸ Qu©n*ThÇn ¦ng Hé Gi¸p", nId = 1403 },
    [5] = { szName = "Ph¸ Qu©n*ThÇn ¦ng Ngoa", nId = 1203 },
    [6] = { szName = "Ph¸ Qu©n*ThÇn ¦ng Yªu §¸i", nId = 1103 },
    [7] = { szName = "Ph¸ Qu©n*ThÇn ¦ng Trô", nId = 1003 },
    [9] = { szName = "Ph¸ Qu©n*ThÇn ¦ng KÕt", nId = 1303 },
  },
}

-- Trang bi Luc Tien Ma 3x +6
TB_ITEM_4_KIND_1 = {
  [2] = {
    [15] = { szName = "ThÇn Phôc HuyÒn Khung Gi¸p", nId = 3013 },
    [16] = { szName = "Minh Quang §¹o Bµo", nId = 3013 },
    [17] = { szName = "Thiªn Léc Hé Gi¸p", nId = 3013 },
    [33] = { szName = "ThÇn Phôc HuyÒn Khung Gi¸p (nhiÖm vô)", nId = 3013 },
  },

  [5] = {
    [15] = { szName = "HuyÒn Khung ChiÕn Ngoa", nId = 3014 },
    [16] = { szName = "Minh Quang Lý", nId = 3014 },
    [17] = { szName = "Thiªn Léc Ngoa", nId = 3014 },
    [33] = { szName = "HuyÒn Khung ChiÕn Ngoa (nhiÖm vô) ", nId = 3014 },
    [34] = { szName = "Minh Quang Lý (nhiÖm vô)", nId = 3014 },
    [35] = { szName = "Thiªn Léc Ngoa (nhiÖm vô)", nId = 3014 },
  },
  [6] = {
    [15] = { szName = "HuyÒn Khung Yªu §¸i", nId = 3014 },
    [16] = { szName = "Minh Quang C©n", nId = 3014 },
    [17] = { szName = "Thiªn Léc Yªu §¸i", nId = 3014 },
    [33] = { szName = "HuyÒn Khung Yªu §¸i (nhiÖm vô) ", nId = 3014 },
    [34] = { szName = "Minh Quang C©n (nhiÖm vô)", nId = 3014 },
    [35] = { szName = "Thiªn Léc Yªu §¸i (nhiÖm vô)", nId = 3014 },
  },
  [7] = {
    [15] = { szName = "HuyÒn Khung Kh«i", nId = 3014 },
    [16] = { szName = "Minh Quang Qu¸n", nId = 3014 },
    [17] = { szName = "Thiªn Léc Trô", nId = 3014 },
    [33] = { szName = "HuyÒn Khung Kh«i (nhiÖm vô)", nId = 3014 },
    [34] = { szName = "Minh Quang Qu¸n (nhiÖm vô)", nId = 3014 },
    [35] = { szName = "Thiªn Léc Trô (nhiÖm vô)", nId = 3014 },
  },
  [9] = {
    [15] = { szName = "HuyÒn Khung Phi Phong", nId = 3014 },
    [16] = { szName = "Minh Quang LÖnh", nId = 3014 },
    [17] = { szName = "Thiªn Léc KÕt", nId = 3014 },
    [33] = { szName = "HuyÒn Khung Phi Phong (nhiÖm vô) ", nId = 3014 },
    [34] = { szName = "Minh Quang LÖnh (nhiÖm vô)", nId = 3014 },
    [35] = { szName = "Thiªn Léc KÕt (nhiÖm vô)", nId = 3014 },
  },
}

-- Trang bi Luc 10x + 6
TB_ITEM_4_KIND_2 = {
  [2] = {
    [3] = { szName = "Hoµng Kim ChÊn §¸n Gi¸p", nId = 1012 },
    [4] = { szName = "Hång Qu©n §¹o Bµo", nId = 1012 },
    [5] = { szName = "Kh¸ng Long Hé Gi¸p", nId = 1012 },
    [6] = { szName = "Hoµng Kim ChÊn §¸n Gi¸p (nhiÖm vô)", nId = 1012 },
    [7] = { szName = "Hång Qu©n §¹o Bµo (nhiÖm vô)", nId = 1012 },
    [8] = { szName = "Kh¸ng Long Hé Gi¸p (nhiÖm vô)", nId = 1012 },
  },

  [5] = {
    [3] = { szName = "ChÊn §¸n ChiÕn Ngoa", nId = 1014 },
    [4] = { szName = "Hång Qu©n Lý", nId = 1014 },
    [5] = { szName = "Kh¸ng Long Ngoa", nId = 1014 },
    [6] = { szName = "ChÊn §¸n ChiÕn Ngoa (nhiÖm vô)", nId = 1014 },
    [7] = { szName = "Hång Qu©n Lý (nhiÖm vô)", nId = 1014 },
    [8] = { szName = "Kh¸ng Long Ngoa (nhiÖm vô)", nId = 1014 },
  },
  [6] = {
    [3] = { szName = "ChÊn §¸n Yªu §¸i", nId = 1014 },
    [4] = { szName = "Hång Qu©n C©n", nId = 1014 },
    [5] = { szName = "Kh¸ng Long Yªu §¸i", nId = 1014 },
    [6] = { szName = "ChÊn §¸n Yªu §¸i (nhiÖm vô)", nId = 1014 },
    [7] = { szName = "Hång Qu©n C©n (nhiÖm vô)", nId = 1014 },
    [8] = { szName = "Kh¸ng Long Yªu §¸i (nhiÖm vô)", nId = 1014 },
  },
  [7] = {
    [3] = { szName = "ChÊn §¸n Kh«i", nId = 1014 },
    [4] = { szName = "Hång Qu©n Qu¸n", nId = 1014 },
    [5] = { szName = "Kh¸ng Long Trô", nId = 1014 },
    [6] = { szName = "ChÊn §¸n Kh«i (nhiÖm vô)", nId = 1014 },
    [7] = { szName = "Hång Qu©n Qu¸n (nhiÖm vô)", nId = 1014 },
    [8] = { szName = "Kh¸ng Long Trô (nhiÖm vô)", nId = 1014 },
  },
  [9] = {
    [3] = { szName = "ChÊn §¸n Phi Phong", nId = 1014 },
    [4] = { szName = "Hång Qu©n LÖnh", nId = 1014 },
    [5] = { szName = "Kh¸ng Long KÕt", nId = 1014 },
    [6] = { szName = "ChÊn §¸n Phi Phong (nhiÖm vô)", nId = 1014 },
    [7] = { szName = "Hång Qu©n LÖnh (nhiÖm vô)", nId = 1014 },
    [8] = { szName = "Kh¸ng Long KÕt  (nhiÖm vô)", nId = 1014 },
  },
}

-- Vu khi Hoang Kim 10x + 6
TB_ITEM_4_KIND_3 = {
  [4] = { szName = "Viªm §Õ KiÕm", nId = 3008 },
  [5] = { szName = "Tr¹m Kim Phñ", nId = 3008 },
  [6] = { szName = "Th¸i Cùc KiÕm", nId = 3008 },
  [7] = { szName = "DiÖt ThÇn Phñ", nId = 3008 },
  [31] = { szName = "Viªm §Õ KiÕm", nId = 3008 },
  [32] = { szName = "Tr¹m Kim Phñ", nId = 3008 },
  [33] = { szName = "Th¸i Cùc KiÕm", nId = 3008 },
  [34] = { szName = "DiÖt ThÇn Phñ", nId = 3008 },
}

function ResetEvent()
  -- LÊy ngµy th¸ng hiÖn t¹i
  local nCurYear, nCurMonth, nCurDay = GetYMD();
  -- NÕu ch­a qua ngµy míi th× tho¸t
  if (GetBitExt(ntidEventDayMonthYear, 1, 4) == nCurMonth and GetBitExt(ntidEventDayMonthYear, 5, 9) == nCurDay and GetBitExt(ntidEventDayMonthYear, 10, 20) == nCurYear) then
    return
  end
  -- Ghi nhËn l¹i ngµy hiÖn t¹i
  SetBitExt(ntidEventDayMonthYear, nCurDay, 5, 9);
  -- Ghi nhËn l¹i th¸ng hiÖn t¹i
  SetBitExt(ntidEventDayMonthYear, nCurMonth, 1, 4);
  -- Ghi nhËn l¹i n¨m hiÖn t¹i
  SetBitExt(ntidEventDayMonthYear, nCurYear, 10, 20);

  -- Event Truy T×m Bao L× X× ThÊt L¹c - ViLH - 14/01/2014 - Reset Bao L× X×, reset sè lÇn giao b¸nh trong ngµy

  SetBitExt(n20140116_VDGT_nLiXi, 0, n20140116_VDGT_nLiXi_Num1, n20140116_VDGT_nLiXi_Num2);
  SetBitExt(n20140116_VDGT_nExchangeBanhChung, 0, n20140116_VDGT_nExchangeBanhChung_BS, n20140116_VDGT_nExchangeBanhChung_BE);

  SetBitExt(n20140114_VDGT_nUsedBaoLiXi, 0, n20140114_VDGT_nUsedBaoLiXi_BS, n20140114_VDGT_nUsedBaoLiXi_BE);
  -- Event Truy T×m Bao L× X× ThÊt L¹c - ViLH - 14/01/2014 - Reset Bao L× X×
  -- SetTask(TASKID_QSTH_GIFTCOUNT_DAILY, 0)
end

function AddRandomBuff()
  local tbBuff = {
    [1] = { szID = 1479, szName = "Tèc ®é håi phôc sinh lùc -250", nRate = 25 },
    [2] = { szID = 1480, szName = "Tèc ®é håi phôc néi lùc -250", nRate = 25 },
    [3] = { szID = 1481, szName = "Tèc ®é di chuyÓn -50%", nRate = 25 },
    [4] = { szID = 1482, szName = "Tèc ®é xuÊt chiªu -50%", nRate = 25 },
  };

  local nLucky = random(1, 100);
  local nCount = 0;
  for i = 1, getn(tbBuff) do
    nCount = nCount + tbBuff[i].nRate;
    if (nLucky <= nCount) then
      AddIBBuff(tbBuff[i].szID);

      Msg2Player("B¹n võa nhËn tr¹ng th¸i buff: " .. tbBuff[i].szName);
      break
    end
  end

end

----------------------------------------------------------------------------------------
-- hµm ®¸nh qu¸i nhËn vËt phÈm
----------------------------------------------------------------------------------------
function AddGiftOnDeath(nNpcLevel)
  -- TÝnh n¨ng ChuyÓn Sinh 1 & 2 - BaoNLT created - 20121127
  local nMapID, _nX, _nY = GetWorldPos();
  --local nServerID = LoadIniInteger("ServerID_2010", "ID")
  if (nMapID >= 79 and nMapID <= 82 ) then
    local nLucky = random(1, 100)
    if (nLucky <= 1) then
      if (GetTeam() ~= 0) then
        -- L­u l¹i index hiÖn t¹i cña nh©n vËt
        local OldPlayer = PlayerIndex;

        -- DuyÖt tõng thµnh viªn trong ®éi
        for nIndex = 1, GetTeamSize() do
          PlayerIndex = GetTeamMember(nIndex);
          AddNormalItemPile(3, 1200, 0, 0, 0, 0);
          WriteVNGFeatureLog(48, "ChuyÓn Sinh", "Gift", "§¸nh boss V¹n Tiªn TrËn", "", "Cöu ChuyÓn Tiªn §an", "", 1, "", 1)
          ScrollMessage("NhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");
          Msg2Player("<ChuyÓn Sinh> B¹n nhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");

        end;
        -- LÊy l¹i index cho nh©n vËt
        PlayerIndex = OldPlayer;
      else
        AddNormalItemPile(3, 1200, 0, 0, 0, 0);
        WriteVNGFeatureLog(48, "ChuyÓn Sinh", "Gift", "§¸nh boss V¹n Tiªn TrËn", "", "Cöu ChuyÓn Tiªn §an", "", 1, "", 1)
        ScrollMessage("NhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");
        Msg2Player("<ChuyÓn Sinh> B¹n nhËn ®­îc <c=green>Cöu ChuyÓn Tiªn §an<c>");

      end;
    end;
  end;
  -- TÝnh n¨ng ChuyÓn Sinh 1 & 2 - BaoNLT created - 20121127
end;

function Evt_GetReward_KillMod()
  if  EventMonthly:IsActive() then
    local nRand = 5

    local nLucky = random(1, 1000);
    if (nLucky <= nRand) then
      if (GetTeam() ~= 0) then
        -- tæ ®éi

        -- L­u l¹i index hiÖn t¹i cña nh©n vËt
        local OldPlayer = PlayerIndex;

        -- DuyÖt tõng thµnh viªn trong ®éi
        for nIndex = 1, GetTeamSize() do
          PlayerIndex = GetTeamMember(nIndex);
          AddRewardKillMob_VDGT();
        end ;

        -- LÊy l¹i index cho nh©n vËt
        PlayerIndex = OldPlayer;

      else
        -- kh«ng tæ ®éi
        AddRewardKillMob_VDGT();
      end
    end
  end
end

function AddRewardKillMob_VDGT()
  local nLucky = random(1, 100)
  if nLucky <= 10 then
    AddGiftBaoLiXi(1)
  elseif nLucky <= 40 then
    AddGiftBaoLiXi(2)
  else
    AddGiftBaoLiXi(3)
  end
end

function AddGiftBaoLiXi(nNum)
  for _ = 1, nNum do
    AddNormalItemPile(6, 1, 5943, 0, 0, 0);
  end

  WriteVNGEventLog(156, LOG_TITLE_LUNAR_NEWYEAR_2022, "Gift", "§¸nh th¾ng boss nhËn th­ëng", "VNG_447", "Bao L× X×", "", nNum, "", 1, "")
  Msg2Player("<" .. LOG_TITLE_LUNAR_NEWYEAR_2022 .. "> B¹n nhËn ®­îc <c=green>" .. nNum .. " Bao L× X×<c>")
  ScrollMessage("NhËn ®­îc <c=green>" .. nNum .. " Bao L× X×<c>")

end

function DelEventItemExt(szItemName, nG, nD, nP, nAmount, nPromotionID, nPromotionName, nIsEventPromotion)
  -- Xãa vËt phÈm
  local nCount = HaveNormalItem(nG, nD, nP, 0);

  if (nCount < nAmount) then
    Talk(1, "no", format("HiÖn t¹i ng­¬i chØ cã %d %s nªn kh«ng thÓ xo¸ %d %s ®­îc", nCount, szItemName, nAmount, szItemName));
    Msg2Player(format("HiÖn t¹i b¹n chØ cã %d %s nªn kh«ng thÓ xo¸ %d %s ®­îc", nCount, szItemName, nAmount, szItemName));
    return
  end

  for _ = 1, nAmount do
    DelNormalItem(nG, nD, nP, 0);
  end

  -- Xãa kh«ng thµnh c«ng
  if (HaveNormalItem(nG, nD, nP, 0) + nAmount > nCount) then
    if (nIsEventPromotion == 1) then
      WriteVNGEventLog(nPromotionID, nPromotionName, "Error", szItemName .. "_IsNotDeleted", "", szItemName, "", nAmount, "", 0)
    else
      WriteVNGFeatureLog(nPromotionID, nPromotionName, "Error", szItemName .. "_IsNotDeleted", "", szItemName, "", nAmount, "", 0)
    end
  end

end

function DelEventItemExtNew(szItemName, nG, nD, nP, nAmount, nPromotionID, nPromotionName, nIsEventPromotion)
  -- Xãa vËt phÈm
  local nCount = HaveNormalItem(nG, nD, nP, 1);

  if (nCount < nAmount) then
    Talk(1, "no", format("HiÖn t¹i ng­¬i chØ cã %d %s nªn kh«ng thÓ xo¸ %d %s ®­îc", nCount, szItemName, nAmount, szItemName));
    Msg2Player(format("HiÖn t¹i b¹n chØ cã %d %s nªn kh«ng thÓ xo¸ %d %s ®­îc", nCount, szItemName, nAmount, szItemName));
    return
  end

  for _ = 1, nAmount do
    DelNormalItem(nG, nD, nP, 1);
  end

  -- Xãa kh«ng thµnh c«ng
  if (HaveNormalItem(nG, nD, nP, 1) + nAmount > nCount) then
    if (nIsEventPromotion == 1) then
      WriteVNGEventLog(nPromotionID, nPromotionName, "Error", szItemName .. "_IsNotDeleted", "", szItemName, "", nAmount, "", 0)
    else
      WriteVNGFeatureLog(nPromotionID, nPromotionName, "Error", szItemName .. "_IsNotDeleted", "", szItemName, "", nAmount, "", 0)
    end
  end

end

function Table2File(filePath, strFileName, strMode, tbData)
  --	for i=1, getn(tbData) do
  --		Msg2Player(tbData[i])
  --	end
  local file = openfile(filePath .. strFileName, strMode)
  if file == nil then
    execute(format("mkdir -p %s", filePath))
    file = openfile(filePath .. strFileName, strMode)
  end
  if type(tbData[1]) == "table" then
    for row = 1, getn(tbData) do
      for col = 1, getn(tbData[row]) do
        if col == getn(tbData[row]) then
          write(file, tbData[row][col], "\n")
        else
          write(file, tbData[row][col], "\t")
        end
      end
    end
  else
    for i = 1, getn(tbData) do
      if i == getn(tbData) then
        write(file, tbData[i], "\n")
      else
        write(file, tbData[i], "\t")
      end
    end
  end
  closefile(file)
end

function WriteVNGEventLog(nPromotionID, szPromotionName, ...)
  local strFilePath = "logs/translog/event/";
  local nYear, nMonth, nDay = GetYMD();
  local nH, nM, nS = GetHMS();
  local szTime = nYear .. "-" .. nMonth .. "-" .. nDay .. " " .. nH .. ":" .. nM .. ":" .. nS;
  local strFileName = nYear .. "-" .. nMonth .. "-" .. nDay .. "_Event_TransLog.txt";
  local tbLog2Write = {
    szTime,
    GetAccount() or "",
    GetName() or "",
    GetLevel() or 0,
    GetPlayerType() or "",
    nPromotionID,
    szPromotionName,
  }
  for i = 1, getn(arg) do
    tinsert(tbLog2Write, arg[i])
  end
  Table2File(strFilePath, strFileName, "a", tbLog2Write)
end

function WriteVNGFeatureLog(nPromotionID, szPromotionName, ...)
  local strFilePath = "logs/translog/feature/";
  local nYear, nMonth, nDay = GetYMD();
  local nH, nM, nS = GetHMS();
  local szTime = nYear .. "-" .. nMonth .. "-" .. nDay .. " " .. nH .. ":" .. nM .. ":" .. nS;
  local strFileName = nYear .. "-" .. nMonth .. "-" .. nDay .. "_Feature_TransLog.txt";
  local tbLog2Write = {
    szTime,
    GetAccount() or "",
    GetName() or "",
    GetLevel() or 0,
    GetPlayerType() or "",
    nPromotionID,
    szPromotionName,
  }
  for i = 1, getn(arg) do
    tinsert(tbLog2Write, arg[i])
  end
  Table2File(strFilePath, strFileName, "a", tbLog2Write)
end

-- Function xö lý khi nhÆt item - BaoNLT created - 20130510
function CollectItem_InProgress(nLevel, szItemCollect, szScriptEndMotion, nTimeCollect)
  local nCurLevel = GetLevel()
  if (nCurLevel < nLevel) then
    Talk(1, "no", "§¼ng cÊp cña ng­¬i <c=green>ch­a ®¹t ®Õn " .. nLevel .. " nªn kh«ng thÓ nhÆt" .. szItemCollect .. "<c>")
    return
  end
  -- NÕu ®ang bµo th­¬ng
  if (GetMorphType() == 364) then
    Talk(1, "no", "Ng­¬i ®ang <c=green>Bµo Th­¬ng<c> kh«ng thÓ nhÆt" .. szItemCollect .. "<c>")
    return
  end ;
  if (GetMorphType() == 411) then
    Talk(1, "no", "Ng­¬i ®ang <c=green>biÕn h×nh thµnh ThÇn C¸t T­êng<c>, kh«ng thÓ nhÆt" .. szItemCollect .. "<c>")
    return
  end ;
  -- PK ®á = 8
  -- T¾t PK = 7
  -- Pk tr¾ng = 0
  -- PK l·nh ®Þa = 1, 2, 3, 4
  -- Buéc bËt PK khi nhËn nhiÖm vô
  local nPK = GetCamp()
  local nCurPK = GetCurCamp()
  if (nCurPK ~= 1 or nCurPK ~= 2 or nCurPK ~= 3 or nCurPK ~= 4 or nCurPK ~= 8 or nPK ~= 1 or nPK ~= 2 or nPK ~= 3 or nPK ~= 4 or nPK ~= 8) then
    local nPKRand = random(1, 4)
    SetCamp(nPKRand)
    SetCurCamp(nPKRand)
  end

  local nInterrupt = 0
  nInterrupt = SetBit(nInterrupt, 1, 1)    -- Logout
  nInterrupt = SetBit(nInterrupt, 2, 1)    -- Movement
  nInterrupt = SetBit(nInterrupt, 3, 1)    -- Skill
  nInterrupt = SetBit(nInterrupt, 4, 1)    -- Injured
  nInterrupt = SetBit(nInterrupt, 5, 1)    -- Cross-map
  nInterrupt = SetBit(nInterrupt, 6, 0)    -- Adder
  nInterrupt = SetBit(nInterrupt, 7, 1)
  nInterrupt = SetBit(nInterrupt, 9, 1)    -- Character dies
  nInterrupt = SetBit(nInterrupt, 10, 0)    -- Monster goal loss
  nInterrupt = SetBit(nInterrupt, 11, 1)
  SetNpcTask(DialogNpcIdx, 10, 1234)
  BeginMotion(DialogNpcIdx, 0, nTimeCollect, szScriptEndMotion, nInterrupt);
end
-- Function xö lý khi nhÆt item - BaoNLT created - 20130510
-- Function sau khi nhÆt item - BaoNLT created - 20130510
function CollectItem_EndProgress(npcIdx, npcTemplateID, szCollectItem)
  if (npcIdx > 0 and GetNpcTemplateID(npcIdx) == 166 and GetNpcPolyMorph(npcIdx) == npcTemplateID and GetNpcTask(DialogNpcIdx, 10) == 1234) then
    DelNpc(npcIdx)
    return 1
  else
    InfoBox("NhÆt thÊt b¹i, <c=green>" .. szCollectItem .. "<c> ®· bÞ ng­êi kh¸c nhÆt råi.")
    return 0
  end
end
-- Function sau khi nhÆt item - BaoNLT created - 20130510

FunctionLib = {}

function FunctionLib:ParseNumbTable(tbNumber)
  local szNumbList = ""
  for i=1, getn(tbNumber) do
    if i >= getn(tbNumber) then
      szNumbList = szNumbList .. tbNumber[i]
    else
      szNumbList = szNumbList .. tbNumber[i]..","
    end
  end
  return dostring("return " .. szNumbList)
end

PlayerFunLib = {}

function PlayerFunLib:CallFunByPlayer(nPlayerIndex, fun, ...)
  local nOldPlayer = PlayerIndex;
  PlayerIndex = nPlayerIndex
  local re = self:Pack(call(fun, arg));
  PlayerIndex = nOldPlayer;
  return re
end

function PlayerFunLib:Pack(...)
  return arg
end

function PlayerFunLib:UnPack(tb, i)
  i = i or 1
  if tb[i] then
    return tb[i], self:UnPack(tb, i + 1)
  end
end

tbAwardTemplet = {}
tbAwardTemplet.TYPE = {}

function tbAwardTemplet:RegType(szKey, pClass)
  self.TYPE[szKey] = pClass
end

function tbAwardTemplet:GiveByRandom(tbItem, nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
  if tbItem == nil then
    return 0
  end
  local rtotal = 10000000
  local rcur = random(1, rtotal);
  local rstep = 0;
  for i = 1, getn(tbItem) do
    rstep = rstep + floor(tbItem[i].nRate * rtotal / 100);
    if (rcur <= rstep) then
      return self:Give(tbItem[i], nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
    end
  end
end

function tbAwardTemplet:Give(tbItem, nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
  local szOldStr = szItemNameStr
  szItemNameStr = ""
  if not tbItem then
    return 0
  end
  nAwardCount = nAwardCount or 1
  if type(tbItem[1]) == "table" then
    if tbItem[1].nRate then
      for i = 1, nAwardCount do
        szItemNameStr = self:GiveByRandom(tbItem, 1, nIsTalk, szItemNameStr, tbLogTitle)
      end
      if (nIsTalk == 1) then
        Talk(1, "CloseDialog", format(szOldStr .. szItemNameStr))
      end
      return 1
    else
      for i = 1, getn(tbItem) do
        local szTmpStr = self:Give(tbItem[i], nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
        if (i == 1) then
          szItemNameStr = szItemNameStr .. szTmpStr
        else
          szItemNameStr = szItemNameStr .. ", " .. szTmpStr
        end
      end
      if (nIsTalk == 1) then
        Talk(1, "CloseDialog", format(szOldStr .. szItemNameStr))
      end
      return 1;
    end
  else

    for k, v in self.TYPE do
      if tbItem[k] then
        local szTmpStr = v:Give(tbItem, nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
        return szTmpStr
      end
    end
  end
end

------------------------------------------------------------------------------------------------------------------------------------------------
-- Item Award
------------------------------------------------------------------------------------------------------------------------------------------------

if (ItemType == nil) then
  ItemType = {}
end

function ItemType:Give(tbItem, nAmount, nIsTalk, szItemNameStr, tbLogTitle)
  local szItemName = nil
  nAmount = (nAmount or 1) * (tbItem.nCount or 1)
  for i = 1, nAmount do

    if tbItem.nType == 1 then
      self:ProcessItemType1(tbItem)
    end

    if tbItem.nType == 2 then
      AddNormalItem2(FunctionLib:ParseNumbTable(tbItem.tbProp))
    end

    if tbItem.nType == 3 then
      local tbParam, szName = self:ProcessItemType3(tbItem)
      szItemName = szName
    end

    if tbItem.nType == 4 then
      local tbParam, szName = self:ProcessItemType4(tbItem)
      szItemName = szName
    end

    if type(tbItem.CallBack) == "function" then
      tbItem.CallBack(tbItem.nType)
    end
  end

  local szItemID = ""
  if (tbItem.szItemID ~= nil) then
    szItemID = tbItem.szItemID
  end
  tbLogTitle[6] = szItemID
  tbLogTitle[7] = tbItem.szName
  tbLogTitle[9] = nAmount
  local nPlayerIndex = PlayerIndex
  self:WriteLog(tbLogTitle)

  if (nIsTalk == 0) then
    ScrollMessage(format("NhËn ®­îc %d %s.", nAmount, szItemName or tbItem.szName or "vËt phÈm"))
    Msg2Player(format("<%s> NhËn ®­îc %d %s.", tbLogTitle[3], nAmount, szItemName or tbItem.szName or "vËt phÈm"))
  end
  szItemNameStr = szItemName or tbItem.szName or "vËt phÈm"
  return szItemNameStr
end

function ItemType:GetRandom(tbRate)
  local rtotal = 10000000
  local rcur = random(1, rtotal);
  local rstep = 0;
  for i = 1, getn(tbRate) do
    rstep = rstep + floor(tbRate[i] * rtotal / 100);
    if (rcur <= rstep) then
      return i
    end
  end
end

function ItemType:GetParamValue(tbProp)
  local tbParam = {}
  for i = 1, getn(tbProp) do
    if (type(tbProp[i]) == "table") then
      local tbList = tbProp[i][1]
      local tbRate = tbProp[i][2]
      local nIndex = self:GetRandom(tbRate)
      tbParam[i] = tbList[nIndex]
    elseif (type(tbProp[i]) == "function") then
      tbParam[i] = tbProp[i]()
    else
      tbParam[i] = tbProp[i]
    end
  end
  return tbParam
end

function ItemType:ProcessItemType1(tbItem)
  local tbParam = self:GetParamValue(tbItem.tbProp)
  AddNormalItemPile(FunctionLib:ParseNumbTable(tbParam))
end

function ItemType:ProcessItemType3(tbItem)
  local tbParam = self:GetParamValue(tbItem.tbProp)
  local szName = nil
  if tbParam[7] == 1 then
    -- Cam Tran Nguyen
    tbParam[7] = TB_ITEM_TRAN_NGUYEN[tbParam[3]][tbParam[2]].nId
    szName = TB_ITEM_TRAN_NGUYEN[tbParam[3]][tbParam[2]].szName
  elseif tbParam[7] == 2 then
    -- Cam Su Kien
    if (tbParam[3] == 2) then
      tbParam[7] = 1001
    else
      tbParam[7] = tbParam[3] + 1001
    end
  end
  AddNormalItem3(FunctionLib:ParseNumbTable(tbParam))
  return tbParam, szName
end

function ItemType:ProcessItemType4(tbItem)
  local tbParam = self:GetParamValue(tbItem.tbProp)
  local szName = nil

  if tbParam[6] == 1 then
    -- Trang bi Luc Tien Ma 3x +6
    tbParam[6] = TB_ITEM_4_KIND_1[tbParam[2]][tbParam[3]].nId
    szName = TB_ITEM_4_KIND_1[tbParam[2]][tbParam[3]].szName
  elseif tbParam[6] == 2 then
    -- Trang bi Luc 10x + 6
    tbParam[6] = TB_ITEM_4_KIND_2[tbParam[2]][tbParam[3]].nId
    szName = TB_ITEM_4_KIND_2[tbParam[2]][tbParam[3]].szName
  elseif tbParam[6] == 3 then
    -- Vu khi Hoang Kim 10x + 6
    tbParam[6] = TB_ITEM_4_KIND_3[tbParam[3]].nId
    szName = TB_ITEM_4_KIND_3[tbParam[3]].szName
  end
  AddNormalItem4(FunctionLib:ParseNumbTable(tbParam))
  return tbParam, szName
end

function ItemType:WriteLog(tbLogTitle)
  local nPromotionID = tbLogTitle[2]
  local szPromotionName = tbLogTitle[3]
  local szActionType = tbLogTitle[4]
  local szAction = tbLogTitle[5]
  local szItemID = tbLogTitle[6]
  local szItemName = tbLogTitle[7]
  local nPrice = tbLogTitle[8]
  local nQuantity = tbLogTitle[9]
  local nMoneyType = tbLogTitle[10]
  local nTotalMoney = tbLogTitle[11]

  if (tbLogTitle[1] == 1) then
    WriteVNGEventLog(nPromotionID, szPromotionName, szActionType, szAction, szItemID, szItemName, nPrice, nQuantity, nMoneyType, 1, nTotalMoney)
  else
    WriteVNGFeatureLog(nPromotionID, szPromotionName, szActionType, szAction, szItemID, szItemName, nPrice, nQuantity, nMoneyType, 1, nTotalMoney)
  end
end

tbAwardTemplet:RegType("tbProp", ItemType)

------------------------------------------------------------------------------------------------------------------------------------------------
-- Fun Type
------------------------------------------------------------------------------------------------------------------------------------------------
FunType = {}

function FunType:Give(tbItem, nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
  if type(tbItem.pFun) == "function" then
    tbItem:pFun((nAwardCount or 1) * (tbItem.nCount or 1), nIsTalk, szItemNameStr, tbLogTitle)
  end
end

tbAwardTemplet:RegType("pFun", FunType)


------------------------------------------------------------------------------------------------------------------------------------------------
-- Simple Type
------------------------------------------------------------------------------------------------------------------------------------------------

SimpleType = {}

function SimpleType:new(szKey)
  local tb = {}
  for k, v in self do
    tb[k] = v
  end
  tb.szKey = szKey
  return tb
end

SimpleType.szKey = ""
SimpleType.pFun = nil
function SimpleType:Give(tbItem, nAwardCount, nIsTalk, szItemNameStr, tbLogTitle)
  local var = tbItem[self.szKey]
  if not var then
    return
  end
  local nAmount = var * (nAwardCount or 1) * (tbItem.nCount or 1)
  if type(self.pFun) == "function" then
    local nPlayerIndex = PlayerIndex
    PlayerFunLib:CallFunByPlayer(nPlayerIndex, self.pFun, nAmount)
    --self:pFun(nAmount)
    tbLogTitle[6] = szItemID or ""
    tbLogTitle[7] = tbItem.szName
    tbLogTitle[9] = 1
    --PlayerFunLib:CallFunByPlayer(nPlayerIndex, self.WriteLog, self, nAmount, tbLogTitle)
    self:WriteLog(nAmount, tbLogTitle)
    if (nIsTalk ~= 1) then
      self:Msg2Player(tbItem, nAmount)
    end
    return (format(self.szMsgFormat, nAmount))
  end
end

function SimpleType:Reg()
  tbAwardTemplet:RegType(self.szKey, self)
end

function SimpleType:Msg2Player(tbItem, nAmount)
  if tbItem.szMessage then
    Msg2Player("NhËn ®­îc " .. szMessage)
    ScrollMessage("NhËn ®­îc " .. szMessage)
  else
    Msg2Player("NhËn ®­îc " .. format(self.szMsgFormat, nAmount))
    ScrollMessage("NhËn ®­îc " .. format(self.szMsgFormat, nAmount))
  end
end

function SimpleType:WriteLog(nAmount, tbLogTitle)
  local nPromotionID = tbLogTitle[2]
  local szPromotionName = tbLogTitle[3]
  local szActionType = tbLogTitle[4]
  local szAction = tbLogTitle[5]
  local szItemID = tbLogTitle[6]
  local szItemName = tbLogTitle[7]
  local nPrice = tbLogTitle[8]
  local nQuantity = tbLogTitle[9]
  local nMoneyType = tbLogTitle[10]
  local nTotalMoney = tbLogTitle[11]

  if (tbLogTitle[1] == 1) then
    WriteVNGEventLog(nPromotionID, szPromotionName, szActionType, szAction, szItemID, szItemName, nPrice, nQuantity, nMoneyType, 1, nTotalMoney)
  else
    WriteVNGFeatureLog(nPromotionID, szPromotionName, szActionType, szAction, szItemID, szItemName, nPrice, nQuantity, nMoneyType, 1, nTotalMoney)
  end
end

------------------------------------------------------------------------------------------------------------------------------------------------
-- Exp
------------------------------------------------------------------------------------------------------------------------------------------------

ExpType = SimpleType:new("nExp")
ExpType.pFun = AddExp
ExpType.szMsgFormat = "§¹t ®­îc kinh nghiÖm kh«ng thÓ céng dån %s"
ExpType:Reg()

Exp_tlType = SimpleType:new("nOwnExp")
Exp_tlType.pFun = AddOwnExp
Exp_tlType.szMsgFormat = "<c=green>%s ®iÓm kinh nghiÖm<c>"
Exp_tlType:Reg()

Exp_tlType1 = SimpleType:new("nOwnExtendExp")
Exp_tlType1.pFun = AddOwnExtendExp
Exp_tlType1.szMsgFormat = "<c=green>%s ®iÓm tu luyÖn Tiªn Ma <c>"
Exp_tlType1:Reg()

------------------------------------------------------------------------------------------------------------------------------------------------
-- Justic Evil Credit
------------------------------------------------------------------------------------------------------------------------------------------------

ReputeType = SimpleType:new("nRepute")
ReputeType.pFun = ChangeJusticEvilCredit
ReputeType.szMsgFormat = "§iÓm Danh Väng t¨ng %d"
ReputeType:Reg()

-- Common Functions
function GetBitExt(nTask, nBitStart, nBitEnd)
  if (nBitStart > nBitEnd) or (nBitStart < 1) or (nBitEnd > 32) then
    return 0;
  end ;

  local Value = 0;
  local iBit = 1;
  local iTask = GetTask(nTask);

  for i = nBitStart, nBitEnd do
    Value = SetBit(Value, iBit, GetBit(iTask, i));
    iBit = iBit + 1;
  end ;
  return Value;
end;

function SetBitExt(nTask, Value, nBitStart, nBitEnd)
  if (nBitStart > nBitEnd) or (nBitStart < 1) or (nBitEnd > 32) then
    return 0;
  end ;

  local iBit = 1;
  for i = nBitStart, nBitEnd do
    SetTask(nTask, SetBit(GetTask(nTask), i, GetBit(Value, iBit)));
    iBit = iBit + 1;
  end ;

end;

function GetByteExt(nTask, nByteStart, nByteEnd)
  if (nByteStart > nByteEnd) or (nByteStart < 1) or (nByteEnd > 4) then
    return 0;
  end ;
  local iByte = 1;
  local iTask_Value = GetTask(nTask);
  local Value = 0;

  for i = nByteStart, nByteEnd do
    Value = SetByte(Value, iByte, GetByte(iTask_Value, i));
    iByte = iByte + 1;
  end ;
  return Value;
end;

function SetByteExt(nTask, Value, nByteStart, nByteEnd)
  if (nByteStart > nByteEnd) or (nByteStart < 1) or (nByteEnd > 4) then
    return 0;
  end ;

  local iByte = 1;
  for i = nByteStart, nByteEnd do
    SetTask(nTask, SetByte(GetTask(nTask), i, GetByte(Value, iByte)));
    iByte = iByte + 1;
  end ;
end;

function WriteEventLog(NameEvent, Type, Param1, Param2, Param3)
  NameEvent = checkparam(NameEvent, "");
  Type = checkparam(Type, "");
  Param1 = checkparam(Param1, "");
  Param2 = checkparam(Param2, "");
  Param3 = checkparam(Param3, "");

  local str = "<" .. NameEvent .. ">\t<" .. Type .. ">\t" .. Param1 .. "\t" .. Param2 .. "\t" .. Param3;
  WriteLog(str);
end;

function checkparam(param, default)
  if param == nil then
    param = default;
  end ;
  return param;
end;

function WriteMissionLog(MissionName, MissionNum, UseItemType)
  MissionName = checkparam(MissionName, "");
  MissionNum = checkparam(MissionNum, "");
  if (UseItemType == nil) or (UseItemType == "") then
    UseItemType = 0;
  end ;

  local type = { "Free", "IBItem", "KhÊu Trõ" }
  local str = MissionName .. "\t" .. MissionNum .. "\t" .. type[UseItemType];
  WriteLog(str, "mission");
end;

function WriteTongLog(TongName, Param1, Param2, Param3, Param4, Param5)
  TongName = checkparam(TongName, "");
  Param1 = checkparam(Param1, "");
  Param2 = checkparam(Param2, "");
  Param3 = checkparam(Param3, "");
  Param4 = checkparam(Param4, "");
  Param5 = checkparam(Param5, "");

  local str = TongName .. "\t" .. Param1 .. "\t" .. Param2 .. "\t" .. Param3 .. "\t" .. Param4 .. "\t" .. Param5;
  WriteLog(str, "tong");
end;

function WriteCityLog(TongName, CityName, Param1, Param2, Param3, Param4, Param5)
  TongName = checkparam(TongName, "");
  CityName = checkparam(CityName, "");
  Param1 = checkparam(Param1, "");
  Param2 = checkparam(Param2, "");
  Param3 = checkparam(Param3, "");
  Param4 = checkparam(Param4, "");
  Param5 = checkparam(Param5, "");

  local str = TongName .. "\t" .. CityName .. "\t" .. Param1 .. "\t" .. Param2 .. "\t" .. Param3 .. "\t" .. Param4 .. "\t" .. Param5;
  WriteLog(str, "city");
end;

function WriteStatisticsLog(logfile, Param1, Param2, Param3, Param4, Param5)
  if (logfile == nil) or (logfile == "") then
    logfile = "Statistics";
  end ;
  Param1 = checkparam(Param1, "");
  Param2 = checkparam(Param2, "");
  Param3 = checkparam(Param3, "");
  Param4 = checkparam(Param4, "");
  Param5 = checkparam(Param5, "");

  local str = Param1 .. "\t" .. Param2 .. "\t" .. Param3 .. "\t" .. Param4 .. "\t" .. Param5;
  WriteLog(str, logfile);
end;

function isReliable()
  if (GetCityTask(254) ~= 0) then
    if GetTeamSize() == 2 then
      if GetMateNameID() ~= GetCityTask(254) then
        return 0;
      else
        return 1;
      end ;
    else
      return 0;
    end ;
  else
    return 1;
  end ;
end;

--event
