
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# set_vb
#  in:$target:右クリックした仮想座標x,y,z、
#             クリックした面情報はdx,dy,dz
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 右クリックした仮想座標
scoreboard players operation $next x = $target x
scoreboard players operation $next y = $target y
scoreboard players operation $next z = $target z
# クリックした面情報
scoreboard players operation $next x += $target dx
scoreboard players operation $next y += $target dy
scoreboard players operation $next z += $target dz

# 既に仮想ブロックのある座標に設置しようとしているか
#  $isExist=1の場合、既に存在しているので仮想ブロック設置を行わない
scoreboard players set $isExist _ 0
execute as @e[tag=vb,tag=core] if score $next x = @s x if score $next y = @s y if score $next z = @s z run scoreboard players set $isExist _ 1
# 仮想ワールド(storage)にブロック情報を登録
execute if score $isExist _ matches 0 store result storage vbu:datas vb_info.vPos[0] int 1 run scoreboard players get $next x
execute if score $isExist _ matches 0 store result storage vbu:datas vb_info.vPos[1] int 1 run scoreboard players get $next y
execute if score $isExist _ matches 0 store result storage vbu:datas vb_info.vPos[2] int 1 run scoreboard players get $next z
execute if score $isExist _ matches 0 run data modify storage vbu:datas vb_world.coodinate append from storage vbu:datas vb_info

# 仮想ブロックの設置
#  coreとしてinteraction
execute if score $isExist _ matches 0 run summon minecraft:interaction ~ ~ ~ {height:0,Tags:["vb","core","first"]}
execute if score $isExist _ matches 0 as @e[tag=vb,tag=core,tag=!first] if score @s x = $target x if score @s y = $target y if score @s z = $target z at @s as @e[tag=vb,tag=core,tag=first,limit=1] run tp @s ~ ~ ~
execute if score $isExist _ matches 0 as @e[tag=vb,tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_core_info
#  ブロック表示
execute if score $isExist _ matches 0 as @e[tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_display
#  クリック判定
execute if score $isExist _ matches 0 as @e[tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_interaction
#  自身をチェック状態にする
execute if score $isExist _ matches 0 as @e[tag=vb] if score @s x = $next x if score @s y = $next y if score @s z = $next z run tag @s add check
scoreboard players set $tick _ 9

# 設置不可ブロックの場合、設置した仮想ブロックを削除し、以降の処理をキャンセル
scoreboard players set $not_placable_block _ 0
execute if score $isExist _ matches 0 as @e[tag=vb,tag=display] if score @s x = $next x if score @s y = $next y if score @s z = $next z if data entity @s block_state{Name:"minecraft:air"} run scoreboard players set $not_placable_block _ 1
execute if score $isExist _ matches 0 if score $not_placable_block _ matches 1 as @e[tag=vb] if score @s x = $next x if score @s y = $next y if score @s z = $next z run kill @s

# 右クリックされた仮想ブロックの選択状態を解除 ただし、設置不可ブロックで右クリックした場合は選択状態を解除しない
execute if score $not_placable_block _ matches 0 as @e[tag=vb,tag=check,tag=display] if score @s x = $target x if score @s y = $target y if score @s z = $target z run data modify entity @s brightness set value {sky:15,block:15}
execute if score $not_placable_block _ matches 0 as @e[tag=vb,tag=check,tag=detection] if score @s x = $target x if score @s y = $target y if score @s z = $target z run kill @s
execute if score $not_placable_block _ matches 0 as @e[tag=vb,tag=check] if score @s x = $target x if score @s y = $target y if score @s z = $target z run tag @s remove check

# 仮想ブロックの初期設定が終了したのでフラグを削除
tag @e[tag=vb,tag=core,tag=first] remove first

# 繰り返しに備えて、$nextの仮想座標を次の$targetとする
scoreboard players operation $target x = $next x
scoreboard players operation $target y = $next y
scoreboard players operation $target z = $next z