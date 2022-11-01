-- Escribe codigo
require "library"
prepareWindow()

MousePositionX = nil
MousePositionY = nil

-- Define tus variables globales
Pawns = {}
ID = 0
-- Termina tu definicion de variables

function onUpdate(seconds)
end

function onClickLeft(down)
    print("Clicked Left")
    if not down then
        -- Escribe tu c�digo para el bot�n izquierdo
        local creatureSizeX, creatureSizeY = getCreatureSize("griphon")
        local creaturePositionX, creaturePositionY = MousePositionX - creatureSizeX/2, MousePositionY - creatureSizeY/2
        local creature = addCreature("griphon", creaturePositionX, creaturePositionY)
        Pawns[ID] = { id = creature, health = 25, X = creaturePositionX, Y = creaturePositionY }
        ID = ID + 1
        -- Termina tu c�digo
    end
end

function onClickRight(down)
    print("Clicked Right")
    local creatureSizeX, creatureSizeY = getCreatureSize("griphon")
    if not down then
        -- Escribe tu c�digo para el bot�n derecho
        for k, v in pairs(Pawns) do
            if (v.X <= MousePositionX and v.X + creatureSizeX >= MousePositionX
            and v.Y <= MousePositionY and v.Y + creatureSizeY >= MousePositionY) then
                v.health = v.health - 5
                print("Creature health: " .. v.health)
            end
        end

        for k, v in pairs(Pawns) do
            if (v.health <= 0) then
                removeCreature(v.id)
                Pawns[k] = nil
            end
        end
        -- Termina tu c�digo
    end
end

function onMouseMove(posX, posY)
    MousePositionX = posX
    MousePositionY = posY
end

function onKeyPress(key, down)
    print("Key pressed: " .. key)
end

callbackConfiguration(onClickLeft, onClickRight, onMouseMove, onKeyPress)
mainLoop()
