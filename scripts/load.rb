require 'scripts/states'

#module Moon
#  class Input
#    def on_key(*args)
#      puts args.inspect
#    end
#
#    def on_button(*args)
#      puts args.inspect
#    end
#
#    def on_type(*args)
#      puts args.inspect
#    end
#
#    def on_mousemove(*args)
#      puts args.inspect
#    end
#  end
#end

def exec_time
  time_then = Time.now
  yield
  Time.now - time_then
end

def step(engine, delta)
  #@state ||= RendererWindowskinTest.new(engine)
  #@state ||= RendererTest.new(engine)
  @state ||= TextTest.new(engine)
  #@state ||= TilemapTest.new(engine)
  #@state ||= SpritesheetTest.new(engine)
  @state.update(delta)
end
