#built using mc-build (https://github.com/mc-build/mc-build)

summon sheep ~3.31 ~ ~-7.49 {NoAI:1b, Tags:["laughing_mob"]}
summon cow ~6.73 ~ ~1.69 {NoAI:1b, Tags:["laughing_mob"]}
summon chicken ~-8.85 ~ ~7.66 {NoAI:1b, Tags:["laughing_mob"]}
summon pig ~-1.67 ~ ~8.53 {NoAI:1b, Tags:["laughing_mob"]}
summon ocelot ~7.29 ~ ~-3.85 {NoAI:1b, Tags:["laughing_mob"]}
summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["pants_AS"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101101}}]}
execute as @e[type=#minecraft:laughing_mob, tag=laughing_mob, distance=..20] at @s run tp @s ^ ^ ^ facing entity @e[type=armor_stand, tag=pants_AS, limit=1]
schedule function mtnt.main:__generated__/sequence/66 30t replace
schedule function mtnt.main:__generated__/sequence/67 60t replace
schedule function mtnt.main:__generated__/sequence/68 100t replace
schedule function mtnt.main:__generated__/sequence/69 130t replace
schedule function mtnt.main:__generated__/sequence/70 170t replace