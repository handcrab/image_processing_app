require 'rails_helper'

RSpec.describe Images::CompressImage do
  subject do
    described_class.new(
      image_compressor_job: image_compressor_job_double
    )
  end

  def call_uc
    subject.call(params)
  end

  let(:image_compressor_job_double) { class_double(CompressImageJob) }
  let(:params) do
    {
      email: 'test@test.test',
      file_image: File.open('test/fixtures/files/test_img.jpg', 'rb')
    }
  end

  it 'creates image' do
    expect(image_compressor_job_double).to receive(:perform_later)

    result = call_uc

    expect(result).to be_a(Image)
    expect(result).to be_persisted
  end
end
