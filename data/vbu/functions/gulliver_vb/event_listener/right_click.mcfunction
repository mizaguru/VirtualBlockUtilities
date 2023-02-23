
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 仮想ブロック右クリックイベント
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 右クリックされたinteracitonにタグづけ
tag @e[tag=detection,nbt={interaction:{}},limit=1] add r_click

# 設置する仮想ブロック情報作成
# 仮想座標 vb_info.vPosと計算用として$target:クリックした仮想座標 $next:設置しようとしている仮想座標
scoreboard players operation $target x = @e[tag=r_click,limit=1] x
scoreboard players operation $target y = @e[tag=r_click,limit=1] y
scoreboard players operation $target z = @e[tag=r_click,limit=1] z
scoreboard players operation $target dx = @e[tag=r_click,limit=1] dx
scoreboard players operation $target dy = @e[tag=r_click,limit=1] dy
scoreboard players operation $target dz = @e[tag=r_click,limit=1] dz

# 表示ブロック情報取得
#  メインハンドが紙以外の場合:表示ブロック情報をメインハンドアイテムに更新
data modify storage vbu:datas player_input.main_hand set from entity @p SelectedItem
execute if entity @e[tag=r_click] unless data storage vbu:datas player_input.main_hand{id:"minecraft:paper"} run data modify storage vbu:datas vb_info.id set from storage vbu:datas player_input.main_hand.id
#  メインハンドが紙場合:クリックした仮想ブロックの表示ブロック情報を取得:紙を複製ツールとして利用するため
execute if entity @e[tag=r_click] if data storage vbu:datas player_input.main_hand{id:"minecraft:paper"} as @e[tag=vb,tag=display] if score @s x = $target x if score @s y = $target y if score @s z = $target z run data modify storage vbu:datas vb_info.id set from entity @s block_state.Name

# 右クリックされたときに取得した情報を削除
execute as @e[tag=r_click,limit=1] at @s run data remove entity @s interaction
tag @e[tag=detection,tag=r_click] remove r_click

# 仮想ブロック設置main
#  メインハンドが紙:アイテム数回繰り返す
execute store result score $count _ run data get storage vbu:datas player_input.main_hand.Count
execute if data storage vbu:datas player_input.main_hand{id:"minecraft:paper"} run function vbu:gulliver_vb/set_vb_recursive
#  紙以外ならば、1回だけ実行
execute unless data storage vbu:datas player_input.main_hand{id:"minecraft:paper"} run function vbu:gulliver_vb/set_vb

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 進捗リセット
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
advancement revoke @a only vbu:click_vb/right_click
