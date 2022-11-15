width = 300

pac = pacman.new()

function loadValues()
    pac:setPowerUpScore(2000)
    pac:setPowerUpTime(5)
    pac:setVelMult(2.5)
    pac:setPointsForMedals(10, 10, 10)
    pac:setCoinScore(5)
end

function getColor(life)
    if life == 1.5 then
        pac.setColor(100, 0, 256)
    elseif life == 1 then
        pac.setColor(250, 115, 0)
    elseif life == 0.5 then
        pac.setColor(0, 250, 50)
    elseif life == 0 then
        pac.setColor(0, 160, 250)
    end
end

function getWidth()
    return 200
end
