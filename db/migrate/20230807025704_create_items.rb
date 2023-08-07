class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.date :start_date
      t.string :category
      t.text :detail
      t.bigint :user_id
      t.string :rakuten_url

      t.timestamps
    end
  end
end
