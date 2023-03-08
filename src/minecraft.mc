advancement punched{
  "criteria": {
    "requirement": {
      "trigger": "minecraft:player_hurt_entity",
      "conditions": {
        "entity": [
          {
            "condition": "minecraft:entity_properties",
            "entity": "this",
            "predicate": {
              "type": "minecraft:villager",
              "nbt": "{Tags:[\"count_punch_AS\"]}"
            }
          }
        ]
      }
    }
  },
  "rewards": {
    "function": "mtnt.main:increment_punch"
  }
}

entities all_living{
  zombie_villager
  zombified_piglin
  glow_squid
  pig
  skeleton_horse
  wolf
  bat
  witch
  polar_bear
  spider
  giant
  guardian
  ender_dragon
  piglin_brute
  magma_cube
  zoglin
  tropical_fish
  wither
  frog
  creeper
  zombie
  fox
  illusioner
  iron_golem
  player
  ravager
  chicken
  llama
  piglin
  axolotl
  wither_skeleton
  cow
  parrot
  villager
  blaze
  salmon
  bee
  stray
  silverfish
  cave_spider
  ghast
  mule
  vex
  vindicator
  enderman
  zombie_horse
  trader_llama
  elder_guardian
  turtle
  armor_stand
  rabbit
  shulker
  goat
  tadpole
  pillager
  cod
  drowned
  hoglin
  phantom
  evoker
  cat
  mooshroom
  slime
  strider
  dolphin
  horse
  wandering_trader
  endermite
  husk
  skeleton
  squid
  warden
  donkey
  allay
  pufferfish
  sheep
  snow_golem
  panda
  ocelot
}

entities laughing_mob{
  sheep
  cow
  chicken
  pig
  ocelot
}