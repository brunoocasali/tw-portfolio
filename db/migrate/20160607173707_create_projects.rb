class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :status, index: true
      t.string :code
      t.references :owner, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :projects, :code, unique: true
  end
end
