
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# set_vb
#  in:$target:右クリックした仮想座標x,y,z、
#             クリックした面情報はdx,dy,dz
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
scoreboard players operation $next x = $target x
scoreboard players operation $next y = $target y
scoreboard players operation $next z = $target z
scoreboard players operation $next x += $target dx
scoreboard players operation $next y += $target dy
scoreboard players operation $next z += $target dz


execute store result storage vbu:datas vb_info.vPos[0] int 1 run scoreboard players get $next x
execute store result storage vbu:datas vb_info.vPos[1] int 1 run scoreboard players get $next y
execute store result storage vbu:datas vb_info.vPos[2] int 1 run scoreboard players get $next z


# 既に仮想ブロックのある座標に設置しようとしているか
#  $isExist=1の場合、既に存在しているので仮想ブロック設置を行わない
scoreboard players set $isExist _ 0
execute as @e[tag=vb,tag=core] if score $next x = @s x if score $next y = @s y if score $next z = @s z run scoreboard players set $isExist _ 1
# 仮想ワールド(storage)にブロック情報を登録
execute if score $isExist _ = $const_int_0 _ run data modify storage vbu:datas vb_world.coodinate append from storage vbu:datas vb_info

# 仮想ブロックの設置
# coreという名のテキスト
execute if score $isExist _ = $const_int_0 _ as @e[tag=vb,tag=core] if score @s x = $target x if score @s y = $target y if score @s z = $target z at @s summon minecraft:text_display run function vbu:gulliver_vb/set_vb_core_info
# ブロック表示
execute if score $isExist _ = $const_int_0 _ as @e[tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_display
# クリック判定
execute if score $isExist _ = $const_int_0 _ as @e[tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_interaction


# 仮想ブロックの初期設定が終了したのでフラグを削除
tag @e[tag=vb,tag=core,tag=first] remove first

# 繰り返しに備えて、$nextの仮想座標を次の$targetとする
scoreboard players operation $target x = $next x
scoreboard players operation $target y = $next y
scoreboard players operation $target z = $next z