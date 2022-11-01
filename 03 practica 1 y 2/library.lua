Creatures = {}
Creatures.grunt = { image = "grunt.png", dimX = 64, dimY = 64}
Creatures.mage = { image = "mago.png", dimX = 24, dimY = 24}
Creatures.griphon = { image = "grifo.png", dimX = 128, dimY = 128}
Creatures.dragon = { image = "dragon.png", dimX = 64, dimY = 64}
Creatures.health_bar = {image = "health_bar.png", dimX = 256, dimY = 119}
Creatures.wow = {image = "wow.png", dimX = 1024, dimY = 768}

function drawCreature(the_layer, name, posX, posY)
    posX = posX or 0
    posY = posY or 0
    local gfxQuad = MOAIGfxQuad2D.new()
    
    local texture_name = Creatures[name].image
  
    gfxQuad:setTexture(texture_name)
    gfxQuad:setRect(0, 0, Creatures[name].dimX, Creatures[name].dimY)
    gfxQuad:setUVRect(0, 0, 1, 1)
  
    local prop = MOAIProp2D.new()
    prop:setDeck(gfxQuad)
    prop:setLoc(posX, posY)
    layer:insertProp(prop)
    return prop
end

function drawPoint(x, y)
    r, g, b, a = 1, 1, 0, 1
    MOAIGfxDevice.setPenColor (r, g, b, a)
    MOAIDraw.drawPoints(x, y)
end

function drawBackground(the_layer, name)
    return drawCreature(the_layer, name)
end

function getPropPosition(prop)
    return prop:getLoc()
end
    
function setPropPosition(prop, x, y)
    prop:setLoc(x, y)
end

function prepareWindow(onDraw)
    MOAISim.openWindow("test", 1024, 768)

    local viewport = MOAIViewport.new()
    viewport:setSize(1024, 768)
    viewport:setScale(1024, -768)
    viewport:setOffset(-1, 1)

    layer = MOAILayer2D.new()
    layer:setViewport(viewport)
    MOAISim.pushRenderPass(layer)
 
    return layer
end

-- Configuration --
function pointerCallback(x, y)
    local mouseX, mouseY = layer:wndToWorld(x, y)
    OnMouseMove(mouseX, mouseY)
end

function callbackConfiguration(onClickLeft, onClickRight, pointerCallback, onKeyPress, onDraw, layer)
    -- callbacks configuration
    MOAIInputMgr.device.mouseLeft:setCallback(onClickLeft)
    MOAIInputMgr.device.mouseRight:setCallback(onClickRight)
    MOAIInputMgr.device.pointer:setCallback(pointerCallback)
    if (MOAIInputMgr.device.keyboard) then
        MOAIInputMgr.device.keyboard:setCallback(onKeyPress)
    end
    
    if (onDraw and layer) then
        local scriptDeck = MOAIScriptDeck.new ()
        scriptDeck:setRect (0, 0, 1, 1)
        scriptDeck:setDrawCallback (onDraw)

        local prop = MOAIProp2D.new()
        prop:setDeck(scriptDeck)
        layer:insertProp(prop)
    end
end

function mainLoop()
    local mainThread = MOAIThread.new()
    mainThread:run(
      function ()
        local timer0 = os.clock()
        while true do
            local timer1 = os.clock()
            local time_elapsed = math.min(timer1-timer0, 1/30)
            OnUpdate(time_elapsed)
            timer0 = timer1
            coroutine.yield()
        end
      end
    )
end
