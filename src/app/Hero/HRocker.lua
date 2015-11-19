local HRocker = class("HRocker", function()
return display.newLayer("HRocker")
end)

function HRocker:ctor()

-- 用于标识摇杆与摇杆的背景
self.tagForHRocker = {
tag_rocker = 0, 
tag_rockerBG = 1}
-- 用于标识摇杆方向 8 方向 
self.tagDirecton = {rocker_stay = 0,
rocker_right = 1,
rocker_up = 2,
rocker_left = 3,
rocker_down = 4,
rocker_left_up = 5,
rocker_left_down = 6,
rocker_right_up = 7,
rocker_right_down = 8
}
-- 判断控制杆方向，用来判断精灵上、下、左、右运动
self.rocketDirection = nil
-- 当前人物行走方向,用来判断精灵的朝向，精灵脸朝右还是朝左
self.rocketRun = false
-- 是否可操作摇杆
self.isCanMove = false
-- 摇杆背景的坐标
self.rockerBGPosition = nil
-- 所按
self.PI = 3.1415
end
-- 创建摇杆(摇杆的操作题图片资源名，摇杆背景图片资源名，起始坐标)
function HRocker:createHRocker( rockerImageName, rockerBGImageName, position )
local layer = HRocker:new()
if layer then
-- 1 按钮， 2 背景 
layer:rockerInit(rockerImageName, rockerBGImageName, position)
layer:jinengDemo() --技能按键
return layer
end
return nil
end
function HRocker:jinengDemo( )
    self.node = display.newNode()
    self.node:setPosition(display.right-170,130)
    self.node:addTo(self)
    --技能1
    local pos1 = {x=-140,y=-45}
    self.pushbutton1 = ccui.Button:create("1009_1_1.png","1009_1_2.png",nil,1)
    --self.pushbutton1:setScale(0.8)
    self.pushbutton1:setPressedActionEnabled(true)
    self.pushbutton1:setPosition(pos1)
    self.node:addChild(self.pushbutton1)
    self.pushbutton1:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
            if SkillData.Data.P2==0 and SkillData.Data.P3==0 and SkillData.Data.P4==0 and SkillData.Data.P1 == 0 then
                SkillData.Data.P1 = 1
                ModifyData.setMP(ModifyData.getMP()-20)
            end

        end return true;end)
    --技能2
    local pos2 = {x=-125,y=70}
    self.pushbutton2 = ccui.Button:create("1009_2_1.png","1009_2_2.png",nil,1)
    --self.pushbutton2:setScale(0.8)
    self.pushbutton2:setPressedActionEnabled(true)
    self.pushbutton2:setPosition(pos2)
    self.node:addChild(self.pushbutton2)
    self.pushbutton2:addTouchEventListener( function(sender,event)
        if event==0 then
        elseif event==1 then
        elseif event==2 then
            if SkillData.Data.P2==0 and SkillData.Data.P3==0 and SkillData.Data.P4==0 and SkillData.Data.P1 == 0 then
                SkillData.Data.P2 = 1
                ModifyData.setMP(ModifyData.getMP()-40)
            end
        end return true;end) 
    --技能3
    local pos3 = {x=-25,y=135}
    self.pushbutton3 = ccui.Button:create("1009_3_1.png","1009_3_2.png",nil,1)
    --self.pushbutton3:setScale(0.8)

    self.pushbutton3:setPressedActionEnabled(true)

    self.pushbutton3:setPosition(pos3)
    self.node:addChild(self.pushbutton3)
    self.pushbutton3:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
            if SkillData.Data.P2==0 and SkillData.Data.P3==0 and SkillData.Data.P4==0 and SkillData.Data.P1 == 0 then
                SkillData.Data.P3 = 1
                ModifyData.setMP(ModifyData.getMP()-60)
            end 
        --self.pushbutton3:setTouchEnabled(false)
        --local Sp3 = display.newSprite("#attack_button.png")
        --self:lenqueDemo( Sp3,self.pushbutton3,3,pos3)
        --print(3)

        end return true;end)
    --技能4
	local pos4 = {x=92,y=120}
	self.pushbutton4 = ccui.Button:create("1009_4_1.png","1009_4_2.png",nil,1)
    --self.pushbutton4:setScale(0.8)
	self.pushbutton4:setPressedActionEnabled(true)
	self.pushbutton4:setPosition(pos4)
    self.node:addChild(self.pushbutton4)
    self.pushbutton4:addTouchEventListener( function(sender,event)
    	if event==0 then
    	elseif event==1 then 
    	elseif event==2 then
            if SkillData.Data.P2==0 and SkillData.Data.P3==0 and SkillData.Data.P4==0 and SkillData.Data.P1 == 0 then
                SkillData.Data.P4 = 1
                ModifyData.setMP(ModifyData.getMP()-80)
            end
    	end return true;end)
    --普攻
    local pos5 = {x=10,y=-10}
    self.pushbutton5 = ccui.Button:create("attack1.png","attack2.png")
    --self.pushbutton5:setScale(0.8)
    self.pushbutton5:setPressedActionEnabled(true)
    --self.pushbutton5:setZoomScale(0.1)
    self.pushbutton5:setPosition(pos5)
    self.node:addChild(self.pushbutton5)
    self.pushbutton5:addTouchEventListener( function(sender,event)
    --addNodeEventListener(cc.NODE_TOUCH_EVENT,
        if event==0 then 
            SkillData.Data.P5 = 1
        elseif event==1 then 
            --SkillData.Data.P5 = 2
        elseif event==2 then 
            SkillData.Data.P5 = 2
        end 
        return true;end)
end
-- privete 
-- 自定义初始化函数 ， 1 按钮，  2 背景图
function HRocker:rockerInit( rockerImageName, rockerBGImageName, position )
local spRockerBG = display.newSprite(rockerBGImageName)
spRockerBG:setPosition( position )

self:addChild(spRockerBG, 0, self.tagForHRocker.tag_rockerBG)

spRockerBG:setVisible(false)
local spRocker = display.newSprite(rockerImageName)
spRocker:setPosition( position )
self:addChild(spRocker, 1, self.tagForHRocker.tag_rocker)
spRocker:setVisible(false)
self.rockerBGPosition = position
self.rockerBGR = spRockerBG:getContentSize().width * 0.3
-- 表示摇杆方向不变
self.rocketDirection = self.tagDirecton.rocker_stay --0
end
-- 启动摇杆(显示摇杆、监听摇杆触屏事件)
function HRocker:startRocker( _isStopOther )
 
  local rocker = self:getChildByTag(self.tagForHRocker.tag_rocker)
  rocker:setVisible(true)

  local rockerBG = self:getChildByTag(self.tagForHRocker.tag_rockerBG)
  rockerBG:setVisible(true)

-- 这里开启了点击事件
  self:setTouchEnabled(true)
  self.touchId = self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.addTouchEvent))
  self:setTouchSwallowEnabled(true)
