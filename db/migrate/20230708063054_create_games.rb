class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :min_age
      t.integer :max_age
      t.integer :min_duration, comment: 'max duration in minutes'
      t.integer :max_duration, comment: 'min duration in minutes'

      t.timestamps
    end
  end
end
