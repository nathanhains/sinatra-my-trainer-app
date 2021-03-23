class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :description
      t.string :reps
      t.string :sets
      t.string :muscle_group
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
