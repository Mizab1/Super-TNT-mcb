#built using mc-build (https://github.com/mc-build/mc-build)

tp @s ^ ^ ^0.3 facing entity @p[tag=!master]
playsound minecraft:block.ancient_debris.step ambient @a[distance=..40] ~ ~ ~ 2
execute if entity @a[distance=..1, tag=!master] run function mtnt.main:__generated__/execute/3