local OneMonster = class("OneMonster", function ( )
	return display.newSprite("#2002_role/0000")--利用精灵帧创建精灵 2，利用图片帧创建精灵 3，图片直接创建
end)
--[[
cc.Sprite:createWithTexture("#2002_role/0000")
TextureCache::getInstance()->addImage("30004_skill_hit_0000.png");//加入预加载
mySp2 = Sprite::createWithTexture(TextureCache::getInstance()->getTextureForKey("30004_skill_hit_0000.png"));//读取加载后
]]
--小兵
function OneMonster:ctor()
      self.MsAc = false
	local StateMachine = require("framework.cc.components.behavior.StateMachine")
	self.fsm = StateMachine.new()--创建一个状态机
	self.fsm:setupState({
		events = {
                  {name="noneAction",from={"attackA"},to="noneSp"},                            
                  {name="stopAction",from={"walk","noneSp","hurt","parry"},to="stop"},         --站立
			{name="walkAction",from={"none","attackA","stop"},to="walk"},                --行走
                  {name="hurtAction", from ={"none","walk","attackA","stop","noneSp"},to = "hurt"},--受伤
                  {name="parryAction", from ={"none","walk","attackA","stop","noneSp"},to = "parry"},--格挡
			{name="deadAction",from={"hurt"},to="dead"},  --死亡
			{name="attackAAction",from={"walk","noneSp","stop"},to="attackA"},           --攻击
	},--[[前缀固定为onbefore on.. onleave 状态转换间隔为3个动作 onbefore on..开启帧动画]]
	callbacks={
            --空
            onbeforenoneAction = function(event) self:stopAllActions(); end,
            onnoneAction = function(event)  end,
            onleavenoneAction = function(event)  end,
            --站立
            onbeforestopAction = function(event) self:stopAllActions(); end,
            onstopAction = function(event) self:stop() end,
            onleavestopAction = function(event)  end,
            --跑动
		onbeforewalkAction = function(event) self:stopAllActions(); end,
            onwalkAction = function(event) self:walk() end,
            onleavewalkAction = function(event) end,
            --受伤
            onbeforehurtAction = function(event) self:stopAllActions(); end,
            onhurtAction = function(event) self:hurt() 
            self:performWithDelay(function() self.fsm:doEvent("stopAction") 
            end, 0.5)
            end,
            onleavehurtAction =  function(event)  end,
            --格挡
            onbeforeparryAction = function(event) self:stopAllActions(); end,
            onparryAction = function(event) self:parry(); 
            self:performWithDelay(function() self.fsm:doEvent("stopAction") end, 0.4)
            end,
            onleaveparryAction =  function(event)  end,
            --死亡
            onbeforedeadAction = function(event) self:stopAllActions(); end,
            ondeadAction = function(event)self:dead() end,
            onleavedeadAction = function(event) end,
            --劈刺
            onbeforeattackAAction = function(event) self:stopAllActions(); end,
            onattackAAction = function(event) 
            self:stop()
            self:performWithDelay(function() self:stopAllActions()  self:attackA()
                  self.MsAc = true
            self:performWithDelay(function() self.fsm:doEvent("noneAction") end, 0.8); --延迟函数
            end, 0.6); --延迟函数
            end,
            onleaveattackAAction = function(event) end,
	},
})
end
function OneMonster:stop()
      local frames = display.newFrames("2002_role/00%.2d",0,20) --站立
      local animation = display.newAnimation(frames, 0.5/15)
      self:playAnimationForever(animation)
end
function OneMonster:walk()
      local frames = display.newFrames("2002_role/00%.2d",20,32)--行走
      local animation = display.newAnimation(frames, 0.5 / 16)
      self:playAnimationForever(animation)
end
function OneMonster:hurt()
      local frames = display.newFrames("2002_role/0%.3d",111,5) --受伤
      local animation = display.newAnimation(frames, 0.8 / 10) 
      self:playAnimationForever(animation)
      if HeroData.Data.isPlaySound then
        audio.playSound("JianHurt.mp3", false)--受伤
      end
end
function OneMonster:parry()
      local frames = display.newFrames("2002_role/00%.2d",80,10)--格挡
      local animation = display.newAnimation(frames, 0.4 / 10) 
      self:playAnimationOnce(animation)
      if HeroData.Data.isPlaySound then
        audio.playSound("block.mp3", false) --格挡
      end
end
function OneMonster:dead()
      local frames = display.newFrames("die_role/10%.2d",0,27)  --死亡
      local animation = display.newAnimation(frames, 1.0 / 27) 
      self:playAnimationOnce(animation)
      if HeroData.Data.isPlaySound then
            audio.playSound("blood.mp3", false)
      end
end
function OneMonster:attackA()
      local frames = display.newFrames("2002_role/00%.2d",52,28)--劈刺
      local animation = display.newAnimation(frames, 0.8 / 28) 
      self:playAnimationOnce(animation)
      if HeroData.Data.isPlaySound then
        audio.playSound("JianAttack.mp3", false)
      end
      
end
return OneMonster