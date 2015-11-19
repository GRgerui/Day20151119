module("MonsterData",package.seeall)

--怪物属性表

SCENE={} --总表
SCENE[1] = {} --分表1对应场景1 
						--速度    攻击距离     攻击力     血量       --肉盾--                                             --法师--
SCENE[1][1] = {boy1 = {Speed = 1,range =100,power =241,hp = 600} ,boy2 = {Speed = 1,range = 70,power = 100,hp = 1800},boy3 = {Speed = 1,range = 220,power = 356,hp = 600}}
SCENE[1][2] = {boy1 = {Speed = 1,range =100,power =294,hp = 700} ,boy2 = {Speed = 1,range = 70,power = 110,hp = 1800},boy3 = {Speed = 1,range = 220,power = 320,hp = 700}}
SCENE[1][3] = {boy1 = {Speed = 2,range =120,power =312,hp = 800} ,boy2 = {Speed = 2,range = 70,power = 110,hp = 2000},boy3 = {Speed = 2,range = 220,power = 380,hp = 800}}
SCENE[1][4] = {boy1 = {Speed = 2,range =120,power =351,hp = 900} ,boy2 = {Speed = 2,range = 80,power = 120,hp = 2100},boy3 = {Speed = 2,range = 220,power = 369,hp = 900}}
SCENE[1][5] = {boy1 = {Speed = 3,range =130,power =453,hp = 1000},boy2 = {Speed = 2,range = 80,power = 120,hp = 2300},boy3 = {Speed = 2,range = 220,power = 451,hp = 1200}}

SCENE[2]={}   --分表2对应场景2
						--速度    攻击距离     攻击力     血量       --肉盾--                                             --法师--
SCENE[2][1] = {boy1 = {Speed = 1,range =100,power =562,hp = 800} ,boy2 = {Speed = 2,range = 80,power = 120,hp = 2700},boy3 = {Speed = 1,range = 240,power = 540,hp = 1500}}
SCENE[2][2] = {boy1 = {Speed = 2,range =110,power =543,hp = 800} ,boy2 = {Speed = 1,range = 80,power = 120,hp = 2800},boy3 = {Speed = 2,range = 280,power = 460,hp = 1700}}
SCENE[2][3] = {boy1 = {Speed = 2,range =120,power =682,hp = 900} ,boy2 = {Speed = 2,range = 80,power = 130,hp = 3000},boy3 = {Speed = 1,range = 260,power = 481,hp = 2000}}
SCENE[2][4] = {boy1 = {Speed = 2,range =130,power =712,hp = 900} ,boy2 = {Speed = 1,range = 90,power = 130,hp = 3500},boy3 = {Speed = 1,range = 300,power = 524,hp = 2500}}
SCENE[2][5] = {boy1 = {Speed = 3,range =140,power =764,hp =1000} ,boy2 = {Speed = 2,range = 90,power = 150,hp = 4500},boy3 = {Speed = 2,range = 320,power = 537,hp = 3000}}

SCENE[3]={}   --分表3对应场景3
						--速度    攻击距离     攻击力     血量       --肉盾--                                             --法师--
SCENE[3][1] = {boy1 = {Speed = 2,range =100,power =645,hp = 900} ,boy2 = {Speed = 3,range = 80,power = 754,hp = 3000},boy3 = {Speed = 2,range = 320,power = 431,hp = 1200}}
SCENE[3][2] = {boy1 = {Speed = 3,range =120,power =764,hp = 900} ,boy2 = {Speed = 2,range = 90,power = 749,hp = 3500},boy3 = {Speed = 2,range = 350,power = 481,hp = 1500}}
SCENE[3][3] = {boy1 = {Speed = 2,range =130,power =741,hp =1000} ,boy2 = {Speed = 2,range =100,power = 760,hp = 4000},boy3 = {Speed = 2,range = 300,power = 492,hp = 1800}}
SCENE[3][4] = {boy1 = {Speed = 3,range =150,power =761,hp =1000} ,boy2 = {Speed = 2,range =110,power = 840,hp = 4500},boy3 = {Speed = 2,range = 320,power = 524,hp = 2100}}
SCENE[3][5] = {boy1 = {Speed = 3,range =180,power =842,hp =1200} ,boy2 = {Speed = 3,range =120,power = 999,hp = 5000},boy3 = {Speed = 3,range = 400,power = 13240,hp = 3200}}

