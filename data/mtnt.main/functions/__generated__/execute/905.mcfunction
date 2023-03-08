#built using mc-build (https://github.com/mc-build/mc-build)

summon sheep ~-1.95 ~ ~0.49 {NoAI:1b, Tags:["laughing_mob"]}
summon cow ~6.14 ~ ~6.13 {NoAI:1b, Tags:["laughing_mob"]}
summon chicken ~-8.63 ~ ~8.93 {NoAI:1b, Tags:["laughing_mob"]}
summon pig ~6.28 ~ ~-8.57 {NoAI:1b, Tags:["laughing_mob"]}
summon ocelot ~9.56 ~ ~-9.48 {NoAI:1b, Tags:["laughing_mob"]}
execute as @e[type=#minecraft:laughing_mob, tag=laughing_mob, distance=..20] at @s run tp @s ^ ^ ^ facing entity @e[type=armor_stand, tag=tnt.as, tag=tnt.laugh, limit=1]
summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["pants_AS"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101101}}]}
schedule function mtnt.main:__generated__/sequence/57 30t replace
schedule function mtnt.main:__generated__/sequence/58 60t replace
schedule function mtnt.main:__generated__/sequence/59 100t replace
schedule function mtnt.main:__generated__/sequence/60 130t replace
schedule function mtnt.main:__generated__/sequence/61 170t replace