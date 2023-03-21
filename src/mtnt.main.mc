import ./macros/rngV2.mcm
import ./macros/private_macros.mcm

function load{
    # Make a Dummy scoreboard of Fuse Timer
    scoreboard objectives add fuse_time dummy
    scoreboard objectives add rng_score dummy
    scoreboard objectives add private dummy
    gamerule universalAnger true  
    gamerule showDeathMessages false
    gamerule keepInventory true
    gamerule doWeatherCycle false
    gamerule doDaylightCycle false
}
clock 5t {
    # star tnt particles
    execute at @e[type=fireball] run{
        particle minecraft:flame ~ ~ ~ 0.3 1 0.3 0 20
    }
}
function tick{
    effect give @a[tag=!in_darkness] night_vision 100 0 true

    # flower TNT: detect player nearby the flowers
    execute as @e[type=marker, tag=will_explode] at @s if entity @a[distance=..0.5] run{
        summon creeper ~ ~ ~ {Fuse:0, ignited:1b}
        kill @s
    }

    # car tnt: chase player
    execute as @e[type=armor_stand, tag=aggressive_car] at @s run{
        tp @s ^ ^ ^0.3 facing entity @p[tag=!master]
        playsound minecraft:block.ancient_debris.step ambient @a[distance=..40] ~ ~ ~ 2
        execute if entity @a[distance=..1, tag=!master] run{
            execute as @a[distance=..1, tag=!master] run{
                tellraw @a [{"selector":"@s"},{"text":" Died due to a car crash","color":"red"}]
                playsound minecraft:custom.carcrash master @a[distance=..20] ~ ~ ~
                kill @s
            }
            # summon creeper ~ ~ ~ {Fuse:0, ignited:1b}
            kill @s
        }
    }

    # falling star:
    execute as @e[type=fireball, tag=falling_star] at @s if entity @a[distance=..4] run{
        kill @a[distance=..4]
    }
    # ads TNT: Lock ratotion
    execute as @e[type=armor_stand, tag=tv, sort=nearest, limit=1] at @s run tp @a[tag=!master, tag=viewing_tv] ^ ^ ^-2 facing entity @s
    # giant tnt: break blocks
    execute as @e[type=giant, tag=giant_aot] at @s run{
        fill ~3 ~10 ~3 ~-3 ~ ~-3 air destroy
    }
    execute as @e[type=zombie, tag=giant_controller] at @s unless block ~ ~-0.35 ~ air run{
        kill @s
    }

    # setblock the custom TNT
    execute as @e[type=endermite, tag=tnt.endermite] at @s run{
        #*------ TODO: Change Custom model data
        #--- skyscraper
        execute if entity @s[tag=skyscraper] run{
            placetnt skyscraper 110001
        }
        #--- flower
        execute if entity @s[tag=flower] run{
            placetnt flower 110002
        }
        #--- car
        execute if entity @s[tag=car] run{
            placetnt car 110003
        }
        #--- punch
        execute if entity @s[tag=punch] run{
            summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.punch","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110004}}]}
            summon villager ~ ~ ~ {NoGravity:1b,Silent:1b,PersistenceRequired:1b,NoAI:1b,Health:500f,Tags:["count_punch_AS"],ActiveEffects:[{Id:14,Amplifier:1b,Duration:99999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}
            setblock ~ ~ ~ tnt
            tp @s ~ ~-600 ~
        }
        #--- earthquake
        execute if entity @s[tag=earthquake] run{
            placetnt earthquake 110005
        }
        #--- gravity
        execute if entity @s[tag=gravity] run{
            placetnt gravity 110006
        }
        #--- teleport
        execute if entity @s[tag=teleport] run{
            placetnt teleport 110007
        }
        #--- void
        execute if entity @s[tag=void] run{
            placetnt void 110008
        }
        #--- steal
        execute if entity @s[tag=steal] run{
            placetnt steal 110009
        }
        #--- star
        execute if entity @s[tag=star] run{
            placetnt star 110010
        }
        #--- turbo
        execute if entity @s[tag=turbo] run{
            placetnt turbo 110011
        }
        #--- catapult
        execute if entity @s[tag=catapult] run{
            placetnt catapult 110012
        }
        #--- giant
        execute if entity @s[tag=giant] run{
            placetnt giant 110013
        }
        #--- laugh
        execute if entity @s[tag=laugh] run{
            placetnt laugh 110014
        }
        #--- ads
        execute if entity @s[tag=ads] run{
            placetnt ads 110015
        }
        #--- carnivorous
        execute if entity @s[tag=carnivorous] run{
            placetnt carnivorous 110016
        }
    }

    # Tnt validation and explosion handler
    execute as @e[type=armor_stand, tag=tnt.as] at @s run{
        #--- skyscraper
        execute if entity @s[tag=tnt.skyscraper] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block quartz_block ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    setblock ~ ~-1 ~ structure_block[mode=load]{name:"minecraft:building",posX:-13,posY:1,posZ:-10,rotation:"NONE",mirror:"NONE",mode:"LOAD"} replace
                    setblock ~ ~-2 ~ redstone_block
                    setblock ~ ~46 ~ structure_block[mode=load]{name:"minecraft:skyscraper2",posX:-8,posY:0,posZ:-10,rotation:"NONE",mirror:"NONE",mode:"LOAD"} replace
                    setblock ~ ~45 ~ redstone_block
                    tp @a[distance=..10] ~ ~100 ~
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.skyscraper,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- flower
        execute if entity @s[tag=tnt.flower] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block dandelion ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    execute positioned ~-10 ~ ~-10 run{
                        LOOP(20,i){
                            LOOP(20,j){
                                rng range 0 2 rng rng_score
                                execute if score rng rng_score matches 1 run{
                                    execute positioned ~<%i%> ~ ~<%j%> unless block ~ ~-1 ~ air run{
                                        setblock ~ ~-1 ~ grass_block
                                        setblock ~ ~ ~ dandelion
                                        summon marker ~ ~ ~ {Tags:["flower_tnt_AS", "will_explode"]}
                                    }
                                }     
                            }
                        }
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    # kill @e[type=armor_stand,tag=tnt.flower,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- car
        execute if entity @s[tag=tnt.car] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block yellow_wool ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    tellraw @a {"text":"It looks like a aggressive car is on the loose, try to avoid it!", "color":"green"}
                    summon armor_stand ~ ~1 ~ {Invisible:1b,Tags:["aggressive_car"],ArmorItems:[{},{},{},{id:"minecraft:blue_dye",Count:1b,tag:{CustomModelData:101102}}]}
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.car,distance=..4]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- punch
        execute if entity @s[tag=tnt.punch] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block dandelion ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    summon creeper ~ ~ ~ {NoGravity:1b,Silent:1b,PersistenceRequired:1b,NoAI:1b,ExplosionRadius:1b,Fuse:3,ignited:1b,Tags:["punch_tnt_creeper"]}
                    execute store result entity @e[type=creeper, limit=1, distance=..1] ExplosionRadius byte 1 run scoreboard players get punched_score private
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    # kill @e[type=armor_stand,tag=tnt.punch,distance=..4]
                    kill @s
                    tp @e[type=villager, tag=count_punch_AS, distance=..1] ~ ~-600 ~
                    scoreboard players set punched_score private 1
                    kill @e[type=tnt,distance=..1]
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
                tp @e[type=villager, tag=count_punch_AS, distance=..1] ~ ~-600 ~
                scoreboard players set punched_score private 1
            }
        }
        #--- earthquake
        execute if entity @s[tag=tnt.earthquake] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block bedrock ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                # execute if score @s fuse_time matches 2 run{
                #     summon creeper ~ ~-0.7 ~ {NoGravity:1b,Silent:1b,ExplosionRadius:100b,Fuse:0}
                # }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt,distance=..1]
                    weather thunder
                    execute as @a[tag=!master] run{
                        tag @s add in_darkness
                        effect clear @s minecraft:night_vision
                    }
                    sequence{
                        LOOP(50,i){
                            <%%
                                function getRandomArbitrary(min, max) {
                                    return Math.random() * (max - min) + min;
                                }
                                emit(`execute as @a at @s run tp @s ~ ~ ~ ~${Number((getRandomArbitrary(-1, 1)).toFixed(2))} ~${Number((getRandomArbitrary(-1, 1)).toFixed(2))}`)
                            %%>
                            delay 2t
                        }
                    }
                    sequence{
                        LOOP(6,i){
                            <%%
                                function getRandomArbitrary(min, max) {
                                    return Math.random() * (max - min) + min;
                                }
                                emit(`execute at @a[tag=!master] run summon minecraft:lightning_bolt ~${Number((getRandomArbitrary(-3, 3)).toFixed(2))} ~ ~${Number((getRandomArbitrary(-3, 3)).toFixed(2))}`)
                                if(i == 5){
                                    emit(`weather clear`)
                                    emit(`tag @a[tag=in_darkness] remove in_darkness`)
                                }
                            %%>
                            delay 20t
                        }
                    }
                    sequence{
                        LOOP(4,i){
                            <%%
                                switch (i) {
                                    case 1:
                                        emit(`execute as @a[tag=!master] at @s run clone 296 125 284 302 134 302 ~-2 ~-10 ~-10 filtered minecraft:magma_block`)
                                        break;
                                    case 2:
                                        emit(`execute as @a[tag=!master] at @s run clone 296 125 284 302 134 302 ~-2 ~-10 ~-10 filtered minecraft:air`)
                                        break;
                                    case 3:
                                        emit(`execute as @a[tag=!master] at @s run clone 296 125 284 302 134 302 ~-2 ~-10 ~-10 filtered minecraft:lava`)
                                        emit(`kill @s`)
                                        break;
                                }
                            %%>
                            delay 33t
                        }
                    }
                    kill @e[type=armor_stand,tag=tnt.earthquake,distance=1..4]
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- gravity
        execute if entity @s[tag=tnt.gravity] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block black_concrete_powder ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    sequence{
                        LOOP(5,i){
                            effect give @e[type=#minecraft:all_living, tag=!master] levitation 1 14 true
                            delay 2s
                        }
                    }
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.gravity,distance=..4]
                    # kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- teleport
        execute if entity @s[tag=tnt.teleport] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:reverse_portal ~ ~ ~ 1 1 1 0.5 20
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    execute as @a[tag=!master] at @s run{
                        clone ~-4 ~-4 ~-4 ~4 ~4 ~4 ~10 ~ ~-12 replace move
                        tp @s ~14 ~5 ~-8
                    }
                    # spreadplayers ~ ~ 20 30 false @e[type=#minecraft:all_living,tag=!master,distance=..30]
                    kill @e[type=armor_stand,tag=tnt.teleport,distance=..4]
                    kill @s
                    execute as @a[tag=!master] at @s run particle minecraft:portal ~ ~ ~ 1 1 1 1 100
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- void
        execute if entity @s[tag=tnt.void] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:soul ~ ~ ~ 1 1 1 0.3 20
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    execute as @e[type=#minecraft:all_living, tag=!master] at @s run tp @s ~ ~-300 ~
                    kill @e[type=armor_stand,tag=tnt.void,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- steal
        execute if entity @s[tag=tnt.steal] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block iron_block ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics 
                execute if score @s fuse_time matches 2 run{
                    tellraw @a[distance=..20, tag=!master] {"text":"Something is missing from your inventory ;)", "color":"green"}
                    LOOP(10,i){
                        rng range 0 61 steal_rng rng_score
                        execute as @a[distance=..20, tag=!master] run{
                            <%%
                                let slots = [
                                    "armor.chest",
                                    "armor.feet",
                                    "armor.head",
                                    "armor.legs",
                                    "weapon",
                                    "weapon.mainhand",
                                    "weapon.offhand",
                                    "container.0",
                                    "container.1",
                                    "container.2",
                                    "container.3",
                                    "container.4",
                                    "container.5",
                                    "container.6",
                                    "container.7",
                                    "container.8",
                                    "container.9",
                                    "container.10",
                                    "container.11",
                                    "container.12",
                                    "container.13",
                                    "container.14",
                                    "container.15",
                                    "container.16",
                                    "container.17",
                                    "container.18",
                                    "container.19",
                                    "container.20",
                                    "container.21",
                                    "container.22",
                                    "container.23",
                                    "container.24",
                                    "container.25",
                                    "container.26",
                                    "container.27",
                                    "container.28",
                                    "container.29",
                                    "container.30",
                                    "container.31",
                                    "container.32",
                                    "container.33",
                                    "container.34",
                                    "container.35",
                                    "container.36",
                                    "container.37",
                                    "container.38",
                                    "container.39",
                                    "container.40",
                                    "container.41",
                                    "container.42",
                                    "container.43",
                                    "container.44",
                                    "container.45",
                                    "container.46",
                                    "container.47",
                                    "container.48",
                                    "container.49",
                                    "container.50",
                                    "container.51",
                                    "container.52",
                                    "container.53"
                                ]
                                slots.forEach((element, index) => {
                                    emit(`execute if score steal_rng rng_score matches ${index} run item replace entity @s ${element} with air`)
                                });
                            %%>
                        }
                    }
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.steal,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- star
        execute if entity @s[tag=tnt.star] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block gilded_blackstone ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    execute at @a[distance=..20] run{
                        LOOP(20,i){
                            <%%
                                function getRandomArbitrary(min, max) {
                                    return Math.random() * (max - min) + min;
                                }
                                emit(`summon fireball ~${Number((getRandomArbitrary(-6, 6)).toFixed(2))} ~${Number((getRandomArbitrary(30, 40)).toFixed(2))} ~${Number((getRandomArbitrary(-6, 6)).toFixed(2))} {Tags:["falling_star"], ExplosionPower:1b,power:[0.0,-0.1,0.0],Item:{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101105}}}`)
                            %%>
                        }
                        playsound minecraft:item.trident.thunder hostile @a ~ ~5 ~ 2 0.1
                    }
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.star,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- turbo
        execute if entity @s[tag=tnt.turbo] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block gold_block ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    function car:playerspawn_car1
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.turbo,distance=..4]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- catapult
        execute if entity @s[tag=tnt.catapult] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block oak_planks ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    execute positioned ~-4 ~4 ~ run function tf_catapult:summon/place
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.catapult,distance=..4]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- giant
        execute if entity @s[tag=tnt.giant] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block redstone_block ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    LOOP(4,i){
                        summon giant ~<%Math.round(Math.random() * 10)%> ~10 ~<%Math.round(Math.random() * 10)%> {Health:200f,Tags:["giant_aot","giant"],Passengers:[{id:"minecraft:zombie",Health:500f,Tags:["giant_controller","giant"],ArmorItems:[{},{},{},{id:'minecraft:leather_helmet',Count:1b}],ActiveEffects:[{Id:14,Amplifier:1b,Duration:999999,ShowParticles:0b}],Attributes:[{Name:generic.max_health,Base:500}]}],CustomName:'{"text":"Colossal Titan"}',Attributes:[{Name:generic.max_health,Base:200}]}
                    }
                    particle minecraft:poof ~ ~ ~ 1 0.2 0 0.1 100
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.giant,distance=..4]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- laugh
        execute if entity @s[tag=tnt.laugh] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block white_wool ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    <%%
                        function getRandomArbitrary(min, max) {
                            return Math.random() * (max - min) + min;
                        }
                        let mobs = ["sheep", "cow", "chicken", "pig", "ocelot"]
                        mobs.forEach(element => {
                            emit(`summon ${element} ~${Number((getRandomArbitrary(-10, 10)).toFixed(2))} ~ ~${Number((getRandomArbitrary(-10, 10)).toFixed(2))} {NoAI:1b, Tags:["laughing_mob"]}`)
                        });
                    %%>
                    summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["pants_AS"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101101}}]}
                    execute as @e[type=#minecraft:laughing_mob, tag=laughing_mob, distance=..20] at @s run{
                        tp @s ^ ^ ^ facing entity @e[type=armor_stand, tag=pants_AS, limit=1]
                    }
                    sequence{
                        delay 30t
                        execute at @a run{
                            playsound minecraft:custom.laugh master @a ~ ~ ~
                            tellraw @a[tag=!master] {"text":"It looks like you are missing your pants!","color":"green"}
                        }
                        delay 30t
                        execute at @a run{
                            playsound minecraft:custom.laugh master @a ~ ~ ~
                        }
                        delay 40t
                        execute at @a run{
                            playsound minecraft:custom.laugh master @a ~ ~ ~
                        }
                        delay 30t
                        execute at @a run{
                            playsound minecraft:custom.laugh master @a ~ ~ ~
                        }
                        delay 40t
                        tp @e[type=#minecraft:laughing_mob, tag=laughing_mob] ~ ~-600 ~
                        kill @e[type=armor_stand, tag=pants_AS]
                        execute as @a[tag=!master] run{
                            kill @s
                            tellraw @a [{"selector":"@s"},{"text":" Died of shame","color":"red"}]
                        }
                    }
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.laugh,distance=..15]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- ads
        execute if entity @s[tag=tnt.ads] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block iron_block ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    summon armor_stand ~ ~ ~ {Invisible:1b,Tags:["tv"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101102}}]}
                    execute as @a[tag=!master] at @s run{
                        tag @s add viewing_tv
                        tellraw @s {"text":"You are viewing ads! Thats cringe", "color":"green"}
                        effect give @s slowness 20 100 true
                    }
                    sequence{
                        delay 2s
                            execute as @e[type=armor_stand, tag=tv] run data modify entity @s ArmorItems[3].tag.CustomModelData set value 101103
                        delay 2s 
                            execute as @a[tag=!master] at @s run{
                                playsound minecraft:block.note_block.chime master @s ~ ~ ~ 2 1.2
                                tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}
                                tellraw @s {"text":"-------------Ad 1--------------"}
                                tellraw @s {"text":"50% OFF 50% OFF 50% OFF", "color":"red"}
                                tellraw @s {"text":"SALE ON SHOES","color":"blue"}
                                tellraw @s {"text":"FLAT 50% OFF", "color":"gold"}
                                tellraw @s {"text":"BUY NOW!", "color":"yellow"}
                                tellraw @s {"text":"------------------------------"}
                            }
                        delay 5s 
                            execute as @a[tag=!master] at @s run{
                                playsound minecraft:block.note_block.chime master @s ~ ~ ~ 2 1.2
                                tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}
                                tellraw @s {"text":"-------------Ad 2--------------"}
                                tellraw @s {"text":"FLAT 100% OFF", "color":"yellow"}
                                tellraw @s {"text":"SALE ON HOODIES AND T-SHIRT", "color":"aqua"}
                                tellraw @s {"text":"BUY BEFORE MIDNIGHT", "color":"red"}
                                tellraw @s {"text":"CALL @ +1 694208008", "color":"gold"}
                                tellraw @s {"text":"------------------------------"}
                            }
                        delay 3s 
                            execute as @a[tag=!master] at @s run{
                                playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 2 0.8
                                tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}
                                tellraw @s {"text":"Ok enough that was boring, now you shall die", "color":"red"}
                            }
                        delay 2s 
                            execute as @a[tag=!master] run{
                                tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}
                                tellraw @a [{"selector":"@s"},{"text":" Died of Boredom","color":"red"}]
                                kill @s
                                kill @e[type=armor_stand, tag=tv]
                                tag @a remove viewing_tv
                            }
                    }
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.ads,distance=..4]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        #--- carnivorous
        execute if entity @s[tag=tnt.carnivorous] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block moss_block ~ ~ ~ 1 1 1 1 20
                }
                # Execute the Exploding Mechanics for Apple TNT (Dirt TNT)
                execute if score @s fuse_time matches 2 run{
                    <%%
                        let blocks = [
                            "moss_block",
                            "moss_block",
                            "moss_block",
                            "moss_block",
                            "minecraft:mossy_cobblestone",
                            "minecraft:mossy_stone_bricks"
                        ] 
                        for (let i = 1; i <= 20; i++) {
                            for (let j = 0; j <= 70; j++) {
                                emit(`setblock ~${Math.round(Math.sin(j) * i)} ~-1 ~${Math.round(Math.cos(j) * i)} ${blocks[Math.floor(Math.random() * blocks.length)]}`)
                            } 
                        }
                    %%>
                    LOOP(15,i){
                        summon spider ~ ~ ~ {Tags:["carnivorous_plant"]}
                    }
                    spreadplayers ~ ~ 3 10 false @e[type=spider, tag=carnivorous_plant]
                }
                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.carnivorous,distance=..4]
                    kill @e[type=tnt,distance=..1]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
    }
}
function test{
    spawnpoint @s ~ ~ ~ ~ 
    gamemode spectator @s 
    summon creeper ~ ~ ~ {NoAI:1b, Tags:["toggle_shader"]}
    spectate @e[tag=toggle_shader, limit=1]
    tag @s add on_shader
    gamerule doImmediateRespawn true
    sequence{
        delay 10t
        kill @a[tag=on_shader]
        gamerule doImmediateRespawn false
        delay 10t
        tp @e[type=creeper, tag=toggle_shader] ~ ~-600 ~
        gamemode creative @a[tag=on_shader]
        tag @a[tag=on_shader] remove on_shader
    }
}
function undo{
    spawnpoint @s ~ ~ ~ ~ 
    gamemode spectator @s 
    summon sheep ~ ~ ~ {NoAI:1b, Tags:["toggle_shader_undo"]}
    spectate @e[tag=toggle_shader_undo, limit=1]
    tag @s add on_shader_undo
    gamerule doImmediateRespawn true
    sequence{
        delay 10t
        kill @a[tag=on_shader_undo]
        gamerule doImmediateRespawn false
        delay 10t
        tp @e[type=sheep, tag=toggle_shader_undo] ~ ~-600 ~
        gamemode creative @a[tag=on_shader_undo]
        tag @a[tag=on_shader_undo] remove on_shader_undo
    }
}
function kill_catapult{
    kill @e[tag=tf_catapult]
    tp @e[tag=tfcp_release] ~ ~-600 ~
    tp @e[tag=tfcp_hitbox] ~ ~-600 ~
}

