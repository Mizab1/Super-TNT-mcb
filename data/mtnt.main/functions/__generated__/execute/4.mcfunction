#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a [{"selector":"@s"},{"text":" Died due to a car crash","color":"red"}]
playsound minecraft:custom.carcrash master @a[distance=..20] ~ ~ ~
kill @s