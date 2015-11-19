local Player = class("Player", function ( )
	--cc.SpriteFrameCache:getInstance():
	--cc.SpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("1009_role.plist")
	return cc.Sprite:createWithSpriteFrameName("1009_role/1000")
	--cc.Sprite:createWithSpriteFrameName("1009_role/1000")
	--display.newSprite("#1009_role/1000")
	--cc.Sprite:createWithSpriteFrameName("1009_role.png")
	--cc.Sprite:createWithSpriteFrame("#1009_role/1000")
	--display.newSprite("#1009_role/1000") 利用精灵帧创建精灵 2，利用图片帧创建精灵 3，图片直接创建
end)
function Player:ctor()
	local StateMachine = require("framework.cc.components.behavior.StateMachine")
	self.fsm = StateMachine.new()--创建一个状态机
	self.fsm:setupState({
		events = {
			{name="walkAction",from={"none","stop"},to="walk"},
			{name="deadAction",from={"none","attackP","attackA","attackB","attackC","attackD","stop","walk"},to="dead"},
			{name="stopAction",from={"none","attackP","attackA","attackB","attackC","attackD","walk"},to="stop"},
			{name="winAction",from={"none","attackP","attackA","attackB","attackC","attackD","stop","walk"},to="win"},
			{name="attackPAction",from={"stop","walk"},to="attackP"},--可以省去SkillData中的Data.AC开关.
			{name="attackAAction",from={"stop","walk"},to="attackA"},
			{name="attackBAction",from={"stop","walk"},to="attackB"},
			{name="attackCAction",from={"stop","walk"},to="attackC"},
			{name="attackDAction",from={"stop","walk"},to="attackD"},
	},--[[前缀固定为onbefore on.. onleave 状态转换间隔为3个动作 onbefore on..开启帧动画]]
	callbacks={
			--站立
	        onbeforestopAction = function(event) self:stopAllActions(); end,
            onstopAction = function(event) self:stop() end,
            onleavestopAction = function(event)  end,
            --跑动
			onbeforewalkAction = function(event) self:stopAllActions(); end,
            onwalkAction = function(event) self:walk() end,
            onleavewalkAction = function(event) end,
            --死亡
            onbeforedeadAction = function(event) self:stopAllActions(); end,
            ondeadAction = function(event)self:dead() end,
            onleavedeadAction = function(event) end,
            --胜利
            onbeforewinAction = function(event) self:stopAllActions(); end,
            onwinAction = function(event)self:win() end,
            onleavewinAction = function(event) end,
            --普攻
            onbeforeattackPAction = function(event) self:stopAllActions(); end,
            onattackPAction = function(event) self:attackP();  end,
            onleaveattackPAction =  function(event) end,
            --A
            onbeforeattackAAction = function(event) self:stopAllActions(); end,
            onattackAAction = function(event) 
            self:attackA()
            if HeroData.Data.isPlaySound then
        		audio.playSound("Q_bIsAttack.mp3",false)
    		end
            self:performWithDelay(function() self.fsm:doEvent("stopAction") SkillData.Data.P1 = 0 end, 0.6); --延迟函数
            end,
            onleaveattackAAction = function(event) end,
            --B
            onbeforeattackBAction = function(event)  self:stopAllActions(); end,
            onattackBAction = function(event) self:attackB()
            if HeroData.Data.isPlaySound then
        		audio.playSound("W_bIsAttack1.mp3",true)
    		end 
            self:performWithDelay(function() self.fsm:doEvent("stopAction") SkillData.Data.P2 = 0 
            	if HeroData.Data.isPlaySound then
            		audio.stopAllSounds()
        			audio.playSound("W_bIsAttack2.mp3",false)
    			end 
            end,1.0); --延迟函数
            end,
            onleaveattackBAction = function(event) end,
            --C
            onbeforeattackCAction = function(event) self:stopAllActions(); end,
            onattackCAction = function(event) self:attackC() 
            if HeroData.Data.isPlaySound then
        		audio.playSound("E_bIsAttack.mp3",false)
    		end 
            self:performWithDelay(function() self.fsm:doEvent("stopAction") SkillData.Data.P3 = 0 end, 1.0); --延迟函数
            end,
            onleaveattackCAction = function(event) end,
            --D
            onbeforeattackDAction = function(event)  self:stopAllActions(); end,
            onattackDAction = function(event) self:attackD() 
            if HeroData.Data.isPlaySound then
        		audio.playSound("R_bIsAttack.mp3",false)
    		end
            self:performWithDelay(function()  self.fsm:doEvent("stopAction") SkillData.Data.P4 = 0 
            	if HeroData.Data.isPlaySound then
        			audio.stopAllSounds()
    			end
            end, 2.0); --延迟函数
            end,
            onleaveattackDAction = function(event) end,

	},
})
end
function Player:stop()
	local frames = display.newFrames("1009_role/10%.2i", 0, 27)  --站立
	local animation = display.newAnimation(frames, 0.5/15)
	self:playAnimationForever(animation)
	if HeroData.Data.isPlaySound then
		audio.stopAllSounds()
    end
end
function Player:walk()
	local frames = display.newFrames("1009_role/00%.2i", 27,17)   --跑动
	local animation = display.newAnimation(frames,0.5/15)
	local ain = cc.Animate:create(animation)
	if HeroData.Data.isPlaySound then
        audio.playSound("run.mp3",true)
    end
	self:runAction(cc.RepeatForever:create(ain))
end
function Player:dead()
	local frames = display.newFrames("1009_role/03%.2i", 45, 8)  --死亡
	local animation = display.newAnimation(frames,0.5/4)
	self:playAnimationOnce(animation)
	if HeroData.Data.isPlaySound then
        audio.playSound("herodie.mp3",false)
    end
end
function Player:win()
	local frames = display.newFrames("1009_role/0%.3i", 275, 63) -- 旋转技能
	local animation = display.newAnimation(frames,0.5/15)
	self:playAnimationOnce(animation)
end
function Player:attackP() --普攻
	local frames = display.newFrames("1009_role/1%.3i",45,130)   --普攻
	local animation = display.newAnimation(frames, 0.5/24)
	animation:setRestoreOriginalFrame(true)
	self:playAnimationForever(animation)
    if HeroData.Data.isPlaySound then
        audio.playSound("Attack.mp3",true)
    end
end
function Player:attackA() 
	local frames = display.newFrames("1009_role/01%.2i", 81,18)  -- 大棒技能
	local animation = display.newAnimation(frames,0.5/15)
	animation:setRestoreOriginalFrame(true)
	self:playAnimationOnce(animation)
end
function Player:attackB()
	local frames = display.newFrames("1009_role/02%.2i", 0, 45)  --翻滚打怪技能
	local animation = display.newAnimation(frames,0.5/20)
	animation:setRestoreOriginalFrame(true)
	self:playAnimationOnce(animation)
end
function Player:attackC() 
	local frames = display.newFrames("1009_role/02%.2i", 45, 26) --分身打怪
	local animation = display.newAnimation(frames,0.5/15)
	animation:setRestoreOriginalFrame(true)
	self:playAnimationOnce(animation)
end
function Player:attackD()
	local frames = display.newFrames("1009_role/0%.3i", 275, 63) -- 旋转技能
	local animation = display.newAnimation(frames,0.5/15)
	animation:setRestoreOriginalFrame(true)
	self:playAnimationOnce(animation) --永久
end


return Player