class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :plan_id, null: false

      t.timestamps
      
      t.index :user_id
      t.index :plan_id
      t.index [:user_id, :plan_id], unique: true
    end
  end
end
