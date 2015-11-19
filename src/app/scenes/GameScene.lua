local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)
function GameScene:ctor()
    
    -- 音乐
    if HeroData.Data.isPlayMusic==true then
        audio.playMusic("backgroundmusic.mp3",true)
    end
    --  初始化技能
    SkillData.Data.P1 = 0
    SkillData.Data.P2 = 0
    SkillData.Data.P3 = 0
    SkillData.Data.P4 = 0
    SkillData.Data.P5 = 0
    --  加载背景
    Sc = ModifyData.getSceneNum()
    Ch = ModifyData.getChapterNum()
    local SceneNum = 0
    if Sc==1 then
        SceneNum = 2
    elseif Sc==2 then
            SceneNum = 3
    elseif Sc==3 then
        SceneNum = 1
    end
    --背景 具有景深效果
    local bg = display.newSprite("#bgmap"..SceneNum ..".png")
    bg:setAnchorPoint(cc.p(0,0))
    --中间层
    local mid = display.newSprite("#MapMiddle"..SceneNum ..".png")
    mid:setAnchorPoint(cc.p(0,0))
    --道路
    self.r = display.newSprite("#MapGround"..SceneNum ..".png")
    self.r:setAnchorPoint(cc.p(0,0))
    --最前的植物
    local befor = display.newSprite("#MapBefore"..SceneNum ..".png")
    befor:setAnchorPoint(cc.p(0,0))
    self.parallax = cc.ParallaxNode:create() 
    self.parallax:addChild(bg, 1 , cc.p(0.2,0),cc.p(0,0))
    self.parallax:addChild(mid, 2 , cc.p(0.5,0),cc.p(0,320))
    self.parallax:addChild(self.r, 3 , cc.p(0.8,0),cc.p(0,0))
    self.parallax:addChild(befor, 4 , cc.p(0.6,0),cc.p(0,0))
    --添加摇杆
    self.rocker = HRocker:createHRocker("import2.png", "import1.png", cc.p(160, 150))
    self.rocker:startRocker()
    self.rocker:addTo(self,1)
    --添加怪物
    self.Ms1Array = {}
    self.Ms2Array = {}
    self.Ms3Array = {}
    --获取怪物数
    Ms1num = CSData.SCENE[Sc][Ch].boy1
    Ms2num = CSData.SCENE[Sc][Ch].boy2
    Ms3num = CSData.SCENE[Sc][Ch].boy3
    --创建英雄
    self.hero = HeroNode.new() --HeroNode被声明为全局
    self.hero:setPosition(display.cx,display.cy)
    self:HeroZTL() --状态栏
    --英雄位置初始化
    ModifyData.heroPos.x = self.hero:getPositionX()
    ModifyData.heroPos.y = self.hero:getPositionY()
    --地图
    self.layer = display.newLayer()
    self.r:addChild(self.hero,2)
    self.layer:addChild(self.parallax)
    self:addChild(self.layer)
    self.layer:setContentSize(2100,640)
    --定时器 -- 同碰撞检测
    self.id = scheduler.scheduleGlobal(handler(self, GameScene.updatePos),1/60)
    --定时器 -- 出怪
    self.is = scheduler.scheduleGlobal(handler(self, GameScene.updateMons),0.2)
    --暂停按钮
    self:PauseButton()
end
function GameScene:collision( spa,spb )--碰撞检测方法
    local r1 = spa:getBoundingBox()
    local r2 = spb:getBoundingBox()
    return cc.rectIntersectsRect(r1,r2)
