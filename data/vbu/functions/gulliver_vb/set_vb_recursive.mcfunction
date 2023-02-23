
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# set_vbを再帰的に実行する
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
function vbu:gulliver_vb/set_vb
scoreboard players remove $count _ 1
execute if score $isExist _ matches 1 if score $not_placable_block _ matches 1 run scoreboard players set $count _ 0
execute if score $count _ > $const_int_0 _ run function vbu:gulliver_vb/set_vb_recursive