#> TNT Command
function skyscraper{
    givetnt <Skyscraper TNT> 110001 skyscraper
    tellraw @a {"text":"Summons a skyscraper when exploded and teleport the player on top","color":"green"}
}
function flower{
    givetnt <Flower TNT> 110002 flower
    tellraw @a {"text":"Places alot of flowers randomly and they will explode if they detect a player nearby","color":"green"}
}
function car{
    givetnt <Car TNT> 110003 car
    tellraw @a {"text":"Summons a car which will crash into you hence killing you","color":"green"}
}
function punch{
    givetnt <Punch TNT> 110004 punch
    tellraw @a {"text":"The more you punch the TNT the more powerful it becomes, punch atleast 0.3 block above the TNT","color":"green"}
}
function earthquake{
    givetnt <Earthquake TNT> 110005 earthquake
    tellraw @a {"text":"Induce a earthquake where it explodes","color":"green"}
}
function gravity{
    givetnt <Gravity TNT> 110006 gravity
    tellraw @a {"text":"Remove gravity for 3 seconds repetedly","color":"green"}
}
function teleport{
    givetnt <Teleport TNT> 110007 teleport
    tellraw @a {"text":"Teleport the player randomly","color":"green"}
}
function void{
    givetnt <Void TNT> 110008 void
    tellraw @a {"text":"Teleport all the living mobs to the void","color":"green"}
}
function steal{
    givetnt <Steal TNT> 110009 steal
    tellraw @a {"text":"Steal random items from the player","color":"green"}
}
function star{
    givetnt <Star TNT> 110010 star
    tellraw @a {"text":"Star rain which may kill the player","color":"green"}
}
function turbo{
    givetnt <Turbo TNT> 110011 turbo
    tellraw @a {"text":"Spawns a car without brake, if you crash you die","color":"green"}
}
function catapult{
    givetnt <Catapult TNT> 110012 catapult
    tellraw @a {"text":"Spawns a catapult","color":"green"}
}
function giant{
    givetnt <Colossal Titan TNT> 110013 giant
    tellraw @a {"text":"Spawns a colossal titan","color":"green"}
}
function laugh{
    givetnt <Laugh TNT> 110014 laugh
    tellraw @a {"text":"Spawns random mod which will laugh at the player and they will die","color":"green"}
}
function ads{
    givetnt <Ads TNT> 110015 ads
    tellraw @a {"text":"Show ads tp the player and kills them out of cringe","color":"green"}
}
function carnivorous{
    givetnt <Carnivorous TNT> 110016 carnivorous
    tellraw @a {"text":"Spawns carnivorous plants and change the ground","color":"green"}
}



function increment_punch{
    scoreboard players add punched_score private 1
    advancement revoke @s only minecraft:punched 
}



#> Misc.
function reset_hat{
    summon item_frame 328 161 223 {Facing:4b,Invulnerable:1b,Invisible:1b,Tags:["hat_if"],Item:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{display:{Name:'{"text":"Click the button if you see the hat","color":"green"}'},CustomModelData:123321}}}

    setblock 328 160 223 polished_blackstone_button[facing=west]
}
function click_hat{
    kill @e[type=item_frame, tag=hat_if]
    setblock 328 160 223 air
    execute as @a at @s run{
        summon firework_rocket ^1 ^ ^ {LifeTime:20,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:2,Trail:1b,Colors:[I;3691519,16383810,16711680]},{Type:0,Colors:[I;382463,16723676]}]}}}}
        summon firework_rocket ^-1 ^ ^ {LifeTime:20,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:2,Trail:1b,Colors:[I;3691519,16383810,16711680]},{Type:0,Colors:[I;382463,16723676]}]}}}}
    }
}