end
--重写的rect --作用于碰撞、触摸方法中
function GameScene:newHeroRect( v,frame )
        local width = frame.width
        local height = frame.height
        local x = v:getPositionX()
        local y = v:getPositionY()
        if self.rocker.rocketRun then--print("左")
            x = x - width+100
            width = width-65
            height = 60
            else--print("右")
            x = x-30
            width = width*3.0/4 - 30
            height = 60
        end
        if SkillData.Data.P1 == 1 then
            x = v:getPositionX()
            y = v:getPositionY()
            width = frame.width
            height = frame.height
            if self.rocker.rocketRun then--print("左")
                x = x - width+100
                width = width-60
                height = 60
                else--print("右")
                x = x-10
                width = width*3.0/4 - 10
                height = 60
            end
        elseif SkillData.Data.P2 == 1 then
            y = v:getPositionY()
            y = y-30
        elseif SkillData.Data.P3 == 1 then
            if self.rocker.rocketRun then--print("左")
                x = v:getPositionX()
                x = x - width
                height = 80
                else--print("右")
                x = x-10
                width = width+60
                height = 80
            end
        elseif SkillData.Data.P4 == 1 then
            x = v:getPositionX()
            y = v:getPositionY()
            width = frame.width
            height = frame.height
            x = x - width+60
            width = 2*width-100
            height = 70
        elseif SkillData.Data.P5 == 1 then
            x = v:getPositionX()
            y = v:getPositionY()
            width = frame.width
            height = frame.height
            if self.rocker.rocketRun then--print("左")
                x = x - width+60
                width = width-40
                height = 60
                else--print("右")
                x = x-30
                width = width*3.0/4 - 5
                height = 60
            end
        end
        local rect = cc.rect(x, y, width,height)
        --self.draw:clear()
        --self.draw:drawRect(cc.p(x,y),cc.p(x+width,y+height), cc.c4f(1,0,0,1))
        return rect
end
function GameScene:newMonsterRect( v,width,height )
        local x = v:getPositionX()
        local y = v:getPositionY()
        local rect = cc.rect(x-width/2, y, width-30,height-20)
        return rect
end
-- 暂停按钮事件
key1 = 1
function GameScene:PauseButton()
    self.Pause = ccui.Button:create("pauseNormal_1.png","pauseSelected_1.png","pauseSelected_1.png",1)
    --self.Pause:setScale(0.8)
    self.Pause:setPressedActionEnabled(false)
    self.Pause:setPosition(display.right-70,display.top-70)
    self:addChild(self.Pause)
    self.Pause:addTouchEventListener( function(sender,event)
        if event==0 then 
        elseif event==1 then 
        elseif event==2 then
            if HeroData.Data.isPlaySound then
                audio.playSound("click.mp3", false)
            end
            self:Pausefunc()
            local pauselayer = Pauselayer.new()
            pauselayer:addEventListener("Resumefunc",handler(self, self.Resumefunc))
            pauselayer:setPosition(display.cx, display.cy)
            pauselayer:addTo(self,10)
        end return true;end)
end
function GameScene:Pausefunc()
    local actionman = cc.Director:getInstance():getActionManager()
    for k,v in pairs(self.Ms1Array) do
        actionman:pauseTarget(v)
        v:setVisible(false)
    end
    for k,v in pairs(self.Ms2Array) do
        actionman:pauseTarget(v)
        v:setVisible(false)
    end
    for k,v in pairs(self.Ms3Array) do
        actionman:pauseTarget(v)
        v:setVisible(false)
    end
end
function GameScene:Resumefunc()
    local actionman = cc.Director:getInstance():getActionManager()
    for k,v in pairs(self.Ms1Array) do
        actionman:resumeTarget(v)
        v:setVisible(true)
    end
    for k,v in pairs(self.Ms2Array) do
        actionman:resumeTarget(v)
        v:setVisible(true)
    end
    for k,v in pairs(self.Ms3Array) do
        actionman:resumeTarget(v)
        v:setVisible(true)
    end
end
-- 技能按键是否可见控制
function GameScene:VisButton()
    if ModifyData.getMP()>=80 then
        self.rocker.pushbutton1:setVisible(true)
        self.rocker.pushbutton2:setVisible(true)
        self.rocker.pushbutton3:setVisible(true)
        self.rocker.pushbutton4:setVisible(true)
    elseif ModifyData.getMP()>=60 then
        self.rocker.pushbutton1:setVisible(true)
        self.rocker.pushbutton2:setVisible(true)
        self.rocker.pushbutton3:setVisible(true)
        self.rocker.pushbutton4:setVisible(false)
    elseif ModifyData.getMP()>=40 then
        self.rocker.pushbutton1:setVisible(true)
        self.rocker.pushbutton2:setVisible(true)
        self.rocker.pushbutton3:setVisible(false)
        self.rocker.pushbutton4:setVisible(false)
    elseif ModifyData.getMP()>=20 then
        self.rocker.pushbutton1:setVisible(true)
        self.rocker.pushbutton2:setVisible(false)
        self.rocker.pushbutton3:setVisible(false)
        self.rocker.pushbutton4:setVisible(false)
    else
        self.rocker.pushbutton1:setVisible(false)
        self.rocker.pushbutton2:setVisible(false)
        self.rocker.pushbutton3:setVisible(false)
        self.rocker.pushbutton4:setVisible(false)
    end
