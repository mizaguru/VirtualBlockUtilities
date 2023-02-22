
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# 仮想ブロックの削除
# ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
# プレイヤーが左クリックした仮想座標の仮想ブロックを削除
execute as @e[tag=vb] if score @s x = @e[tag=l_click,limit=1] x if score @s y = @e[tag=l_click,limit=1] y if score @s z = @e[tag=l_click,limit=1] z at @s run kill @s

# 削除した仮想ブロックの周囲のinteractionの補填(未実装 そもそも重複interactionの削除が未実装)
