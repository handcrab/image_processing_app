class CompressImageJob < ApplicationJob
  queue_as :default

  def perform(image_uuid)
    Rails.logger.info("Start processing image=#{image_uuid}")
    
    image = Image.find(image_uuid)
  end
end