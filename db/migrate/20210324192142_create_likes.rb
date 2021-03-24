class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.timestamps null: false
    end
  end
end
