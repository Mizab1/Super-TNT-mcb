#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}
tellraw @a [{"selector":"@s"},{"text":" Died of Boredom","color":"red"}]
kill @s
kill @e[type=armor_stand, tag=tv]
tag @a remove viewing_tv