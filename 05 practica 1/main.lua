-- Escribe codigo
require "library"
require "prepare"

-- Define tus variables globales
Punto = { x = 0, y = 0 }
-- Termina tu definicion de variables

function pintarPunto(Punto)
    -- Rellenar c�digo para pintar un punto en la pantalla
    drawPoint(Punto.x, Punto.y)
    -- Fin de c�digo
end

function onUpdate(seconds)
end

function onDraw()
    -- Empieza tu c�digo, que debe emplear la funcion pintarPunto
    for i = 0, 100, 1 do
        for j = 0, 100, 1 do
            local p = { x = i + 128, y = j + 128 }
            pintarPunto(p)
        end
    end
    -- Termina tu c�digo
end

function onClickLeft(down)
    print("Clicked Left")
    if down then
    end
end

function onClickRight(down)
    print("Clicked Right")
    if down then
    end
end

function onMouseMove(posX, posY)
    --print("Mouse Moved to " .. posX .. ","..posY)
end

function onKeyPress(key, down)
    print("Key pressed: " .. key)
end

callbackConfiguration(onClickLeft, onClickRight, onMouseMove, onKeyPress, onDraw, window_layer)
mainLoop()
