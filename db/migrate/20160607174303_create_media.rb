class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :filename
      t.references :gallery, index: true, foreign_key: true
      t.boolean :show
      t.string :subtitle

      t.timestamps null: false
    end
  end
end
