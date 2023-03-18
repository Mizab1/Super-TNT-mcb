#built using mc-build (https://github.com/mc-build/mc-build)

<<<<<<< HEAD
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if entity @e[type=tnt,distance=..0.5] run function mtnt.main:__generated__/conditional/24
scoreboard players set #execute LANG_MC_INTERNAL 0
execute unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5] run function mtnt.main:__generated__/conditional/25
=======
summon giant ~4 ~10 ~2 {Health:200f,Tags:["giant_aot","giant"],Passengers:[{id:"minecraft:zombie",Health:500f,Tags:["giant_controller","giant"],ArmorItems:[{},{},{},{id:'minecraft:leather_helmet',Count:1b}],ActiveEffects:[{Id:14,Amplifier:1b,Duration:999999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}],CustomName:'{"text":"Colossal Titan"}',Attributes:[{Name:generic.max_health,Base:200}]}
summon giant ~0 ~10 ~8 {Health:200f,Tags:["giant_aot","giant"],Passengers:[{id:"minecraft:zombie",Health:500f,Tags:["giant_controller","giant"],ArmorItems:[{},{},{},{id:'minecraft:leather_helmet',Count:1b}],ActiveEffects:[{Id:14,Amplifier:1b,Duration:999999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}],CustomName:'{"text":"Colossal Titan"}',Attributes:[{Name:generic.max_health,Base:200}]}
summon giant ~7 ~10 ~7 {Health:200f,Tags:["giant_aot","giant"],Passengers:[{id:"minecraft:zombie",Health:500f,Tags:["giant_controller","giant"],ArmorItems:[{},{},{},{id:'minecraft:leather_helmet',Count:1b}],ActiveEffects:[{Id:14,Amplifier:1b,Duration:999999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}],CustomName:'{"text":"Colossal Titan"}',Attributes:[{Name:generic.max_health,Base:200}]}
summon giant ~1 ~10 ~5 {Health:200f,Tags:["giant_aot","giant"],Passengers:[{id:"minecraft:zombie",Health:500f,Tags:["giant_controller","giant"],ArmorItems:[{},{},{},{id:'minecraft:leather_helmet',Count:1b}],ActiveEffects:[{Id:14,Amplifier:1b,Duration:999999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}],CustomName:'{"text":"Colossal Titan"}',Attributes:[{Name:generic.max_health,Base:200}]}
particle minecraft:poof ~ ~ ~ 1 0.2 0 0.1 100
>>>>>>> 0833d0f022c82a27d833e139c2ef0ddac739ca80
