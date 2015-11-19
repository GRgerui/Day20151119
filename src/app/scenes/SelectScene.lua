local SelectScene = class("SelectScene", function ( )
	return display.newScene("SelectScene")
end)
function SelectScene:ctor( )
	
	self:init()
end
function SelectScene:init( )
	--keyPad
    self:setKeypadEnabled(true)
    self:addNodeEventListener(cc.KEYPAD_EVENT , function(event)
        if event.key == "back" then
            if StartScene.isTime==1 then
                self.message = MessageBox.new()
                self.message:setPosition(cc.p(0, 0))
                self:addChild(self.message,10)
                StartScene.isTime = 2
            elseif StartScene.isTime==2 then
                if self.message then
                    self.message:removeFromParent()
                end
                StartScene.isTime = 1
            end
        end
    end)
	--背景
	local bg = display.newSprite("Choosegbackground.png")
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScaleX(scaleX)
	bg:setScaleY(scaleY)
	bg:setPosition(display.cx, display.cy)
	self:addChild(bg)
	--星星Label
	self:LabelStarNum()
	--返回按钮
	self:BackButton()
	self:SelectSceneNode()
end
function SelectScene:SelectSceneNode( )
	--创建节点
	local node = display.newNode()
	node:setPosition(display.cx,display.cy+100)
	node:addTo(self)
	local jump = cc.JumpTo:create(1.0, cc.p(display.cx,display.cy), 50, 2)
	node:runAction(jump)
	--春天 1
	local item1 = cc.ui.UIPushButton.new()
	item1:setButtonImage(cc.ui.UIPushButton.NORMAL,"#level_1_Normal.png", nil)
	item1:setButtonImage(cc.ui.UIPushButton.PRESSED,"#level_1_Selected.png", nil)
	item1:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name=="ended" then
			print("场景1")
			ModifyData.setSceneNum(1)
			HeroData.MusicSound()

			local scene = cc.TransitionFade:create(1.0, SelectChapter.new())
			cc.Director:getInstance():replaceScene(scene)
		end
		return true
	end)
	item1:setPosition(cc.p(-250,0))
	item1:addTo(node)
	--秋天 2
	local item2 = cc.ui.UIPushButton.new()
	item2:setButtonImage(cc.ui.UIPushButton.NORMAL,"#level_2_Normal.png", nil)
	item2:setButtonImage(cc.ui.UIPushButton.PRESSED,"#level_2_Selected.png", nil)
	item2:setButtonImage(cc.ui.UIPushButton.DISABLED,"#level_2_Ban.png", nil)
	item2:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name=="ended" then
			print("场景2")
			ModifyData.setSceneNum(2)
			HeroData.MusicSound()

			local scene = cc.TransitionFade:create(1.0, SelectChapter.new())
			cc.Director:getInstance():replaceScene(scene)
		end
		return true
	end)
	item2:setPosition(cc.p(0,0))
	item2:addTo(node)
	--冬天 3
	local item3 = cc.ui.UIPushButton.new()
	item3:setButtonImage(cc.ui.UIPushButton.NORMAL,"#level_3_Normal.png", nil)
	item3:setButtonImage(cc.ui.UIPushButton.PRESSED,"#level_3_Selected.png", nil)
	item3:setButtonImage(cc.ui.UIPushButton.DISABLED,"#level_3_Ban.png", nil)
	item3:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
		if event.name=="ended" then
			print("场景3")
			ModifyData.setSceneNum(3)
			HeroData.MusicSound()
			local scene = cc.TransitionFade:create(1.0, SelectChapter.new())
			cc.Director:getInstance():replaceScene(scene)
		end
		return true
	end)
	item3:setPosition(cc.p(250,0))
	item3:addTo(node)
	--根据星星数 加以判断 是否解锁
	if CSData.getAllStarNum()<15 then
		item2:setButtonEnabled(false)
		item3:setButtonEnabled(false)
		elseif CSData.getAllStarNum()<30 then
		item3:setButtonEnabled(false)
	end
	
	
end
function SelectScene:LabelStarNum()
	--星星精灵
	local starSp = display.newSprite("#star.png",display.cx,50)
	starSp:setScale(0.5)
	starSp:addTo(self)
	--星星总数
	local starlabel = cc.ui.UILabel.new({
		UILabelType = 1,
		text = CSData.getAllStarNum(), --底层Data中星星数赋值
		font = "NumFont.fnt",
    	size = 28,
    	align = cc.ui.TEXT_ALIGN_CENTER -- 文字内部居中对齐
		})
	starlabel:setPosition(cc.p(display.cx+30,50))
	starlabel:addTo(self)
end
function SelectScene:BackButton()
    local pushbutton = cc.ui.UIPushButton.new({normal="#backButton_1.png",pressed="#backButton_2.png"},{scale9=true})
    pushbutton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then 
        elseif event.name=="moved" then 
        elseif event.name=="ended" then
        	if HeroData.Data.isPlaySound then
        		audio.playSound("close.mp3")
    		end
            local startscene = StartScene.new()
            local s = cc.TransitionFade:create(1.0, startscene)
            cc.Director:getInstance():replaceScene(s)
        end return true;end)
    --pushbutton:setScale(0.5)
    pushbutton:setPosition(100,100)
    self:addChild(pushbutton)
end
return SelectScene