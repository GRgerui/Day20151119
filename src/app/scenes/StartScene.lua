local StartScene = class("StartScene", function ( )
	return display.newScene("StartScene")
end)
StartScene.isTime = 1
function StartScene:ctor( )
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
	print("StartScene")
    local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
    if cc.FileUtils:getInstance():isFileExist(docpath)==false then
        print("写入")
        --写入文件
        ModifyData.WriteDataToDoc( CSData.SCENE )
        else
        print("读出")
        --读出文件 场景关卡文件
        CSData.SCENE = ModifyData.ReadDataToDoc()
    end

    local docpath = cc.FileUtils:getInstance():getWritablePath().."herodata.txt"
    if cc.FileUtils:getInstance():isFileExist(docpath)==false then
        --写入文件
        ModifyData.WriteDataToDocHero( HeroData.Data )
        else
        HeroData.Data = ModifyData.ReadDataToDocHero()
    end

	self:init()
end
function StartScene:init( )
	--背景
	local bg = display.newSprite("menubackground.png")
	local scaleX = display.width/bg:getContentSize().width
    local scaleY = display.height/bg:getContentSize().height
    bg:setScaleX(scaleX)
    bg:setScaleY(scaleY)
    bg:setPosition(display.cx, display.cy)
    self:addChild(bg)
	--按钮
    self:BubbleButton()
    --下雪
    self.snow = cc.ParticleSnow:create()
    self.snow:setPosition(cc.p(display.cx,display.top))
    self.snow:addTo(self)
end
function StartScene:BubbleButton()
    --闯关按钮
    local pushbutton = cc.ui.UIPushButton.new({normal="#EmigratedNormal.png",pressed="#EmigratedSelected.png"},{scale9=true})
    pushbutton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then
        elseif event.name=="moved" then
        elseif event.name=="ended" then
            HeroData.MusicSound()
            local selectscene = SelectScene.new()
            local s = cc.TransitionFade:create(1.0, selectscene)
            cc.Director:getInstance():replaceScene(s)
        end return true;end)
    --pushbutton:setScale(0.5)
    pushbutton:setPosition(display.cx-200,display.cy-200)
    self:addChild(pushbutton)
    --设置按钮
    local pushbutton1 = cc.ui.UIPushButton.new({normal="#SetNormal.png",pressed="#SetSelected.png"},{scale9=true})
    pushbutton1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then
        elseif event.name=="moved" then
        elseif event.name=="ended"  then
            HeroData.MusicSound()
            local setLayer = SetLayer.new()
            setLayer:addTo(self)
        end
        return true;end)
    --pushbutton1:setScale(0.8)
    pushbutton1:setPosition(display.right-100,display.top-400)
    self:addChild(pushbutton1)
    --技能按钮
    local pushbutton3 = cc.ui.UIPushButton.new({normal="#CheatsNormal.png",pressed="#CheatsSelected.png"},{scale9=true})
    pushbutton3:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then
        elseif event.name=="moved" then
        elseif event.name=="ended" then
            HeroData.MusicSound()
            local skillLayer = SkillLayer.new()
            cc.Director:getInstance():replaceScene(skillLayer)
        end
        return true;end)
    --pushbutton3:setScale(0.8)
    pushbutton3:setPosition(display.right-100,display.top-250)
    self:addChild(pushbutton3)
    --图鉴按钮
    local pushbutton2 = cc.ui.UIPushButton.new({normal="#PhotoGalleryNormal.png",pressed="#PhotoGallerySelected.png"},{scale9=true})
    pushbutton2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then
        elseif event.name=="moved" then
        elseif event.name=="ended" then
            print("图籍按钮...")
            HeroData.MusicSound()
            local tujian = Tujian.new()
            tujian:addTo(self)
        end
        return true;end)
    --pushbutton2:setScale(0.8)
    pushbutton2:setPosition(display.right-100,display.top-100)
    self:addChild(pushbutton2)
end

function StartScene:onEnter()
    if HeroData.Data.isPlayMusic==true and not audio.isMusicPlaying()  then
        audio.preloadMusic("menubackmusic.mp3")
        audio.playMusic("menubackmusic.mp3",true)
        audio.setMusicVolume(0.75)
    end
end

function StartScene:onExit()
    self.snow:removeFromParent()
end
return StartScene