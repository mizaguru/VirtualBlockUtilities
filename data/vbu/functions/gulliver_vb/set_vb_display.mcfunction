
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 仮想ブロックのブロック表示を設定する
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# block_displayを設置
execute positioned ~ ~ ~ run summon minecraft:block_display ~ ~ ~ {height:0,width:0,Tags:["vb","display","first"]}



# 位置の設定
#  仮想ワールド1つ目の仮想ブロックの場合(origin):
#   x,zは半ブロック分位置補正
execute as @e[tag=vb,tag=display,tag=first,limit=1] store result score @s dx run data get storage vbu:datas vb_calc_param.vb_size_half_3vec[0] 100000
execute as @e[tag=vb,tag=display,tag=first,limit=1] store result score @s dz run data get storage vbu:datas vb_calc_param.vb_size_half_3vec[2] 100000
execute as @e[tag=vb,tag=display,tag=first,limit=1] store result score @s x run data get entity @s Pos[0] 100000
execute as @e[tag=vb,tag=display,tag=first,limit=1] store result score @s z run data get entity @s Pos[2] 100000
execute as @e[tag=vb,tag=display,tag=first,limit=1] store result entity @s Pos[0] double 0.00001 run scoreboard players operation @s x -= @s dx
execute as @e[tag=vb,tag=display,tag=first,limit=1] store result entity @s Pos[2] double 0.00001 run scoreboard players operation @s z -= @s dz

# サイズの設定
data modify entity @e[tag=vb,tag=display,tag=first,limit=1] transformation.scale set from storage vbu:datas vb_calc_param.vb_size_3vec

# 仮想座標の設定
#  coreと同期
scoreboard players operation @e[tag=vb,tag=display,tag=first,limit=1] x = @s x
scoreboard players operation @e[tag=vb,tag=display,tag=first,limit=1] y = @s y
scoreboard players operation @e[tag=vb,tag=display,tag=first,limit=1] z = @s z

# ブロック情報の設定
data modify entity @e[tag=vb,tag=display,tag=first,limit=1] block_state.Name set from storage vbu:datas vb_info.id
# tellraw @a [{"text":"text"},{"entity":"@e[tag=vb,tag=display,tag=first,limit=1]","nbt":"block_state.Name"}] 

# 明るさの設定
data modify entity @e[tag=vb,tag=display,tag=first,limit=1] brightness set value {sky:15,block:15}

# 初期設定が完了したのでフラグを削除
tag @e[tag=vb,tag=display,tag=first,limit=1] remove first

