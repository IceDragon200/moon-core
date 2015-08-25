class SpriteTest
  def initialize(engine)
    @engine = engine

    @sprite = Moon::Sprite.new Moon::Texture.new('resources/blocks/block_8x8_007.png')
    @sprite.origin.x = @sprite.texture.w / 2
    @sprite.origin.y = @sprite.texture.h / 2
  end

  def update(delta)
    @sprite.angle += delta * 10
    @sprite.opacity = (@sprite.opacity + delta * 2) % 1
    @sprite.render 32, 32, 0
  end
end
