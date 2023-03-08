#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[distance=..1, tag=!master] run function mtnt.main:__generated__/execute/4
summon creeper ~ ~ ~ {Fuse:0, ignited:1b}
kill @s