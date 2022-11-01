-- Escribe codigo
require "library"
prepareWindow()

Carta, Carta_image = drawImage(layer, "cards\\A_C.png", 256, 256, 79, 123)
MousePositionX = 0
MousePositionY = 0
First, Second = nil, nil

function onUpdate(seconds)
end

function onClickLeft(down)
    if down then
        print("Clicked Left")
    end
end

function onClickRight(down)
    print("Clicked Right")
end

function onMouseMove(posX, posY)
    MousePositionX = posX
    MousePositionY = posY
end

function onKeyPress(key, down)
    local image_file = nil
    local key_pressed = convertKeyToChar(key)
    print("\n --- ")
    print("Key pressed: ", key_pressed, "down: ", down)
    -- Escribe tu c�digo para gestion de teclado

    if key == nil or down == false then
        First, Second = nil, nil
        return
    end

    print("First: ", First, "Second: ", Second)

    if First == nil then
        if key_pressed == "C" or key_pressed == "c" then
            First = "C"
        elseif key_pressed == "T" or key_pressed == "t" then
            First = "T"
        elseif key_pressed == "D" or key_pressed == "d" then
            First = "D"
        elseif key_pressed == "P" or key_pressed == "p" then
            First = "P"
        else 
            First, Second = nil, nil
        end
    else
        if key_pressed == "2" or key_pressed == "\"" then
            Second = "2"
        elseif key_pressed == "3" or key_pressed == "·" then
            Second = "3"
        elseif key_pressed == "4" or key_pressed == "$" then
            Second = "4"
        elseif key_pressed == "5" or key_pressed == "%" then
            Second = "5"
        elseif key_pressed == "6" or key_pressed == "&" then
            Second = "6"
        elseif key_pressed == "7" or key_pressed == "/" then
            Second = "7"
        elseif key_pressed == "8" or key_pressed == "(" then
            Second = "8"
        elseif key_pressed == "9" or key_pressed == ")" then
            Second = "9"
        elseif key_pressed == "J" or key_pressed == "j" then
            Second = "J"
        elseif key_pressed == "Q" or key_pressed == "q" then
            Second = "Q"
        elseif key_pressed == "K" or key_pressed == "k" then
            Second = "K"
        else
            Second = nil
        end
    end

    print("First: ", First, "Second: ", Second)

    if First ~= nil and Second ~= nil then
        image_file = "cards\\" .. Second .. "_" .. First .. ".png"
        First, Second = nil, nil
    end

    -- Termina tu c�digo
    if image_file then
        setImage(Carta_image, image_file)
    end
end



callbackConfiguration(onClickLeft, onClickRight, onMouseMove, onKeyPress)
mainLoop()

