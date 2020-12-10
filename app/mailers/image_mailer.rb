class ImageMailer < ApplicationMailer
  def success_email(image)
    @image_dowload_url = Rails.application.routes.url_helpers.download_image_url(image, host: ENV['ACTION_MAILER_HOST']);

    mail(to: image.callback_email, subject: 'Image processed successfully')
  end

  def fail_email(image)
    @image_filename = image.image.metadata["filename"]
    @image_uploaded_at = image.created_at

    mail(to: image.callback_email, subject: 'Image processing failed')
  end
end