end

-- 停止摇杆（隐藏摇杆， 取消摇杆的触屏监听）
function HRocker:stopRocker()

local rocker = self:getChildByTag(self.tagForHRocker.tag_rocker)
rocker:setVisible(false)

local rockerBG = self:getChildByTag(self.tagForHRocker.tag_rockerBG)
rockerBG:setVisible(false)

-- 这里移除了点击事件
self:removeNodeEventListener(self.touchId)

end

-- 获取当前摇杆与用户触屏点的角度
function HRocker:getRad( pos1, pos2 )
local px1 = pos1.x
local py1 = pos1.y
local px2 = pos2.x
local py2 = pos2.y
-- 得到两点x的距离
local x = px2 - px1
-- 得到两点y的距离 
local y = py1 - py2
-- 算出斜边的长度
local xie = math.sqrt(math.pow(x, 2) + math.pow(y, 2))
-- 得到这个角度的余弦值（通过三角函数中的定里：角度余弦值 ＝ 斜边/斜边
local cosAngle = x / xie
-- 通过反余弦定理获取到期角度的弧度
local rad = math.acos(cosAngle)
-- 注意：当触屏的位置Y坐标<摇杆的Y坐标，我们要去反值-0~-180

if py2 < py1 then

rad = -rad

end

return rad
end

function HRocker:getAngelePosition( r, angle )
return cc.p( r * math.cos( angle ), r * math.sin(angle))
end

function HRocker:addTouchEvent( event )

local x, y = event.x, event.y
       
local location = cc.p(x, y)
if event.name == "began" then
local isBool = self:touchBegan(location)
return isBool
elseif event.name == "moved" then
self:touchMoved(location)
elseif event.name == "ended" then
self:touchEnded(location)
end
end
-- 抬起事件
function HRocker:touchBegan( _pTouch )

