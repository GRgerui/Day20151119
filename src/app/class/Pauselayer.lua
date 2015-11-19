local Pauselayer = class("Pauselayer", function ()
	return cc.LayerColor:create(cc.c4b(100, 100, 100, 0))
	--display.newColorLayer(cc.c4b(100, 100, 100, 0))--层的触摸事件
end)
function Pauselayer:ctor()
    cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods()
    self:init()
end
function Pauselayer:init()
	local nodeleft = display.newNode()
	nodeleft:setPosition(-930, 0)
    print(nodeleft:getContentSize().width)
	nodeleft:addTo(self,3)

	local bg1 = display.newSprite("#pauseBG1.png")--左侧黑屏幕
	bg1:setPosition(0,0)
	nodeleft:addChild(bg1)

	--声音按钮
	local musicbtn = ccui.Button:create("musicOn.png","musicOff.png",nil,1)

    musicbtn:setPosition(cc.p(50,-200))
    nodeleft:addChild(musicbtn)
    musicbtn:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then
        elseif event==2 then
            if HeroData.Data.isPlayMusic then
                HeroData.Data.isPlayMusic = false --音乐控制开关
                audio.pauseMusic()
                print("写入文件")
                ModifyData.WriteDataToDocHero( HeroData.Data )
            else
                HeroData.Data.isPlayMusic = true

                audio.resumeMusic()
                audio.playMusic("backgroundmusic.mp3",true)
                --写入文件
                print("写入文件")
                ModifyData.WriteDataToDocHero( HeroData.Data )
            end
        end return true;end)

	--重新按钮
	local againbtn = ccui.Button:create("againNormal.png","againSelected.png",nil,1)

    againbtn:setPosition(cc.p(220,-200))
    nodeleft:addChild(againbtn)
    againbtn:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
        HeroData.MusicSound()
        cc.Director:getInstance():resume()
        local gamescene = GameScene.new()
        local s = cc.TransitionFade:create(0.6, gamescene)
        cc.Director:getInstance():replaceScene(s)

        end return true;end)
---------------------------------------------------------------------------------------------------------
	local noderight= display.newNode()
	noderight:setPosition(930, 0)
	noderight:addTo(self)

	local bg2 = display.newSprite("#pauseBG2.png")--左侧黑屏幕
	bg2:setPosition(0,0)
	noderight:addChild(bg2)


	local backbtn = ccui.Button:create("backNormal.png","backSelected.png",nil,1)
    backbtn:setPosition(cc.p(-50,-200))
    noderight:addChild(backbtn)
    backbtn:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
        HeroData.MusicBack()
        cc.Director:getInstance():resume()
        local selectchapter = SelectChapter.new()
        local s = cc.TransitionFade:create(1.2, selectchapter)
        cc.Director:getInstance():replaceScene(s)
        end return true;end)
--技能按钮
	local jinengbtn = ccui.Button:create("shopNormal.png","shopSelected.png",nil,1)
    jinengbtn:setPosition(cc.p(-220,-200))
    noderight:addChild(jinengbtn)
    jinengbtn:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
        cc.Director:getInstance():resume()
        local x = SkillLayer.new()
        cc.Director:getInstance():replaceScene(x)
        HeroData.MusicBack()
        HeroData.MusicSound()

    end return true;end)
---------------------------------------------------------------------------------------------------------
	--播放按钮
	local play = ccui.Button:create("playNormal.png","playSelected.png",nil,1)
    play:setScale(0)
    play:setPosition(0,0)
    self:addChild(play,5)
    play:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
            HeroData.MusicSound()
			local moveLeft = cc.MoveTo:create(0.5, cc.p(-960,0))
			local moveRight = cc.MoveTo:create(0.5, cc.p(960,0))
			nodeleft:runAction(moveLeft)
			noderight:runAction(moveRight)
			transition.scaleTo(play, {scale = 0, time = 0.4})

  			self:dispatchEvent({name = "Resumefunc"})

  			self:performWithDelay(function ()
  				self:removeFromParent()
  			end, 0.4)
    end return true;end)
	transition.scaleTo(play, {scale = 1.05, time = 0.4})
---------------------------------------------------------------------------------------------------------
	local moveLeft = cc.MoveTo:create(0.4, cc.p(-320,0))
	local moveRight = cc.MoveTo:create(0.4, cc.p(320,0))
	nodeleft:runAction(moveLeft)
	noderight:runAction(moveRight)
    

	local da = cc.Director:getInstance():getEventDispatcher()--获取分发中心
	local ls = cc.EventListenerTouchOneByOne:create()		--创建监听器
	ls:registerScriptHandler(function ( touch,event )
		return true end , cc.Handler.EVENT_TOUCH_BEGAN)
	ls:registerScriptHandler(function ()
	 end , cc.Handler.EVENT_TOUCH_MOVED)
	ls:registerScriptHandler(function ( touch,event )
		end,cc.Handler.EVENT_TOUCH_ENDED)
	ls:setSwallowTouches(true)
	da:addEventListenerWithSceneGraphPriority(ls, noderight)
	
end
return Pauselayer