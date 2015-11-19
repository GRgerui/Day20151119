local SetLayer = class("SetLayer", function()
	return display.newColorLayer(cc.c4b(100, 100, 100, 0))
end)

function SetLayer:ctor()
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
	self:init()
end

SetLayer.SLIDER_IMAGES = {
    bar = "#bgBar.png",
    button = "#unchecked.png",
}
function SetLayer:init()
	--面板
	local bg = display.newSprite("#BGPicSet.png")
    local scaleX = display.width/bg:getContentSize().width
    local scaleY = display.height/bg:getContentSize().height
    bg:setScaleX(scaleX)
    bg:setScaleY(scaleY)
	bg:setPosition(cc.p(display.cx, display.cy))
	self:addChild(bg)
	--音乐开关
	cc.ui.UICheckBoxButton.new({on = "#Hook.png",off = "#closeSetNormal.png"})
        :pos(display.cx-360, display.cy+100)
        :setButtonSelected(HeroData.Data.isPlayMusic)
        :onButtonStateChanged(function(event)
            HeroData.MusicSound()	--音效
        	if event.state == "on" then
        		HeroData.Data.isPlayMusic = true
                audio.playMusic("menubackmusic.mp3",true)
				audio.resumeMusic()
			elseif  event.state == "off" then
				HeroData.Data.isPlayMusic = false
				audio.pauseMusic()
			end
        	end)
        :addTo(self,4)
    --音效开关
	cc.ui.UICheckBoxButton.new({on = "#Hook.png",off = "#closeSetNormal.png"})
        :pos(display.cx-360,display.cy)
        :setButtonSelected(HeroData.Data.isPlaySound)
        :onButtonStateChanged(function(event)
            HeroData.MusicSound() --音效
        	if event.state == "on" then
        		HeroData.Data.isPlaySound = true
                print("写入文件")
                --ModifyData.WriteDataToDocHero( HeroData.Data )
				audio.playSound("yinxiao.wav", false)
			elseif  event.state == "off" then
				HeroData.Data.isPlaySound = false
                print("写入文件")
                --ModifyData.WriteDataToDocHero( HeroData.Data )
			end
			end)
        :addTo(self,4)
	--音量控制滑块
	cc.ui.UISlider.new(display.LEFT_TO_RIGHT, SetLayer.SLIDER_IMAGES, {scale9 = true})
        :onSliderValueChanged(function(event)

            audio.setMusicVolume(event.value/100)
            
        end)
        :setSliderSize(450, 40)
        :setSliderValue(70)--默认音量70
        :align(display.LEFT_BOTTOM, 100, bg:getContentSize().height/2-50) 	--align 停靠方式   X方向位置 Y方向位置
        :addTo(bg)
        :setPosition(390, display.cy+60)

    -- local Sp1 = display.newSprite("#bgBar.png")
    -- local Sp2 = display.newSprite("#unchecked.png")
    -- local Sp3 = display.newSprite("#progressBar.png")
    -- local SildMuisc = cc.ControlSlider:create(Sp1, Sp3, Sp2)
    -- SildMuisc:addNodeEventListener(cc.NODE_EVENT,function( event )
    --     print(111)
    --     return true
    -- end)
    -- SildMuisc:setAnchorPoint(cc.p(0,0))
    -- SildMuisc:setMinimumValue(0)
    -- SildMuisc:setMaximumValue(100)
    -- SildMuisc:setPosition(380, display.cy+70)
    -- SildMuisc:setScale(0.9)
    -- SildMuisc:addTo(self)

    --音效控制滑块
	cc.ui.UISlider.new(display.LEFT_TO_RIGHT, SetLayer.SLIDER_IMAGES, {scale9 = true})
        :onSliderValueChanged(function(event)

            audio.setSoundsVolume(event.value/100)

        end)
        :setSliderSize(450, 40)
        :setSliderValue(70)--默认音量70
        :align(display.LEFT_BOTTOM, 100, bg:getContentSize().height/2-50) 	--align 停靠方式   X方向位置 Y方向位置
        :addTo(bg)
        :setPosition(390, display.cy-40)

    --保存设置
    local SeveBu=cc.ui.UIPushButton.new({normal="#SaveSettings.png",pressed="SaveSelected.png"},{scale9=true})
        :onButtonClicked(function (event)
            if HeroData.Data.isPlaySound then
                audio.playSound("close.mp3")
            end
        	self:removeFromParent() 
            print("读出")
            ModifyData.WriteDataToDocHero( HeroData.Data )
            HeroData.Data = ModifyData.ReadDataToDocHero()
        end)
        :pos(display.cx-110,display.cy-200)
        :addTo(bg)
end

return SetLayer