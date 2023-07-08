class CreateJoinTableCategoriesGames < ActiveRecord::Migration[7.1]
  def change
    create_join_table :categories, :games do |t|
      t.index [:game_id, :category_id]
    end
  end
end
