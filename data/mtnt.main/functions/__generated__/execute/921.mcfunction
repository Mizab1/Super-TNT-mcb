#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["tv"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101102}}]}
execute as @a[tag=!master] at @s run function mtnt.main:__generated__/execute/922
schedule function mtnt.main:__generated__/sequence/72 40t replace
schedule function mtnt.main:__generated__/sequence/73 80t replace
schedule function mtnt.main:__generated__/sequence/74 180t replace
schedule function mtnt.main:__generated__/sequence/75 240t replace
schedule function mtnt.main:__generated__/sequence/76 280t replace