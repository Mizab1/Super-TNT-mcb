#built using mc-build (https://github.com/mc-build/mc-build)

setblock ~ ~-1 ~ structure_block[mode=load]{name:"minecraft:building",posX:-13,posY:1,posZ:-10,rotation:"NONE",mirror:"NONE",mode:"LOAD"} replace
setblock ~ ~-2 ~ redstone_block
setblock ~ ~46 ~ structure_block[mode=load]{name:"minecraft:skyscraper2",posX:-8,posY:0,posZ:-10,rotation:"NONE",mirror:"NONE",mode:"LOAD"} replace
setblock ~ ~45 ~ redstone_block
tp @a[distance=..10] ~ ~100 ~