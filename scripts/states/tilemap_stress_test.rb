class TilemapStressTest
  def initialize(engine)
    @engine = engine
    @text = Moon::Text.new(
      Moon::Font.new("resources/fonts/uni0553/uni0553-webfont.ttf", 16),
      "Tilemap Stress test:\n  The tilemap should be fading in and out, if not, we have a opacity problem"
    )

    cw, ch = 4, 4
    @ss = Moon::Spritesheet.new("resources/blocks/block_#{cw}x#{ch}_007.png", cw, ch)
    @cols = (@engine.screen.w / @ss.w).to_i
    @rows = (@engine.screen.h / @ss.h).to_i
    @data = Array.new(@cols * @rows) { rand(@ss.cell_count) }
    t = exec_time do
      @tm = Moon::Tilemap.new(tileset: @ss, datasize: Moon::Vector3.new(@cols, @rows, 1), data: @data)
    end
    puts "Indices: #{@tm.vbo.index_count}"
    puts "Vertices: #{@tm.vbo.vertex_count}"
    puts "Width: #{@tm.w}"
    puts "Height: #{@tm.h}"
    puts "Cell Count: #{@cols * @rows}"
    puts "Generated in: #{t} sec(s)"
    @t = 0
  end

  def update(delta)
    @t += delta
    @t %= 2
    op = @t % 1
    @tm.opacity = @t > 1 ? op : 1 - op
    @tm.render 0, 0, 0

    @text.render 0, 0, 0
  end
end
