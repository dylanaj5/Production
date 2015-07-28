class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :content
      t.date :post_time

      t.timestamps null: false

    end
  end
end
