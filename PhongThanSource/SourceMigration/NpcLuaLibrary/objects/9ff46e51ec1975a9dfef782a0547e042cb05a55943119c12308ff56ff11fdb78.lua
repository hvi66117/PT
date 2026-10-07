require("king/lib.luax")

EventMidAutumnLantern = EventMidAutumnLantern or {}

EventMidAutumnLantern.szName = "<c=g>Hoa §¨ng Trung Thu<c>"
EventMidAutumnLantern.nRequiredLevel = 25
EventMidAutumnLantern.nMaxAnswerTime = 20
EventMidAutumnLantern.nStartDate = 20220910
EventMidAutumnLantern.nEndDate = 20220912
EventMidAutumnLantern.nStartHour = 20
EventMidAutumnLantern.nEndHour = 22

EventMidAutumnLantern.nWorldID = 21 -- trieu ca

EventMidAutumnLantern.nGlobalLanternPos1 = 376
EventMidAutumnLantern.nGlobalLanternPos2 = 377

EventMidAutumnLantern.nTaskIdQuestion = 1733
EventMidAutumnLantern.nByte_AnsweredQuestionCnt = 1
EventMidAutumnLantern.nByte_AnsweredLastDate = 2
EventMidAutumnLantern.nByte_CorrectAnswerCnt = 3
EventMidAutumnLantern.nByte_SelectedQuestionIdx = 4

EventMidAutumnLantern.nTaskId_SelectedLanternIdx = 1734
EventMidAutumnLantern.nNPCPosIdx = 0
EventMidAutumnLantern.nNpcPosBitField = 1

EventMidAutumnLantern.nIBBuffId = 1331

EventMidAutumnLantern.nAwardExpRate = 3000

EventMidAutumnLantern.tbLanternPositions = {
  [1] = { 1747, 3028 },
  [2] = { 1693, 3041 },
  [3] = { 1706, 3069 },
  [4] = { 1746, 3096 },
  [5] = { 1695, 3084 },
  [6] = { 1801, 3149 },
  [7] = { 1625, 2963 },
  [8] = { 1600, 2938 },
  [9] = { 1661, 3155 },
  [10] = { 1613, 3182 },
}

EventMidAutumnLantern.tbLanternPositionsDelta = {
  [1] = { 0, 0 },
  [2] = { 8, 0 },
  [3] = { 0, 8 },
  [4] = { -8, 0 },
  [5] = { 0, -8 },
}

