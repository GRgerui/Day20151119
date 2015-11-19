local  LoseLayer = class("LoseLayer", function()

return display.newColorLayer(cc.c4b(100, 100, 100, 0))
end)

function LoseLayer:ctor()
self:init()
end
function LoseLayer:init()
	local png = "resultLayer.png"
	local plist = "resultLayer.plist"
	display.addSpriteFrames(plist,png)

	local heiping = display.newSprite("#heiping.png")--黑屏图片
	heiping:setPosition(display.cx,display.cy-100)
	self:addChild(heiping)

	local bg = display.newSprite("#faliure.png")--失败图片
	bg:setPosition(display.cx,display.cy+80)
	self:addChild(bg,1)

	local dianji = display.newSprite("#tipsNext.png")--点击图片
	dianji:setPosition(display.cx,display.cy-300)
	self:addChild(dianji,2)

	local d = cc.Director:getInstance():getEventDispatcher()--获取分发中心
	local l = cc.EventListenerTouchOneByOne:create()		--创建监听器
	l:registerScriptHandler(function ( touch,event )
		return true end , cc.Handler.EVENT_TOUCH_BEGAN)
	l:registerScriptHandler(function ()
	 end , cc.Handler.EVENT_TOUCH_MOVED)
	l:registerScriptHandler(function ( touch,event )
			if HeroData.Data.isPlaySound then
        		audio.playSound("close.mp3")
    		end
    		-- 音乐
    		HeroData.MusicBack()
			local selectchapter = SelectChapter.new()
			local s = cc.TransitionFade:create(1.2, selectchapter)
			cc.Director:getInstance():replaceScene(s)
		end,cc.Handler.EVENT_TOUCH_ENDED)
	l:setSwallowTouches(true)
	d:addEventListenerWithSceneGraphPriority(l, self)

end
function LoseLayer:onExit()
		self:removeAllNodeEventListeners()
end
return LoseLayer