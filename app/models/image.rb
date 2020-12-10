class Image < ApplicationRecord
  validates :callback_email, presence: true, email_format: { message: 'invalid email' }
end
