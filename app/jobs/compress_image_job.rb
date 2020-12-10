require 'image_processing/mini_magick'

class CompressImageJob < ApplicationJob
  queue_as :default
  delegate :logger, to: Rails

  def perform(image_uuid)
    logger.info("Started processing image=#{image_uuid}")

    image = find_image(image_uuid)

    compress_image(image)
    notify_owner(image, :success)
  rescue StandardError => error
    logger.error("#{image}: error during image processing: #{error}")
    notify_owner(image, :error)

    raise error
  end

  private

  def find_image(id)
    Image.find(id)
  end

  def compress_image(image)
    image.image.open do |file|
      processed_image = ImageProcessing::MiniMagick.source(file)
      processed_image.magick.resize_to_limit(50, 50)
      image.processed_image = processed_image.call
    end

    image.process!

    logger.info("#{image}: compression completed")
  end

  def notify_owner(image, state)
    message =
      case state
      when :success
        ImageMailer.success_email(image)
      when :error
        ImageMailer.fail_email(image)
      end

    message.deliver_later

    logger.info("#{image}: notification sent")
  end
end
