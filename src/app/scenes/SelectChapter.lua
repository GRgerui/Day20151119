local SelectChapter = class("SelectChapter", function ( )
	return display.newScene("SelectChapter")
end)
function SelectChapter:ctor( )
	self:init()
end
function SelectChapter:init( )
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
	--print(ModifyData.getSceneNum())
	local bg = display.newSprite("gatebackground_"..ModifyData.getSceneNum() ..".png")
	local scaleX = display.width/bg:getContentSize().width
	local scaleY = display.height/bg:getContentSize().height
	bg:setScaleX(scaleX)
	bg:setScaleY(scaleY)
	bg:setPosition(display.cx, display.cy)
	self:addChild(bg)
	--back按钮
	self:BackButton()
	--关卡百叶视图
	self:ChapterView()
end
function SelectChapter:ChapterView()
	--print("关卡百叶视图")
	local SceneNum = ModifyData.getSceneNum()
	local Tmp = nil
	local TableNormal5 = {}
	local TablSelected5 = {}
	local TabLock = {}

if SceneNum==1 then
	for k,v in pairs(CSData.SCENE[SceneNum]) do
		local starnum = v.star
		local locknum = v.lock
		if starnum~=0 then
			Tmp = "#level_"..k .."_star_"..starnum ..".png"
		elseif locknum == 1 then--解锁
			Tmp = "#level_"..k .."_star_"..starnum ..".png"
		else
			Tmp = "#level_"..k .."_star_ban.png"
		end
		table.insert(TableNormal5,#TableNormal5+1,Tmp) --#TableNormal5长度
		table.insert(TablSelected5,#TablSelected5+1,Tmp)
		table.insert(TabLock,#TabLock+1,locknum)
	end
elseif SceneNum==2 then
	for k,v in pairs(CSData.SCENE[SceneNum]) do
		local starnum = v.star
		local locknum = v.lock
		if starnum~=0 then
			Tmp = "#level_"..k+5 .."_star_"..starnum ..".png"
		elseif locknum == 1 then
			Tmp = "#level_"..k+5 .."_star_"..starnum ..".png"
		else
			Tmp = "#level_"..k+5 .."_star_ban.png"
		end
		table.insert(TableNormal5,#TableNormal5+1,Tmp)
		table.insert(TablSelected5,#TablSelected5+1,Tmp)
		table.insert(TabLock,#TabLock+1,locknum)
	end
elseif SceneNum==3 then
	for k,v in pairs(CSData.SCENE[SceneNum]) do 
		local starnum = v.star
		local locknum = v.lock
		if starnum~=0 then
			Tmp = "#level_"..k+10 .."_star_"..starnum ..".png"
			--print("if")
		elseif locknum == 1 then
			--print("elseif")
			Tmp = "#level_"..k+10 .."_star_"..starnum ..".png"
		else
			--print("else")
			Tmp = "#level_"..k+10 .."_star_ban.png"
		end
		table.insert(TableNormal5,#TableNormal5+1,Tmp)
		table.insert(TablSelected5,#TablSelected5+1,Tmp)
		table.insert(TabLock,#TabLock+1,locknum)
	end
end
--5个关卡
local RscView5 = RotationScViewByMyself.new(TableNormal5,TablSelected5,{fun1,fun1,fun1,fun1,fun1},TabLock)
	RscView5:setPosition(480,260)
	self:addChild(RscView5)
end
--CSData.SCENE[ModifyData.getSceneNum()]
function fun1(chap)
	--boy1、boy2、boy3
	ModifyData.setChapterNum(chap)
	print("跳转场景GameScene")
	local gamescene = GameScene.new()
    local s = cc.TransitionFade:create(1.0, gamescene)
    cc.Director:getInstance():replaceScene(s)
end


function SelectChapter:BackButton()

    local pushbutton = cc.ui.UIPushButton.new({normal="#backButton_1.png",pressed="#backButton_2.png"},{scale9=true})
    pushbutton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then
        elseif event.name=="moved" then
        elseif event.name=="ended" then
        	if HeroData.Data.isPlaySound then
        		audio.playSound("close.mp3")
    		end
            local selectscene = SelectScene.new()
            local s = cc.TransitionFade:create(1.0, selectscene)
            cc.Director:getInstance():replaceScene(s)
        end return true;end)
    --pushbutton:setScale(0.5)
    pushbutton:setPosition(100,100)
    self:addChild(pushbutton)
end
return SelectChapter