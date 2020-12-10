class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :callback_email, presence: true, email_format: { message: 'invalid email' }
end
