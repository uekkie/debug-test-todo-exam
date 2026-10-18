class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title, null: false
      t.text :memo
      t.date :due_on
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
