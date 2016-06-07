class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :date_at
      t.string   :local
      t.references :project, index: true, foreign_key: true
      t.integer :status, index: true

      t.timestamps null: false
    end
  end
end
