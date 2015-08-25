# A basic mixin for any object to be rendered on screen.
# Tracks object transformations: position, rotation, color/opacity, origin/anchor, scale.
module Renderable
  # @return [Integer] id counter
  @@context_id = 0

  # @return [Integer] RenderContext id
  attr_reader :id

  def initialize
    @id = @@context_id += 1

    @position = Moon::Vector3.new
    @rotation = 0.0
    @visible  = true

    @parent   = nil
    yield self if block_given?
  end

  ##
  # @return [Boolean] should this render?
  def render?
    true
  end

  # ...

  # TODO: add world functions that use parent to calculate the current transform
  # to_global, to_local(position, from) position
end

# TODO: Should sprite extend container? Should sprites be nestable?g
class Moon::Container
  include Renderable

  attr_reader :children

  def initialize
    super # in order to initialize Renderable
    @children = []
  end

  def add(child)
    @children << child
  end
  alias :<< :add

  def delete(child)
    @children.delete(child)
  end

  def [](index)
    @children[index]
  end

  # bounds
  # local_bounds calculates the bounding box of children
end

# a simple mat4 transformation with accessors to modify it
class Moon::Camera
  extend Moon::TypedAttributes

  attribute :projection, Moon::Matrix4
  attribute :model_view, Moon::Matrix4

  def initialize
    self.projection = Moon::Matrix4.new(1.0)
    self.model_view = Moon::Matrix4.new(1.0)
  end
end

class Moon::Renderer
  def render_node(parent, camera)
    parent.render
    parent.children.each do |node|
      render_node(node, camera)
    end
  end

  def render(scene, camera)
    # for now, simply loop over and call render, later we add batching
    # calc transform for children
    transform = self.calc

    render_node scene, camera
  end
end

class RendererTest
  def initialize(engine)
    @engine = engine
    @camera = Moon::Camera.new
    @camera.projection = Moon::Shader.projection_matrix
    @renderer = Moon::Renderer.new # inits OGL
    # also derived from Object3D/DisplayObject/Renderable
    @scene = Moon::Container.new
    # everything that can be pushed is a subinstance of Object3D/DisplayObject/Renderable
    @scene.add(sprite)
    # sort by shader, then texture
    # render each obj
  end

  def update(delta)
    @renderer.render(@scene, @camera)
  end
end
