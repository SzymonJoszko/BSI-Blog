class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :owner_id, null: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
