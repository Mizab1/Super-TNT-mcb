#built using mc-build (https://github.com/mc-build/mc-build)

execute as @e[type=#minecraft:all_living, tag=!master] at @s run tp @s ~ ~-300 ~
kill @e[type=armor_stand,tag=tnt.void,distance=..4]
kill @s