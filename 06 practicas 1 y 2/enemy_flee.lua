require "library"

EnemyFlee = {}

function EnemyFlee:new(name, posX, posY)
    local newCreature = drawCreature(layer, name, posX, posY)
    local enemy =
    {
        creature = newCreature,
        type = name,
        maxHp = 100,
        hp = 100
    }
    setmetatable(enemy, self)
    self.__index = self
    return enemy
end

function EnemyFlee:checkCollision(otherX, otherY)
    local creatureSizeX, creatureSizeY = getCreatureSize(self.type)
    local posX, posY = getPropPosition(self.creature)
    local hp = self.hp
    if otherX > posX and otherX < posX + creatureSizeX and otherY > posY and otherY < posY + creatureSizeY and hp > 0 then
        return true
    end
    return false
end

function EnemyFlee:getDamage(damage)
    if self.hp > 0 then
        self.hp = self.hp - damage
        if self.hp <= 0 then
            self:death()
        elseif self.hp <= self.maxHp / 2 then
            self:flee()
        end
    end
end

function EnemyFlee:flee()
    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()

    local x = math.random(0, 512)
    local y = math.random(0, 512)

    setPropPosition(self.creature, x, y)
end

function EnemyFlee:death()
    local gfxQuad = MOAIGfxQuad2D.new()
    local texture_name = creatures[self.type].image

    gfxQuad:setTexture(texture_name)
    gfxQuad:setRect(0, 0, creatures[self.type].dimX / 2, creatures[self.type].dimY / 2)
    gfxQuad:setUVRect(0, 0, 1, 1)

    self.creature:setDeck(gfxQuad)
end
