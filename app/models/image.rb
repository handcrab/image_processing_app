class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include ImageUploader::Attachment(:processed_image)

  validates :callback_email, presence: true, email_format: { message: 'invalid email' }
end
