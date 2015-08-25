class SpriteStressTest
  def initialize(engine)
    @engine = engine
    @texture = Moon::Texture.new('resources/blocks/block_8x8_007.png')
    @sprite = Moon::Sprite.new(@texture)
    @sprite.clip_rect = Moon::Rect.new(0, 0, 8, 8)

    @cols = (@engine.screen.w / @sprite.w).to_i
    @rows = (@engine.screen.h / @sprite.h).to_i
  end

  def update(delta)
    cw, ch = @sprite.w, @sprite.h
    @rows.times do |y|
      @cols.times do |x|
        @sprite.render x * cw, y * cw, 0
      end
    end
  end
end
