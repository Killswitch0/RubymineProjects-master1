require_relative 'module'

class Post
  include Animation
  include Saving


  def initialize
    @created_at = Time.now
    @text = []
  end

  def self.post_types
    [Memo, Link, Task]
  end

  def self.create(type_index)
    post_types[type_index].new
  end

  def to_strings
    # to do
  end
  
  def read_from_console
    # to do
  end
end