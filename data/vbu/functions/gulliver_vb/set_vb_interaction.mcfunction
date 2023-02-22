
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 仮想ブロックのクリック判定を設定する
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 6面分のinteractionを設置
execute positioned ~00.001 ~ ~ run summon minecraft:interaction ~ ~ ~ {height:0,width:0,Rotation:[270f,000f],Tags:["vb","detection","first","x+","x"]}
execute positioned ~-0.001 ~ ~ run summon minecraft:interaction ~ ~ ~ {height:0,width:0,Rotation:[090f,000f],Tags:["vb","detection","first","x-","x"]}
execute positioned ~ ~00.001 ~ run summon minecraft:interaction ~ ~ ~ {height:0,width:0,Rotation:[000f,-90f],Tags:["vb","detection","first","y+","y"]}
execute positioned ~ ~-0.001 ~ run summon minecraft:interaction ~ ~ ~ {height:0,width:0,Rotation:[000f,090f],Tags:["vb","detection","first","y-","y"]}
execute positioned ~ ~ ~00.001 run summon minecraft:interaction ~ ~ ~ {height:0,width:0,Rotation:[000f,000f],Tags:["vb","detection","first","z+","z"]}
execute positioned ~ ~ ~-0.001 run summon minecraft:interaction ~ ~ ~ {height:0,width:0,Rotation:[180f,000f],Tags:["vb","detection","first","z-","z"]}

# 位置の設定
#  x,zは半ブロック分位置補正
execute as @e[type=interaction,tag=detection,tag=first] run execute store result score @s _ run data get storage vbu:datas vb_calc_param.vb_size_half_3vec[0] 100000
execute as @e[type=interaction,tag=detection,tag=first] run execute store result score @s x run data get entity @s Pos[0] 100000
execute as @e[type=interaction,tag=detection,tag=first] run execute store result entity @s Pos[0] double 0.00001 run scoreboard players operation @s x += @s _
execute as @e[type=interaction,tag=detection,tag=first] run execute store result score @s _ run data get storage vbu:datas vb_calc_param.vb_size_half_3vec[2] 100000
execute as @e[type=interaction,tag=detection,tag=first] run execute store result score @s z run data get entity @s Pos[2] 100000
execute as @e[type=interaction,tag=detection,tag=first] run execute store result entity @s Pos[2] double 0.00001 run scoreboard players operation @s z += @s _

# サイズの設定
execute as @e[type=interaction,tag=detection,tag=first] run data modify entity @s height set from storage vbu:datas vb_calc_param.vb_size
execute as @e[type=interaction,tag=detection,tag=first] run data modify entity @s width set from storage vbu:datas vb_calc_param.vb_size

# 仮想座標の設定
#  coreと同期
scoreboard players operation @e[type=interaction,tag=detection,tag=first] x = @s x
scoreboard players operation @e[type=interaction,tag=detection,tag=first] y = @s y
scoreboard players operation @e[type=interaction,tag=detection,tag=first] z = @s z

# 方向情報を保持
scoreboard players set @e[type=interaction,tag=detection,tag=first,tag=x+] dx 01
scoreboard players set @e[type=interaction,tag=detection,tag=first,tag=x-] dx -1
scoreboard players set @e[type=interaction,tag=detection,tag=first,tag=y+] dy 01
scoreboard players set @e[type=interaction,tag=detection,tag=first,tag=y-] dy -1
scoreboard players set @e[type=interaction,tag=detection,tag=first,tag=z+] dz 01
scoreboard players set @e[type=interaction,tag=detection,tag=first,tag=z-] dz -1

# ブロックに面するdetectionは打ち消しあう(未実装)
# 6方向にブロックがあるか
# 重なる面のinteractionを削除(未実装)


# 初期設定が完了したのでフラグを削除
execute as @e[type=interaction,tag=detection,tag=first] run tag @s remove first
