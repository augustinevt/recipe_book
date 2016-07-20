require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  erb(:index)
end

get('/recipes/:id') do
  @recipe = Recipe.find(params['id'])
  @ingredients = Ingredient.all
  @tags = Tag.all
  @unused_tags = @tags - @recipe.tags
  erb(:recipe)
end

patch('/recipes/:id') do
  @recipe = Recipe.find(params['id'])
  # @recipe.update(params)
  @recipe.update(instructions: params['instructions'], rating: params['rating'], name: params['name'], image: params['image'])
  redirect "recipes/#{@recipe.id()}/recipe/edit"
end

post('/recipes/create') do
  @recipe = Recipe.create();
  redirect "recipes/#{@recipe.id()}/edit"
end

post('/ingredients/create') do
  @ingredient = Ingredient.create(name: params['ingredient_name'], amount: params['amount'], unit: params['unit'], recipe_id: params['recipe_id']);
  redirect "recipes/#{params['recipe_id']}/ingredients/edit"
end

post('/tags/create') do
  @recipe = Recipe.find(params['recipe_id'])
  if Tag.find_by_name(params['tag_name'])
    tag = Tag.find_by_name(params['tag_name'])
  else
    tag = Tag.create(name: params['tag_name'])
  end
  @recipe.tags.push(tag)
  redirect "recipes/#{params['recipe_id']}/tags/edit"
end

get('/recipes/:id/edit') do
  @recipe = Recipe.find(params['id'])
  @ingredients = Ingredient.all
  @tags = Tag.all
  erb(:recipe_form)
end

get('/recipes/:id/recipe/edit') do
  @recipe = Recipe.find(params['id'])
  erb(:recipe_edit)
end

get('/recipes/:id/ingredients/edit') do
  @recipe = Recipe.find(params['id'])
  @ingredients = Ingredient.all
  erb(:ingredients_edit)
end

get('/recipes/:id/tags/edit') do
  @recipe = Recipe.find(params['id'])
  @tags = Tag.all
  @unused_tags = @tags - @recipe.tags
  erb(:tags_edit)
end