end
--计时器调度方法 --碰撞检测
function GameScene:updatePos() 
    --方向1-8      --脸的方向      --点击的技能按钮
    self.hero:setRockbackData(self.rocker.rocketDirection,self.rocker.rocketRun) --人物走动
    --能量条的刷新
    if 100*ModifyData.getMP()/200>0 then
        self.MpBar:setPercentage(100*ModifyData.getMP()/200)
        else
        self.MpBar:setPercentage(0)
    end
    --技能按钮是否可以见
    self:VisButton()
    --地图更随
    self:moveMap(self.hero:getPositionX(),self.hero:getPositionY()) --地图跟随
    --碰撞检测
    local frame = self.hero.player:getTextureRect() --英雄矩形区域
    local HeroRect = self:newHeroRect( self.hero,frame )
    --第一种怪物的碰撞检测
    for i,v in ipairs(self.Ms1Array) do
        if v.Ms1~=nil then
            local MsFrame = v.Ms1:getTextureRect()         --怪兽的矩形区域
            local w = MsFrame.width
            local h = MsFrame.height
            local RectMs = self:newMonsterRect( v,w,h )
            if cc.rectIntersectsRect(RectMs, HeroRect) and (SkillData.Data.P1 == 1 or SkillData.Data.P2 == 1 or SkillData.Data.P3 == 1 or SkillData.Data.P4 == 1 or SkillData.Data.P5 == 1) then
                if SkillData.Data.P1 == 1 then
                    if v.Ms1.fsm:canDoEvent("hurtAction") then
                        v.Ms1.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A1 + math.random(HeroData.Data.A1/5,HeroData.Data.A1)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                    end
                elseif SkillData.Data.P2 == 1 then
                    if v.Ms1.fsm:canDoEvent("hurtAction") then
                        v.Ms1.fsm:doEvent("hurtAction")
                        --飘血
                        local pow = HeroData.Data.A2 + math.random(HeroData.Data.A2/5,HeroData.Data.A2)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P3 == 1 then
                    if v.Ms1.fsm:canDoEvent("hurtAction") then
                        v.Ms1.fsm:doEvent("hurtAction")
                        --飘血
                        local pow = HeroData.Data.A3 + math.random(HeroData.Data.A3/5,HeroData.Data.A3)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P4 == 1 then
                    if v.Ms1.fsm:canDoEvent("hurtAction") then
                        v.Ms1.fsm:doEvent("hurtAction")
                        local pow = HeroData.Data.A4 + math.random(HeroData.Data.A4/5,HeroData.Data.A4)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P5 == 1 then
                    local Rk = math.random(1,3)
                    if v.Ms1.fsm:canDoEvent("hurtAction") and (Rk == 1 or Rk == 2) then
                        v.Ms1.fsm:doEvent("hurtAction")
                        --飘血
                        local pow = HeroData.Data.AC + math.random(HeroData.Data.AC/5,HeroData.Data.AC)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                    elseif v.Ms1.fsm:canDoEvent("parryAction") and Rk == 3 then
                        v.Ms1.fsm:doEvent("parryAction")
                        local lab = Flylabel:create("Miss","MissText.fnt")
                        v:addChild(lab,10)
                    end
                end
                --被攻击的怪物停止移动
                if v.Zt==false then
                    v.Zt = true
                    v:performWithDelay(function() v.Zt = false end, 0.4)
                end
            end
            --怪物死亡
            if v.MsHp<=0 and v.Ms1.fsm:canDoEvent("deadAction") then
                v.HpBar:setPercentage(0)
                local func1 = cca.callFunc(function() v.Ms1.fsm:doEvent("deadAction") table.remove(self.Ms1Array,i)   end)
                local func2 = cca.callFunc(function() v:removeFromParent()

                local Mp = 2 + math.random(0,8)
                    if (ModifyData.getMP()+Mp)>=200 then
                        ModifyData.setMP(200)
                        else
                        ModifyData.setMP(ModifyData.getMP()+Mp)
                    end
                local lab = Flylabel:create(Mp,"MpText.fnt")
                self.hero:addChild(lab,10)

                end)
                local Seq = cc.Sequence:create(func1,cc.DelayTime:create(0.5),func2)
                v:runAction(Seq)
                break
            else
                v.HpBar:setPercentage(100*v.MsHp/v.Hp)
            end
            --怪物攻击英雄
            if v.Ms1.MsAc == true then
                v.Ms1.MsAc = false
                local pow = v.MsPower + math.random(v.MsPower/5,v.MsPower)
                        local lab = Flylabel:create(pow,"MStext.fnt")
                        self.hero:addChild(lab,10) --飘血
                        self.hero.MoHp = self.hero.MoHp - pow
                    if self.hero.MoHp<=0 then
                        self:Defeated()
                        self.HpBar:setPercentage(0)
                        break
                    else
                        self.HpBar:setPercentage(100*self.hero.MoHp/self.hero.Hp)
                    end
            end --怪物攻击英雄

        end
    end
    --第二种怪物的碰撞检测
    for i,v in ipairs(self.Ms2Array) do
        if v.Ms2~=nil then
            local MsFrame = v.Ms2:getTextureRect()         --怪兽的矩形区域
            local w = MsFrame.width
            local h = MsFrame.height
            local RectMs = self:newMonsterRect( v,w,h )
            if cc.rectIntersectsRect(RectMs, HeroRect) and (SkillData.Data.P1 == 1 or SkillData.Data.P2 == 1 or SkillData.Data.P3 == 1 or SkillData.Data.P4 == 1 or SkillData.Data.P5 == 1) then
                if SkillData.Data.P1 == 1 then
                    if v.Ms2.fsm:canDoEvent("hurtAction") then
                        v.Ms2.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A1 + math.random(HeroData.Data.A1/5,HeroData.Data.A1)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P2 == 1 then
                    if v.Ms2.fsm:canDoEvent("hurtAction") then
                        v.Ms2.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A2 + math.random(HeroData.Data.A2/5,HeroData.Data.A2)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P3 == 1 then
                    if v.Ms2.fsm:canDoEvent("hurtAction") then
                        v.Ms2.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A3 + math.random(HeroData.Data.A3/5,HeroData.Data.A3)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P4 == 1 then
                    if v.Ms2.fsm:canDoEvent("hurtAction") then
                        v.Ms2.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A4 + math.random(HeroData.Data.A4/5,HeroData.Data.A4)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P5 == 1 then

                local Rk = math.random(1,3)
                if v.Ms2.fsm:canDoEvent("hurtAction") and (Rk == 1 or Rk == 2) then
                    if v.Ms2.fsm:canDoEvent("hurtAction") then
                        v.Ms2.fsm:doEvent("hurtAction")
                         --飘血
                        local pow = HeroData.Data.AC + math.random(HeroData.Data.AC/5,HeroData.Data.AC)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                        elseif v.Ms2.fsm:canDoEvent("parryAction") and Rk == 3 then
                        v.Ms2.fsm:doEvent("parryAction")
                        local lab = Flylabel:create("Miss","MissText.fnt")
                        v:addChild(lab,10)
                        end
                    end

                end

                if v.Zt==false then
                    v.Zt = true
                    v:performWithDelay(function() v.Zt = false end, 0.4)
                end
            end
            --怪物死亡
            if v.MsHp<=0 and v.Ms2.fsm:canDoEvent("deadAction") then
                local func1 = cca.callFunc(function() v.Ms2.fsm:doEvent("deadAction") table.remove(self.Ms2Array,i) end)
                local func2 = cca.callFunc(function() v:removeFromParent()

                local Mp = 4 + math.random(0,8)
                    if (ModifyData.getMP()+Mp)>=200 then
                        ModifyData.setMP(200)
                        else
                        ModifyData.setMP(ModifyData.getMP()+Mp)
                    end
                local lab = Flylabel:create(Mp,"MpText.fnt")
                self.hero:addChild(lab,10)

                end)
                local Seq = cc.Sequence:create(func1,cc.DelayTime:create(0.5),func2) 
                v.HpBar:setPercentage(0)
                v:runAction(Seq) 
                break
            else
                v.HpBar:setPercentage(100*v.MsHp/v.Hp)
            end
            --怪物攻击英雄
            if v.Ms2.MsAc == true then
                v.Ms2.MsAc = false
                local pow = v.MsPower + math.random(v.MsPower/5,v.MsPower)
                        local lab = Flylabel:create(pow,"MStext.fnt")
                        self.hero:addChild(lab,10) --飘血
                        self.hero.MoHp = self.hero.MoHp - pow
                    if self.hero.MoHp<=0 then
                        self:Defeated()
                        self.HpBar:setPercentage(0)
                        break
                    else
                        self.HpBar:setPercentage(100*self.hero.MoHp/self.hero.Hp)
                    end
            end --怪物攻击英雄
        end
    end
    --第三种怪物的碰撞检测
    for i,v in ipairs(self.Ms3Array) do
        if v.Ms3~=nil then
            local MsFrame = v.Ms3:getTextureRect()         --怪兽的矩形区域
            local w = MsFrame.width
            local h = MsFrame.height
            local RectMs= self:newMonsterRect( v,w,h )
            if cc.rectIntersectsRect(RectMs, HeroRect) and (SkillData.Data.P1 == 1 or SkillData.Data.P2 == 1 or SkillData.Data.P3 == 1 or SkillData.Data.P4 == 1 or SkillData.Data.P5 == 1) then
                if SkillData.Data.P1 == 1 then
                    if v.Ms3.fsm:canDoEvent("hurtAction") then
                        v.Ms3.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A1 + math.random(HeroData.Data.A1/5,HeroData.Data.A1)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P2 == 1 then
                    if v.Ms3.fsm:canDoEvent("hurtAction") then
                        v.Ms3.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A1 + math.random(HeroData.Data.A1/5,HeroData.Data.A1)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P3 == 1 then
                    if v.Ms3.fsm:canDoEvent("hurtAction") then
                        v.Ms3.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A1 + math.random(HeroData.Data.A1/5,HeroData.Data.A1)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P4 == 1 then
                    if v.Ms3.fsm:canDoEvent("hurtAction") then
                        v.Ms3.fsm:doEvent("hurtAction")
                        --伤害飘血
                        local pow = HeroData.Data.A1 + math.random(HeroData.Data.A1/5,HeroData.Data.A1)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                    end
                elseif SkillData.Data.P5 == 1 then
                local Rk = math.random(1,3)
                if v.Ms3.fsm:canDoEvent("hurtAction") and (Rk == 1 or Rk == 2) then
                    if v.Ms3.fsm:canDoEvent("hurtAction") then
                        v.Ms3.fsm:doEvent("hurtAction")
                         --飘血
                        local pow = HeroData.Data.AC + math.random(HeroData.Data.AC/5,HeroData.Data.AC)
                        local lab = Flylabel:create(pow,"NumFont.fnt")
                        v:addChild(lab,10)
                        v.MsHp = v.MsHp - pow
                        
                        elseif v.Ms3.fsm:canDoEvent("parryAction") and Rk == 3 then
                        v.Ms3.fsm:doEvent("parryAction")
                        local lab = Flylabel:create("Miss","MissText.fnt")
                        v:addChild(lab,10)
                        end
                    end
                end
                if v.Zt==false then
                    v.Zt = true
                    v:performWithDelay(function() v.Zt = false end, 0.4)
                end
            end
            --怪物死亡
            if v.MsHp<=0 and v.Ms3.fsm:canDoEvent("deadAction") then
                local func1 = cca.callFunc(function() v.Ms3.fsm:doEvent("deadAction") table.remove(self.Ms3Array,i) end)
                local func2 = cca.callFunc(function() v:removeFromParent() 
                local Mp = 2 + math.random(0,8)
                    if (ModifyData.getMP()+Mp)>=200 then
                        ModifyData.setMP(200)
                        else
                        ModifyData.setMP(ModifyData.getMP()+Mp)
                    end
                local lab = Flylabel:create(Mp,"MpText.fnt")
                self.hero:addChild(lab,10)
                end)
                local Seq = cc.Sequence:create(func1,cc.DelayTime:create(0.5),func2)
                v:runAction(Seq)
                v.HpBar:setPercentage(0)
            break
            else
                v.HpBar:setPercentage(100*v.MsHp/v.Hp)
            end
            --怪物攻击英雄
            if v.Ms3.MsAc == true then
                v.Ms3.MsAc = false
                local pow = v.MsPower + math.random(v.MsPower/5,v.MsPower)
                        local lab = Flylabel:create(pow,"MStext.fnt")
                        self.hero:addChild(lab,10) --飘血
                        self.hero.MoHp = self.hero.MoHp - pow
                    if self.hero.MoHp<=0 then
                        self:Defeated()
                        self.HpBar:setPercentage(0)
                        break
                    else
                        self.HpBar:setPercentage(100*self.hero.MoHp/self.hero.Hp)
                    end
            end --怪物攻击英雄
        end
    end
    --判断是否胜利
    if (Ms1num==0 and Ms2num==0 and Ms3num==0) and (#self.Ms1Array==0 and #self.Ms2Array==0 and #self.Ms3Array==0 ) then
        self:Winning() --胜利调度方法
    end
end
function GameScene:updateMons() --出怪物计时器
    if Ms1num~=0 then
        local x = math.random(0,1850) + 40
        local y = math.random(10,180) + 120
        local MsNode = OneMonsterNode:new()
        MsNode:setPosition(x,y)
        table.insert(self.Ms1Array,1,MsNode)
        self.r:addChild(MsNode,1)
        Ms1num = Ms1num - 1
    end
    if Ms2num~=0 then
        Ms2num = Ms2num - 1
        local x = math.random(0,1850) + 40
        local y = math.random(10,180) + 120
        local MsNode = TwoMonsterNode:new()
        MsNode:setPosition(x,y)
        table.insert(self.Ms2Array,1,MsNode)
        self.r:addChild(MsNode,1)
    end
    if Ms3num~=0 then
        Ms3num = Ms3num - 1
        local x = math.random(0,1850) + 40
        local y = math.random(10,180) + 120
        local MsNode = ThreeMonsterNode:new()
        MsNode:setPosition(x,y)
        table.insert(self.Ms3Array,1,MsNode)
        self.r:addChild(MsNode,1)
    end
    if Ms1num==0 and Ms2num==0 and Ms3num==0 then
        scheduler.unscheduleGlobal(self.is)         --关闭碰撞检测
    end
    if HeroData.Data.isPlaySound then
        audio.playSound("monsterout.mp3", false)
    end
end
function GameScene:moveMap(xx,yy)--精灵坐标为参数
    local winSize = cc.Director:getInstance():getWinSizeInPixels()--像素为单位 获取屏幕坐标
    local x = math.max(xx, winSize.width/2)
    local y = math.max(yy, winSize.height/2)
    x = math.min(x, self.layer:getContentSize().width-winSize.width/2)
    y = math.min(y, self.layer:getContentSize().height-winSize.height/2)
    local PM = cc.p(winSize.width/2, winSize.height/2)--屏幕中心的点
    self.layer:setPosition(PM.x-x,PM.y-y)
end
function GameScene:HeroZTL( ) --英雄的状态栏 
    local barbj = display.newSprite("#barGround.png",display.left+250,display.top-60)
    barbj:addTo(self,1)
    --血条
    self.HPSp = display.newSprite("#HPBar.png")
    self.HpBar = cc.ProgressTimer:create(self.HPSp)
    self.HpBar:setType(cc.PROGRESS_TIMER_TYPE_BAR) --设置为条形 type:cc.PROGRESS_TIMER_TYPE_RADIAL
    self.HpBar:setMidpoint(cc.p(0,0.5)) --设置起点在左边 1,0 起点在右边
    self.HpBar:setBarChangeRate(cc.p(1,0))  --设置为竖直方向
    self.HpBar:setPercentage(100) -- 设置初始进度为30
    self.HpBar:setPosition(display.left+236,display.top-67)
    self:addChild(self.HpBar,1)
    --蓝条
    self.MpSp = display.newSprite("#MPBar.png")
    self.MpBar = cc.ProgressTimer:create(self.MpSp)
    self.MpBar:setType(cc.PROGRESS_TIMER_TYPE_BAR) --设置为条形 type:cc.PROGRESS_TIMER_TYPE_RADIAL
    self.MpBar:setMidpoint(cc.p(0,0.5)) --设置起点在左边 1,0 起点在右边
    self.MpBar:setBarChangeRate(cc.p(1,0))  --设置为竖直方向
    self.MpBar:setPercentage(100) -- 设置初始进度为30
    self.MpBar:setPosition(display.left+228,display.top-82)
    self:addChild(self.MpBar,1)
end
function GameScene:Winning() --胜利
    audio.stopAllSounds()
    if HeroData.Data.isPlaySound then
        audio.playSound("victory.mp3", false)
    end
    self.rocker:setVisible(false)
    self.Pause:setTouchEnabled(false)
    scheduler.unscheduleGlobal(self.id)         --关闭碰撞检测
    self.hero.player.fsm:doEvent("winAction")
    self.HpBar:getPercentage()
    if self.HpBar:getPercentage()>=75 then
        ModifyData.setStarNum(3)
    elseif self.HpBar:getPercentage()>=50 then
        ModifyData.setStarNum(2)
    else
        ModifyData.setStarNum(1)
    end
    if ModifyData.getStarNum()>CSData.SCENE[Sc][Ch].star then
        --加技能点
        ModifyData.setSD( ModifyData.getStarNum()-CSData.SCENE[Sc][Ch].star )
        HeroData.setSD(HeroData.getSD()+ModifyData.getSD())

        --刷新底层星星数
        CSData.SCENE[Sc][Ch].star = ModifyData.getStarNum()
        else
        ModifyData.setSD(0)
    end
    if ModifyData.getStarNum() == 3 and Ch<5 and CSData.SCENE[Sc][Ch+1].lock ==0 then
        CSData.SCENE[Sc][Ch+1].lock = 1
    end
    if ModifyData.getStarNum() == 3 and Ch==5 and Sc<3 then
        CSData.SCENE[Sc+1][1].lock = 1
    end
        --写入文件
    ModifyData.WriteDataToDoc( CSData.SCENE )
        -- --写入文件
    ModifyData.WriteDataToDocHero( HeroData.Data )
    --弹出胜利层
    self:performWithDelay(function()
        scheduler.unscheduleGlobal(self.hero.id)    --关闭摇杆
        local winlayer = WinLayer.new()
        winlayer:addTo(self,10)
    end, 2.0)
end
function GameScene:Defeated() --失败
    audio.stopAllSounds()
    if HeroData.Data.isPlaySound then
        audio.playSound("failure.mp3", false)
    end
    self.hero.player.fsm:doEvent("deadAction")  --英雄死亡
    scheduler.unscheduleGlobal(self.id)         --关闭碰撞检测
    scheduler.unscheduleGlobal(self.hero.id)    --关闭摇杆
    self:stopMster() --怪物移除
    local loseLayer = LoseLayer.new()
    loseLayer:setPosition(0, 120)
    loseLayer:addTo(self,10)
    loseLayer:setTouchEnabled(false)

    local func = cca.callFunc(function() loseLayer:setTouchEnabled(true) end)
    local move = cc.MoveTo:create(1.0,cc.p(0,60))
    local Seq = cc.Sequence:create(move,func)

    loseLayer:runAction(move)
end
function GameScene:stopMster() --停止所有怪物的行动
    for k,v in pairs(self.Ms1Array) do
        v:removeFromParent()
    end
    for k,v in pairs(self.Ms2Array) do
        v:removeFromParent()
    end
    for k,v in pairs(self.Ms3Array) do
        v:removeFromParent()
    end
end
function GameScene:onEnter()
end
function GameScene:onExit()
    scheduler.unscheduleGlobal(self.is)         --关闭出怪
    scheduler.unscheduleGlobal(self.id)         --关闭碰撞检测
    scheduler.unscheduleGlobal(self.hero.id)    --关闭摇杆
end
return GameScene
