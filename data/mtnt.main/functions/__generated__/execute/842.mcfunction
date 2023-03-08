#built using mc-build (https://github.com/mc-build/mc-build)

summon creeper ~ ~ ~ {NoGravity:1b,Silent:1b,PersistenceRequired:1b,NoAI:1b,ExplosionRadius:1b,Fuse:3,ignited:1b,Tags:["punch_tnt_creeper"]}
execute store result entity @e[type=creeper, limit=1, distance=..1] ExplosionRadius byte 1 run scoreboard players get punched_score private