class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include ImageUploader::Attachment(:processed_image)

  state_machine :state, initial: :created do
    event(:process) { transition created: :processed }
  end

  validates :callback_email, presence: true, email_format: { message: 'invalid email' }

  def to_s
    "image#id=#{id}"
  end
end
