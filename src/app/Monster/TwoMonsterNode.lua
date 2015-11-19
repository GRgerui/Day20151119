local TwoMonsterNode = class("TwoMonsterNode", function( )
	return display.newNode()
end)
function TwoMonsterNode:ctor()
    self.Zt = false
	self:init()
end
function TwoMonsterNode:init()
    local func = cca.callFunc(function ()
        --创建和添加怪物 2
        self.Ms2 = TwoMonster:new()
        self.Ms2:setPosition(0,90)
        self:addChild(self.Ms2)
        --血条
        self:MsProgressTimer()
        --跟随
        self:GoonMs()
    end)
    --落地动画
    local node = display.newSprite("#monsterout_effup/1000")
    node:addTo(self)
    node:setPosition(-10,60)
    local frames = display.newFrames("monsterout_effup/10%.2i",0,15)
    local animation = display.newAnimation(frames, 0.5 / 15) 
    local ain = cc.Animate:create(animation)
    local seqAct = cc.Sequence:create(cc.TargetedAction:create(node, ain),func)
    node:runAction(seqAct)
    --获取该场景所有怪物的血量
    Sc = ModifyData.getSceneNum()
    Ch = ModifyData.getChapterNum()
    self.Hp = MonsterData.SCENE[Sc][Ch].boy2.hp
    self.MsHp = MonsterData.SCENE[Sc][Ch].boy2.hp
    self.MsPower = MonsterData.SCENE[Sc][Ch].boy2.power
end
function TwoMonsterNode:MsProgressTimer()
    local barBg = display.newSprite("#master_1.png",0,90)
    barBg:addTo(self,1)
    --血条
    self.HPSp = display.newSprite("#master_2.png")
    self.HpBar = cc.ProgressTimer:create(self.HPSp)
    self.HpBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)  --设置为条形 type:cc.PROGRESS_TIMER_TYPE_RADIAL
    self.HpBar:setMidpoint(cc.p(0,0.5))             --设置起点在左边 1,0 起点在右边
    self.HpBar:setBarChangeRate(cc.p(1,0))          --设置为竖直方向
    self.HpBar:setPercentage(100)                   -- 设置初始进度为30
    self.HpBar:setPosition(0,90)
    self:addChild(self.HpBar,1)
end
function TwoMonsterNode:GoonMs() --跟随人物
    local sceneNum = ModifyData.getSceneNum()
    local chapterNum = ModifyData.getChapterNum()
    local speed = MonsterData.SCENE[sceneNum][chapterNum].boy2.Speed
    local Range = MonsterData.SCENE[sceneNum][chapterNum].boy2.range
    EnemyGoonMudo:enemyGoon(self,self.Ms2,speed,Range)
end
return TwoMonsterNode