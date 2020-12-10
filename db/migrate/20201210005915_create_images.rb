class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: :uuid  do |t|
      t.string :callback_email, null: false

      t.timestamps null: false
    end
  end
end
