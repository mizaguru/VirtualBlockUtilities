
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 既存仮想ブロックの削除
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
kill @e[tag=vb]

# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# ストレージ初期化
# player_input:プレイヤーからの入力を一時的に記憶
# vb_info:1ブロック単位の情報を格納
# vb_world:仮想座標などワールドに関する情報を格納
# vb_calc_param:サイズや位置など計算に利用
# click_info:クリックされた面などの情報を格納
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
data modify storage vbu:datas player_input set value {}
data modify storage vbu:datas player_input.left_hand set from entity @p Inventory[{Slot:-106b}]
data modify storage vbu:datas player_input.main_hand set from entity @p SelectedItem
data modify storage vbu:datas vb_info set value {}
data modify storage vbu:datas vb_world set value {}
data modify storage vbu:datas vb_calc_param set value {vb_size_3vec:[0.0f,0.0f,0.0f],vb_size_half_3vec:[0.0f,0.0f,0.0f]}
data modify storage vbu:datas click_info set value {}

# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 世界系の大小フラグ
#  左手アイテムが「発酵したクモの目」の場合:小世界
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
execute if data storage vbu:datas player_input.left_hand{id:"minecraft:fermented_spider_eye"} run data modify storage vbu:datas vb_world set value {is_small:true}

# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# サイズなどの設定値を計算
#  vb_calc_param.vb_size
#   大世界の場合:[左手アイテムカウント]倍
#   小世界の場合:1/[左手アイテムカウント]
#  vb_calc_param.vb_size_3vec
#   display系のサイズ設定に利用
#  vb_calc_param.vb_size_half
#   エンティティの位置などを補正するために利用
#  vb_calc_param.vb_size_half_3vec
#   block_displayのtranslation補正するために利用 y座標は一致しているため0
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# vb_calc_param.vb_size
scoreboard players set $vb_size _ 100000
execute store result score $tmp _ run data get storage vbu:datas player_input.left_hand.Count 1
execute if score $tmp _ = $const_int_0 _ run scoreboard players set $tmp _ 1 
execute unless data storage vbu:datas vb_world{is_small:true} store result storage vbu:datas vb_calc_param.vb_size float 0.00001 run scoreboard players operation $vb_size _ *= $tmp _
execute if data storage vbu:datas vb_world{is_small:true} store result storage vbu:datas vb_calc_param.vb_size float 0.00001 run scoreboard players operation $vb_size _ /= $tmp _
# vb_calc_param.vb_size_3vec
execute store result storage vbu:datas vb_calc_param.vb_size_3vec[0] float 0.00001 run scoreboard players get $vb_size _
execute store result storage vbu:datas vb_calc_param.vb_size_3vec[1] float 0.00001 run scoreboard players get $vb_size _
execute store result storage vbu:datas vb_calc_param.vb_size_3vec[2] float 0.00001 run scoreboard players get $vb_size _
# vb_calc_param.vb_size_half
execute store result storage vbu:datas vb_calc_param.vb_size_half float 0.00001 run scoreboard players operation $vb_size _ /= $const_int_2 _
# vb_calc_param.vb_size_half_3vec
execute store result storage vbu:datas vb_calc_param.vb_size_half_3vec[0] float 0.00001 run scoreboard players get $vb_size _
execute store result storage vbu:datas vb_calc_param.vb_size_half_3vec[1] float 0 run scoreboard players get $vb_size _
execute store result storage vbu:datas vb_calc_param.vb_size_half_3vec[2] float 0.00001 run scoreboard players get $vb_size _

# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 原点となる仮想ブロックの設置
#  set_vb_core_info:text_displayをcoreとしている。(markerのほうがよかった？)
#  set_vb_display:
#  set_vb_detection:
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 設置する仮想ブロック情報(原点)作成
# 仮想座標
data modify storage vbu:datas vb_info.vPos set value [0,0,0]
# 表示ブロック
data modify storage vbu:datas vb_info.id set value "minecraft:bedrock"
# 仮想ワールド(storage)にブロック情報を登録
data modify storage vbu:datas vb_world.coodinate append from storage vbu:datas vb_info

# 仮想ブロックの設置
scoreboard players set $target x 0
scoreboard players set $target y 0
scoreboard players set $target z 0
# core looking_atするためにinteraction
summon minecraft:interaction ~ ~ ~ {height:0,Tags:["vb","core","origin"]}
execute as @s at @s anchored eyes positioned ^ ^ ^1.0 align xyz as @e[tag=vb,tag=origin,limit=1] run tp @s ~ ~ ~
execute as @e[tag=vb,tag=origin,limit=1] at @s run function vbu:gulliver_vb/set_vb_core_info
#  ブロック表示
execute as @e[tag=vb,tag=origin,limit=1] at @s run function vbu:gulliver_vb/set_vb_display
#  クリック判定
execute as @e[tag=core,tag=origin,limit=1] at @s run function vbu:gulliver_vb/set_vb_interaction
#  仮想ブロックを選択状態にする
execute as @e[tag=vb] if score @s x = $target x if score @s y = $target y if score @s z = $target z run tag @s add check
scoreboard players set $tick _ 9

tag @e[tag=vb,tag=origin] remove origin

