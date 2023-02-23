
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# このページは製作者のメモです。気にしないでください。
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# TODO memo
# ・同一座標に設置できないようにする
# 　->設置時の座標をstorageに保存、右クリック時に参照して存在していない場合に設置する。
#    ->現状はscoreで存在を確認している
#   ->破壊時に削除する
# ・範囲設置　線、面、柱、円、球
# ・向き　通常はaxisなどを使う(影も正しいし。)
# 　　　　ハーフブロックや作業台など通常じゃないものはスライムボールを左手に持つ場合
# ・ブロックから仮想ブロックへ変換
# ・仮想ブロックの拡大縮小
# ・ピストン/粘着ピストン
# ・直接ブロックの種類変更
# ・storageで座標を渡すと削除できるようになるといいな(願望)
# 
# 
# 
# 


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 向きとかの調査BK
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 向きの反映
# execute if entity @e[tag=r_click,tag=x] run data modify entity @s block_state.Properties merge value {axis:"x"}
# execute if entity @e[tag=r_click,tag=y] run data modify entity @s block_state.Properties merge value {axis:"y"}
# execute if entity @e[tag=r_click,tag=z] run data modify entity @s block_state.Properties merge value {axis:"z"}
# execute if entity @e[tag=r_click,tag=y-] run data modify entity @s block_state.Properties merge value {type:"top"}
# execute if entity @e[tag=r_click,tag=y+] run data modify entity @s block_state.Properties merge value {type:"bottom"}
# execute if entity @e[tag=r_click,tag=z+] run data modify entity @s block_state.Properties merge value {facing:"north"}
# execute if entity @e[tag=r_click,tag=z-] run data modify entity @s block_state.Properties merge value {facing:"south"}
# execute if entity @e[tag=r_click,tag=x-] run data modify entity @s block_state.Properties merge value {facing:"east"}
# execute if entity @e[tag=r_click,tag=x+] run data modify entity @s block_state.Properties merge value {facing:"west"}
# execute if entity @e[tag=r_click,tag=y+] run data modify entity @s block_state.Properties merge value {facing:"up"}
# execute if entity @e[tag=r_click,tag=y-] run data modify entity @s block_state.Properties merge value {facing:"down"}

# # 角度の反映
# # クオータニアンの作成
# execute positioned 0.0 0.0 0.0 summon minecraft:marker run function mycircle:diorama/set_block_display_rotation
# # クオータニアンの反映
# execute run data modify entity @s transformation.left_rotation set from storage mycircle:datas mini_block_info.axis_y_rotation


# ※階段ベースで回転を揃えたい。
# # x軸方向
# execute if entity @e[tag=r_click,tag=x+] run data modify entity @s transformation.right_rotation set value [0.0f,0.0f,0.7071f,-0.7071f]
# execute if entity @e[tag=r_click,tag=x+] run data modify entity @s transformation.translation[1] set from storage mycircle:datas mini_block_info.size_rate_arr[1]
# execute if entity @e[tag=r_click,tag=x-] run data modify entity @s transformation.right_rotation set value [0.0f,0.0f,0.7071f,00.7071f]
# execute if entity @e[tag=r_click,tag=x-] run data modify entity @s transformation.translation[0] set from storage mycircle:datas mini_block_info.block_display_translation_arr-[0]

# # y軸方向
# execute if entity @e[tag=r_click,tag=y-] run data modify entity @s transformation.right_rotation set value {angle:3.14f,axis:[0.0f,0.0f,1.0f]}
# execute if entity @e[tag=r_click,tag=y-] run data modify entity @s transformation.translation[0] set from storage mycircle:datas mini_block_info.block_display_translation_arr-[0]
# execute if entity @e[tag=r_click,tag=y-] run data modify entity @s transformation.translation[1] set from storage mycircle:datas mini_block_info.size_rate_arr[1]

# # z軸方向
# execute if entity @e[tag=r_click,tag=z+] run data modify entity @s transformation.right_rotation set value [0.7071f,0.0f,0.0f,00.7071f]
# execute if entity @e[tag=r_click,tag=z+] run data modify entity @s transformation.translation[1] set from storage mycircle:datas mini_block_info.size_rate_arr[1]
# execute if entity @e[tag=r_click,tag=z-] run data modify entity @s transformation.right_rotation set value [0.7071f,0.0f,0.0f,-0.7071f]
# execute if entity @e[tag=r_click,tag=z-] run data modify entity @s transformation.translation[2] set from storage mycircle:datas mini_block_info.block_display_translation_arr-[2]




