class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.integer :manager_id
    end
    add_index :employees, :manager_id
    add_foreign_key :employees, :employees, column: :manager_id
  end
end
