#built using mc-build (https://github.com/mc-build/mc-build)

summon sheep ~0.33 ~ ~5.47 {NoAI:1b, Tags:["laughing_mob"]}
summon cow ~-6.91 ~ ~-2.19 {NoAI:1b, Tags:["laughing_mob"]}
summon chicken ~-5.75 ~ ~6.29 {NoAI:1b, Tags:["laughing_mob"]}
summon pig ~7.28 ~ ~3.17 {NoAI:1b, Tags:["laughing_mob"]}
summon ocelot ~6.69 ~ ~-3.81 {NoAI:1b, Tags:["laughing_mob"]}
summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["pants_AS"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101101}}]}
execute as @e[type=#minecraft:laughing_mob, tag=laughing_mob, distance=..20] at @s run tp @s ^ ^ ^ facing entity @e[type=armor_stand, tag=pants_AS, limit=1]
schedule function mtnt.main:__generated__/sequence/57 30t replace
schedule function mtnt.main:__generated__/sequence/58 60t replace
schedule function mtnt.main:__generated__/sequence/59 100t replace
schedule function mtnt.main:__generated__/sequence/60 130t replace
schedule function mtnt.main:__generated__/sequence/61 170t replace