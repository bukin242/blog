class AddPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string     :name, null: false
      t.text       :annonce
      t.text       :text, null: false
      t.references :user, foreign_key: true
      t.boolean    :active, null: false, default: true

      t.timestamps
    end
  end
end
