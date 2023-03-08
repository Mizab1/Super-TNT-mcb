#built using mc-build (https://github.com/mc-build/mc-build)

kill @s
tp @e[type=villager, tag=count_punch_AS, distance=..1] ~ ~-600 ~
scoreboard players set punched_score private 1
scoreboard players set #execute LANG_MC_INTERNAL 1