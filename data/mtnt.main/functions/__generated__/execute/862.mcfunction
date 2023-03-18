#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=!master] at @s run function mtnt.main:__generated__/execute/863
kill @e[type=armor_stand,tag=tnt.teleport,distance=..4]
kill @s
execute as @a[tag=!master] at @s run particle minecraft:portal ~ ~ ~ 1 1 1 1 100