#built using mc-build (https://github.com/mc-build/mc-build)

kill @s
tp @e[type=villager, tag=count_punch_AS, distance=..1] ~ ~-600 ~
scoreboard players set punched_score private 1
kill @e[type=tnt,distance=..1]