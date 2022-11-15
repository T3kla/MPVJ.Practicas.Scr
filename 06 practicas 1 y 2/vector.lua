Vec = {}

--constructor
function Vec:new(a, b)
    local vector = { x = a, y = b }
    setmetatable(vector, self)
    self.__index = self
    return vector
end

function Vec.__add(a, b)
    local x = a.x + b.x
    local y = a.y + b.y
    return Vec:new(x, y)
end

function Vec.__sub(a, b)
    local x = a.x - b.x
    local y = a.y - b.y
    return Vec:new(x, y)
end

function Vec.__mul(a, b)
    return a.x * b.x + a.y * b.y
end

function Vec:lenght()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vec:normalize()
    local lenght = math.sqrt(self.x * self.x + self.y * self.y)
    local x = self.x / lenght
    local y = self.y / lenght
    return Vec:new(x, y)
end

function Vec:scale(n)
    local x = self.x * n
    local y = self.y * n
    return Vec:new(x, y)
end

function Vec.print(a)
    print(a.x, a.y)
end

function Test()
    print("a is ")
    Vec.print(a)
    print("b is ")
    Vec.print(b)

    print("add is ")
    Vec.print(a + b)
    print("sub is ")
    Vec.print(b - a)

    print("dot is ")
    print(a * b)

    print("a scaled by 2:")
    Vec.print(a:scale(2))

    print("b scaled by 3:")
    Vec.print(a:scale(3))

    print("a normalized is ")
    Vec.print(a:normalize())
    print("b normalized is ")
    Vec.print(b:normalize())

    print("a lenght is ")
    print(a:lenght())
    print("b lenght is ")
    print(b:lenght())
end
