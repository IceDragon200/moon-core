class SpritesheetTest
  def initialize(engine)
    @engine = engine
    @spritesheet = Moon::Spritesheet.new(Moon::Texture.new('resources/blocks/block_16x16_007.png'), 16, 16)
  end

  def update(delta)
    @spritesheet.render 16, 0, 0, 0, angle: 45
    @spritesheet.render 32, 0, 0, 1, opacity: 0.5
    @spritesheet.render 16, 16, 0, 2
  end
end
