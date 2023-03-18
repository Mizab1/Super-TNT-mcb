#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a {"text":"It looks like a aggressive car is on the loose, try to avoid it!", "color":"green"}
summon armor_stand ~ ~1 ~ {Invisible:1b,Tags:["aggressive_car"],ArmorItems:[{},{},{},{id:"minecraft:blue_dye",Count:1b,tag:{CustomModelData:101102}}]}