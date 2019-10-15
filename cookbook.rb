require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    CSV.foreach(csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def all
    @recipes
  end

  def mark(index)
    @recipes[index].change_marked!
    CSV.open(@csv_file_path, 'wb') do |row|
      @recipes.each do |recipe|
        row << [recipe.name, recipe.description]
      end
    end
  end

  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@csv_file_path, 'ab') do |row|
      row << [recipe.name, recipe.description]
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index.to_i)
    CSV.open(@csv_file_path, 'wb') do |row|
      @recipes.each do |recipe|
        row << [recipe.name, recipe.description]
      end
    end
  end
end
