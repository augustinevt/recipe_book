class CreateRecipesTags < ActiveRecord::Migration
  def change
    create_join_table(:recipes, :tags) do |t|
      t.timestamps()
    end
  end
end
