
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 仮想ブロック右クリックイベント
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 右クリックされたinteracitonにタグづけ
tag @e[tag=detection,nbt={interaction:{}},limit=1] add r_click

# 設置する仮想ブロック情報作成
# 仮想座標
scoreboard players operation $tmp x = @e[tag=r_click,limit=1] x
scoreboard players operation $tmp y = @e[tag=r_click,limit=1] y
scoreboard players operation $tmp z = @e[tag=r_click,limit=1] z
execute store result storage vbu:datas vb_info.vPos[0] int 1 run scoreboard players operation $tmp x += @e[tag=r_click,limit=1] dx
execute store result storage vbu:datas vb_info.vPos[1] int 1 run scoreboard players operation $tmp y += @e[tag=r_click,limit=1] dy
execute store result storage vbu:datas vb_info.vPos[2] int 1 run scoreboard players operation $tmp z += @e[tag=r_click,limit=1] dz
# 表示ブロック
execute if entity @e[tag=r_click] run data modify storage vbu:datas vb_info.id set from entity @p SelectedItem.id

# 仮想ブロックの設置
# coreという名のテキスト
execute as @e[tag=vb,tag=core] if score @s x = @e[tag=r_click,limit=1] x if score @s y = @e[tag=r_click,limit=1] y if score @s z = @e[tag=r_click,limit=1] z at @s summon minecraft:text_display run function vbu:gulliver_vb/set_vb_core_info
# ブロック表示
execute as @e[tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_display
# クリック判定
execute as @e[tag=core,tag=first,limit=1] at @s run function vbu:gulliver_vb/set_vb_interaction

# 右クリックされたときに取得した情報を削除
execute as @e[tag=r_click,limit=1] at @s run data remove entity @s interaction
# 仮想ブロックの初期設定が終了したのでフラグを削除
tag @e[tag=vb,tag=core,tag=first] remove first
tag @e[tag=detection,tag=r_click] remove r_click

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 進捗リセット
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
advancement revoke @a only vbu:click_vb/right_click
