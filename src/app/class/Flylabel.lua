local Flylabel = class("Flylabel", function()
	return display.newNode("Flylabel")
end)
function Flylabel:ctor()
	
end
function Flylabel:create(word,fontText)
	local node = Flylabel.new() --点调用
	if node then
		node:init(word,fontText)
		return node
	else
		return nil
	end
end
function Flylabel:init(word,fontText)
	self.label = cc.ui.UILabel.new({
            UILabelType = 1,
            text = word,
            font = fontText,
            })
    self.label:align(display.CENTER, 0, 60)
    self:addChild(self.label)
    self:Flying()
end
function Flylabel:Flying()
	local moveby = cc.MoveBy:create(0.5,cc.p(0,140))
	local fade = cc.FadeTo:create(0.5,0)
	local func = cca.callFunc(function() self:Flyend() end)
	local Seq = cc.Sequence:create(moveby,func)
	self.label:runAction(Seq)
	self.label:runAction(fade)
end
function Flylabel:Flyend()
	--self:removeAllChildrenWithCleanup(true)
	self:removeFromParent() --中自动调用上面的方法
end
return Flylabel