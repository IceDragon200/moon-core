class TextTest
  def initialize(engine)
    @engine = engine

    font = Moon::Font.new('resources/fonts/uni0553/uni0553-webfont.ttf', 16)
    @text = Moon::Text.new font, "Hello, World", color: Moon::Vector4.new(1, 1, 1, 1)
  end

  def update(delta)
    @text.render 32, 32, 0
  end
end
