ui=require("framework.ui")
--游戏主要部分
ResourceLoadScene = require("app.scenes.ResourceLoadScene") --加载界面
StartScene = require("app.scenes.StartScene") --开始界面
SelectScene = require("app.scenes.SelectScene") --选择场景界面
SelectChapter = require("app.scenes.SelectChapter") --选择关卡界面
RotationScViewByMyself = require("app.class.RotationScViewByMyself") --关卡转轮层
GameScene = require("app.scenes.GameScene") --游戏关卡
--功能对象
scheduler = require(cc.PACKAGE_NAME .. ".scheduler") --计时器对象
BubbleButton = require("app.class.BubbleButton") --抖动按钮
HRocker = require("app.Hero.HRocker")
--弹出层
MessageBox = require("app.class.MessageBox")
Flylabel = require("app.class.Flylabel") --飘血 Node
SkillLayer = require("app.class.SkillLayer")
SetLayer = require("app.class.SetLayer") --音乐设置界面
Tujian = require("app.class.Tujian")
Pauselayer = require("app.class.Pauselayer")  	--暂停游戏层 左
WinLayer = require("app.class.WinLayer")	  --过关弹出层
LoseLayer = require("app.class.LoseLayer")	  --失败弹出层
--英雄
Player = require("app.Hero.Player") 		--状态机
HeroNode = require("app.Hero.HeroNode")
--怪物
OneMonster = require("app.Monster.OneMonster") 		--状态机 --小兵
OneMonsterNode = require("app.Monster.OneMonsterNode") 		--小兵
TwoMonster = require("app.Monster.TwoMonster") 		--状态机	--肉盾
TwoMonsterNode = require("app.Monster.TwoMonsterNode") 		--肉盾
ThreeMonster = require("app.Monster.ThreeMonster") 	--状态机 --法师
ThreeMonsterNode = require("app.Monster.ThreeMonsterNode") 	--法师

