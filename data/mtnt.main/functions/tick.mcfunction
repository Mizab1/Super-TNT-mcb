#built using mc-build (https://github.com/mc-build/mc-build)

effect give @a night_vision 100 0 true
execute as @e[type=marker, tag=will_explode] at @s if entity @a[distance=..0.5] run function mtnt.main:__generated__/execute/1
execute as @e[type=armor_stand, tag=aggressive_car] at @s run function mtnt.main:__generated__/execute/2
execute as @e[type=giant, tag=giant_aot] at @s run fill ~3 ~10 ~3 ~-3 ~ ~-3 air destroy
execute as @e[type=zombie, tag=giant_controller] at @s unless block ~ ~-0.35 ~ air run kill @s
execute as @e[type=endermite, tag=tnt.endermite] at @s run function mtnt.main:__generated__/execute/7
execute as @e[type=armor_stand, tag=tnt.as] at @s run function mtnt.main:__generated__/execute/24