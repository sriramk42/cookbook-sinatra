require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_path = "/Users/sriram/code/sriramk1986/fullstack-challenges/02-OOP/04-Cookbook-Day-Two/01-Cookbook-Advanced/lib/recipes.csv"
cookbook = Cookbook.new(csv_path)

get '/' do
  csv_path = "/Users/sriram/code/sriramk1986/fullstack-challenges/02-OOP/04-Cookbook-Day-Two/01-Cookbook-Advanced/lib/recipes.csv"
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  recipe = Recipe.new(params[:recipe_name], params[:recipe_description])
  cookbook.add_recipe(recipe)
  @recipes = cookbook.all
  erb :index
end

get '/recipes/:index' do
  cookbook.remove_recipe(params[:index].to_i)
  @recipes = cookbook.all
  erb :index
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