local point = _pTouch
local rocker = self:getChildByTag(self.tagForHRocker.tag_rocker)
if cc.rectContainsPoint(rocker:getBoundingBox(), point) then
self.isCanMove = true
end
return true
end
-- 移动事件
function HRocker:touchMoved( _pTouch )
if not self.isCanMove then
return
end

local point = _pTouch
local rocker = self:getChildByTag(self.tagForHRocker.tag_rocker)
-- 得到摇杆与触屏点所形成的角度
local angle = self:getRad(self.rockerBGPosition, point)
-- 两个圆的圆心距
local kf = math.sqrt(math.pow( self.rockerBGPosition.x - point.x, 2) + math.pow( self.rockerBGPosition.y - point.y, 2))
-- 判断两个圆的圆心距是否大于摇杆背景的半径
if kf >= self.rockerBGR then
-- 保证内部小圆运动的长度限制
rocker:setPosition(cc.pAdd(self:getAngelePosition(self.rockerBGR, angle), cc.p(self.rockerBGPosition.x, self.rockerBGPosition.y)))
else
-- 当没有超过，让摇杆跟随用户触屏点移动即可
rocker:setPosition(point)

end

-- 判断八个方向 
local rockerBG = self:getChildByTag(self.tagForHRocker.tag_rockerBG)
local p_dian = {x = rockerBG:getPositionX(), y = rockerBG:getPositionY()}

local move_x = p_dian.x - point.x
local move_y = p_dian.y - point.y
-- printf("movex == %f, movey == %f", move_x, move_y)

if move_x >= 23 and move_y <= -23 then
--左上
self.rocketDirection = self.tagDirecton.rocker_left_up
-- print("左上 左上 左上 左上 左上 左上 左上 左上")
self.rocketRun = true
SkillData.Data.Run = self.rocketRun
elseif move_x >= 23 and move_y >= 23 then
-- 左下
self.rocketDirection = self.tagDirecton.rocker_left_down
-- print("左下 左下 左下 左下 左下 左下 左下 左下")
self.rocketRun = true
SkillData.Data.Run = self.rocketRun
elseif move_x <= -23 and move_y <= -23 then
-- 右上
self.rocketDirection = self.tagDirecton.rocker_right_up
-- print("右上 右上 右上 右上 右上 右上 右上 右上")
self.rocketRun = false
SkillData.Data.Run = self.rocketRun
elseif move_x <= -23 and move_y >= 23 then
-- 右下
self.rocketDirection = self.tagDirecton.rocker_right_down
-- print("右下 右下 右下 右下 右下 右下 右下 右下")
self.rocketRun = false
SkillData.Data.Run = self.rocketRun
elseif move_x > -23 and move_x < 23 and move_y > 0 then
-- 下
self.rocketDirection = self.tagDirecton.rocker_down

-- print("下 下  下  下  下  下  下  下  下  下  下 ")
elseif move_x > -23 and move_x < 23 and move_y < 0 then
-- 上
self.rocketDirection = self.tagDirecton.rocker_up

-- print("上 上 上 上  上 上  上 上  上 上  上 上 上")
elseif move_x > 0 and move_y > -23 and move_y < 23 then
-- 左
self.rocketDirection = self.tagDirecton.rocker_left

-- print("左 左 左 左 左 左 左 左 左 左 左 左 左 左 左")
self.rocketRun = true
SkillData.Data.Run = self.rocketRun
elseif move_x < 0 and move_y > -23 and move_y < 23 then
-- 右
self.rocketDirection = self.tagDirecton.rocker_right
-- print("右 右 右 右 右 右 右 右 右 右 右 右 右 右 右")
self.rocketRun = false
SkillData.Data.Run = self.rocketRun

end
end
-- 离开事件
function HRocker:touchEnded( _pTouch )
if not self.isCanMove then
return
end
local rockerBG = self:getChildByTag(self.tagForHRocker.tag_rockerBG)
local rocker = self:getChildByTag(self.tagForHRocker.tag_rocker)
rocker:stopAllActions()
transition.moveTo(rocker, { x = rockerBG:getPositionX(), y = rockerBG:getPositionY(), time = 0.08 })
self.isCanMove = false
self.rocketDirection = self.tagDirecton.rocker_stay
end

return HRocker