EventMidAutumnLantern.tbQuestions = {
  [1] = {
    szName = "TÕt Trung thu cã nguån gèc tõ quèc gia nµo?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "Trung Quèc",
      [2] = "Hµn Quèc",
      [3] = "NhËt B¶n",
    }
  },
  [2] = {
    szName = "Lo¹i b¸nh nµo th­êng cã mÆt trong tÕt Trung thu ë c¸c gia ®×nh?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "B¸nh n­íng",
      [2] = "B¸nh dÎo",
      [3] = "C¶ A, B ®Òu ®óng",
    }
  },
  [3] = {
    szName = "Lo¹i ®å ch¬i nµo phæ biÕn nhÊt trong tÕt Trung thu t¹i ViÖt Nam", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "MÆt n¹",
      [2] = "§Ìn «ng sao",
      [3] = "C¶ A, B ®Òu ®óng",
    }
  },
  [4] = {
    szName = "Ng­êi ViÖt th­êng tæ chøc ho¹t ®éng g× trong tÕt Trung thu?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "Móa rèi n­íc",
      [2] = "H¸t quan hä",
      [3] = "Móa l©n",
    }
  },
  [5] = {
    szName = "Trong tèi Trung thu, ngoµi th­ëng nguyÖt, d©n gian hay tæ chøc thi g×?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "Thi cç",
      [2] = "Thi ®Ìn",
      [3] = "C¶ A, B ®Òu ®óng",
    }
  },
  [6] = {
    szName = "Trong truyÒn thuyÕt, \"chÞ H»ng\" ë cung nµo trªn Thiªn ®×nh?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "Thiªn Cùc B¾c",
      [2] = "Quµng Hµn",
      [3] = "C«n Lu©n",
    }
  },
  [7] = {
    szName = "Trong truyÖn cæ tÝch, chó Cuéi v× lý do g× mµ ph¶i trèn lªn mÆt tr¨ng?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "Nãi dèi",
      [2] = "Trèn nî",
      [3] = "NÝu gi÷ c©y §a cã phÐp c¶i tö hoµn sinh",
    }
  },
  [8] = {
    szName = "Theo d©n gian, cïng sèng víi H»ng Nga vµ chó Cuéi trªn cung tr¨ng lµ ai?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "Tr­ B¸t Giíi",
      [2] = "Thá ngäc",
      [3] = "T«n Ngé Kh«ng",
    }
  },
  [9] = {
    szName = "Bµi h¸t ChiÕc ®Ìn «ng sao lµ cña nh¹c sÜ nµo?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "Ph¹m Tuyªn",
      [2] = "TrÞnh C«ng S¬n",
      [3] = "Hoµng L©n",
    }
  },
  [10] = {
    szName = "TÕt Trung Thu cßn cã tªn gäi nµo kh¸c?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "TÕt Tr«ng Tr¨ng",
      [2] = "TÕt ThiÕu Nhi/ TÕt Nhi §ång",
      [3] = "C¶ hai c©u ®Òu ®óng",
    }
  },
  [11] = {
    szName = "Ngµy TÕt Trung Thu ®­îc mõng ë c¸c quèc gia nµo?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "C¸c quèc gia ë §«ng Nam ¸",
      [2] = "TÊt c¶ c¸c quèc gia Ch©u ¸",
      [3] = "PhÇn lín c¸c quèc gia §«ng ¸",
    }
  },
  [12] = {
    szName = "V× sao c¸c n­íc ë ¢u Ch©u, Mü Ch©u kh«ng mõng TÕt Trung Thu?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "V× hä kh«ng thÝch",
      [2] = "V× Trung Thu lµ TÕt cña ng­êi Tµu",
      [3] = "V× hä chØ sö dông LÞch MÆt Trêi",
    }
  },
  [13] = {
    szName = "TÕt Trung Thu lµ ngµy TÕt dµnh riªng cho ai?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "ThiÕu Niªn Nhi §ång",
      [2] = "TÊt c¶ mäi ng­êi",
      [3] = "Cho tÊt c¶ Thanh ThiÕu Niªn",
    }
  },
  [14] = {
    szName = "Hai nh©n vËt ®­îc nh¾c ®Õn nhiÒu trong ngµy TÕt Trung thu lµ ai?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "ChÞ H»ng vµ Thá ngäc",
      [2] = "Chó Cuéi vµ Thá Ngäc",
      [3] = "Chó Cuéi vµ ChÞ H»ng",
    }
  },
  [15] = {
    szName = "Theo truyÖn Cæ TÝch, ai lµ ng­êi ViÖt Nam ®Çu tiªn lªn MÆt Tr¨ng?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "ChÞ H»ng",
      [2] = "Chó Cuéi",
      [3] = "Thiªn L«i",
    }
  },
  [16] = {
    szName = "Sù tÝch Chó Cuéi g¾n liÒn víi c©y g×?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "C©y Sung",
      [2] = "C©y §a",
      [3] = "©y Bå ®Ò",
    }
  },
  [17] = {
    szName = "Khi bÞ kÐo lªn Cung Tr¨ng, chó cuéi mang theo vËt g×?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "C©y s¸o",
      [2] = "C©y bóa",
      [3] = "C©y r×u",
    }
  },
  [18] = {
    szName = "Bµi h¸t nµo vÒ TÕt Trung Thu ®­îc h¸t nhiÒu nhÊt?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "ChiÕc §Ìn ¤ng Sao",
      [2] = "Móa S­ Tö",
      [3] = "R­íc §Ìn Th¸ng T¸m",
    }
  },
  [19] = {
    szName = "§ªm TÕt Trung Thu cßn ®­îc gäi lµ ®ªm héi g×?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "Héi §Ìn Lång",
      [2] = "Héi Tr¨ng R»m",
      [3] = "Héi Móa L©n",
    }
  },
  [20] = {
    szName = "Ba con vËt th­êng xuÊt hiÖn trong c¸c ®iÖu móa ®ªm r»m Trung Thu lµ nh÷ng con vËt nµo?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "L©n - S­ - Rång",
      [2] = "L©n - Phông - Rång",
      [3] = "L©n - Rång - R¾n",
    }
  },
  [21] = {
    szName = "B¸nh Trung Thu th­êng cã h×nh trßn vµ h×nh vu«ng. H×nh trßn vµ h×nh vu«ng nµy cã ý nghÜa g×?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "Tr¨ng trßn ®Êt vu«ng",
      [2] = "Trêi vu«ng ®Êt trßn",
      [3] = "Trêi trßn ®Êt vu«ng",
    }
  },
  [22] = {
    szName = "§ªm TÕt Trung Thu cã 2 sinh ho¹t vui ch¬i nµo ®Æc biÖt?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "R­íc §Ìn vµ Ph¸t b¸nh Trung Thu",
      [2] = "Ph¸t b¸nh Trung Thu vµ Móa L©n",
      [3] = "R­íc §Ìn vµ Móa L©n",
    }
  },
  [23] = {
    szName = "So víi Tr¸i §Êt, MÆt Tr¨ng lín h¬n hay nhá h¬n?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "Nhá h¬n",
      [2] = "Lín h¬n",
      [3] = "B»ng nhau",
    }
  },
  [24] = {
    szName = "MÆt Tr¨ng quay xong mét vßng quanh Tr¸i §Êt ph¶i mÊt bao l©u?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "29 ngµy",
      [2] = "30 ngµy",
      [3] = "31 ngµy",
    }
  },
  [25] = {
    szName = "LÇn ®Çu tiªn con ng­êi ®Æt ch©n lªn MÆt Tr¨ng lµ vµo n¨m nµo?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "1968",
      [2] = "1969",
      [3] = "1970",
    }
  },
  [26] = {
    szName = "V× sao MÆt Tr¨ng lóc th× trßn, lóc th× khuyÕt?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "V× MÆt Tr¨ng bÞ mÐo",
      [2] = "V× MÆt Tr¨ng bÞ mÆt trêi che khuÊt",
      [3] = "V× ¸nh s¸ng MÆt Trêi chiÕu vµo MÆt Tr¨ng mçi lóc mçi kh¸c",
    }
  },
  [27] = {
    szName = "NguyÖt thùc chØ cã thÓ x¶y ra khi nµo?", nCorrectAnswerIdx = 1,
    tbAnswers = {
      [1] = "Khi MÆt Trêi, Tr¸i §Êt vµ MÆt Tr¨ng n»m trªn mét ®­êng th¼ng",
      [2] = "Khi MÆt Trêi, MÆt Tr¨ng vµ Tr¸i §Êt n»m trªn mét ®­êng th¼ng",
      [3] = "Khi MÆt Tr¨ng, MÆt Trêi vµ Tr¸i §Êt n»m trªn mét ®­êng th¼ng",
    }
  },
  [28] = {
    szName = "Trong th¸ng, chÝnh x¸c ngµy nµo ta kh«ng thÊy MÆt Tr¨ng?", nCorrectAnswerIdx = 2,
    tbAnswers = {
      [1] = "Ngµy 30",
      [2] = "Ngµy cuèi th¸ng",
      [3] = "Ngµy ®Çu th¸ng",
    }
  },
  [29] = {
    szName = "Lo¹i ®Ìn nµo trÎ em ViÖt Nam hay ch¬i khi tÕt Trung Thu ®Õn?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "§Ìn lång",
      [2] = "§Ìn pin",
      [3] = "§Ìn «ng sao",
    }
  },
  [30] = {
    szName = "TÕt Trung Thu ®­îc tæ chøc khi nµo?", nCorrectAnswerIdx = 3,
    tbAnswers = {
      [1] = "15 th¸ng 9 ©m lÞch",
      [2] = "16 th¸ng 8 ©m lÞch",
      [3] = "15 th¸ng 8 ©m lÞch",
    }
  }
}

return EventMidAutumnLantern
