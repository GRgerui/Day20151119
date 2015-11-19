local HeroNode = class("HeroNode", function( )
	return display.newNode()
end)
function HeroNode:ctor( )
	self:init()
end
function HeroNode:setRockbackData( Direction,Run,ButJn,Jntime )
	self.rocketDirection=Direction
	self.rocketRun = Run
end
function HeroNode:init()
	--self:labelDemo()
	self:schedulerDemo()

    self.player = Player:new();
    self:addChild(self.player);
    self.player.fsm:doEvent("stopAction")
    local effupSp = display.newSprite("hero_effup.png",5,20)
    effupSp:addTo(self,1)

    --英雄的属性
    self.Hp = HeroData.getHP()
    self.MoHp = HeroData.getHP()
    --将能量值加入底层
    ModifyData.setMP(HeroData.getMP())
end
function HeroNode:newRect(v)
        local size = v:getContentSize()
        local x = v:getPositionX()
        local y = v:getPositionY()
        local rect = cc.rect(x-size.width/2, y-size.height/2, size.width, size.height)
        return rect
end
function getHero()
    return self.player
end
function HeroNode:labelDemo()
	local namelabel = cc.ui.UILabel.new({
		UILabelType = 1,
		text = "大圣",
		font = "mytext.fnt",
		align = cc.ui.TEXT_ALIGN_CENTER -- 文字内部居中对齐 
		})
	namelabel:setPosition(-25,-25)
    namelabel:setScale(0.4)
	self:addChild(namelabel)
end
function HeroNode:schedulerDemo()
	local scheduler = cc.Director:getInstance():getScheduler()
	self.id=scheduler:scheduleScriptFunc(handler(self,HeroNode.schedulerfunc), 1/60, false)
end
walk = true
AC = true
function HeroNode:schedulerfunc()
    local x = self:getPositionX()
    local y = self:getPositionY()
    local sudu = 6

 if SkillData.Data.P1 == 0 and SkillData.Data.P2 == 0 and SkillData.Data.P3 == 0 and SkillData.Data.P4 == 0 and SkillData.Data.P5 ~= 1 then
    if self.rocketDirection == 0 and walk==true then
    	walk=false
        if self.player.fsm:canDoEvent("stopAction") then
            self.player.fsm:doEvent("stopAction")
        end
    elseif self.rocketDirection == 1 then --右走
        if x+sudu>1920 then
            self:setPosition(cc.p(1920,y))
        else
            self:setPosition(cc.p(x+sudu,y))
        end
    elseif self.rocketDirection == 2 then
        if y+sudu>320 then
            self:setPosition(cc.p(x,320))
        else
            self:setPosition(cc.p(x,y+sudu))
        end
    elseif self.rocketDirection == 3 then
        if x-sudu<20 then
            self:setPosition(cc.p(20,y))
        else
            self:setPosition(cc.p(x-sudu,y))
        end
    elseif self.rocketDirection == 4 then
        if y-sudu<120 then
            self:setPosition(cc.p(x,120))
        else
            self:setPosition(cc.p(x,y-sudu))
        end
    elseif self.rocketDirection == 5 then
        if x>20 and y>=320 then
            self:setPosition(cc.p(x-sudu,320))
        end
        if x<=20 and y<320 then
            self:setPosition(cc.p(20,y+sudu))
        end
        if x<=20 and y>=320 then
            self:setPosition(cc.p(20,320))
        end
        if x>20 and y<320 then 
            self:setPosition(cc.p(x-sudu+2,y+sudu-2)) --左上
        end
    elseif self.rocketDirection == 6 then
        if x>20 and y>120 then
            self:setPosition(cc.p(x-sudu+2,y-sudu+2)) --左下
        end
        if x<=20 and y>120 then
            self:setPosition(cc.p(20,y-sudu))
        end
        if x>20 and y<=120 then
            self:setPosition(cc.p(x-sudu,120))
        end
        if x<=20 and y<=120 then
            self:setPosition(cc.p(20,120))
        end
    elseif self.rocketDirection == 7 then
        if x<1920 and y<320 then
            self:setPosition(cc.p(x+sudu-2,y+sudu-2)) --右上
        end
        if x>=1920 and y<320 then
            self:setPosition(cc.p(1920,y+sudu))
        end
        if x<1920 and y>=320 then
            self:setPosition(cc.p(x+sudu,320))
        end
        if x>=1920 and y>=320 then
            self:setPosition(cc.p(1920,320))
        end
    elseif self.rocketDirection == 8 then
        if x<1920 and y>120 then
            self:setPosition(cc.p(x+sudu-2,y-sudu+2)) --右下
        end
        if x>=1920 and y>120 then
            self:setPosition(cc.p(1920,y-sudu))
        end
        if x<1920 and y<=120 then
            self:setPosition(cc.p(x+sudu,120))
        end
        if x>=1920 and y<=120 then
            self:setPosition(cc.p(1920,120))
        end
    end
    
    if self.rocketRun then --控制英雄的面向
    	self.player:setScaleX(-1)
    	else
    	self.player:setScaleX(1)
    end
