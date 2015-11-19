module("HeroData",package.seeall)
Data = {}
--属性
Data.HP = 1000 --血量
Data.MP = 200 --蓝量
Data.AC = 54  --攻击
Data.A1 = 185 --技能1
Data.A2 = 194 --技能2
Data.A3 = 153 --技能3
Data.A4 = 215 --技能4

Data.SD = 100	  --技能点
Data.HPSD = 0
Data.ACSD = 0
Data.P1SD = 0
Data.P2SD = 0
Data.P3SD = 0

Data.P4SD = 0

Data.P5SD = 0

Data.isPlayMusic = true --音乐控制开关
Data.isPlaySound = true --音效控制开关


function MusicSound()
    if Data.isPlaySound then
        audio.playSound("click.mp3")
    end
end
function MusicBack()
    if Data.isPlayMusic==true then
        audio.playMusic("menubackmusic.mp3",true)
        audio.setMusicVolume(0.75)
    end
end

function getSD()
	return Data.SD
end
function setSD(x)
	Data.SD = x
end
function getHP()
	return Data.HP
end
function setHP(x)
	Data.HP = x
end
function getMP()
	return Data.MP
end
function setMP(x)
	Data.MP = x
end