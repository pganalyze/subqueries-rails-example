class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    create_table :employees do |t|
      t.integer :role_id, null: false
      t.string :name, null: false
      t.float :salary, null: false
      t.timestamps

      t.index :role_id
    end

    create_table :performance_reviews do |t|
      t.integer :employee_id, null: false
      t.integer :reviewer_id, null: false
      t.integer :score, null: false
      t.timestamps

      t.index :employee_id
      t.index :reviewer_id
    end

    create_table :vacations do |t|
      t.integer :employee_id, null: false
      t.date :starts_on, null: false
      t.date :ends_on, null: false
      t.integer :days, null: false
      t.timestamps

      t.index :employee_id
    end
  end
end
