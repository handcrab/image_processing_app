require 'rails_helper'

RSpec.describe Images::FindProcessedImage do
  def call_uc
    subject.call(params)
  end

  let!(:image) { create(:image, :processed) }
  let(:params) { { id: image.id } }

  it 'finds processed image' do
    result = call_uc

    expect(result).to be_a(Image)
  end

  context 'when image is not found' do
    let!(:image) { nil }
    let(:params) { { id: 42 } }

    it 'raises error' do
      expect { call_uc }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when image is not processed' do
    let(:image) { create(:image) }

    it 'raises error' do
      expect { call_uc }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
