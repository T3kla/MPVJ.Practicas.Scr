-- Escribe codigo
require "library"
prepareWindow()

Creature1 = drawCreature(layer, "griphon", 512, 256)
Creature2 = drawCreature(layer, "griphon", 512, 512)

function OnUpdate(seconds)
    local creaturePosition1X, creaturePosition1Y = getPropPosition(Creature1)
    local creaturePosition2X, creaturePosition2Y = getPropPosition(Creature2)
    -- Empieza tu c�digo
    creaturePosition1X = creaturePosition1X + 10;
    creaturePosition2X = creaturePosition2X - 10;
    -- Termina tu c�digo
    setPropPosition(Creature1, creaturePosition1X, creaturePosition1Y)
    setPropPosition(Creature2, creaturePosition2X, creaturePosition2Y)
end

function OnClickLeft(down)
    print("Clicked Left")
end

function OnClickRight(down)
    print("Clicked Right")
end

function OnMouseMove(posX, posY)
    --print("Mouse Moved to " .. posX .. ","..posY)
end

function OnKeyPress(key, down)
    print("Key pressed: "..key)
end

callbackConfiguration(OnClickLeft, OnClickRight, OnMouseMove, OnKeyPress)
mainLoop()
