class SpritesheetStressTest
  def initialize(engine)
    @engine = engine
    cw, ch = 48, 48
    @texture = Moon::Texture.new("resources/blocks/block_#{cw}x#{ch}_007.png")
    @sprite = Moon::Spritesheet.new(@texture, cw, ch)
    @cols = (@engine.screen.w / @sprite.w).to_i
    @rows = (@engine.screen.h / @sprite.h).to_i
    @cells = @cols * @rows
    @i = 0
  end

  def update(delta)
    cc = @sprite.cell_count - 3
    cw, ch = @sprite.w, @sprite.h
    dx = @cols / @cells.to_f
    @rows.times do |y|
      d = y * @cols / @cells
      @cols.times do |x|
        index = (@i - d * cc / 2).to_i % cc
        @sprite.render x * cw, y * cw, 0, index
        d += dx
      end
    end
    if @i > cc
      @i = @i - cc
    end
    @i += delta
  end
end
