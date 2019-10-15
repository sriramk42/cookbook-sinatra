class Recipe
  attr_reader :name, :description
  def initialize(name, description)
    @name = name
    @description = description
    # @prep_time = prep_time
    # @marked = marked
    # @difficulty = difficulty
  end
end
