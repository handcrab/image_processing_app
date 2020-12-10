class AddProcessedImageToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :processed_image_data, :text
  end
end
