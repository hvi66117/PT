--description: »¤·¨
--author: mayining
--date: 2009/1/12

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()

    local tasks = {
        { "Phong thó s¬n hån", "renwu1"; show = 0 },
    }

    SayTask("DÞ thó thËt lµ hung d÷, chóng ta e r»ng sÏ kh«ng gi÷ næi n÷a!Nh­ng dï cã t¸ng m¹ng n¬i ®©y ta quyÕt kh«ng rêi nöa b­íc.", tasks)

end;

function renwu1()

end

function no()
    CloseDialog()
end;