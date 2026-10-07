Task_Catch_Wolf = 1346

Wolf_TemplateID = 746
Wolf_Boss_TemplateID = 885

function main()
    local TargetNpcIdx = GetPlayerTarget()
    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    if (GetTaskByte(Task_Catch_Wolf, 1) == 1 and GetTaskByte(Task_Catch_Wolf, 2) < 30) then
        if (TargetNpcIdx == 0 or GetNpcTemplateID(TargetNpcIdx) ~= Wolf_TemplateID) then
            Msg2Player("NhÞ KhÝ b×nh chØ dïng ®Ó b¾t Sãi mµ th«i!")
            return
        end
        AddProcessBar()

    elseif (GetTaskByte(Task_Catch_Wolf, 1) == 3 and GetTaskByte(Task_Catch_Wolf, 3) < 3) then
        if (TargetNpcIdx == 0 or GetNpcTemplateID(TargetNpcIdx) ~= Wolf_Boss_TemplateID) then
            Msg2Player("NhÞ KhÝ b×nh chØ dïng ®Ó b¾t Sãi chóa mµ th«i!")
            return
        end
        AddProcessBar()
    end
end

function AddProcessBar()
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 7, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    BeginMotion(Task_Catch_Wolf, 0, 5, "\\script\\motion\\²¶×½ÊÉÀÇÏìÓ¦.lua", nInterrupt)
end

function no()
    CloseDialog()
end
