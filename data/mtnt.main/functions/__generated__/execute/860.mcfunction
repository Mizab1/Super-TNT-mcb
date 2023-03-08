#built using mc-build (https://github.com/mc-build/mc-build)

spreadplayers ~ ~ 20 30 false @e[type=#minecraft:all_living,tag=!master,distance=..30]
kill @e[type=armor_stand,tag=tnt.teleport,distance=..4]
kill @s
execute as @a at @s run particle minecraft:portal ~ ~ ~ 1 1 1 1 100