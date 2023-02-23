
execute as @p if predicate vbu:is_looking_vb run say a




# 選択仮想ブロック可視化
scoreboard players add $tick _ 1
scoreboard players operation $tick _ %= $const_int_15 _
execute if entity @e[type=block_display,tag=vb,tag=check] if score $tick _ matches 0 as @e[type=block_display,tag=vb,tag=check] run data modify entity @s brightness set value {sky:15,block:15}
execute if entity @e[type=block_display,tag=vb,tag=check] if score $tick _ matches 10 as @e[type=block_display,tag=vb,tag=check] run data modify entity @s brightness set value {sky:0,block:0}