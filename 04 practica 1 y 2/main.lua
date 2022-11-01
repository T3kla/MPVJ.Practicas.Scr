-- Escribe codigo
require "library"
prepareWindow()

Creature = drawCreature(layer, "griphon", 256, 256)
MousePositionX = 0
MousePositionY = 0
Direction = 0

function onUpdate(seconds)
    local creaturePositionX, creaturePositionY = getPropPosition(Creature)
    -- Empieza tu c�digo para mover a la criatura
    
    if Direction == 0 then
        creaturePositionX = creaturePositionX + 10
    elseif Direction == 1 then
        creaturePositionY = creaturePositionY + 10
    elseif Direction == 2 then
        creaturePositionX = creaturePositionX - 10
    elseif Direction == 3 then
        creaturePositionY = creaturePositionY - 10
    end
    
    -- Termina tu c�digo
    setPropPosition(Creature, creaturePositionX, creaturePositionY)
end

function onClickLeft(down)
    if down then
        print("Clicked Left")
        local creatureSizeX, creatureSizeY = getCreatureSize("griphon")
        local creaturePositionX, creaturePositionY = getPropPosition(Creature)
        -- Escribe tu c�digo aqui para bot�n izquierdo rat�n

        Direction = Direction + 1

        if Direction == 4 then
            Direction = 0
        end

        -- Termina tu c�digo
    end
end

function onClickRight(down)
    print("Clicked Right")
end

function onMouseMove(posX, posY)
    MousePositionX = posX
    MousePositionY = posY
    --print("Mouse Moved to " .. posX .. ","..posY)
end

function onKeyPress(key, down)
    print("Key pressed: "..key)
end

callbackConfiguration(onClickLeft, onClickRight, onMouseMove, onKeyPress)
mainLoop()
