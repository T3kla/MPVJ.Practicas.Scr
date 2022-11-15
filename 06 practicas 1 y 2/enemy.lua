require "library"

Enemy = {}

function Enemy:new(name, posX, posY)
    local newCreature = drawCreature(layer, name, posX, posY)
    local enemy =
    {
        creature = newCreature,
        type = name,
        maxHp = 50,
        hp = 50
    }
    setmetatable(enemy, self)
    self.__index = self
    return enemy
end

function Enemy:checkCollision(otherX, otherY)
    local creatureSizeX, creatureSizeY = getCreatureSize(self.type)
    local posX, posY = getPropPosition(self.creature)
    local hp = self.hp
    if otherX > posX and otherX < posX + creatureSizeX and otherY > posY and otherY < posY + creatureSizeY and hp > 0 then
        return true
    end
    return false
end

function Enemy:getDamage(damage)
    if self.hp > 0 then
        self.hp = self.hp - damage
        if self.hp <= 0 then
            self:death()
        end
    end
end

function Enemy:death()
    gfxQuad = MOAIGfxQuad2D.new()
    texture_name = creatures[self.type].image

    gfxQuad:setTexture(texture_name)
    gfxQuad:setRect(0, 0, creatures[self.type].dimX / 2, creatures[self.type].dimY / 2)
    gfxQuad:setUVRect(0, 0, 1, 1)

    self.creature:setDeck(gfxQuad)
end
