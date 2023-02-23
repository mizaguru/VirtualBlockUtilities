
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 仮想ブロック右クリックイベント
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 右クリックされたinteracitonにタグづけ
tag @e[tag=vb,tag=core,nbt={interaction:{}},limit=1] add r_click

execute as @e[tag=core,tag=r_click,limit=1] at @s run function vbu:gulliver_vb/set_vb_interaction

# 自身以外の仮想ブロックのチェック状態を解除
execute as @e[tag=vb,tag=detection,tag=check] run kill @s
execute as @e[tag=vb,tag=display,tag=check] run data modify entity @s brightness set value {sky:15,block:15}
execute as @e[tag=vb,tag=check] run tag @s remove check
# 自身をチェック状態にする
execute as @e[tag=vb,tag=!check] if score @s x = @e[tag=core,tag=r_click,limit=1] x if score @s y = @e[tag=core,tag=r_click,limit=1] y if score @s z = @e[tag=core,tag=r_click,limit=1] z run tag @s add check
scoreboard players set $tick _ 9


# 右クリックされたときに取得した情報を削除
execute as @e[tag=vb,tag=core,tag=r_click,limit=1] at @s run data remove entity @s interaction
tag @e[tag=vb,tag=core,tag=r_click,limit=1] remove r_click

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# 進捗リセット
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
advancement revoke @a only vbu:click_vb/right_click_core
