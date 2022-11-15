-- Escribe codigo
require "library"
require "vector"
require "enemy"
require "enemy_flee"
prepareWindow()

mousePositionX = nil
mousePositionY = nil

-- Define tus variables globales

grifo1 = Enemy:new("griphon", 256, 256)
grifo2 = EnemyFlee:new("griphon", 512, 256)
a = Vec:new(1, 2)
b = Vec:new(3, 4)

-- Termina tu definicion de variables

Test()

function onUpdate(seconds)
end

function onClickLeft(down)
    print("Clicked Left")
    if not down then
        -- Escribe tu c�digo para el bot�n izquierdo
        if grifo1:checkCollision(mousePositionX, mousePositionY) then
            print("Hit grifo")
            grifo1:getDamage(10)
        end
        if grifo2:checkCollision(mousePositionX, mousePositionY) then
            print("Hit grifo huidizo")
            grifo2:getDamage(10)
        end
        -- Termina tu c�digo
    end
end

function onClickRight(down)
    print("Clicked Right")
    creatureSizeX, creatureSizeY = getCreatureSize("griphon")
    if not down then
        -- Escribe tu c�digo para el bot�n derecho
        -- Termina tu c�digo
    end
end

function onMouseMove(posX, posY)
    mousePositionX = posX
    mousePositionY = posY
    --print("Mouse Moved to " .. posX .. ","..posY)
end

function onKeyPress(key, down)
    print("Key pressed: " .. key)
end

callbackConfiguration(onClickLeft, onClickRight, onMouseMove, onKeyPress)
mainLoop()
