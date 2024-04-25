class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :description
      t.integer :sequence
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
