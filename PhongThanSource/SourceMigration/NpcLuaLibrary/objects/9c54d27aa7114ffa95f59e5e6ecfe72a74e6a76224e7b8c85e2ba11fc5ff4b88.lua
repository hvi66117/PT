Task_PrepareMaterial = 1049;
------------问命之签 Add by gaojignwei at 2009/04/08 begin--------
Task_Divination = 1375        --1byte:1在卦师处领任务 2在算命先生处领任务 3在南极仙翁处领任务 4回复南极仙翁加buffA 5领到九转丹 6在算命先生处经验奖励
--7得到签 8完成应签任务 2byte 采集红玉草的个数 3byte采集幽冥草的个数 4byte杀死鬼驭的个数
Task_Label_Type = 1376      --1byte: 1纳财签 2血光签 3宜色签
Buff_Make_Drug = 636           --1分钟制药buff
Buff_Add_Life = 635           --1小时回复生命及内力buff
Buff_Polymorph = 404        --半小时变身buff
Buff_Plutus = 228            --天将财神buff
Task_Num = 1039                --taskinfo的编号
------------问命之签 Add by gaojignwei at 2009/04/08 end--------

--------------------------- 中秋活动 added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:记录任务进度 1:去赌徒领取模具 2:去采集3种果实，然后去朝歌礼官处兑换月饼馅 
--                    3:去三山关打面粉 4:去超级月饼处领取奖励 5:任务完成
-- 2byte:记录任务次数
-- 3byte:时间戳
-- 4byte:记录是否已经在超级月饼处领取过特殊奖励
Gloal_zhongqiu_num = 257    -- 记录服务器所有玩家已经完成的任务次数
TaskNote_zhongqiu = 1103
--------------------------- 中秋活动 end of add yangtao 2009.9.14 -----------------------------

function main()
    local nNum = HaveNormalItem(3, 144, 0, 0)
    -- 中秋活动 Added by yangtao 2009.9.14
    --local Process	= GetTaskByte(Task_zhongqiu, 1)
    --if(Process == 2) then
    --	if(IsHaveSpaceForTreasure (1) == 0) then
    --		Msg2Player("没有足够的空间,无法采集。")
    --		return
    --	end
    --	AddNormalItemPile(3,144,0,0,0,0)
    --	SetPropState(1)
    --	if((HaveEventItemCount(193) >= 1) and (HaveNormalItem(3,145,0,0 ) >= 1)) then
    --		Msg2Player("材料已齐，快回朝歌礼官处吧！")
    --		TopMessage("材料已齐，快回朝歌礼官处吧")
    --		return
    --	else
    --		Msg2Player("采集到一个玉红草")
    --		TopMessage("采集到一个玉红草")
    --		return
    --	end
    -- 中秋活动 end of add yangtao 2009.9.14
    if (GetTask(Task_PrepareMaterial) == 1 and GetPlayerType() == 1) then
        --		if( nNum < 10)then
        AddNormalItemPile(3, 144, 0, 0, 0, 0)
        ---玉红草
        nNum = nNum + 1
        SetPropState(1)
        if (nNum >= 10) then
            TopMessage(13235)
            Msg2Player("Thu th藀  H錸g.")
        else
            TopMessage(13236)
            Msg2Player("nh薾 頲 H錸g.")
        end
        --		end
    elseif (GetTaskByte(Task_Divination, 1) == 3 and HaveNormalItem(3, 144, 0, 0) < 5) then
        local grassNum = HaveNormalItem(3, 144, 0, 0)
        AddNormalItemPile(3, 144, 0, 0, 0, 0)
        grassNum = grassNum + 1
        SetPropState(1)
        SetTaskByte(Task_Divination, 2, grassNum)
        if (grassNum < 5) then
            TopMessage("Л頲 1 H錸g")
            Msg2Player("Л頲 1 H錸g")
        else
            TopMessage("Thu th藀  H錸g")
            Msg2Player("Thu th藀  H錸g")
        end
    else
        TopMessage(13237)
    end
end