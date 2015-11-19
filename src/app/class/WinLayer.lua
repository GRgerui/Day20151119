local  WinLayer = class("WinLayer", function()
	return display.newColorLayer(cc.c4b(100, 100, 100, 0))
end)

function WinLayer:ctor()
	self:init()
end
function WinLayer:init()
	local png = "resultLayer.png"
	local  plist = "resultLayer.plist"
	display.addSpriteFrames(plist,png)

	local blackbg = display.newSprite("#bgTitle.png")
	blackbg:setPosition(display.cx,display.cy)
	blackbg:setScaleY(0.8)
	self:addChild(blackbg)
	local bg = display.newSprite("#victory.png")
	bg:setPosition(display.cx,display.cy+140)
	bg:setScale(0.8)
	self:addChild(bg,1)

	--星标题
	local starSp = display.newSprite("#starAdd.png",display.cx-30,display.cy+40)
	starSp:setScale(0.8)
	starSp:addTo(self,1)
	--技能点标题
	local SdSp = display.newSprite("#powerBallAdd.png",display.cx-30,display.cy-30)
	SdSp:setScale(0.8)
	SdSp:addTo(self,1)
	--星星数
	local starlabel = cc.Label:createWithCharMap("num_redyellow.png",30,32,48)
	starlabel:setString(ModifyData.getStarNum())
	starlabel:setPosition(display.cx+25, display.cy+33)
	starlabel:addTo(self,2)
	--技能点数
	local SDlabel = cc.Label:createWithCharMap("num_redyellow.png",30,32,48)
	SDlabel:setString(ModifyData.getSD())
	SDlabel:setPosition(display.cx+25, display.cy-36)
	SDlabel:addTo(self,2)
--Next游戏
	local nextbutton = cc.ui.UIPushButton.new({normal="#nextNormal.png",pressed="#nextSelected.png",disabled="#nextOver.png"})
	nextbutton:setScale(0.6)
	nextbutton:setPosition(display.cx+180,display.cy-150)
	self:addChild(nextbutton,10)
	nextbutton:onButtonClicked(function()
	cc.Director:getInstance():resume()
	HeroData.MusicSound()
	ModifyData.setChapterNum(ModifyData.getChapterNum()+1) 

	local gamescene = GameScene.new()
	local s = cc.TransitionFade:create(1.0, gamescene)
	cc.Director:getInstance():replaceScene(s)
	end)
	if ModifyData.getChapterNum()>4 then
		nextbutton:setButtonEnabled(false)
	end
		
-- 重新开始游戏
local againbutton = cc.ui.UIPushButton.new({normal="#againNormal.png",pressed="#againSelected.png"})
	againbutton:setPosition(display.cx+60,display.cy-150)
	againbutton:setScale(0.6)
	self:addChild(againbutton,10)
	againbutton:onButtonClicked(function()
  	cc.Director:getInstance():resume()
  	local gamescene = GameScene.new()
	local s = cc.TransitionFade:create(1.0, gamescene)
	cc.Director:getInstance():replaceScene(s)
	HeroData.MusicSound()
end)

-- 技能商店
local jinengbtn = cc.ui.UIPushButton.new({normal="#shopNormal.png",pressed="#shopSelected.png"})
	jinengbtn:setPosition(display.cx-180,display.cy-150)
	jinengbtn:setScale(0.6)
	self:addChild(jinengbtn,10)
	jinengbtn:onButtonClicked(function()
  	cc.Director:getInstance():resume()

  	local x = SkillLayer.new()
  	cc.Director:getInstance():replaceScene(x)

  	HeroData.MusicBack()
  	HeroData.MusicSound()
end)

-- 返回
local backbtn = cc.ui.UIPushButton.new({normal="#backNormal.png",pressed="#backSelected.png"})
	backbtn:setPosition(display.cx-60,display.cy-150)
	backbtn:setScale(0.6)
	self:addChild(backbtn,10)
	backbtn:onButtonClicked(function()
  	cc.Director:getInstance():resume()
  		if HeroData.Data.isPlaySound then
        	audio.playSound("close.mp3")
    	end
  		-- 音乐
    	HeroData.MusicBack()

  		local selectchapter = SelectChapter.new()
		local s = cc.TransitionFade:create(1.2, selectchapter)
		cc.Director:getInstance():replaceScene(s)
end)

end

function WinLayer:onExit()
		self:removeAllNodeEventListeners()
end

return WinLayer