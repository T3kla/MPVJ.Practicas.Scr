-- Escribe codigo
require "library"
prepareWindow()

mousePositionX = nil
mousePositionY = nil

-- Define tus variables globales
Creatures = {}
Creatures.grunt = { image = "creatures/grunt.png"}
Creatures.mage = { image = "creatures/mage.png"}
Creatures.gryphon = { image = "creatures/gryphon.png"}
Creatures.dragon = { image = "creatures/dragon.png"}
Creatures.peon = {image = "creatures/peon.png"}
-- Fin de tus variables globales

-- Define tus funciones y llamadas
function addCreature(name, posX, posY, sizeX, sizeY)
    posX = posX or 0
    posY = posY or 0
    local gfxQuad = MOAIGfxQuad2D.new()

    local texture_name = Creatures[name].image

    gfxQuad:setTexture(texture_name)
    gfxQuad:setRect(0, 0, sizeX, sizeY)
    gfxQuad:setUVRect(0, 0, 1, 1)

    local prop = MOAIProp2D.new()
    prop:setDeck(gfxQuad)
    prop:setLoc(posX, posY)
    layer:insertProp(prop)
    return prop
end
-- Fin de tus funciones

addCreature("dragon", 50, 50, 128, 128)
addCreature("dragon", 100, 50, 128, 128)
addCreature("dragon", 150, 50, 128, 128)
addCreature("mage", 50, 200, 64, 64)
addCreature("mage", 100, 200, 64, 64)
addCreature("grunt", 100, 200, 64, 64)
addCreature("peon", 150, 200, 64, 64)
addCreature("gryphon", 200, 50, 128, 128)

function onUpdate(seconds)
end

function onClickLeft(down)
    print("Clicked Left")
    if not down then
        -- Escribe tu c�digo para el bot�n izquierdo
        -- Termina tu c�digo
    end
end

function onClickRight(down)
    print("Clicked Right")
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
    print("Key pressed: "..key)
end



callbackConfiguration(onClickLeft, onClickRight, onMouseMove, onKeyPress)
mainLoop()

