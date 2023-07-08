class CreateGameCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :game_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
