class CreateRecipesAndIngredients < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.text(:instructions)
      t.integer(:rating)
      t.string(:name)
      t.string(:image)

      t.timestamps()
    end

    create_table(:ingredients) do |t|
      t.string(:name)
      t.integer(:amount)
      t.string(:unit)
      t.integer(:recipe_id)

      t.timestamps()
    end
  end
end
