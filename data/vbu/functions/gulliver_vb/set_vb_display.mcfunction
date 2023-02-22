
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 仮想ブロックのブロック表示を設定する
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# block_displayを設置
execute positioned ~ ~ ~ run summon minecraft:block_display ~ ~ ~ {Tags:["vb","display","first"]}

# サイズの設定
data modify entity @e[type=block_display,tag=display,tag=first,limit=1] transformation.scale set from storage vbu:datas vb_calc_param.vb_size_3vec

# 仮想座標の設定
#  coreと同期
scoreboard players operation @e[type=block_display,tag=display,tag=first,limit=1] x = @s x
scoreboard players operation @e[type=block_display,tag=display,tag=first,limit=1] y = @s y
scoreboard players operation @e[type=block_display,tag=display,tag=first,limit=1] z = @s z

# ブロック情報の反映
data modify entity @e[type=block_display,tag=display,tag=first,limit=1] block_state.Name set from storage vbu:datas vb_info.id


# 初期設定が完了したのでフラグを削除
tag @e[type=block_display,tag=display,tag=first,limit=1] remove first

