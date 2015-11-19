local RotationScViewByMyself = class("RotationScViewByMyself", function() return display.newNode() end)
local clickFlag = true
table.insert(RotationScViewByMyself,"directionLeft")
table.insert(RotationScViewByMyself,"childNodes")
table.insert(RotationScViewByMyself,"childNodesPos")
table.insert(RotationScViewByMyself,"OnClickedFuncs")
table.insert(RotationScViewByMyself,"ButtonNum")
table.insert(RotationScViewByMyself,"ButtonConSize")
table.insert(RotationScViewByMyself,"coefficientX")
table.insert(RotationScViewByMyself,"coefficientY")

function RotationScViewByMyself:ctor(TableNormals,TablSelecteds,OnClickedFuncs,TabLock)
    self.childNodes = {}
    self.OnClickedFuncs = {}
    self.directionLeft = 0
    self.ButtonNum = 0
    self.childNodesPos = {}
    self.ButtonConSize = {width = 0,height = 0}
    self.coefficientX = 0
    self.coefficientY = 0
    if TableNormals == nil or TablSelecteds == nil then
        print("The pic isn't 5.")
       return nil
    end 
    self.lock = TabLock
    ---
    if #TableNormals == #TablSelecteds then
        self.ButtonNum = #TableNormals
    else
        return nil
    end
    ---
    if _coefficientX ~=nil then
        self.coefficientX = nil
    end

    if _coefficientY ~=nil then
        self.coefficientY = nil
    end
    ---
    self.OnClickedFuncs = clone(OnClickedFuncs)
    self:setAnchorPoint(cc.p(0.5,0.5))
    for i=1,self.ButtonNum do
        self.childNodes[i] = cc.ui.UIPushButton.new({normal=TableNormals[i],pressed=TablSelecteds[i]})
    end
    self.ButtonConSize["width"] = display.newSprite(TableNormals[1]):getContentSize().width
    self.ButtonConSize["height"] = display.newSprite(TableNormals[1]):getContentSize().height

    ---
    if self.ButtonNum == 5 then
        if self.coefficientX == 0 then
            self.coefficientX = 2.5
        end
        if self.coefficientY == 0 then
            self.coefficientY = 1.5
        end
        self.childNodesPos[1] = cc.p(0,0)
        self.childNodesPos[2] = cc.p(self.ButtonConSize["width"]/9*2*self.coefficientX*(-1),self.ButtonConSize["height"]/9*self.coefficientY)
        self.childNodesPos[3] = cc.p(self.ButtonConSize["width"]/9*self.coefficientX*(-1),self.ButtonConSize["height"]/9*2*self.coefficientY)
        self.childNodesPos[4] = cc.p(self.ButtonConSize["width"]/9*2*self.coefficientX,self.ButtonConSize["height"]/9*self.coefficientY)
        self.childNodesPos[5] = cc.p(self.ButtonConSize["width"]/9*self.coefficientX,self.ButtonConSize["height"]/9*2*self.coefficientY)
    else
        return nil
    end
    ---
    if self.ButtonNum == 5 then
        for i=1,self.ButtonNum do
            self.childNodes[i]:setPosition(self.childNodesPos[i])
            self.childNodes[i]:setAnchorPoint(cc.p(0.5,0.5))
            self.childNodes[i]:setTag(i)
            self.childNodes[i]:setScale(0.5)
            if i == 1 then
                self.childNodes[i]:setTouchEnabled(true)
                self.childNodes[i]:setOpacity(255)
                self.childNodes[i]:setLocalZOrder(3)
            elseif i == 3 or i == 5 then 
                self.childNodes[i]:setTouchEnabled(false)
                self.childNodes[i]:setOpacity(80)
                self.childNodes[i]:setLocalZOrder(2)
                --self.childNodes[i]:setScale(0.8, 0.8)
            elseif i == 2 or i == 4 then 
                self.childNodes[i]:setTouchEnabled(false)
                self.childNodes[i]:setOpacity(150)
                self.childNodes[i]:setLocalZOrder(1)
                --self.childNodes[i]:setScale(0.9, 0.9)
            end
            self.childNodes[i]:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.ThreeTouchCBack5))
            self:addChild(self.childNodes[i])
        end
    end
	---
	if OnClickedFuncs~=nil and #OnClickedFuncs ~= 0 and #OnClickedFuncs == self.ButtonNum then
		for i=1,#OnClickedFuncs do
			self.childNodes[i]:onButtonClicked(function()
                local t = CSData.SCENE[ModifyData.getSceneNum()][i]
                print("锁:".. t.lock)
                if clickFlag and t.lock == 1 then
                    print("星星:".. t.star)
                    -- i 关卡数 
                    self.OnClickedFuncs[i](i)
                    HeroData.MusicSound()
                else
                    return
                end
            end)
		end
	end 
    ---
    printf("_coefficientX = %f",self.coefficientX)
    printf("_coefficientY = %f",self.coefficientY)
    ---
