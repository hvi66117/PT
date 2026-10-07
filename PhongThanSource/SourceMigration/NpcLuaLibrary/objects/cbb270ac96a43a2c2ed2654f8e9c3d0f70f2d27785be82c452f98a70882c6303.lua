--description: Ðþ¶¼´ó·¨Ê¦
--author: likun
--date: 2009/1/12
--func: ÓÈ³æ¸½Ìå
--TaskYouChong µÚÒ»¸ö×Ö½Ú±£´æÈÎÎñ±äÁ¿ 
--			   µÚ¶þ¸ö×Ö½Ú±£´æÒªÉ±ËÀ¸öÓÈ³æ¸öÊý 

--TaskYouChongµÚÒ»¸ö×Ö½Ú=0 Ã»ÓÐ½Óµ½ÈÎÎñ
--TaskYouChongµÚÒ»¸ö×Ö½Ú=1 Õý´¦ÓÚÈÎÎñ×´Ì¬
--TaskYouChongµÚÒ»¸ö×Ö½Ú=2 Íê³ÉÈÎÎñ

TaskYouChong = 1288
TaskMsg = {
    [1] = "cßn ph¶i tiªu diÖt",
    [2] = "V­u Trïng",
    [3] = "B¹n ®· haßn thµnh nhiÖm vô V­u Trïng Phô ThÓ",
}

function OnDeath(npcindex)
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    local lKillNum = GetByte(GetTask(TaskYouChong), 3)

    if (lTaskCtrl == 1 and lKillNum > 0) then
        lKillNum = lKillNum - 1
        SetTaskWord(TaskYouChong, SetByte(GetTask(TaskYouChong), 3, lKillNum))
        Msg2Player(TaskMsg[1] .. lKillNum .. TaskMsg[2])
    end

    if (lTaskCtrl == 1 and lKillNum <= 0) then
        Msg2Player(TaskMsg[3])
        SetTaskWord(TaskYouChong, 1, 2)
    end

    BorthYouChong()
end

function BorthYouChong()
    local rate = random(1, 2)
    local num = GetByte(GetTask(TaskYouChong), 4)

    if (num <= 0) then
        return 0
    end

    if (rate == 1) then
        num = num - 1
        SetByte(TaskYouChong, SetByte(GetTask(TaskYouChong), 4, num))
        local w, x, y = GetWorldPos()
        local newnpcidx = AddNpc(660, 10, SubWorld, x, y)
        return 1
    end
    return 0
end