module("ModifyData",package.seeall)
scene = 1
chapter = 1
star = 0
Mp = 0 
SD = 0
heroPos = {x = 1,y = 1}
function getSD()
	return SD
end
function setSD(x)
	SD = x
end

function getMP()
	return MP
end
function setMP(x)
	MP = x
end
function setSceneNum( num )
	scene=num
end
function setChapterNum( num )
	chapter=num
end
function setStarNum( num )
	star=num
end
function getSceneNum( )
	return scene
end
function getChapterNum( ) 
	return chapter
end
function getStarNum( )
	return star
end
		--写入文件
function WriteDataToDoc( t ) --传入表
	local str = json.encode(t)
	--str = crypto.encryptXXTEA(t, "123456")
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
	local f = assert(io.open(docpath,'w'))
	f:write(str)
	f:close()
end
		 --读出文件
function ReadDataToDoc() 
	local path = cc.FileUtils:getInstance():getWritablePath().."data.txt"
	local str = cc.FileUtils:getInstance():getStringFromFile(path)
	--str = crypto.decryptXXTEA(str, "123456")
	return json.decode(str) 
end

function WriteDataToDocHero( t ) --传入表
	local str = json.encode(t)
	--str = crypto.encryptXXTEA(t, "123456")
	local docpath = cc.FileUtils:getInstance():getWritablePath().."herodata.txt"
	local f = assert(io.open(docpath,'w'))
	f:write(str)
	f:close()
end
		 --读出文件
function ReadDataToDocHero() --传入表
	local path = cc.FileUtils:getInstance():getWritablePath().."herodata.txt"
	local str = cc.FileUtils:getInstance():getStringFromFile(path)
	--str = crypto.decryptXXTEA(str, "123456")
	return json.decode(str) 
end