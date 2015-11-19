module("EnemyGoonMudo",package.seeall)

function EnemyGoonMudo:enemyGoon(psender,Monster,speed,Range)
    local face = (ModifyData.heroPos.x - psender:getPositionX())>0
    if face then --控制面向
        Monster:setScaleX(1)
        else
        Monster:setScaleX(-1)
    end
    local x = (ModifyData.heroPos.x - psender:getPositionX())>20 and speed or -speed
    local y = (ModifyData.heroPos.y - psender:getPositionY())>0 and speed or -speed
    if math.abs(ModifyData.heroPos.y - psender:getPositionY())<=2 then
        y = 0
    end
    if math.abs(ModifyData.heroPos.x-psender:getPositionX())<=Range then
        x = 0
    end
    if x == 0 and y == 0 then
        if Monster.fsm:canDoEvent("attackAAction") then
            Monster.fsm:doEvent("attackAAction")
        end
    else
        if Monster.fsm:canDoEvent("walkAction") then
            Monster.fsm:doEvent("walkAction")  --控制技能的中断
        end
    end
    if psender.Zt then
        x = 0
        y = 0
    end
    local move = cc.MoveBy:create(0.025, cc.p(x, y))
    local funcN = cca.callFunc(function ( sender ) EnemyGoonMudo:enemyGoon(psender,Monster,speed,Range) end) 
    local seq = cc.Sequence:create(move,funcN)
    psender:runAction(seq)
end