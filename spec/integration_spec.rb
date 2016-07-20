require 'spec_helper'

describe 'home route', type: :feature do
  it 'should list out recipes' do
    new_recipe = Recipe.create(name: "Curry", instructions: "Go to nearest foodcart", rating: 4, image: "http://www.wyvernacademy.co.uk/wp-content/uploads/2015/11/Mild_Chicken_Curry_0000x0000_0.jpg")
    visit('/')
    expect(page).to have_content('Curry')
  end

  it 'should route to "recipes/:id/edit"' do
    visit('/')
    click_on('New Recipe')
    expect(page).to have_content('Add Ingredients')
  end

  it 'should route to "recipes/:id/edit"' do
    new_recipe = Recipe.create(name: "Curry", instructions: "Go to nearest foodcart", rating: 4, image: "http://www.wyvernacademy.co.uk/wp-content/uploads/2015/11/Mild_Chicken_Curry_0000x0000_0.jpg")
    visit('/')
    click_on('Curry')
    expect(current_url).to eq("http://www.example.com/recipes/#{new_recipe.id}")
  end

  it 'should update recipe on submit' do
    new_recipe = Recipe.create(name: "Curry", instructions: "Go to nearest foodcart", rating: 4, image: "http://www.wyvernacademy.co.uk/wp-content/uploads/2015/11/Mild_Chicken_Curry_0000x0000_0.jpg")
    visit("/recipes/#{new_recipe.id()}/edit")
    fill_in('name', with: "Yellow Curry")
    fill_in('instructions', with: "Go to nearest indian restaurant")
    fill_in('rating', with: 5)
    click_on('Submit')
    expect(page).to have_content("Go to nearest indian restaurant")
  end

  it 'should create ingredient on "Add Ingredient"' do
    new_recipe = Recipe.create(name: "Curry", instructions: "Go to nearest foodcart", rating: 4, image: "http://www.wyvernacademy.co.uk/wp-content/uploads/2015/11/Mild_Chicken_Curry_0000x0000_0.jpg")
    visit("/recipes/#{new_recipe.id()}/edit")
    fill_in('ingredient_name', with: "Egg")
    fill_in('amount', with: 10)
    fill_in('unit', with: "")
    click_on('Add Ingredient')
    expect(page).to have_content("Egg")
  end

  it 'should create ingredient on "Add Ingredient"' do
    new_recipe = Recipe.create(name: "Curry", instructions: "Go to nearest foodcart", rating: 4, image: "http://www.wyvernacademy.co.uk/wp-content/uploads/2015/11/Mild_Chicken_Curry_0000x0000_0.jpg")
    visit("/recipes/#{new_recipe.id()}/edit")
    fill_in('tag_name', with: "italian")
    click_on('Add Tag')
    expect(page).to have_content("italian")
  end
end
