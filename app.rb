require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all().order('rating DESC')
  @tags = Tag.all()
  erb(:index)
end


get('/search') do
  if Recipe.includes(:tags).where('tags.name' => params['tag_name']).any?
    @matched_recipes = Recipe.includes(:tags).where('tags.name' => params['tag_name']).all().order('rating DESC')
    @tag = Tag.find_by_name(params['tag_name'])
    @tags = Tag.all()
    erb(:search)
  else
    redirect "/"
  end
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
  @recipe = Recipe.create(name: 'New Recipe', instructions: 'feed me Bacon ipsum dolor amet pork loin tail tongue chicken. Ball tip ham hock turducken beef ribs, alcatra jowl biltong pig boudin flank meatloaf fatback sausage bresaola brisket. Bresaola fatback sausage, tri-tip brisket tenderloin bacon turkey. Corned beef landjaeger boudin flank beef ribs pancetta ham kevin. T-bone drumstick filet mignon, ribeye rump fatback cow pig corned beef sausage capicola ham hock. Filet mignon porchetta pork loin pork chop cupim pig pancetta sausage, ham tongue shank tenderloin rump beef ribs. Porchetta filet mignon swine pork loin andouille biltong beef ribs.', rating: 2, image: "http://foodnetwork.sndimg.com/content/dam/images/food/fullset/2011/7/26/1/EA0914_creme-brulee_s4x3.jpg");
  redirect "recipes/#{@recipe.id()}/edit"
end

delete ('/recipes/:id/destroy') do
  @recipe = Recipe.find(params['id']).destroy()
  redirect "/"
end

post('/ingredients/create') do
  @ingredient = Ingredient.create(name: params['ingredient_name'], amount: params['amount'], unit: params['unit'], recipe_id: params['recipe_id']);
  redirect "recipes/#{params['recipe_id']}/ingredients/edit"
end

delete('/ingredients/:id/destroy') do
  @ingredient = Ingredient.find(params['id'])
  @ingredient.destroy()
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

patch('/recipes/:recipe_id/tags/:id') do
  @tag = Tag.find(params['id'])
  @tag.update(recipe_ids: nil)
redirect "/recipes/#{params['recipe_id']}/tags/edit"
end
