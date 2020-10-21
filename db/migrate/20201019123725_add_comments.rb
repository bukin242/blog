class AddComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.text       :text, null: false
      t.timestamps
    end
  end
end
