local  SkillLayer = class("SkillLayer", function()
	return display.newScene("SkillLayer")
end)
function SkillLayer:ctor()
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
	local docpath = cc.FileUtils:getInstance():getWritablePath().."herodata.txt"
    if cc.FileUtils:getInstance():isFileExist(docpath)==true then
        HeroData.Data = ModifyData.ReadDataToDocHero()
    end
	key = 0
	self.SD = HeroData.Data.SD-(HeroData.Data.HPSD+HeroData.Data.ACSD+HeroData.Data.P1SD+HeroData.Data.P2SD+HeroData.Data.P3SD+HeroData.Data.P4SD)
	self:init()
	if self.SD == 0 then
		self.addHp:setButtonEnabled(false)
		self.addAc:setButtonEnabled(false)
		self.addP1:setButtonEnabled(false)
		self.addP2:setButtonEnabled(false)
		self.addP3:setButtonEnabled(false)
		self.addP4:setButtonEnabled(false)
	end
	if HeroData.Data.HPSD==7 then
	 	self.addHp:setButtonEnabled(false)
	end
	if HeroData.Data.ACSD==7 then
		self.addAc:setButtonEnabled(false)
	end
	if HeroData.Data.P1SD==7 then
		self.addP1:setButtonEnabled(false)
	end
	if HeroData.Data.P2SD==7 then
		self.addP2:setButtonEnabled(false)
	end
	if HeroData.Data.P3SD==7 then
		self.addP3:setButtonEnabled(false)
	end
	if HeroData.Data.P4SD==7 then
		self.addP4:setButtonEnabled(false)
	end
end

function SkillLayer:init()
	local bg = display.newSprite("addBack.png")
	local scaleX = display.width/bg:getContentSize().width
    local scaleY = display.height/bg:getContentSize().height
    bg:setScaleX(scaleX)
    bg:setScaleY(scaleY)
    bg:setPosition(display.cx, display.cy)
    self:addChild(bg)

	local hpSp = display.newSprite("#hpButton.png", 140 ,560)
	hpSp:setScale(0.8)
	hpSp:addTo(self)

	local Ac = display.newSprite("#attack_button.png", 140 ,480)
	Ac:setScale(0.8)
	Ac:addTo(self)

	local P1 = display.newSprite("#1009_1_1.png", 140 ,400)
	P1:setScale(0.8)
	P1:addTo(self)

	local P2 = display.newSprite("#1009_2_1.png", 140 ,320)
	P2:setScale(0.8)
	P2:addTo(self)

	local P3 = display.newSprite("#1009_3_1.png", 140 ,240)
	P3:setScale(0.8)
	P3:addTo(self)

	local P4 = display.newSprite("#1009_4_1.png", 140 ,160)
	P4:setScale(0.8)
	P4:addTo(self)

	self:barSk() --技能bar
	self:addButton()
	self:powerNum() --攻击数值
	--self:BoolButtonTouch()
	

	self:BackButton() --返回
