local ResourceLoadScene = class("ResourceLoadScene", function ( )
	return display.newScene("ResourceLoadScene")
end)
function ResourceLoadScene:ctor( )
	self:init()
end
function ResourceLoadScene:init( )
	local rfSp = display.newSprite("226.png",display.right-175,160)
	rfSp:addTo(self,2)
	print("ResourceLoadScene")
	local bg = cc.Sprite:create("SplashBack.png")
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScaleX(scaleX)
	bg:setScaleY(scaleY)
	bg:setPosition(display.cx, display.cy)
	self:addChild(bg)
	self:ProgressTimerDemo()
end
function ResourceLoadScene:ProgressTimerDemo( )
	--创建进度条
	local sp = cc.Sprite:create("jindutiao.png")
	self.timer = cc.ProgressTimer:create(sp)
	self.timer:setType(display.PROGRESS_TIMER_BAR)
	self.timer:setPosition(display.cx, 20)
	self.timer:setMidpoint(cc.p(0,0.5))--基准点
	self.timer:setBarChangeRate(cc.p(1,0))
	self.timer:setPercentage(0)
	self.timer:addTo(self)
	-- --进度条动作

   	self.myid = 0;
   	self.id = scheduler.scheduleGlobal(handler(self, ResourceLoadScene.update),1/20)
   	self.t1 = {"gateMap_4.plist","gateMap_3.plist","gateMap_2.plist","gateMap_1.plist","startGame.plist","uiSprite.plist","setLayer.plist","1009_role.plist","monsterout_effup.plist","mijiLayer.plist","Boss_effup.plist","2002_role.plist","2001_role.plist","2003_Q_effup.plist","2003_role.plist","die_role.plist","mapRoad.plist","mapMid.plist","mapBefore.plist","mapBg.plist","gameLayer.plist"}
   	self.t2 = {"gateMap_4.png","gateMap_3.png","gateMap_2.png","gateMap_1.png","startGame.png","uiSprite.png","setLayer.png","1009_role.png","monsterout_effup.png","mijiLayer.png","Boss_effup.png","2002_role.png","2001_role.png","2003_Q_effup.png","2003_role.png","die_role.png","mapRoad.png","mapMid.png","mapBefore.png","mapBg.png","gameLayer.png"}

end

function ResourceLoadScene:update()
	if self.myid < 21 then
		self.myid = self.myid + 1
		self.timer:setPercentage(self.timer:getPercentage()+4.8)
		display.addSpriteFrames(self.t1[self.myid],self.t2[self.myid]);
	else
		scheduler.unscheduleGlobal(self.id)   
 		local startscene = StartScene.new()
        local s = cc.TransitionFade:create(1.0, startscene)
        cc.Director:getInstance():replaceScene(s)
	end
	
end
return ResourceLoadScene