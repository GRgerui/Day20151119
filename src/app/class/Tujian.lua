local Tujian = class("Tujian",function()
	return display.newColorLayer(cc.c4b(100,100,100,0))
	end)

function Tujian:ctor()
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
      local bg = cc.Sprite:create("gatebackground_3.png")
      bg:setPosition(display.cx,display.cy)
      local scaleX = display.width/bg:getContentSize().width
      local scaleY = display.height/bg:getContentSize().height
      bg:setScaleX(scaleX)
      bg:setScaleY(scaleY)
      self:addChild(bg)

      --变量,定时器
      self.guaiwu2 = false
      self.guaiwu3 = false
      local scheduler = cc.Director:getInstance():getScheduler()
      self.id = scheduler:scheduleScriptFunc(handler(self, Tujian.schedulefunc),1/60,false)
      self.gw1 = 0
      self.gw2 = 0
      self.gw3 = 0
   --返回按钮
      local fanghuiButton = cc.ui.UIPushButton.new()
       fanghuiButton:setButtonImage(cc.ui.UIPushButton.NORMAL,"#backButton_1.png",nil)
       fanghuiButton:setButtonImage(cc.ui.UIPushButton.PRESSED,"#backButton_2.png",nil)
       fanghuiButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
          if event.name == "began" then
          local scheduler = cc.Director:getInstance():getScheduler()
          scheduler:unscheduleScriptEntry(self.id)
          if HeroData.Data.isPlaySound then
            audio.playSound("close.mp3")
          end
          local z = StartScene.new()
          local x = cc.TransitionFade:create(0.8, z)
          cc.Director:getInstance():replaceScene(x)
      end


     end)

      fanghuiButton:setPosition(70,70)
      self:addChild(fanghuiButton)
      
    --怪物动画

       self.s1 = display.newSprite("#2002_role/0000")
       self.s1:setPosition(135,display.cy+275)
       self:addChild(self.s1,2)
       local frames = display.newFrames("2002_role/00%.2d",20,30)
       local animation = display.newAnimation(frames)
       self.s1:playAnimationForever(animation)

       self.s2 = display.newSprite("#2001_role/0000")
       self.s2:setPosition(135,display.cy+100)
       self:addChild(self.s2,2)
       local frames = display.newFrames("2001_role/00%.2d",20,28)
       local animation = display.newAnimation(frames)
       self.s2:playAnimationForever(animation)

  
       self.s3 = display.newSprite("#2003_role/0000")
       self.s3:setPosition(135,display.cy-25)
       self:addChild(self.s3,2)
       local frames = display.newFrames("2003_role/00%.2d",19,25)   --41,34 ji neng
       local animation = display.newAnimation(frames)               --1/28  ji neng shijian
       self.s3:playAnimationForever(animation)


  
    --怪物介绍
       guaiwu1Button = cc.ui.UIPushButton.new()
       guaiwu1Button:setButtonImage(cc.ui.UIPushButton.NORMAL,"#jianbutton_1.png",nil)
       guaiwu1Button:setButtonImage(cc.ui.UIPushButton.PRESSED,"#jianbutton_2.png",nil)
       guaiwu1Button:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
          if event.name == "began" then

            if self.gw3 == 1   then
           self.s3:stopAllActions()
           local frames = display.newFrames("2003_role/00%.2d",19,25)   --41,34 ji neng
           local animation = display.newAnimation(frames)               --1/28  ji neng shijian
           self.s3:playAnimationForever(animation)
               self.gw3 = 0
             end

             if self.gw2 == 1  then
            self.s2:stopAllActions()
           local frames = display.newFrames("2001_role/00%.2d",20,28)
           local animation = display.newAnimation(frames)
           self.s2:playAnimationForever(animation)
               self.gw2 = 0
             end

           self.s1:stopAllActions()
           local frames = display.newFrames("2002_role/00%.2d",49,30)--技能
           local animation = display.newAnimation(frames)
           self.s1:playAnimationForever(animation) 

            self.jian = display.newSprite("#jianPower.png")
            self.jian:setPosition(display.cx+50,display.cy+52)
            self.jian:setScale(0.8)
            self:addChild(self.jian)
          
          elseif event.name == "ended" then 
            guaiwu1Button:setButtonEnabled(false)
            self.guaiwu2=true
            self.guaiwu3=true
            self.gw1 = 1
           


      end

     return true 
     end)

      guaiwu1Button:setPosition(150,display.cy+200)
      self:addChild(guaiwu1Button)



       guaiwu3Button = cc.ui.UIPushButton.new()
       guaiwu3Button:setButtonImage(cc.ui.UIPushButton.NORMAL,"#fabutton_1.png",nil)
       guaiwu3Button:setButtonImage(cc.ui.UIPushButton.PRESSED,"#fabutton_2.png",nil)
       guaiwu3Button:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
          if event.name == "began" then

            if self.gw1 ==1 then
           self.s1:stopAllActions()
           local frames = display.newFrames("2002_role/00%.2d",20,30)
           local animation = display.newAnimation(frames)
           self.s1:playAnimationForever(animation)
              self.gw1 = 0
            end
             
             if self.gw2 == 1 then
            self.s2:stopAllActions()
           local frames = display.newFrames("2001_role/00%.2d",20,28)
           local animation = display.newAnimation(frames)
           self.s2:playAnimationForever(animation)
                self.gw2 = 0
             end

           self.s3:stopAllActions()
           local frames = display.newFrames("2003_role/00%.2d",41,34)--技能
           local animation = display.newAnimation(frames,1/18)
           self.s3:playAnimationForever(animation) 
           
            self.fa = display.newSprite("#faPower.png")
            self.fa:setPosition(display.cx+50,display.cy+52)
            self.fa:setScale(0.8)
            self:addChild(self.fa)

           elseif event.name == "ended" then
            guaiwu3Button:setButtonEnabled(false)
            guaiwu1Button:setButtonEnabled(true)
            self.guaiwu2 = true 
            self.guaiwu3 = false
            self.gw3 =1 
           
      end

     return true
     end)

      guaiwu3Button:setPosition(150,display.cy-100)
      self:addChild(guaiwu3Button)




       guaiwu2Button = cc.ui.UIPushButton.new()
       guaiwu2Button:setButtonImage(cc.ui.UIPushButton.NORMAL,"#roubutton_1.png",nil)
       guaiwu2Button:setButtonImage(cc.ui.UIPushButton.PRESSED,"#roubutton_2.png",nil)
       guaiwu2Button:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
          if event.name == "began" then

            if self.gw1 == 1 then 
          self.s1:stopAllActions()
           local frames = display.newFrames("2002_role/00%.2d",20,30)
           local animation = display.newAnimation(frames)
           self.s1:playAnimationForever(animation)
              self.gw1 = 0 
             end

            if self.gw3 == 1 then
           self.s3:stopAllActions()
           local frames = display.newFrames("2003_role/00%.2d",19,25)   --41,34 ji neng
           local animation = display.newAnimation(frames)               --1/28  ji neng shijian
           self.s3:playAnimationForever(animation)
               self.gw3 = 0
             end
           
           self.s2:stopAllActions()
           local frames = display.newFrames("2001_role/00%.2d",44,30)--技能
           local animation = display.newAnimation(frames,1/20)
           self.s2:playAnimationForever(animation) 
            
            self.rou = display.newSprite("#rouPower.png")
            self.rou:setPosition(display.cx+50,display.cy+52)
            self.rou:setScale(0.8)
            self:addChild(self.rou)

          elseif event.name == "ended" then
            guaiwu2Button:setButtonEnabled(false)
            guaiwu3Button:setButtonEnabled(true)
            guaiwu1Button:setButtonEnabled(true)
            self.guaiwu2 = false
            self.gw2 = 1  
           
      end
         
      return true
     end)

      guaiwu2Button:setPosition(150,display.cy+50)
      self:addChild(guaiwu2Button)
      


      --光环
      local red2 = display.newSprite("#Boss_effup/0000")
      red2:setPosition(135,display.cy+49)
      red2:setScale(0.5)
      self:addChild(red2,3)
      local frames  = display.newFrames("Boss_effup/00%.2d",0,13)
      local animation = display.newAnimation(frames)
      red2:playAnimationForever(animation)
     

      local red1 = display.newSprite("#Boss_effup/0000")
      red1:setPosition(135,display.cy+195)
      red1:setScale(0.5)
      self:addChild(red1,3)
      local frames  = display.newFrames("Boss_effup/00%.2d",0,13)
      local animation = display.newAnimation(frames)
      red1:playAnimationForever(animation)


      local red3 = display.newSprite("#Boss_effup/0000")
      red3:setPosition(135,display.cy-105)
      red3:setScale(0.5)
      self:addChild(red3,3)
      local frames  = display.newFrames("Boss_effup/00%.2d",0,13)
      local animation = display.newAnimation(frames)
      red3:playAnimationForever(animation)



    --怪物属性
end


function Tujian:schedulefunc()
  if self.guaiwu2 then
    guaiwu2Button:setButtonEnabled(true)
  end
  if self.guaiwu3 then
    guaiwu3Button:setButtonEnabled(true)
  end
end

return Tujian