end
-- Data.HP = 1000 --血量
-- Data.MP = 200 --蓝量
-- Data.AC = 80  --攻击
-- Data.A1 = 180 --技能1
-- Data.A2 = 200 --技能2
-- Data.A3 = 160 --技能3
-- Data.A4 = 250 --技能4
function SkillLayer:addClickfunc(ck)
	if ck==1 then
		self.SD = self.SD - 1
		HeroData.Data.HPSD = HeroData.Data.HPSD + 1 

		HeroData.Data.HP = HeroData.Data.HP + 500
		self.Hpnum:setString(HeroData.Data.HP)

		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("powerBox_"..HeroData.Data.HPSD ..".png")
		self.hpBar:setSpriteFrame(frame)

		self.Sknum:setString(self.SD)
		self:BoolButtonTouch(1)
	elseif ck==2 then
		self.SD = self.SD - 1
		HeroData.Data.ACSD = HeroData.Data.ACSD + 1

		HeroData.Data.AC = HeroData.Data.AC + 50
		self.Acnum:setString(HeroData.Data.AC)

		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("powerBox_"..HeroData.Data.ACSD ..".png")
		self.AcBar:setSpriteFrame(frame)

		self.Sknum:setString(self.SD)
		self:BoolButtonTouch(2)
	elseif ck==3 then
		self.SD = self.SD - 1
		HeroData.Data.P1SD = HeroData.Data.P1SD + 1

		HeroData.Data.A1 = HeroData.Data.A1 + 100
		self.P1num:setString(HeroData.Data.A1)

		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("powerBox_"..HeroData.Data.P1SD ..".png")
		self.P1Bar:setSpriteFrame(frame)

		self.Sknum:setString(self.SD)
		self:BoolButtonTouch(3)
	elseif ck==4 then
		self.SD = self.SD - 1
		HeroData.Data.P2SD = HeroData.Data.P2SD + 1

		HeroData.Data.A2 = HeroData.Data.A2 + 80
		self.P2num:setString(HeroData.Data.A2)

		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("powerBox_"..HeroData.Data.P2SD ..".png")
		self.P2Bar:setSpriteFrame(frame)

		self.Sknum:setString(self.SD)
		self:BoolButtonTouch(4)
	elseif ck==5 then
		self.SD = self.SD - 1
		HeroData.Data.P3SD = HeroData.Data.P3SD + 1

		HeroData.Data.A3 = HeroData.Data.A3 + 80
		self.P3pnum:setString(HeroData.Data.A3)

		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("powerBox_"..HeroData.Data.P3SD ..".png")
		self.P3Bar:setSpriteFrame(frame)

		self.Sknum:setString(self.SD)
		self:BoolButtonTouch(5)
	elseif ck==6 then
		self.SD = self.SD - 1
		HeroData.Data.P4SD = HeroData.Data.P4SD + 1

		HeroData.Data.A4 = HeroData.Data.A4 + 80
		self.P4num:setString(HeroData.Data.A4)

		local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("powerBox_"..HeroData.Data.P4SD ..".png")
		self.P4Bar:setSpriteFrame(frame)

		self.Sknum:setString(self.SD)
		self:BoolButtonTouch(6)
	end
end
function SkillLayer:addButton()
	self.addHp = cc.ui.UIPushButton.new({normal="#buy_1.png",pressed="#buy_2.png",disabled="#buy_3.png"})
	self.addHp:setPosition(900 ,560)
	self.addHp:setScale(0.8)
	self:addChild(self.addHp,2)
	self.addHp:onButtonClicked(function()
		key = key + 1
  		self:addClickfunc(1)
  		HeroData.MusicSound()
	end)

	self.addAc = cc.ui.UIPushButton.new({normal="#buy_1.png",pressed="#buy_2.png",disabled="#buy_3.png"})
	self.addAc:setPosition(900 ,480)
	self.addAc:setScale(0.8)
	self:addChild(self.addAc,2)
	self.addAc:onButtonClicked(function()
		key = key + 1
  		self:addClickfunc(2)
  		HeroData.MusicSound()
	end)

	self.addP1 = cc.ui.UIPushButton.new({normal="#buy_1.png",pressed="#buy_2.png",disabled="#buy_3.png"})
	self.addP1:setPosition(900 ,400)
	self.addP1:setScale(0.8)
	self:addChild(self.addP1,2)
	self.addP1:onButtonClicked(function()
		key = key + 1
  		self:addClickfunc(3)
  		HeroData.MusicSound()
	end)

	self.addP2 = cc.ui.UIPushButton.new({normal="#buy_1.png",pressed="#buy_2.png",disabled="#buy_3.png"})
	self.addP2:setPosition(900 ,320)
	self.addP2:setScale(0.8)
	self:addChild(self.addP2,2)
	self.addP2:onButtonClicked(function()
		key = key + 1
  		self:addClickfunc(4)
  		HeroData.MusicSound()
	end)

	self.addP3 = cc.ui.UIPushButton.new({normal="#buy_1.png",pressed="#buy_2.png",disabled="#buy_3.png"})
	self.addP3:setPosition(900 ,240)
	self.addP3:setScale(0.8)
	self:addChild(self.addP3,2)
	self.addP3:onButtonClicked(function()
		key = key + 1
  		self:addClickfunc(5)
  		HeroData.MusicSound()
	end)

	self.addP4 = cc.ui.UIPushButton.new({normal="#buy_1.png",pressed="#buy_2.png",disabled="#buy_3.png"})
	self.addP4:setPosition(900 ,160)
	self.addP4:setScale(0.8)
	self:addChild(self.addP4,2)
	self.addP4:onButtonClicked(function()
		key = key + 1
  		self:addClickfunc(6)
		HeroData.MusicSound()
	end)
	local xx = 0
	if HeroData.Data.SD/6==0 then
		xx = 0
	elseif HeroData.Data.SD/6<=1 then
		xx = 1
	elseif HeroData.Data.SD/6<=2 then
		xx = 2
	elseif HeroData.Data.SD/6<=3 then
		xx = 3
	elseif HeroData.Data.SD/6<=4 then
		xx = 4
	elseif HeroData.Data.SD/6<=5 then
		xx = 5
	elseif HeroData.Data.SD/6<=6 then
		xx = 6
	elseif HeroData.Data.SD/6<=7 then
		xx = 7
	else
		xx = 7
	end

	if HeroData.Data.HPSD>=xx then
	 	self.addHp:setButtonEnabled(false)
	end
	if HeroData.Data.ACSD>=xx then
		self.addAc:setButtonEnabled(false)
	end
	if HeroData.Data.P1SD>=xx then
		self.addP1:setButtonEnabled(false)
	end
	if HeroData.Data.P2SD>=xx then
		self.addP2:setButtonEnabled(false)
	end
	if HeroData.Data.P3SD>=xx then
		self.addP3:setButtonEnabled(false)
	end
	if HeroData.Data.P4SD>=xx then
		self.addP4:setButtonEnabled(false)
	end
	

