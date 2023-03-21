#built using mc-build (https://github.com/mc-build/mc-build)

summon sheep ~6.5 ~ ~-9.51 {NoAI:1b, Tags:["laughing_mob"]}
summon cow ~-8.73 ~ ~-7.68 {NoAI:1b, Tags:["laughing_mob"]}
summon chicken ~9.91 ~ ~1.16 {NoAI:1b, Tags:["laughing_mob"]}
summon pig ~9.69 ~ ~8.67 {NoAI:1b, Tags:["laughing_mob"]}
summon ocelot ~2.37 ~ ~-3.95 {NoAI:1b, Tags:["laughing_mob"]}
summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["pants_AS"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101101}}]}
execute as @e[type=#minecraft:laughing_mob, tag=laughing_mob, distance=..20] at @s run tp @s ^ ^ ^ facing entity @e[type=armor_stand, tag=pants_AS, limit=1]
schedule function mtnt.main:__generated__/sequence/66 30t replace
schedule function mtnt.main:__generated__/sequence/67 60t replace
schedule function mtnt.main:__generated__/sequence/68 100t replace
schedule function mtnt.main:__generated__/sequence/69 130t replace
schedule function mtnt.main:__generated__/sequence/70 170t replace