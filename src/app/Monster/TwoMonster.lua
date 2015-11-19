local TwoMonster = class("TwoMonster", function ( )
	return display.newSprite("#2001_role/0000")--利用精灵帧创建精灵 2，利用图片帧创建精灵 3，图片直接创建
end)
--  肉盾
function TwoMonster:ctor( )
      self.MsAc = false
	local StateMachine = require("framework.cc.components.behavior.StateMachine")
	self.fsm = StateMachine.new()--创建一个状态机
	self.fsm:setupState({
		events = {
                  {name="noneAction",from={"attackA"},to="noneSp"},
                  {name="stopAction",from={"walk","noneSp","hurt"},to="stop"},                --站立
                  {name="walkAction",from={"none","attackA","stop"},to="walk"},        --行走
                  {name="hurtAction", from ={"none","walk","attackA","stop"},to = "hurt"},     --受伤
                  {name="deadAction",from={"hurt"},to="dead"},  --死亡
                  {name="attackAAction",from={"walk","noneSp","stop"},to="attackA"}, --攻击
	},--[[前缀固定为onbefore on.. onleave 状态转换间隔为3个动作 onbefore on..开启帧动画]]
	callbacks={
            --空
            onbeforenoneAction = function(event) self:stopAllActions(); end,
            onnoneAction = function(event) end,
            onleavenoneAction = function(event)  end,
            --站立
            onbeforestopAction = function(event) self:stopAllActions(); end,
            onstopAction = function(event) self:stop() end,
            onleavestopAction = function(event)  end,
            --行走
		onbeforewalkAction = function(event) self:stopAllActions(); end,
            onwalkAction = function(event) self:walk() end,
            onleavewalkAction = function(event) end,
            --受伤
            onbeforehurtAction = function(event) self:stopAllActions(); end,
            onhurtAction = function(event) self:hurt() 
            self:performWithDelay(function () self.fsm:doEvent("stopAction") 
            end, 0.5)
            end,
            onleavehurtAction =  function(event)  end,
            --死亡
            onbeforedeadAction = function(event) self:stopAllActions(); end,
            ondeadAction = function(event)self:dead() end,
            onleavedeadAction = function(event) end,
            --大锤子攻击
            onbeforeattackAAction = function(event) self:stopAllActions(); end,
            onattackAAction = function(event)
            self:stop()
            self:performWithDelay(function() self:stopAllActions()  self:attackA() 
                  self.MsAc = true
            self:performWithDelay(function() self.fsm:doEvent("noneAction") end, 1.0); --延迟函数
            end, 2.0); --延迟函数
            end,

            onleaveattackAAction = function(event) end,
	},
})
end
function TwoMonster:stop()
      local frames = display.newFrames("2001_role/00%.2d",0,18)  --站立
      local animation = display.newAnimation(frames, 0.5/15)
      self:playAnimationForever(animation)
end
function TwoMonster:walk()
      local frames = display.newFrames("2001_role/00%.2i", 18, 30)--行走
      local animation = display.newAnimation(frames, 0.5 / 16) 
      self:playAnimationForever(animation)
end
function TwoMonster:hurt()
      local frames = display.newFrames("2001_role/00%.2i", 78, 5)--受伤
      local animation = display.newAnimation(frames, 0.5 / 5) 
      self:playAnimationForever(animation)
      if HeroData.Data.isPlaySound then
        audio.playSound("RouHurt.mp3", false)--受伤
      end
end
function TwoMonster:dead()
      local frames = display.newFrames("die_role/10%.2d",0,27)  --死亡
      local animation = display.newAnimation(frames, 0.5 / 10) 
      self:playAnimationOnce(animation)
      if HeroData.Data.isPlaySound then
            audio.playSound("blood.mp3", false)--受伤
      end
      
end
function TwoMonster:attackA()
      local frames = display.newFrames("2001_role/00%.2i", 48, 28)--大锤子攻击
      local animation = display.newAnimation(frames, 1 / 28)
      self:playAnimationOnce(animation)
      if HeroData.Data.isPlaySound then
            audio.playSound("RouAttack.mp3", false)--受伤
      end
end
return TwoMonster