end
function SkillLayer:BoolButtonTouch(bt)
	if self.SD == 0 then
		self.addHp:setButtonEnabled(false)
		self.addAc:setButtonEnabled(false)
		self.addP1:setButtonEnabled(false)
		self.addP2:setButtonEnabled(false)
		self.addP3:setButtonEnabled(false)
		self.addP4:setButtonEnabled(false)
	end

	local xx = 0
	if HeroData.Data.SD/6==0 then
		xx = 0
	elseif HeroData.Data.SD/6<=1 then
		xx = 1
	elseif HeroData.Data.SD/6<=2 then
		xx = 2
	elseif HeroData.Data.SD/6<=3 then
		xx = 3
	elseif HeroData.Data.SD/6<=4 then
		xx = 4
	elseif HeroData.Data.SD/6<=5 then
		xx = 5
	elseif HeroData.Data.SD/6<=6 then
		xx = 6
	elseif HeroData.Data.SD/6<=7 then
		xx = 7
	else
		xx = 7
	end
	if HeroData.Data.HPSD>=xx then
	 	self.addHp:setButtonEnabled(false)
	end
	if HeroData.Data.ACSD>=xx then
		self.addAc:setButtonEnabled(false)
	end
	if HeroData.Data.P1SD>=xx then
		self.addP1:setButtonEnabled(false)
	end
	if HeroData.Data.P2SD>=xx then
		self.addP2:setButtonEnabled(false)
	end
	if HeroData.Data.P3SD>=xx then
		self.addP3:setButtonEnabled(false)
	end
	if HeroData.Data.P4SD>=xx then
		self.addP4:setButtonEnabled(false)
	end

	if self.SD ~= 0 and key == 6 then
			key = 0
	if HeroData.Data.HPSD~=7 and HeroData.Data.HPSD<xx then
	 	self.addHp:setButtonEnabled(true)
	end
	if HeroData.Data.ACSD~=7 and HeroData.Data.ACSD<xx then
		self.addAc:setButtonEnabled(true)
	end
	if HeroData.Data.P1SD~=7 and HeroData.Data.P1SD<xx then
		self.addP1:setButtonEnabled(true)
	end
	if HeroData.Data.P2SD~=7 and HeroData.Data.P2SD<xx then
		self.addP2:setButtonEnabled(true)
	end
	if HeroData.Data.P3SD~=7 and HeroData.Data.P3SD<xx then
		self.addP3:setButtonEnabled(true)
	end
	if HeroData.Data.P4SD~=7 and HeroData.Data.P4SD<xx then
		self.addP4:setButtonEnabled(true)
	end
	end
