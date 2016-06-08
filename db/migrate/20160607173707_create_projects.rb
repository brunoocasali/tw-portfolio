class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :status, index: true
      t.string :code
      t.references :owner, index: true

      t.timestamps null: false
    end

    add_index :projects, :code, unique: true
    add_foreign_key :projects, :users, column: :owner_id
  end
end
