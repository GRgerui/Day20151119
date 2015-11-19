local MessageBox = class("MessageBox", function()

	return cc.LayerColor:create(cc.c4b(1, 1, 1, 150))

end)

function MessageBox:ctor()
	self:init()
end

function MessageBox:init()

	local label = cc.ui.UILabel.new({
		UILabelType = 1,
		text = "你确定要退出游戏吗?",
		font = "EscText.fnt",
		})
	label:align(display.CENTER,display.cx, display.cy+60)
	label:setScale(1.2)
	label:addTo(self)

	local function click(event)
		local tag=event.target:getTag()
		if tag == 1 then
			cc.Director:getInstance():endToLua()
		elseif tag == 2 then 
			self:removeFromParent()
			StartScene.isTime = 1
		end

	end


    local anode=display.newNode()
    anode:pos(display.cx,display.cy-50)
    anode:addTo(self)

    local item1=cc.ui.UIPushButton.new({normal="#Hook.png"},{scale9=true})
                :pos(-80, 0)
                :addTo(anode)
                :onButtonClicked(click)
                :setTag(1)

    local item2=cc.ui.UIPushButton.new({normal="close.png"},{scale9=true})
                :pos(80, 0)
                :addTo(anode)
                :onButtonClicked(click)
                :setTag(2)

end

return MessageBox