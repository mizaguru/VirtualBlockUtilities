
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 仮想ブロックのcoreを設定
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----

# タグの追加
tag @s add vb
tag @s add core
tag @s add first

# 位置の設定
#  設置面方向へ移動: 仮想ワールドに1つ以上仮想ブロックが存在する場合
#  coreはxyzのどれか１つにサイズ分だけ移動するため、[サイズ×方向情報(dx,dy,dz)+座標]の計算により移動先の座標を求める
execute if data storage vbu:datas vb_world.coodinate[1] store result score @s dx run data get storage vbu:datas vb_calc_param.vb_size_3vec[0] 100000
execute if data storage vbu:datas vb_world.coodinate[1] store result score @s dy run data get storage vbu:datas vb_calc_param.vb_size_3vec[1] 100000
execute if data storage vbu:datas vb_world.coodinate[1] store result score @s dz run data get storage vbu:datas vb_calc_param.vb_size_3vec[2] 100000
execute if data storage vbu:datas vb_world.coodinate[1] run scoreboard players operation @s dx *= $target dx
execute if data storage vbu:datas vb_world.coodinate[1] run scoreboard players operation @s dy *= $target dy
execute if data storage vbu:datas vb_world.coodinate[1] run scoreboard players operation @s dz *= $target dz
execute if data storage vbu:datas vb_world.coodinate[1] store result score @s x run data get entity @s Pos[0] 100000
execute if data storage vbu:datas vb_world.coodinate[1] store result score @s y run data get entity @s Pos[1] 100000
execute if data storage vbu:datas vb_world.coodinate[1] store result score @s z run data get entity @s Pos[2] 100000
execute if data storage vbu:datas vb_world.coodinate[1] store result entity @s Pos[0] double 0.00001 run scoreboard players operation @s x += @s dx
execute if data storage vbu:datas vb_world.coodinate[1] store result entity @s Pos[1] double 0.00001 run scoreboard players operation @s y += @s dy
execute if data storage vbu:datas vb_world.coodinate[1] store result entity @s Pos[2] double 0.00001 run scoreboard players operation @s z += @s dz

# 仮想座標の設定
execute store result score @s x run data get storage vbu:datas vb_info.vPos[0]
execute store result score @s y run data get storage vbu:datas vb_info.vPos[1]
execute store result score @s z run data get storage vbu:datas vb_info.vPos[2]
# 仮想座標の表示 
data modify entity @s text set value '[{"score":{"name":"@s","objective":"x"}},{"text":","},{"score":{"name":"@s","objective":"y"}},{"text":","},{"score":{"name":"@s","objective":"z"}}]'

# 表示上の位置の設定
#  x,zは半ブロック、yは1ブロック分補正
execute as @s run data modify entity @s transformation.translation set from storage vbu:datas vb_calc_param.vb_size_half_3vec
execute as @s run data modify entity @s transformation.translation[1] set from storage vbu:datas vb_calc_param.vb_size
# サイズの設定
execute as @s run data modify entity @s transformation.scale set from storage vbu:datas vb_calc_param.vb_size_3vec
