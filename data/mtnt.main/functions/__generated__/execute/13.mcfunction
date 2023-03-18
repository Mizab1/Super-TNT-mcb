#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.punch","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110004}}]}
summon villager ~ ~ ~ {NoGravity:1b,Silent:1b,PersistenceRequired:1b,NoAI:1b,Health:500f,Tags:["count_punch_AS"],ActiveEffects:[{Id:14,Amplifier:1b,Duration:99999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}
setblock ~ ~ ~ tnt
tp @s ~ ~-600 ~