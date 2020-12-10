require 'image_processing/mini_magick'

class CompressImageJob < ApplicationJob
  queue_as :default

  def perform(image_uuid)
    Rails.logger.info("Start processing image=#{image_uuid}")
    
    image = Image.find(image_uuid)
    compress_image!(image)
  rescue StandardError => error
    Rails.logger.error("Error during image processing image=#{image_uuid}: #{error}")
    raise error
  end

  private

  def compress_image!(image)
    image.image.open do |file|
      processed_image = ImageProcessing::MiniMagick.source(file)
      processed_image.magick.resize_to_limit(50, 50)
      image.processed_image = processed_image.call
    end
  end
end