end
function RotationScViewByMyself:ThreeTouchCBack5(event) --5个Button
	event.mode = cc.TOUCH_MODE_ONE_BY_ONE
	--
	local childNode1 = self:getChildByTag(1)
	local childNode2 = self:getChildByTag(2)
	local childNode3 = self:getChildByTag(3)
	local childNode4 = self:getChildByTag(4)
	local childNode5 = self:getChildByTag(5)
	--------
   	local touchOffsetByCenter = 0
   	---------
    if event.name == "ended" then
    	if self.directionLeft == 1 then
            childNode3:moveTo(0.2,self.childNodesPos[5].x,self.childNodesPos[5].y)
            childNode2:moveTo(0.2,self.childNodesPos[3].x,self.childNodesPos[3].y)
            childNode4:moveTo(0.2,self.childNodesPos[1].x,self.childNodesPos[1].y)
            childNode1:moveTo(0.2,self.childNodesPos[2].x,self.childNodesPos[2].y)
            childNode5:moveTo(0.2,self.childNodesPos[4].x,self.childNodesPos[4].y)
        
        	
        
            childNode3:setLocalZOrder(1)
        	childNode3:setTag(5)
        	childNode3:setOpacity(80)
        	-- childNode3:setScale(0.9, 0.9)
        	
            childNode2:setLocalZOrder(1)
        	childNode2:setTag(3)
        	childNode2:setOpacity(80)
        	-- childNode2:setScale(0.8, 0.8)
        	
            childNode4:setLocalZOrder(3)
        	childNode4:setTouchEnabled(true)
        	childNode4:setTag(1)
        	childNode4:setOpacity(255)
        	-- childNode4:setScale(1, 1)

        	childNode1:setTouchEnabled(false)
            childNode1:setLocalZOrder(2)
        	childNode1:setTag(2)
        	childNode1:setOpacity(150)
        	-- childNode1:setScale(0.8, 0.8)
        	
            childNode5:setLocalZOrder(2)
        	childNode5:setTag(4)
        	childNode5:setOpacity(150)
        	-- childNode5:setScale(0.9, 0.9)
        	
        elseif self.directionLeft == -1 then
            childNode3:moveTo(0.2,self.childNodesPos[2].x,self.childNodesPos[2].y)
            childNode2:moveTo(0.2,self.childNodesPos[1].x,self.childNodesPos[1].y)
            childNode4:moveTo(0.2,self.childNodesPos[5].x,self.childNodesPos[5].y)
            childNode1:moveTo(0.2,self.childNodesPos[4].x,self.childNodesPos[4].y)
            childNode5:moveTo(0.2,self.childNodesPos[3].x,self.childNodesPos[3].y)
            ---
            ---
            childNode3:setLocalZOrder(2)
        	childNode3:setTag(2)
        	childNode3:setOpacity(150)
        	-- childNode3:setScale(0.9, 0.9)
        	
            childNode2:setLocalZOrder(3)
			childNode2:setTouchEnabled(true)
        	childNode2:setTag(1)
        	childNode2:setOpacity(255)
        	-- childNode2:setScale(1, 1)
        	
            childNode4:setLocalZOrder(1)
        	childNode4:setTag(5)
        	childNode4:setOpacity(80)
        	-- childNode4:setScale(0.8, 0.8)
        	
            childNode1:setTouchEnabled(false)
            childNode1:setLocalZOrder(2)
        	childNode1:setTag(4)
        	childNode1:setOpacity(150)

        	-- childNode1:setScale(0.9, 0.9)
            childNode5:setLocalZOrder(1)
        	childNode5:setTag(3)
        	childNode5:setOpacity(80)

        	-- childNode5:setScale(0.8, 0.8)
        end
        clickFlag = true
        self.directionLeft = 0
    elseif event.name =="moved" then
        clickFlag = false
        touchOffsetByCenter = event.x - self:getPositionX()
        local tempX = self.ButtonConSize["width"]/9
        local tempK = math.abs(touchOffsetByCenter)/(tempX*2*self.coefficientX)
        if (touchOffsetByCenter < 0 and  touchOffsetByCenter > tempX*2*self.coefficientX*(-1))  then 
        	self.directionLeft = 1
        	childNode1:setPosition(cc.p(self.childNodesPos[1].x - 2*self.coefficientX*tempX*tempK-3,
        								self.childNodesPos[1].y + self.coefficientY*tempX*tempK+25))

        	childNode2:setPosition(cc.p(self.childNodesPos[2].x + self.coefficientX*tempX*tempK+3,
        								self.childNodesPos[2].y + self.coefficientY*tempX*tempK+25)) 

        	childNode4:setPosition(cc.p(self.childNodesPos[4].x - 2*self.coefficientX*tempX*tempK-3,
        								self.childNodesPos[4].y - self.coefficientY*tempX*tempK-25))

        	childNode5:setPosition(cc.p(self.childNodesPos[5].x + self.coefficientX*tempX*tempK+3,
        								self.childNodesPos[5].y - self.coefficientY*tempX*tempK-25))

            childNode3:setPosition(cc.p(self.childNodesPos[3].x + 2*self.coefficientX*tempX*tempK+3,
                                        self.childNodesPos[3].y + 0))
        	---
        	childNode1:setOpacity(255 - 100*tempK)
        	childNode2:setOpacity(150 -  70*tempK)
        	childNode4:setOpacity(150 + 100*tempK)
        	childNode5:setOpacity(80  +  70*tempK)
        	---
        	childNode3:setLocalZOrder(1)
			childNode2:setLocalZOrder(1)
			childNode4:setLocalZOrder(3)
			childNode1:setLocalZOrder(2)
			childNode5:setLocalZOrder(2)
        	---
        elseif (touchOffsetByCenter > 0 and  touchOffsetByCenter < 2*self.coefficientX*tempX) then
        	self.directionLeft = -1
        	childNode1:setPosition(cc.p(self.childNodesPos[1].x + 2*self.coefficientX*tempX*tempK+3,
        								self.childNodesPos[1].y + self.coefficientY*tempX*tempK+25))
        	childNode2:setPosition(cc.p(self.childNodesPos[2].x + 2*self.coefficientX*tempX*tempK+3,
        								self.childNodesPos[2].y - self.coefficientY*tempX*tempK-25))        	
        	childNode4:setPosition(cc.p(self.childNodesPos[4].x - self.coefficientX*tempX*tempK+3,
        								self.childNodesPos[4].y + self.coefficientY*tempX*tempK+25))
        	childNode3:setPosition(cc.p(self.childNodesPos[3].x - self.coefficientX*tempX*tempK-3,
        								self.childNodesPos[3].y - self.coefficientY*tempX*tempK-25))
        	childNode5:setPosition(cc.p(self.childNodesPos[5].x - 2*self.coefficientX*tempX*tempK-3,
        								self.childNodesPos[5].y + 0))
        	---
        	childNode1:setOpacity(255 - 100*tempK)
        	childNode2:setOpacity(150 +  70*tempK)
        	childNode4:setOpacity(150 -  70*tempK)
        	childNode3:setOpacity(80  +  70*tempK)
        	---
        	childNode3:setLocalZOrder(2)
			childNode2:setLocalZOrder(3)
			childNode4:setLocalZOrder(1)
			childNode1:setLocalZOrder(2)
			childNode5:setLocalZOrder(1)
        	---
        end
    elseif event.name =="began" then
    	touchOffsetByCenter = 0
        return true
    end
end 
return RotationScViewByMyself