end
function SkillLayer:barSk()
 	self.hpBar = display.newSprite("#powerBox_"..HeroData.Data.HPSD ..".png", 600 ,560)
	self.hpBar:setScale(0.8)
	self.hpBar:addTo(self)

	self.AcBar = display.newSprite("#powerBox_"..HeroData.Data.ACSD ..".png", 600 ,480)
	self.AcBar:setScale(0.8)
	self.AcBar:addTo(self)

	self.P1Bar = display.newSprite("#powerBox_"..HeroData.Data.P1SD ..".png", 600 ,400)
	self.P1Bar:setScale(0.8)
	self.P1Bar:addTo(self)

	self.P2Bar = display.newSprite("#powerBox_"..HeroData.Data.P2SD ..".png", 600 ,320)
	self.P2Bar:setScale(0.8)
	self.P2Bar:addTo(self)

	self.P3Bar = display.newSprite("#powerBox_"..HeroData.Data.P3SD ..".png", 600 ,240)
	self.P3Bar:setScale(0.8)
	self.P3Bar:addTo(self)

	self.P4Bar = display.newSprite("#powerBox_"..HeroData.Data.P4SD ..".png", 600 ,160)
	self.P4Bar:setScale(0.8)
	self.P4Bar:addTo(self)
end 
function SkillLayer:powerNum()

	self.Hpnum = cc.Label:createWithCharMap("num_text_blue.png",30,34,48)
	self.Hpnum:setString(HeroData.Data.HP)
	self.Hpnum:setPosition(250, 565)
	self.Hpnum:addTo(self,2)

	self.Acnum = cc.Label:createWithCharMap("num_text_blue.png",30,34,48)
	self.Acnum:setString(HeroData.Data.AC)
	self.Acnum:setPosition(250, 485)
	self.Acnum:addTo(self,2)

	self.P1num = cc.Label:createWithCharMap("num_text_blue.png",30,34,48)
	self.P1num:setString(HeroData.Data.A1)
	self.P1num:setPosition(250, 405)
	self.P1num:addTo(self,2)

	self.P2num = cc.Label:createWithCharMap("num_text_blue.png",30,34,48)
	self.P2num:setString(HeroData.Data.A2)
	self.P2num:setPosition(250, 325)
	self.P2num:addTo(self,2)

	self.P3pnum = cc.Label:createWithCharMap("num_text_blue.png",30,34,48)
	self.P3pnum:setString(HeroData.Data.A3)
	self.P3pnum:setPosition(250, 245)
	self.P3pnum:addTo(self,2)

	self.P4num = cc.Label:createWithCharMap("num_text_blue.png",30,34,48)
	self.P4num:setString(HeroData.Data.A4)
	self.P4num:setPosition(250, 165)
	self.P4num:addTo(self,2)

	--技能标志与数量
	local Skbg = display.newSprite("#powerBall.png", 450 ,50)
	Skbg:setScale(0.8)
	Skbg:addTo(self)
	self.Sknum = cc.Label:createWithCharMap("num_redyellow.png",30,32,48)
	self.Sknum:setString(self.SD)
	self.Sknum:setPosition(540, 50)
	self.Sknum:addTo(self,2)
end
function SkillLayer:BackButton()
    local pushbutton = cc.ui.UIPushButton.new({normal="#backButton_1.png",pressed="#backButton_2.png"},{scale9=true})
    pushbutton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name=="began" then
        elseif event.name=="moved" then
        elseif event.name=="ended" then
        	if HeroData.Data.isPlaySound then
        		audio.playSound("close.mp3")
    		end
    		HeroData.MusicBack()

    		ModifyData.WriteDataToDoc( CSData.SCENE )

    		ModifyData.WriteDataToDocHero( HeroData.Data )

            local startscene = StartScene.new()
            local s = cc.TransitionFade:create(1.0, startscene)
            cc.Director:getInstance():replaceScene(s)
        end return true;end)
    pushbutton:setScale(0.8)
    pushbutton:setPosition(70,70)
    self:addChild(pushbutton)
end
function SkillLayer:onEnter()
end
function SkillLayer:onExit()
	
end
return SkillLayer