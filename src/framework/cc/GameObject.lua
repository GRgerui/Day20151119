
local Registry = import(".Registry")

local GameObject = {}

function GameObject.extend(target)
    target.components_ = {} --target.components组件组是一个表

    function target:checkComponent(name)--检查是否有
        return self.components_[name] ~= nil
    end

    function target:addComponent(name)--添加一个
        local component = Registry.newObject(name)
        self.components_[name] = component
        component:bind_(self)
        return component
    end

    function target:removeComponent(name)--移除组件
        local component = self.components_[name]
        if component then component:unbind_() end
        self.components_[name] = nil
    end

    function target:getComponent(name)--获取组件
        return self.components_[name]
    end

    return target
end

return GameObject
