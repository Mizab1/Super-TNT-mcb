#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["tv"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101102}}]}
execute as @e[type=armor_stand, tag=tv] at @s run tp @a[tag=!master] ^ ^ ^-2 facing entity @s
tellraw @a[tag=!master] {"text":"You are viewing ads! Thats cringe", "color":"green"}
effect give @a[tag=!master] slowness 20 100 true
schedule function mtnt.main:__generated__/sequence/63 40t replace
schedule function mtnt.main:__generated__/sequence/64 80t replace
schedule function mtnt.main:__generated__/sequence/65 180t replace
schedule function mtnt.main:__generated__/sequence/66 240t replace
schedule function mtnt.main:__generated__/sequence/67 280t replace