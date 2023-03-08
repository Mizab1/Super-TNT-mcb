#built using mc-build (https://github.com/mc-build/mc-build)

tp @e[type=#minecraft:laughing_mob, tag=laughing_mob] ~ ~-600 ~
kill @e[type=armor_stand, tag=pants_AS]
execute as @a[tag=!master] run function mtnt.main:__generated__/execute/913