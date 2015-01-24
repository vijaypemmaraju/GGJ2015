Choices = class("Choices")

function Choices:initialize()
    self.moves = {self.jump, self.slide, self.hit}

end



function Choices:getRandMove()
  rand = math.floor(love.math.random()*#self.moves) + 1;
  return self.moves[rand];
  
  
end

function Choices:jump()
    Player:jump()
end

function Choices:slide()
    Player:slide()
end

function Choices:hit()
    
end