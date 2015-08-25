class RendererTest
  def initialize(engine)
    @engine = engine
    @renderer = Moon::Renderer.new
    @shader = Moon::Spritesheet.default_shader
    @vbo = Moon::VertexBuffer.new(Moon::VertexBuffer::DYNAMIC_DRAW)
    @texture = Moon::Texture.new('resources/blocks/block_16x16_007.png')
    @transform = Moon::Matrix4.new(1.0)
    c = [0, 0, 0, 0]
    tr = [0, 0, 16.0 / @texture.w, 16.0 / @texture.h]
    @vbo.add_quad [0, 0, 16, 16], tr, c
    @vbo.add_quad [32, 0, 16, 16], tr, c
    @vbo.add_quad [0, 32, 16, 16], tr, c

    @mode = Moon::OpenGL::TRIANGLES
    @color = Moon::Vector4.new 1, 1, 1, 1
    @tone = Moon::Vector4.new 0, 0, 0, 1

    @x = 0
    @y = 0
  end

  def update(delta)
    @x += delta * 12
    @transform = Moon::Matrix4.new.translate(@x, @y, 0)
    @shader.use
    @shader.set_uniform 'opacity', 1.0
    @shader.set_uniform 'color', @color
    @shader.set_uniform 'tone', @tone
    @renderer.render @shader, @vbo, @texture, @transform, @mode
  end
end
