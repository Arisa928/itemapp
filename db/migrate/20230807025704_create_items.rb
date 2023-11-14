class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.date :start_date
      t.string :category
      t.text :detail
      t.string :rakuten_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
