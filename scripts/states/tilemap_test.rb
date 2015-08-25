module Moon
  class Tilemap
    attr_reader :vbo
  end
end

class TilemapTest
  def initialize(engine)
    @engine = engine
    @text = Moon::Text.new(
      Moon::Font.new("resources/fonts/uni0553/uni0553-webfont.ttf", 16),
      "Tilemap test:\n  The tilemap should be fading in and out, if not, we have a opacity problem"
    )

    @ss = Moon::Spritesheet.new("resources/blocks/block_32x32_007.png", 32, 32)
    @data = [
      1, 1, 1, 1,
      2, 2, 2, 2,
      4, 3, 3, 1,
      1, 2, 3, 4,
    ]
    @tm = Moon::Tilemap.new(tileset: @ss, datasize: Moon::Vector3.new(4, 4, 1), data: @data)
    puts "Indices: #{@tm.vbo.index_count}"
    puts "Vertices: #{@tm.vbo.vertex_count}"
    puts "Width: #{@tm.w}"
    puts "Height: #{@tm.h}"
    @t = 0
  end

  def update(delta)
    @t += delta
    @t %= 2
    op = @t % 1
    @tm.opacity = @t > 1 ? op : 1 - op
    @tm.render (@engine.screen.w - @tm.w) / 2, (@engine.screen.h - @tm.h) / 2, 0

    @text.render 0, 0, 0
  end
end