end
    if self.rocketDirection ~= 0 and SkillData.Data.P5 ~= 1 then 
        walk=true
        if self.player.fsm:canDoEvent("walkAction") then
            self.player.fsm:doEvent("walkAction")
        end
    end

    if self.player.fsm:canDoEvent("attackAAction") and SkillData.Data.P1 == 1 then
        walk=true
        self.player.fsm:doEvent("attackAAction")
    elseif self.player.fsm:canDoEvent("attackBAction") and SkillData.Data.P2 == 1 then
        walk=true
        self.player.fsm:doEvent("attackBAction")
        local jump = nil
        if self.rocketRun then
            jump = cca.jumpTo(1.0, self:getPositionX()-350 , self:getPositionY(), 100, 1)
            else
            jump = cca.jumpTo(1.0, self:getPositionX()+350 , self:getPositionY(), 100, 1)
        end
        self:runAction(jump)
    elseif self.player.fsm:canDoEvent("attackCAction") and SkillData.Data.P3 == 1 then
        walk=true
        self.player.fsm:doEvent("attackCAction")
    elseif self.player.fsm:canDoEvent("attackDAction") and SkillData.Data.P4 == 1 then
        walk=true
        self.player.fsm:doEvent("attackDAction")
        local move = nil
        if self.rocketRun then
            move = cca.moveTo(2.0, self:getPositionX()-450 , self:getPositionY())
            else
            move = cca.moveTo(2.0, self:getPositionX()+450 , self:getPositionY())
        end
        self:runAction(move)
    end
    if SkillData.Data.P5 == 1 then
        if self.player.fsm:canDoEvent("attackPAction") then
            walk=true
            self.player.fsm:doEvent("attackPAction")

        end
    elseif SkillData.Data.P5 == 2 and SkillData.Data.P1 == 0 and SkillData.Data.P2 == 0 and SkillData.Data.P3 == 0 and SkillData.Data.P4 == 0  then
        SkillData.Data.P5 = 0
        if self.player.fsm:canDoEvent("stopAction") then
            self.player.fsm:doEvent("stopAction")
        end
    end
    if x<20 then
        self:setPositionX(20)
    elseif x>1920 then
        self:setPositionX(1920)
    end
    ModifyData.heroPos.x = x
    ModifyData.heroPos.y = y

    --怪物3 闪电攻击
    if SkillData.Data.Ms3Ac == true then
        SkillData.Data.Ms3Ac = false
        self:Ace()
    end
end
function HeroNode:Ace()

      local frames = display.newFrames("2003_Q_effup/10%.2i",0,11)  
      local animation = display.newAnimation(frames, 0.5/11)
      local ain = cc.Animate:create(animation)
      local Sp = display.newSprite("#2003_Q_effup/1000")
      Sp:addTo(self,2)
      local func = cca.callFunc(function()
          Sp:removeFromParent()
      end)
      
      local seqAct = cc.Sequence:create(cc.TargetedAction:create(Sp, ain),func)
      Sp:runAction(seqAct)

end
return HeroNode