
require("config")
require("cocos.init")
require("framework.init")
require("app.class.ClassManager")
require("app.GameData.CSData")
require("app.GameData.HeroData")
require("app.GameData.ModifyData")
require("app.GameData.SkillData")
require("app.GameData.MonsterData")	
require("app.class.EnemyGoonMudo")
local MyApp = class("MyApp", cc.mvc.AppBase)
function MyApp:ctor()
    MyApp.super.ctor(self)
end
function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/ui")
    cc.FileUtils:getInstance():addSearchPath("res/roleanimate/")--添加资源文件收索路径
    cc.FileUtils:getInstance():addSearchPath("res/scene/")
    cc.FileUtils:getInstance():addSearchPath("res/sound/")
    cc.FileUtils:getInstance():addSearchPath("res/fonts/")
	cc.FileUtils:getInstance():addSearchPath("res/gateMap/")
    self:enterScene("ResourceLoadScene")
end

return MyApp
