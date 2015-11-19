module("CSData",package.seeall)

--调用表 CSData.SCENE[][] ...
function getAllStarNum() --得到星星总数
	local starnum = 0
	for i=1,3 do
		for j=1,5 do
			starnum = starnum + CSData.SCENE[i][j].star
		end
	end
	return starnum
end
--locl   1开0关
--star   所得星星数
--boy    怪物数
SCENE={} --总表
SCENE[1] = {} --分表1对应场景1
SCENE[1][1] = {lock = 1, star = 0, boy1 = 4 ,boy2 = 0,boy3 = 0}
SCENE[1][2] = {lock = 0, star = 0, boy1 = 2 ,boy2 = 4,boy3 = 0}
SCENE[1][3] = {lock = 0, star = 0, boy1 = 3 ,boy2 = 6,boy3 = 0}
SCENE[1][4] = {lock = 0, star = 0, boy1 = 6 ,boy2 = 3,boy3 = 1}
SCENE[1][5] = {lock = 0, star = 0, boy1 = 7 ,boy2 = 4,boy3 = 2}

SCENE[2]={}   --分表2对应场景2
SCENE[2][1] = {lock = 0, star = 0, boy1 = 3 ,boy2 = 4,boy3 = 3}	--关卡
SCENE[2][2] = {lock = 0, star = 0, boy1 = 4 ,boy2 = 5,boy3 = 3}
SCENE[2][3] = {lock = 0, star = 0, boy1 = 5 ,boy2 = 4,boy3 = 3}
SCENE[2][4] = {lock = 0, star = 0, boy1 = 6 ,boy2 = 5,boy3 = 4}
SCENE[2][5] = {lock = 0, star = 0, boy1 = 7 ,boy2 = 7,boy3 = 7}

SCENE[3]={}   --分表3对应场景3
SCENE[3][1] = {lock = 0, star = 0, boy1 = 3 ,boy2 = 4,boy3 = 2}	--关卡
SCENE[3][2] = {lock = 0, star = 0, boy1 = 4 ,boy2 = 5,boy3 = 3}
SCENE[3][3] = {lock = 0, star = 0, boy1 = 7 ,boy2 = 2,boy3 = 1}
SCENE[3][4] = {lock = 0, star = 0, boy1 = 4 ,boy2 = 8,boy3 = 4}
SCENE[3][5] = {lock = 0, star = 0, boy1 = 9 ,boy2 = 9,boy3 = 9}