FactoryBot.define do
  factory :image do
    callback_email { 'foo@bar.rr' }
    image { File.open('test/fixtures/files/test_img.jpg', 'rb') }
    state { :created }
  end

  trait :processed do
    state { :processed }
    processed_image { File.open('test/fixtures/files/test_img.jpg', 'rb') }
  end
end
